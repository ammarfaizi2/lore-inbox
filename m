Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266660AbUBFH51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUBFHzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:55:12 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:21646 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266660AbUBFHy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:54:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Add some #includes for the v850 to eliminate some compiler warnings
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040206075447.739BB56@mcspd15>
Date: Fri,  6 Feb 2004 16:54:47 +0900 (JST)
From: miles@mcspd15.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.6.2-uc0/arch/v850/kernel/bug.c linux-2.6.2-uc0-v850-20040206/arch/v850/kernel/bug.c
--- linux-2.6.2-uc0/arch/v850/kernel/bug.c	2003-10-09 11:54:16.000000000 +0900
+++ linux-2.6.2-uc0-v850-20040206/arch/v850/kernel/bug.c	2004-02-06 14:02:30.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 
 #include <asm/errno.h>
 #include <asm/ptrace.h>
diff -ruN -X../cludes linux-2.6.2-uc0/arch/v850/kernel/setup.c linux-2.6.2-uc0-v850-20040206/arch/v850/kernel/setup.c
--- linux-2.6.2-uc0/arch/v850/kernel/setup.c	2002-12-24 15:01:07.000000000 +0900
+++ linux-2.6.2-uc0-v850-20040206/arch/v850/kernel/setup.c	2004-02-06 14:02:30.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/setup.c -- Arch-dependent initialization functions
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -13,6 +13,7 @@
 
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+#include <linux/swap.h>		/* we don't have swap, but for nr_free_pages */
 #include <linux/irq.h>
 #include <linux/reboot.h>
 #include <linux/personality.h>
diff -ruN -X../cludes linux-2.6.2-uc0/arch/v850/kernel/v850e_cache.c linux-2.6.2-uc0-v850-20040206/arch/v850/kernel/v850e_cache.c
--- linux-2.6.2-uc0/arch/v850/kernel/v850e_cache.c	2003-07-28 10:13:58.000000000 +0900
+++ linux-2.6.2-uc0-v850-20040206/arch/v850/kernel/v850e_cache.c	2004-02-06 14:02:30.000000000 +0900
@@ -17,6 +17,7 @@
    implementation.  */
 
 #include <asm/entry.h>
+#include <asm/cacheflush.h>
 #include <asm/v850e_cache.h>
 
 #define WAIT_UNTIL_CLEAR(value) while (value) {}
