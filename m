Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbUGTSoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUGTSoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUGTSnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:43:12 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:2861 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266170AbUGTSj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:57 -0400
Date: Tue, 20 Jul 2004 20:39:55 +0200
Message-Id: <200407201839.i6KIdtUD015560@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, johnpol@2ka.mipt.ru
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Dallas 1-wire delay.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dallas 1-wire: never include <asm/delay.h> directly

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/w1/matrox_w1.c	2004-07-18 15:55:33.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/w1/matrox_w1.c	2004-07-18 23:36:48.000000000 +0200
@@ -22,8 +22,8 @@
 #include <asm/atomic.h>
 #include <asm/types.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/list.h>
--- linux-2.6.8-rc2/drivers/w1/w1.c	2004-07-18 15:55:33.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/w1/w1.c	2004-07-18 23:36:46.000000000 +0200
@@ -20,8 +20,8 @@
  */
 
 #include <asm/atomic.h>
-#include <asm/delay.h>
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
--- linux-2.6.8-rc2/drivers/w1/w1_io.c	2004-07-18 15:55:33.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/w1/w1_io.c	2004-07-18 23:36:45.000000000 +0200
@@ -20,8 +20,8 @@
  */
 
 #include <asm/io.h>
-#include <asm/delay.h>
 
+#include <linux/delay.h>
 #include <linux/moduleparam.h>
 
 #include "w1.h"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
