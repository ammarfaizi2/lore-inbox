Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbUAAUCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUAAUCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:02:32 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:4408 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264558AbUAAUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:01:49 -0500
Date: Thu, 1 Jan 2004 21:01:47 +0100
Message-Id: <200401012001.i01K1ltW031691@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 341] M68k head unused
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Remove unused console_video_virtual (from Roman Zippel)

--- linux-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:47:11 -0000	1.10
+++ linux-m68k-2.6.0/arch/m68k/kernel/head.S	13 Oct 2003 22:48:56 -0000
@@ -1232,10 +1232,6 @@
 
 	putc	'F'
 
-	lea	%pc@(L(mac_videobase)),%a0
-	lea	%pc@(L(console_video_virtual)),%a1
-	movel	%a0@,%a1@
-
 	is_not_040_or_060(1f)
 
 	moveq	#_PAGE_NOCACHE_S,%d3
@@ -3830,11 +3826,6 @@
 	.long 0
 #endif
 
-#ifdef CONFIG_MAC
-L(console_video_virtual):
-	.long	0
-#endif	/* CONFIG_MAC */
-
 #if defined(CONSOLE)
 L(console_globals):
 	.long	0		/* cursor column */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
