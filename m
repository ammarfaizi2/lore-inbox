Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUGTTmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUGTTmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUGTSiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:38:54 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:28437 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S266129AbUGTSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:05 -0400
Date: Tue, 20 Jul 2004 20:38:04 +0200
Message-Id: <200407201838.i6KIc4KF015404@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 467] dsp56k sparse const
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari dsp56k: Add missing `const' keywords (found by sparse)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/char/dsp56k.c	2004-05-03 20:04:47.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/char/dsp56k.c	2004-07-10 21:07:36.000000000 +0200
@@ -293,10 +293,10 @@
 		}
 		case 2:  /* 16 bit */
 		{
-			short *data;
+			const short *data;
 
 			count /= 2;
-			data = (short*) buf;
+			data = (const short *)buf;
 			handshake(count, dsp56k.maxio, dsp56k.timeout, DSP56K_TRANSMIT,
 				  get_user(dsp56k_host_interface.data.w[1], data+n++));
 			return 2*n;
@@ -312,10 +312,10 @@
 		}
 		case 4:  /* 32 bit */
 		{
-			long *data;
+			const long *data;
 
 			count /= 4;
-			data = (long*) buf;
+			data = (const long *)buf;
 			handshake(count, dsp56k.maxio, dsp56k.timeout, DSP56K_TRANSMIT,
 				  get_user(dsp56k_host_interface.data.l, data+n++));
 			return 4*n;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
