Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTEKKoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTEKKVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:21:53 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:50221 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S261218AbTEKKV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:28 -0400
Date: Sun, 11 May 2003 12:30:57 +0200
Message-Id: <200305111030.h4BAUv9N019652@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atafb bug in #if 0 code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atafb bug in #if 0 code (from 2.4.x)

--- linux-2.5.x/drivers/video/atafb.c	Wed Mar 19 11:00:46 2003
+++ linux-m68k-2.5.x/drivers/video/atafb.c	Wed Mar 19 11:00:46 2003
@@ -1193,7 +1193,7 @@
 	par->HBB = gend2 - par->HHT - 2;
 #if 0
 	/* One more Videl constraint: data fetch of two lines must not overlap */
-	if (par->HDB & 0x200  &&  par->HDB & ~0x200 - par->HDE <= 5) {
+	if ((par->HDB & 0x200)  &&  (par->HDB & ~0x200) - par->HDE <= 5) {
 		/* if this happens increase margins, decrease hfreq. */
 	}
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
