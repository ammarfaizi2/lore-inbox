Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUAAURG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbUAAUQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:16:13 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:58969 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S265061AbUAAUKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:10:12 -0500
Date: Thu, 1 Jan 2004 21:01:53 +0100
Message-Id: <200401012001.i01K1rfB031745@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 350] M68k symbol exports
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Export missing symbols (from Matthias Urlichs)

--- linux-2.6.0/arch/m68k/mac/config.c	Tue May 27 19:02:33 2003
+++ linux-m68k-2.6.0/arch/m68k/mac/config.c	Mon Oct 20 21:54:14 2003
@@ -11,6 +11,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
@@ -267,6 +268,7 @@
  */
  
 struct mac_model *macintosh_config;
+EXPORT_SYMBOL(macintosh_config);
 
 static struct mac_model mac_data_table[]=
 {
--- linux-2.6.0/arch/m68k/mm/hwtest.c	Sat Jun 13 22:14:33 1998
+++ linux-m68k-2.6.0/arch/m68k/mm/hwtest.c	Mon Oct 20 21:54:14 2003
@@ -23,6 +23,8 @@
  * a temporary VBR and a vector table for the duration of the test.
  */
 
+#include <linux/module.h>
+
 int hwreg_present( volatile void *regp )
 {
     int	ret = 0;
@@ -47,6 +49,7 @@
 
     return( ret );
 }
+EXPORT_SYMBOL(hwreg_present);
   
 /* Basically the same, but writes a value into a word register, protected
  * by a bus error handler. Returns 1 if successful, 0 otherwise.
@@ -78,4 +81,5 @@
 
 	return( ret );
 }
+EXPORT_SYMBOL(hwreg_write);
 
--- linux-2.6.0/arch/m68k/mm/motorola.c	Tue Jul 29 18:18:35 2003
+++ linux-m68k-2.6.0/arch/m68k/mm/motorola.c	Mon Oct 20 21:54:14 2003
@@ -9,6 +9,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -40,6 +41,7 @@
  * For 68040, this is _PAGE_CACHE040 (cachable, copyback)
  */
 unsigned long mm_cachebits = 0;
+EXPORT_SYMBOL(mm_cachebits);
 #endif
 
 static pte_t * __init kernel_page_table(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
