Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTEFC6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTEFC5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:57:47 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:34448 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262288AbTEFC5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:57:06 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Miscellaneous v850 whitespace and comment cleanups
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030506030925.18CF43759@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  6 May 2003 12:09:25 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/as85ep1-rom.ld linux-2.5.69-uc0-v850-20030506/arch/v850/as85ep1-rom.ld
--- linux-2.5.69-uc0/arch/v850/as85ep1-rom.ld	2002-12-24 15:01:07.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/as85ep1-rom.ld	2003-05-06 10:40:26.000000000 +0900
@@ -1,9 +1,6 @@
 /* Linker script for the NEC AS85EP1 V850E evaluation board
    (CONFIG_V850E_AS85EP1), with kernel in ROM (CONFIG_ROM_KERNEL).  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
 MEMORY {
 	/* 4MB of flash ROM.  */
 	ROM   : ORIGIN = 0,          LENGTH = 0x00400000
@@ -12,7 +9,7 @@
 	SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
 
 	/* About 58MB of DRAM.  This can actually be at one of two
-	   positions, determined by jump JP3; we have to use the first
+	   positions, determined by jumper JP3; we have to use the first
 	   position because the second is partially out of processor
 	   instruction addressing range (though in the second position
 	   there's actually 64MB available).  */
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/head.S linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/head.S
--- linux-2.5.69-uc0/arch/v850/kernel/head.S	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/head.S	2003-05-06 10:40:26.000000000 +0900
@@ -39,7 +39,7 @@
 	cmp	r19, r20
 	bne	1f			// Guard was not active
 
-	// If we get here, the reset guard was active.	Load up some
+	// If we get here, the reset guard was active.  Load up some
 	// interesting values as arguments, and jump to the handler.
 	st.w	r0, RESET_GUARD		// Allow further resets to succeed
 	mov	lp, r6			// Arg 0: return address
@@ -53,7 +53,7 @@
 
 1:	st.w	r20, RESET_GUARD	// Turn on reset guard
 #endif /* CONFIG_RESET_GUARD */
-  
+
 	// Setup a temporary stack for doing pre-initialization function calls.
 	// 
 	// We can't use the initial kernel stack, because (1) it may be
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/irq.c linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/irq.c
--- linux-2.5.69-uc0/arch/v850/kernel/irq.c	2003-03-18 13:23:02.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/irq.c	2003-05-06 10:49:25.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * arch/v850/kernel/irq.c -- High-level interrupt handling
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *  Copyright (C) 1994-2000  Ralf Baechle
  *  Copyright (C) 1992  Linus Torvalds
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/ma.c linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/ma.c
--- linux-2.5.69-uc0/arch/v850/kernel/ma.c	2003-03-05 13:07:37.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/ma.c	2003-05-06 10:40:26.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/ma.c -- V850E/MA series of cpu chips
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/mach.h linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/mach.h
--- linux-2.5.69-uc0/arch/v850/kernel/mach.h	2003-02-12 11:26:18.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/mach.h	2003-05-06 10:40:26.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/mach.h -- Machine-dependent functions used by v850 port
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/process.c linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/process.c
--- linux-2.5.69-uc0/arch/v850/kernel/process.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/process.c	2003-05-06 10:40:26.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * arch/v850/kernel/process.c -- Arch-dependent process handling
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/rte_cb_multi.c linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/rte_cb_multi.c
--- linux-2.5.69-uc0/arch/v850/kernel/rte_cb_multi.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/rte_cb_multi.c	2003-05-06 10:40:26.000000000 +0900
@@ -2,7 +2,7 @@
  * include/asm-v850/rte_multi.c -- Support for Multi debugger monitor ROM
  * 	on Midas lab RTE-CB series of evaluation boards
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/rte_ma1_cb.c linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/rte_ma1_cb.c
--- linux-2.5.69-uc0/arch/v850/kernel/rte_ma1_cb.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/rte_ma1_cb.c	2003-05-06 10:40:26.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * arch/v850/kernel/rte_ma1_cb.c -- Midas labs RTE-V850E/MA1-CB board
  *
- *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
  *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
diff -ruN -X../cludes linux-2.5.69-uc0/include/asm-v850/sim.h linux-2.5.69-uc0-v850-20030506/include/asm-v850/sim.h
--- linux-2.5.69-uc0/include/asm-v850/sim.h	2003-03-05 13:08:12.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/include/asm-v850/sim.h	2003-05-06 10:40:26.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/sim.h -- Machine-dependent defs for GDB v850e simulator
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
