Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269402AbUJLAlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269402AbUJLAlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269416AbUJLAUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:20:45 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:22915
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269380AbUJLATD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:03 -0400
Subject: [patch 07/10] uml: kbuild - add even more cleaning
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:17:59 +0200
Message-Id: <20041012001759.317908695@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove one more symlink when doing

make mrproper ARCH=um

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-kbuild-add-even-more-cleaning arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-kbuild-add-even-more-cleaning	2004-10-12 01:08:08.925888512 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 01:08:08.927888208 +0200
@@ -123,7 +123,7 @@ CLEAN_FILES += linux x.i gmon.out $(ARCH
 	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
-	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
+	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
 
 archmrproper:
 	@:
_
