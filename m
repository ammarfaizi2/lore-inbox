Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319666AbSH3V1A>; Fri, 30 Aug 2002 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319667AbSH3V1A>; Fri, 30 Aug 2002 17:27:00 -0400
Received: from maile.telia.com ([194.22.190.16]:44787 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S319666AbSH3V07>;
	Fri, 30 Aug 2002 17:26:59 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Sync arch/alpha/kernel/entry.S with asm/unistd.h
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 30 Aug 2002 23:22:35 +0200
Message-ID: <yw1x8z2oca90.fsf@zaphod.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some (non-implemented) syscalls to entry.S with the same
numbers as in asm/unistd.h

--- arch/alpha/kernel/entry.S	30 Aug 2002 20:13:07 -0000	1.1.1.1
+++ arch/alpha/kernel/entry.S	30 Aug 2002 21:11:07 -0000
@@ -10,7 +10,7 @@
 
 #define SIGCHLD 20
 
-#define NR_SYSCALLS 382
+#define NR_SYSCALLS 394
 
 /*
  * These offsets must match with alpha_mv in <asm/machvec.h>.
@@ -1154,6 +1154,18 @@
 	.quad sys_readahead
 	.quad sys_ni_syscall			/* 380, sys_security */
 	.quad sys_tkill
+	.quad sys_ni_syscall			/* setxattr */
+	.quad sys_ni_syscall			/* lsetxattr */
+	.quad sys_ni_syscall			/* fsetxattr */
+	.quad sys_ni_syscall			/* 385 getxattr */
+	.quad sys_ni_syscall			/* lgetxattr */
+	.quad sys_ni_syscall			/* fgetxattr */
+	.quad sys_ni_syscall			/* listxattr */
+	.quad sys_ni_syscall			/* llistxattr */
+	.quad sys_ni_syscall			/* 390 flistxattr */
+	.quad sys_ni_syscall			/* removexattr */
+	.quad sys_ni_syscall			/* lremovexattr */
+	.quad sys_ni_syscall			/* fremovexattr */
 
 /* Remember to update everything, kids.  */
 .ifne (. - sys_call_table) - (NR_SYSCALLS * 8)



-- 
Måns Rullgård
mru@users.sf.net
