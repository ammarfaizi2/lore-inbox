Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTELJta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbTELJso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:48:44 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:51502 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262050AbTELJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:14 -0400
Date: Mon, 12 May 2003 11:54:45 +0200
Message-Id: <200305120954.h4C9sjiK001069@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [20/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k fbdev drivers: Update to the new irq API (from Roman Zippel and me) [20/20]

--- linux-2.5.69/drivers/video/console/fbcon.c	Mon May  5 10:32:14 2003
+++ linux-m68k-2.5.69/drivers/video/console/fbcon.c	Tue May  6 13:50:50 2003
@@ -187,6 +187,7 @@
 static irqreturn_t fb_vbl_detect(int irq, void *dummy, struct pt_regs *fp)
 {
 	vbl_detected++;
+	return IRQ_HANDLED;
 }
 #endif
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
