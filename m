Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVEMKv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVEMKv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 06:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVEMKv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 06:51:26 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:61455 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262332AbVEMKvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 06:51:24 -0400
To: Jeff Dike <jdike@addtoit.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] UML: add missing files to mrproper
Message-Id: <E1DWXlB-00018x-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 12:51:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add user_constants.h and mk_user_constants to MRPROPER_FILES.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/arch/um/Makefile
===================================================================
--- linux.orig/arch/um/Makefile	2005-05-13 12:22:28.000000000 +0200
+++ linux/arch/um/Makefile	2005-05-13 12:32:47.000000000 +0200
@@ -144,7 +144,8 @@ CLEAN_FILES += linux x.i gmon.out $(ARCH
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os \
-	$(ARCH_DIR)/Kconfig_arch
+	$(ARCH_DIR)/Kconfig_arch $(ARCH_DIR)/include/user_constants.h \
+	$(ARCH_DIR)/os-$(OS)/util/mk_user_constants
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/util
