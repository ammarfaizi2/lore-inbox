Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275506AbTHSGmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275533AbTHSGlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:41:08 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:10880 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S275502AbTHSGhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:37:13 -0400
Date: Tue, 19 Aug 2003 16:38:26 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/10] 2.6.0-t3: struct C99 initialiser conversion
Message-ID: <20030819063826.GN643@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux/include/ patch

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo

--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.0-t3.c99.include.patch"

diff -aur linux.backup/include/asm-arm/proc-armo/processor.h linux/include/asm-arm/proc-armo/processor.h
--- linux.backup/include/asm-arm/proc-armo/processor.h	Thu Oct 31 11:42:20 2002
+++ linux/include/asm-arm/proc-armo/processor.h	Sun Aug 17 00:09:38 2003
@@ -43,7 +43,7 @@
 	uaccess_t	*uaccess;		/* User access functions*/
 
 #define EXTRA_THREAD_STRUCT_INIT		\
-	uaccess:	&uaccess_kernel,
+	.uaccess	= &uaccess_kernel,
 
 #define start_thread(regs,pc,sp)					\
 ({									\
diff -aur linux.backup/include/asm-arm/xor.h linux/include/asm-arm/xor.h
--- linux.backup/include/asm-arm/xor.h	Thu Oct 31 11:42:54 2002
+++ linux/include/asm-arm/xor.h	Sat Aug 16 15:44:59 2003
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
+++ linux/include/asm-arm26/processor.h	Sat Aug 16 15:44:59 2003
@@ -51,7 +51,7 @@
         uaccess_t       *uaccess;         /* User access functions*/
 
 #define EXTRA_THREAD_STRUCT_INIT                \
-        uaccess:        &uaccess_kernel,
+        .uaccess        = &uaccess_kernel,
 
 // FIXME?!!
 
diff -aur linux.backup/include/asm-arm26/xor.h linux/include/asm-arm26/xor.h
--- linux.backup/include/asm-arm26/xor.h	Thu Jun 26 23:47:49 2003
+++ linux/include/asm-arm26/xor.h	Sat Aug 16 15:44:59 2003
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

--BWWlCdgt6QLN7tv3--
