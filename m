Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUJaKPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUJaKPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUJaKOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:14:46 -0500
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:20562
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261529AbUJaKDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:39 -0500
Date: Sun, 31 Oct 2004 11:03:35 +0100
Message-Id: <200410311003.i9VA3ZVQ009578@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 478] M68k SERIAL_PORT_DFNS only if CONFIG_ISA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k serial: Only define SERIAL_PORT_DFNS when CONFIG_ISA is defined. Otherwise
the first 4 slots in the 8250 driver are unavailable on non-ISA machines.
(from Kars de Jong)

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/include/asm-m68k/serial.h	2004-04-05 15:09:08.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/serial.h	2004-07-14 13:19:48.000000000 +0200
@@ -74,6 +74,8 @@
 #define EXTRA_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_ISA
 #define SERIAL_PORT_DFNS		\
 	STD_SERIAL_PORT_DEFNS		\
 	EXTRA_SERIAL_PORT_DEFNS
+#endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
