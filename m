Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTHTIXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTHTIMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:12:42 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:57293 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261817AbTHTIER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:04:17 -0400
Date: Wed, 20 Aug 2003 18:05:26 +1000
Message-Id: <200308200805.h7K85QXi011792@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] C99: 2.6.0-t3-bk7/include
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/include/asm-arm/proc-armo/processor.h linux/include/asm-arm/proc-armo/processor.h
--- linux.backup/include/asm-arm/proc-armo/processor.h	Thu Oct 31 11:42:20 2002
+++ linux/include/asm-arm/proc-armo/processor.h	Wed Aug 20 16:40:22 2003
@@ -43,7 +43,7 @@
 	uaccess_t	*uaccess;		/* User access functions*/
 
 #define EXTRA_THREAD_STRUCT_INIT		\
-	uaccess:	&uaccess_kernel,
+	.uaccess	= &uaccess_kernel,
 
 #define start_thread(regs,pc,sp)					\
 ({									\
diff -aur linux.backup/include/asm-arm/xor.h linux/include/asm-arm/xor.h
--- linux.backup/include/asm-arm/xor.h	Thu Oct 31 11:42:54 2002
+++ linux/include/asm-arm/xor.h	Wed Aug 20 16:40:22 2003
@@ -125,11 +125,11 @@
 }
 
 static struct xor_block_template xor_block_arm4regs = {
-	name:	"arm4regs",
-	do_2:	xor_arm4regs_2,
-	do_3:	xor_arm4regs_3,
-	do_4:	xor_arm4regs_4,
-	do_5:	xor_arm4regs_5,
+	.name	= "arm4regs",
+	.do_2	= xor_arm4regs_2,
+	.do_3	= xor_arm4regs_3,
+	.do_4	= xor_arm4regs_4,
+	.do_5	= xor_arm4regs_5,
 };
 
 #undef XOR_TRY_TEMPLATES
diff -aur linux.backup/include/asm-arm26/processor.h linux/include/asm-arm26/processor.h
--- linux.backup/include/asm-arm26/processor.h	Mon Jul 21 23:35:02 2003
+++ linux/include/asm-arm26/processor.h	Wed Aug 20 16:40:22 2003
@@ -51,7 +51,7 @@
         uaccess_t       *uaccess;         /* User access functions*/
 
 #define EXTRA_THREAD_STRUCT_INIT                \
-        uaccess:        &uaccess_kernel,
+        .uaccess        = &uaccess_kernel,
 
 // FIXME?!!
 
diff -aur linux.backup/include/asm-arm26/xor.h linux/include/asm-arm26/xor.h
--- linux.backup/include/asm-arm26/xor.h	Thu Jun 26 23:47:49 2003
+++ linux/include/asm-arm26/xor.h	Wed Aug 20 16:40:22 2003
@@ -125,11 +125,11 @@
 }
 
 static struct xor_block_template xor_block_arm4regs = {
-	name:	"arm4regs",
-	do_2:	xor_arm4regs_2,
-	do_3:	xor_arm4regs_3,
-	do_4:	xor_arm4regs_4,
-	do_5:	xor_arm4regs_5,
+	.name	= "arm4regs",
+	.do_2	= xor_arm4regs_2,
+	.do_3	= xor_arm4regs_3,
+	.do_4	= xor_arm4regs_4,
+	.do_5	= xor_arm4regs_5,
 };
 
 #undef XOR_TRY_TEMPLATES
