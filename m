Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUAAURC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAAUQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:16:22 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:58421 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S265078AbUAAUKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:10:17 -0500
Date: Thu, 1 Jan 2004 21:01:45 +0100
Message-Id: <200401012001.i01K1iUK031672@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 339] M68k floppy selection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Floppy: On m68k, PC-style floppies are used on Q40/Q60 and Sun-3x only. Sun-3x
floppy is currently broken (needs I/O abstractions)

--- linux-2.6.0/drivers/block/Kconfig	Thu Oct  9 10:02:38 2003
+++ linux-m68k-2.6.0/drivers/block/Kconfig	Thu Oct  9 17:38:53 2003
@@ -6,7 +6,7 @@
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on !X86_PC9800 && !ARCH_S390
+	depends on (!X86_PC9800 && !ARCH_S390 && !M68K) || Q40 || (SUN3X && BROKEN)
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
