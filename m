Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUGTT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUGTT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUGTTnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:43:10 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:43095 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266147AbUGTSjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:44 -0400
Date: Tue, 20 Jul 2004 20:39:42 +0200
Message-Id: <200407201839.i6KIdgEQ015495@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] depends on PCI: ATI Rage 128 and Radeon DRM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ATI Rage 128 and Radeon DRM unconditionally depend on PCI

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/char/drm/Kconfig	2004-07-15 23:14:12.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/char/drm/Kconfig	2004-07-19 18:15:58.000000000 +0200
@@ -31,7 +31,7 @@
 
 config DRM_R128
 	tristate "ATI Rage 128"
-	depends on DRM
+	depends on DRM && PCI
 	help
 	  Choose this option if you have an ATI Rage 128 graphics card.  If M
 	  is selected, the module will be called r128.  AGP support for
@@ -39,7 +39,7 @@
 
 config DRM_RADEON
 	tristate "ATI Radeon"
-	depends on DRM
+	depends on DRM && PCI
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
