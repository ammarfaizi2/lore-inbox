Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWC1W7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWC1W7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWC1W7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:07 -0500
Received: from [198.99.130.12] ([198.99.130.12]:20163 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964787AbWC1W7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:02 -0500
Message-Id: <200603282300.k2SN0Aoe022982@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 5/10] UML - Eliminate duplicate mrpropered files
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:10 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
 
uml: no need to add the same file twice to MRPROPER_FILES
 
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

Index: linux-2.6.16-mm/arch/um/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/Makefile	2006-03-28 09:34:20.000000000 -0500
+++ linux-2.6.16-mm/arch/um/Makefile	2006-03-28 09:34:41.000000000 -0500
@@ -150,8 +150,7 @@ CLEAN_FILES += linux x.i gmon.out $(ARCH
 	$(ARCH_DIR)/include/user_constants.h \
 	$(ARCH_DIR)/include/kern_constants.h $(ARCH_DIR)/Kconfig.arch
 
-MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
-	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
+MRPROPER_FILES += $(ARCH_SYMLINKS)
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \

