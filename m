Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVLOWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVLOWuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVLOWuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:50:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751181AbVLOWtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:49:47 -0500
Date: Thu, 15 Dec 2005 17:49:33 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200512152249.jBFMnX8m016753@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] *at syscalls: x86 syscalls
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -durp linux/arch/i386/kernel/syscall_table.S linux/arch/i386/kernel/syscall_table.S
--- linux/arch/i386/kernel/syscall_table.S	2005-09-10 16:18:09.000000000 -0700
+++ linux/arch/i386/kernel/syscall_table.S	2005-12-14 23:31:12.000000000 -0800
@@ -294,3 +294,14 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_openat
+	.long sys_mkdirat		/* 295 */
+	.long sys_mknodat
+	.long sys_fchownat
+	.long sys_futimesat
+	.long sys_newfstatat
+	.long sys_unlinkat		/* 300 */
+	.long sys_renameat
+	.long sys_linkat
+	.long sys_symlinkat
+	.long sys_readlinkat
diff -durp linux/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux/include/asm-i386/unistd.h	2005-10-31 10:52:19.000000000 -0800
+++ linux/include/asm-i386/unistd.h	2005-12-14 23:30:14.000000000 -0800
@@ -299,8 +299,19 @@
 #define __NR_inotify_init	291
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
+#define __NR_openat		294
+#define __NR_mkdirat		295
+#define __NR_mknodat		296
+#define __NR_fchownat		297
+#define __NR_futimesat		298
+#define __NR_newfstatat		299
+#define __NR_unlinkat		300
+#define __NR_renameat		301
+#define __NR_linkat		302
+#define __NR_symlinkat		303
+#define __NR_readlinkat		304
 
-#define NR_syscalls 294
+#define NR_syscalls 305
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
