Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSJ1Uh3>; Mon, 28 Oct 2002 15:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSJ1UhA>; Mon, 28 Oct 2002 15:37:00 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:54548 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261460AbSJ1Ug6>; Mon, 28 Oct 2002 15:36:58 -0500
Date: Sat, 28 Sep 2002 22:42:36 +0200
Message-Id: <200209282042.g8SKgaJw001503@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] IDE: kill warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE: kill warning

--- linux-2.5.44/drivers/ide/ide-lib.c	Sat Sep 28 14:56:40 2002
+++ linux-m68k-2.5.44/drivers/ide/ide-lib.c	Thu Oct 10 21:42:30 2002
@@ -171,7 +171,7 @@
 		BUG();
 	return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	return min(speed, XFER_PIO_4);
+	return min(speed, (u8)XFER_PIO_4);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

