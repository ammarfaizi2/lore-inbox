Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUAAUOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAAUGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:06:09 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:27162 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264829AbUAAUB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:58 -0500
Date: Thu, 1 Jan 2004 21:01:56 +0100
Message-Id: <200401012001.i01K1ud3031769@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 354] Sun-3 ID PROM C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 ID PROM: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/sun3/idprom.c	Tue Nov  5 10:09:42 2002
+++ linux-m68k-2.6.0/arch/m68k/sun3/idprom.c	Sun Oct  5 12:40:27 2003
@@ -24,34 +24,34 @@
  */
 struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES] = {
 /* First, Sun3's */
-{ "Sun 3/160 Series", (SM_SUN3 | SM_3_160) },
-{ "Sun 3/50", (SM_SUN3 | SM_3_50) },
-{ "Sun 3/260 Series", (SM_SUN3 | SM_3_260) },
-{ "Sun 3/110 Series", (SM_SUN3 | SM_3_110) },
-{ "Sun 3/60", (SM_SUN3 | SM_3_60) },
-{ "Sun 3/E", (SM_SUN3 | SM_3_E) },
+    { .name = "Sun 3/160 Series",	.id_machtype = (SM_SUN3 | SM_3_160) },
+    { .name = "Sun 3/50",		.id_machtype = (SM_SUN3 | SM_3_50) },
+    { .name = "Sun 3/260 Series",	.id_machtype = (SM_SUN3 | SM_3_260) },
+    { .name = "Sun 3/110 Series",	.id_machtype = (SM_SUN3 | SM_3_110) },
+    { .name = "Sun 3/60",		.id_machtype = (SM_SUN3 | SM_3_60) },
+    { .name = "Sun 3/E",		.id_machtype = (SM_SUN3 | SM_3_E) },
 /* Now, Sun3x's */
-{ "Sun 3/460 Series", (SM_SUN3X | SM_3_460) },
-{ "Sun 3/80", (SM_SUN3X | SM_3_80) },
+    { .name = "Sun 3/460 Series",	.id_machtype = (SM_SUN3X | SM_3_460) },
+    { .name = "Sun 3/80",		.id_machtype = (SM_SUN3X | SM_3_80) },
 /* Then, Sun4's */
-//{ "Sun 4/100 Series", (SM_SUN4 | SM_4_110) },
-//{ "Sun 4/200 Series", (SM_SUN4 | SM_4_260) },
-//{ "Sun 4/300 Series", (SM_SUN4 | SM_4_330) },
-//{ "Sun 4/400 Series", (SM_SUN4 | SM_4_470) },
+// { .name = "Sun 4/100 Series",	.id_machtype = (SM_SUN4 | SM_4_110) },
+// { .name = "Sun 4/200 Series",	.id_machtype = (SM_SUN4 | SM_4_260) },
+// { .name = "Sun 4/300 Series",	.id_machtype = (SM_SUN4 | SM_4_330) },
+// { .name = "Sun 4/400 Series",	.id_machtype = (SM_SUN4 | SM_4_470) },
 /* And now, Sun4c's */
-//{ "Sun4c SparcStation 1", (SM_SUN4C | SM_4C_SS1) },
-//{ "Sun4c SparcStation IPC", (SM_SUN4C | SM_4C_IPC) },
-//{ "Sun4c SparcStation 1+", (SM_SUN4C | SM_4C_SS1PLUS) },
-//{ "Sun4c SparcStation SLC", (SM_SUN4C | SM_4C_SLC) },
-//{ "Sun4c SparcStation 2", (SM_SUN4C | SM_4C_SS2) },
-//{ "Sun4c SparcStation ELC", (SM_SUN4C | SM_4C_ELC) },
-//{ "Sun4c SparcStation IPX", (SM_SUN4C | SM_4C_IPX) },
+// { .name = "Sun4c SparcStation 1",	.id_machtype = (SM_SUN4C | SM_4C_SS1) },
+// { .name = "Sun4c SparcStation IPC",	.id_machtype = (SM_SUN4C | SM_4C_IPC) },
+// { .name = "Sun4c SparcStation 1+",	.id_machtype = (SM_SUN4C | SM_4C_SS1PLUS) },
+// { .name = "Sun4c SparcStation SLC",	.id_machtype = (SM_SUN4C | SM_4C_SLC) },
+// { .name = "Sun4c SparcStation 2",	.id_machtype = (SM_SUN4C | SM_4C_SS2) },
+// { .name = "Sun4c SparcStation ELC",	.id_machtype = (SM_SUN4C | SM_4C_ELC) },
+// { .name = "Sun4c SparcStation IPX",	.id_machtype = (SM_SUN4C | SM_4C_IPX) },
 /* Finally, early Sun4m's */
-//{ "Sun4m SparcSystem600", (SM_SUN4M | SM_4M_SS60) },
-//{ "Sun4m SparcStation10/20", (SM_SUN4M | SM_4M_SS50) },
-//{ "Sun4m SparcStation5", (SM_SUN4M | SM_4M_SS40) },
+// { .name = "Sun4m SparcSystem600",	.id_machtype = (SM_SUN4M | SM_4M_SS60) },
+// { .name = "Sun4m SparcStation10/20",	.id_machtype = (SM_SUN4M | SM_4M_SS50) },
+// { .name = "Sun4m SparcStation5",	.id_machtype = (SM_SUN4M | SM_4M_SS40) },
 /* One entry for the OBP arch's which are sun4d, sun4e, and newer sun4m's */
-//{ "Sun4M OBP based system", (SM_SUN4M_OBP | 0x0) }
+// { .name = "Sun4M OBP based system",	.id_machtype = (SM_SUN4M_OBP | 0x0) }
 };
 
 static void __init display_system_type(unsigned char machtype)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
