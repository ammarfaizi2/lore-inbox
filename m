Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272503AbTGZOlN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272504AbTGZOeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:34:37 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:34368 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S272506AbTGZOcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:35 -0400
Date: Sat, 26 Jul 2003 16:51:42 +0200
Message-Id: <200307261451.h6QEpgws002334@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari ACSI SLM Laser Printer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari ACSI SLM Laser Printer: Remove obsolete parameter of atari_stram_alloc()
call.

--- linux-2.6.x/drivers/block/acsi_slm.c	Tue May 27 19:02:43 2003
+++ linux-m68k-2.6.x/drivers/block/acsi_slm.c	Sun Jun  8 11:05:16 2003
@@ -999,7 +999,7 @@
 		return -EBUSY;
 	}
 	
-	if (!(SLMBuffer = atari_stram_alloc( SLM_BUFFER_SIZE, NULL, "SLM" ))) {
+	if (!(SLMBuffer = atari_stram_alloc( SLM_BUFFER_SIZE, "SLM" ))) {
 		printk( KERN_ERR "Unable to get SLM ST-Ram buffer.\n" );
 		unregister_chrdev( ACSI_MAJOR, "slm" );
 		return -ENOMEM;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
