Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbUAAUVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAAURV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:17:21 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:41557 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264964AbUAAUKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:10:02 -0500
Date: Thu, 1 Jan 2004 21:01:52 +0100
Message-Id: <200401012001.i01K1q1n031733@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 348] Amiga sound C99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga sound: Use C99 struct initializers

--- linux-2.6.0/arch/m68k/amiga/amisound.c	Tue Mar 25 10:06:07 2003
+++ linux-m68k-2.6.0/arch/m68k/amiga/amisound.c	Sun Oct  5 11:55:44 2003
@@ -44,7 +44,7 @@
 
 void __init amiga_init_sound(void)
 {
-	static struct resource beep_res = { "Beep" };
+	static struct resource beep_res = { .name = "Beep" };
 
 	snd_data = amiga_chip_alloc_res(sizeof(sine_data), &beep_res);
 	if (!snd_data) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
