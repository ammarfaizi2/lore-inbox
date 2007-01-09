Return-Path: <linux-kernel-owner+w=401wt.eu-S1750932AbXAICLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbXAICLz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbXAICLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:11:54 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44477 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbXAICLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:11:54 -0500
Message-Id: <200701090205.l0925lqE024386@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/7] UML - Delete unused file
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2007 21:05:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that resource.c isn't needed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/Makefile   |    2 +-
 arch/um/kernel/resource.c |   23 -----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/Makefile	2007-01-08 16:15:33.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/Makefile	2007-01-08 16:16:37.000000000 -0500
@@ -7,7 +7,7 @@ extra-y := vmlinux.lds
 clean-files :=
 
 obj-y = config.o exec.o exitcode.o init_task.o irq.o ksyms.o mem.o \
-	physmem.o process.o ptrace.o reboot.o resource.o sigio.o \
+	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o uaccess.o \
 	um_arch.o umid.o
 
Index: linux-2.6.18-mm/arch/um/kernel/resource.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/resource.c	2007-01-07 10:51:51.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,23 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/pci.h"
-
-unsigned long resource_fixup(struct pci_dev * dev, struct resource * res,
-			     unsigned long start, unsigned long size)
-{
-	return start;
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */


