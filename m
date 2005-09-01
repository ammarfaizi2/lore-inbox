Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbVIAWyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbVIAWyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVIAWx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:26 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:35856 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030500AbVIAWxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:23 -0400
Message-Id: <200509012216.j81MGvcQ011525@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/12] UML - x86_64 build fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:16:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

semaphore.c is no longer available from arch/x86_64, so we just pick up the
generic version instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.13-mm1.orig/arch/um/sys-x86_64/Makefile	2005-09-01 15:52:25.000000000 -0400
+++ linux-2.6.13-mm1/arch/um/sys-x86_64/Makefile	2005-09-01 15:53:04.000000000 -0400
@@ -6,7 +6,7 @@
 
 #XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
-	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o stub.o \
+	ptrace.o ptrace_user.o sigcontext.o signal.o stub.o \
 	stub_segv.o syscalls.o syscall_table.o sysrq.o thunk.o
 
 obj-y := ksyms.o
@@ -15,7 +15,7 @@
 USER_OBJS := ptrace_user.o sigcontext.o
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
-	semaphore.c thunk.S module.c
+	thunk.S module.c
 
 include arch/um/scripts/Makefile.rules
 
@@ -24,7 +24,6 @@
 csum-partial.c-dir = lib
 csum-wrappers.c-dir = lib
 memcpy.S-dir = lib
-semaphore.c-dir = kernel
 thunk.S-dir = lib
 module.c-dir = kernel

