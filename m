Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271486AbTGRJml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271736AbTGRJlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:41:39 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:51967 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271486AbTGRJa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  v850 miscellanea
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094540.9F0B537C2@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

Some updated copyright noticed and an unnecessary variable deleted.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/gbus_int.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/gbus_int.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/gbus_int.c	2003-07-14 13:14:39.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/gbus_int.c	2003-07-15 19:06:36.000000000 +0900
@@ -113,9 +113,7 @@
 		/* Only pay attention to enabled interrupts.  */
 		status &= enable;
 		if (status) {
-			unsigned base_irq
-				= IRQ_GBUS_INT (w * GBUS_INT_BITS_PER_WORD);
-			irq = base_irq;
+			irq = IRQ_GBUS_INT (w * GBUS_INT_BITS_PER_WORD);
 			do {
 				/* There's an active interrupt in word
 				   W, find out which one, and call its
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/asm.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/asm.h
--- linux-2.6.0-test1-moo/include/asm-v850/asm.h	2003-02-25 10:45:23.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/asm.h	2003-07-15 19:06:36.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * include/asm-v850/asm.h -- Macros for writing assembly code
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/processor.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/processor.h
--- linux-2.6.0-test1-moo/include/asm-v850/processor.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/processor.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * include/asm-v850/processor.h
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/ptrace.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ptrace.h
--- linux-2.6.0-test1-moo/include/asm-v850/ptrace.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/ptrace.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * include/asm-v850/ptrace.h -- Access to CPU registers
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/stat.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/stat.h
--- linux-2.6.0-test1-moo/include/asm-v850/stat.h	2003-04-08 10:15:57.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/stat.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * include/asm-v850/stat.h -- v850 stat structure
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/system.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/system.h
--- linux-2.6.0-test1-moo/include/asm-v850/system.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/system.h	2003-07-15 19:06:37.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * include/asm-v850/system.h -- Low-level interrupt/thread ops
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
