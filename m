Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUJaKmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUJaKmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUJaKla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:41:30 -0500
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:9776
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261548AbUJaKEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:04:36 -0500
Date: Sun, 31 Oct 2004 11:03:39 +0100
Message-Id: <200410311003.i9VA3d2M009616@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 500] M68k: missing/superfluous config.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing and remove superfluous #include <linux/config.h>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/hp300/config.c	2004-08-14 15:35:36.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/hp300/config.c	2004-10-17 17:48:31.000000000 +0200
@@ -7,6 +7,7 @@
  *  called by setup.c.
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
--- linux-2.6.10-rc1/arch/m68k/mm/sun3mmu.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/mm/sun3mmu.c	2004-10-17 17:49:41.000000000 +0200
@@ -7,7 +7,6 @@
  *
  */
 
-#include <linux/config.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
--- linux-2.6.10-rc1/arch/m68k/q40/q40ints.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/q40/q40ints.c	2004-10-17 17:49:54.000000000 +0200
@@ -11,7 +11,6 @@
  *
  */
 
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
--- linux-2.6.10-rc1/arch/m68k/sun3/sun3dvma.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/sun3/sun3dvma.c	2004-10-17 17:43:51.000000000 +0200
@@ -6,6 +6,7 @@
  * Contains common routines for sun3/sun3x DVMA management.
  */
 
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/list.h>
--- linux-2.6.10-rc1/arch/m68k/sun3/sun3ints.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/sun3/sun3ints.c	2004-10-17 17:44:05.000000000 +0200
@@ -6,6 +6,7 @@
  * for more details.
  */
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
--- linux-2.6.10-rc1/arch/m68k/sun3x/config.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/sun3x/config.c	2004-10-17 17:44:49.000000000 +0200
@@ -6,6 +6,7 @@
  * based on code from Oliver Jowett <oliver@jowett.manawatu.gen.nz>
  */
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/console.h>
@@ -70,7 +71,7 @@ void __init config_sun3x(void)
 	mach_get_model       = sun3_get_model;
 	mach_get_hardware_list = sun3x_get_hardware_list;
 
-#if defined(CONFIG_DUMMY_CONSOLE)
+#ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp	     = &dummy_con;
 #endif
 
--- linux-2.6.10-rc1/include/asm-m68k/atomic.h	2004-07-12 09:48:27.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/atomic.h	2004-10-17 17:45:27.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __ARCH_M68K_ATOMIC__
 #define __ARCH_M68K_ATOMIC__
 
+#include <linux/config.h>
+
 #include <asm/system.h>	/* local_irq_XXX() */
 
 /*
--- linux-2.6.10-rc1/include/asm-m68k/mc146818rtc.h	2004-04-28 10:58:58.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/mc146818rtc.h	2004-10-17 17:45:54.000000000 +0200
@@ -4,6 +4,8 @@
 #ifndef _ASM_MC146818RTC_H
 #define _ASM_MC146818RTC_H
 
+#include <linux/config.h>
+
 #ifdef CONFIG_ATARI
 /* RTC in Atari machines */
 
--- linux-2.6.10-rc1/include/asm-m68k/tlbflush.h	2004-05-24 11:13:53.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/tlbflush.h	2004-10-17 17:46:29.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _M68K_TLBFLUSH_H
 #define _M68K_TLBFLUSH_H
 
+#include <linux/config.h>
+
 #ifndef CONFIG_SUN3
 
 #include <asm/current.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
