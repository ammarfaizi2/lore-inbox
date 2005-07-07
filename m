Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVGGPty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVGGPty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGGPty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:49:54 -0400
Received: from [151.97.230.9] ([151.97.230.9]:44258 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261196AbVGGPty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:49:54 -0400
Subject: [patch 1/1] uml:remove user_constants.h on clean
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 07 Jul 2005 17:53:50 +0200
Message-Id: <20050707155353.2AC3521AD6C@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

make clean ARCH=um does not remove the generated file
arch/um/include/user_constants.h, fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-remove-user-constants_h arch/um/Makefile
--- linux-2.6.git/arch/um/Makefile~uml-remove-user-constants_h	2005-07-07 17:52:09.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Makefile	2005-07-07 17:52:09.000000000 +0200
@@ -140,7 +140,8 @@ endef
 #When cleaning we don't include .config, so we don't include
 #TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
-	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
+	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h \
+	$(ARCH_DIR)/include/user_constants.h
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os \
_
