Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUDMIkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbUDMIiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:38:54 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:57442 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S263219AbUDMIiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:09 -0400
Date: Tue, 13 Apr 2004 10:38:06 +0200
Message-Id: <200404130838.i3D8c6pa018442@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 427] Amiga Zorro8390 Ethernet section conflict
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zorro8390: const data cannot be in the init data section (from Roman Zippel)

--- linux-2.6.5-rc2/drivers/net/zorro8390.c	19 Feb 2004 20:14:19 -0000	1.7
+++ linux-m68k-2.6.5-rc2/drivers/net/zorro8390.c	26 Mar 2004 21:47:26 -0000
@@ -60,7 +60,7 @@
 #define WORDSWAP(a)	((((a)>>8)&0xff) | ((a)<<8))
 
 
-static const struct card_info {
+static struct card_info {
     zorro_id id;
     const char *name;
     unsigned int offset;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
