Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269354AbTGYC1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 22:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTGYC1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 22:27:35 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:45194 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S269354AbTGYC1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 22:27:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Remove <asm-v850/setup.h>
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030725024234.C5729372A@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 25 Jul 2003 11:42:34 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

<asm-v850/setup.h> is not correct, and not used, so remove it.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/process.c linux-2.6.0-test1-moo-v850-20030725/arch/v850/kernel/process.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/process.c	2003-06-16 14:52:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030725/arch/v850/kernel/process.c	2003-07-25 11:24:25.000000000 +0900
@@ -28,7 +28,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
-#include <asm/setup.h>
 #include <asm/pgtable.h>
 
 extern void ret_from_fork (void);
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/v850_ksyms.c linux-2.6.0-test1-moo-v850-20030725/arch/v850/kernel/v850_ksyms.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/v850_ksyms.c	2003-04-08 10:15:33.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030725/arch/v850/kernel/v850_ksyms.c	2003-07-25 11:24:25.000000000 +0900
@@ -9,7 +9,6 @@
 #include <linux/interrupt.h>
 #include <linux/config.h>
 
-#include <asm/setup.h>
 #include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/cacheflush.h linux-2.6.0-test1-moo-v850-20030725/include/asm-v850/cacheflush.h
--- linux-2.6.0-test1-moo/include/asm-v850/cacheflush.h	2003-04-21 10:53:17.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030725/include/asm-v850/cacheflush.h	2003-07-25 11:25:30.000000000 +0900
@@ -17,7 +17,6 @@
 /* Somebody depends on this; sigh...  */
 #include <linux/mm.h>
 
-#include <asm/setup.h>
 #include <asm/machdep.h>
 
 
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/setup.h linux-2.6.0-test1-moo-v850-20030725/include/asm-v850/setup.h
--- linux-2.6.0-test1-moo/include/asm-v850/setup.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030725/include/asm-v850/setup.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,37 +0,0 @@
-/*
- * include/asm-v850/setup.h
- *
- *  Copyright (C) 2001  NEC Corporation
- *  Copyright (C) 2001  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#ifndef __V850_SETUP_H__
-#define __V850_SETUP_H__
-
-/* Linux/v850 platforms.  This corresponds roughly to what the outside
-   the CPU looks like.  */
-#define MACH_SIM	1	/* GDB architectural simulator */
-
-/* v850 cpu architectures.  This is what a user-program would be
-   concerned with.  */
-#define CPU_ARCH_V850E	1
-#define CPU_ARCH_V850E2	2
-
-/* v850 cpu `cores'.  These are system-level extensions to the basic CPU,
-   defining such things as interrupt-handling.  */
-#define CPU_CORE_NB85E	1
-#define CPU_CORE_NB85ET	2
-#define CPU_CORE_NU85E	3
-#define CPU_CORE_NU85ET	4
-
-/* Specific v850 cpu chips.  These each incorporate a `core', and add
-   varions peripheral services.  */
-#define CPU_CHIP_MA1	1
-
-#endif /* __V850_SETUP_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/tlbflush.h linux-2.6.0-test1-moo-v850-20030725/include/asm-v850/tlbflush.h
--- linux-2.6.0-test1-moo/include/asm-v850/tlbflush.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030725/include/asm-v850/tlbflush.h	2003-07-25 11:25:46.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/tlbflush.h
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -14,7 +14,6 @@
 #ifndef __V850_TLBFLUSH_H__
 #define __V850_TLBFLUSH_H__
 
-#include <asm/setup.h>
 #include <asm/machdep.h>
 
 
