Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUJaKkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUJaKkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUJaKjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:39:10 -0500
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:36890
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261540AbUJaKDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:44 -0500
Date: Sun, 31 Oct 2004 11:03:41 +0100
Message-Id: <200410311003.i9VA3f6H009703@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 517] M68k: Disable SERIO_I8042, except on Q40/Q60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Disable SERIO_I8042, except on Q40/Q60

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/drivers/input/serio/Kconfig	2004-09-30 12:53:37.000000000 +0200
+++ linux-m68k-2.6.10-rc1/drivers/input/serio/Kconfig	2004-10-27 23:16:43.000000000 +0200
@@ -20,7 +20,7 @@ config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
 	select SERIO
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST)
+	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && (!M68K || Q40)
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
