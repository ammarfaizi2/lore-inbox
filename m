Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTI2Ihw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbTI2Ihw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:37:52 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:8219 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262886AbTI2Ihu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:50 -0400
Date: Mon, 29 Sep 2003 10:39:07 +0200
Message-Id: <200309290839.h8T8d7Xh003664@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 297] m68k zImage
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m68k: Build a zImage (vmlinux.gz) instead of an uncompressed image by default

--- linux-2.6.0-test6/arch/m68k/Makefile	Tue Jul 29 18:18:35 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/Makefile	Wed Sep  3 13:16:32 2003
@@ -76,6 +76,8 @@
 core-$(CONFIG_M68060)		+= arch/m68k/ifpsp060/
 core-$(CONFIG_M68KFPU_EMU)	+= arch/m68k/math-emu/
 
+all:	zImage
+
 lilo:	vmlinux
 	if [ -f $(INSTALL_PATH)/vmlinux ]; then mv -f $(INSTALL_PATH)/vmlinux $(INSTALL_PATH)/vmlinux.old; fi
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv -f $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
