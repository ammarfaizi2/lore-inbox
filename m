Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272542AbTGZOds (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272541AbTGZOds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:33:48 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:48406 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272499AbTGZOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:23 -0400
Date: Sat, 26 Jul 2003 16:51:28 +0200
Message-Id: <200307261451.h6QEpSeQ002268@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Valkyriefb link fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valkyriefb: Fix link error by adding missing macmodes.o (for Mac/m68k) and cfb*
(for Mac/m68k and PowerMac/PPC) object files

--- linux-2.6.x/drivers/video/Makefile	Tue Apr  8 10:05:26 2003
+++ linux-m68k-2.6.x/drivers/video/Makefile	Sun May 25 15:40:39 2003
@@ -26,7 +26,7 @@
 obj-$(CONFIG_FB_IGA)              += igafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CONTROL)          += controlfb.o
 obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o
-obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o
+obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CT65550)          += chipsfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_ANAKIN)           += anakinfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
