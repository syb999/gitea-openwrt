include $(TOPDIR)/rules.mk
 
PKG_NAME := gitea
PKG_VERSION := 1.21.5
PKG_RELEASE := 1

PKG_BUILD_DIR := $(BUILD_DIR)/gitea-$(PKG_VERSION)
PKG_SOURCE_URL := https://github.com/go-gitea/gitea/archive/refs/tags/
PKG_SOURCE := v$(PKG_VERSION).tar.gz
PKG_HASH := d6f1ab196011cb53e98abfa2a85d7b5a730a69ea426cc1e24a451e410b76a7a5
PKG_BUILD_DEPENDS := golang/host npm/host nodejs/host
PKG_BUILD_PARALLEL := 1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/../feeds/packages/lang/golang/golang-package.mk
 
define Package/$(PKG_NAME)
	SECTION := Custom
	CATEGORY := Extra packages
	TITLE := Git with a cup of tea
	#DESCRIPTION := This variable is obsolete. use the Package/name/description define instead!
	PROVIDES:=gitea
	URL := https://github.com/go-gitea/gitea
endef
 
define Package/$(PKG_NAME)description
	Git with a cup of tea, painless self-hosted git service.
endef

define Build/Compile
	cd $(PKG_BUILD_DIR); GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 TAGS="bindata sqlite sqlite_unlock_notify" make build
endef
 
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/gitea $(1)/usr/bin/gitea
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
