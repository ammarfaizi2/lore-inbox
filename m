Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272513AbTGZPSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272536AbTGZOmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:42:06 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:45874 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272538AbTGZOcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:55 -0400
Date: Sat, 26 Jul 2003 16:51:52 +0200
Message-Id: <200307261451.h6QEpq2j002406@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Ns558 gameport warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ns558 gameport: constness of ns558_pnp_driver depends on CONFIG_PNP, causing a
warning if CONFIG_PNP is not set, so make sure it is never const.

--- linux-2.6.x/drivers/input/gameport/ns558.c	Sun Feb 16 12:16:23 2003
+++ linux-m68k-2.6.x/drivers/input/gameport/ns558.c	Mon Jun 23 13:06:27 2003
@@ -243,7 +243,7 @@
 
 #else
 
-static const struct pnp_driver ns558_pnp_driver;
+static struct pnp_driver ns558_pnp_driver;
 
 #endif
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
