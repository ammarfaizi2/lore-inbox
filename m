Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTI1WqT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 18:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTI1WqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 18:46:19 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:20532 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262736AbTI1WqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 18:46:18 -0400
Date: Sun, 28 Sep 2003 14:55:31 +0200
Message-Id: <200309281255.h8SCtVcp005600@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 321] Atari frame buffer device is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari frame buffer device is broken (needs update to new fbdev framework and
new iplan2p* drawing operations)

--- linux-2.6.0-test6/drivers/video/Kconfig	Tue Sep  9 10:13:11 2003
+++ linux-m68k-2.6.0-test6/drivers/video/Kconfig	Fri Sep 19 14:32:14 2003
@@ -228,7 +228,7 @@
 
 config FB_ATARI
 	bool "Atari native chipset support"
-	depends on FB && ATARI
+	depends on FB && ATARI && BROKEN
 	help
 	  This is the frame buffer device driver for the builtin graphics
 	  chipset found in Ataris.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
