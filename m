Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbTI1WQP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 18:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTI1WQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 18:16:15 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:31789 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262716AbTI1WQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 18:16:14 -0400
Date: Sun, 28 Sep 2003 14:55:33 +0200
Message-Id: <200309281255.h8SCtXLS005612@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 323] Amiga Retina Z3 frame buffer device is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Retina Z3 frame buffer device is broken (needs update to new fbdev
framework)

--- linux-2.6.0-test6/drivers/video/Kconfig	Tue Sep  9 10:13:11 2003
+++ linux-m68k-2.6.0-test6/drivers/video/Kconfig	Fri Sep 19 14:32:14 2003
@@ -212,8 +212,8 @@
 	  Cybervision 64 card, as they use incompatible video chips.
 
 config FB_RETINAZ3
-	tristate "Amiga RetinaZ3 support"
-	depends on FB && ZORRO
+	tristate "Amiga Retina Z3 support"
+	depends on FB && ZORRO && BROKEN
 	help
 	  This enables support for the Retina Z3 graphics card. Say N unless
 	  you have a Retina Z3 or plan to get one before you next recompile

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
