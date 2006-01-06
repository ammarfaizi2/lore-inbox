Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752481AbWAFS56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbWAFS56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWAFS56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:57:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39840 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752481AbWAFS55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:57:57 -0500
Date: Fri, 6 Jan 2006 13:57:49 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200601061857.k06Ivn6M023985@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index 9b21a31..5022238 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -294,3 +294,16 @@ ENTRY(sys_call_table)
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
+	.long sys_fchmodat		/* 305 */
+	.long sys_faccessat
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index 0f92e78..a61fb3a 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -299,8 +299,21 @@
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
+#define __NR_fchmodat		305
+#define __NR_faccessat		306
 
-#define NR_syscalls 294
+#define NR_syscalls 307
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
