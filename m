Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbTI1UxW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTI1UxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:53:22 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:15952 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S262748AbTI1UxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:53:21 -0400
Date: Sun, 28 Sep 2003 14:55:34 +0200
Message-Id: <200309281255.h8SCtYX9005618@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 324] Amiga Cybervision 64/3D frame buffer device is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga Cybervision 64/3D frame buffer device is broken (needs update to new
fbdev framework)

--- linux-2.6.0-test6/drivers/video/Kconfig	Tue Sep  9 10:13:11 2003
+++ linux-m68k-2.6.0-test6/drivers/video/Kconfig	Fri Sep 19 14:32:14 2003
@@ -198,11 +198,11 @@
 	  you have any questions, be sure to ask!). Say N unless you have a
 	  Cybervision 64 or plan to get one before you next recompile the
 	  kernel. Please note that this driver DOES NOT support the
-	  Cybervision 64 3D card, as they use incompatible video chips.
+	  Cybervision 64/3D card, as they use incompatible video chips.
 
 config FB_VIRGE
-	bool "Amiga CyberVision3D support "
-	depends on FB && ZORRO
+	bool "Amiga CyberVision 64/3D support "
+	depends on FB && ZORRO && BROKEN
 	help
 	  This enables support for the Cybervision 64/3D graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
