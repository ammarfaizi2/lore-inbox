Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270109AbTGZPY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272547AbTGZOl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:41:27 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:47454 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S272535AbTGZOcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:53 -0400
Date: Sat, 26 Jul 2003 16:52:01 +0200
Message-Id: <200307261452.h6QEq1MX002496@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmasound SOUND_PCM_READ_RATE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmasound: Implement missing SOUND_PCM_READ_RATE ioctl (from Richard Zidlicky)

--- linux-2.6.x/sound/oss/dmasound/dmasound_core.c	Mon Jul 14 13:16:18 2003
+++ linux-m68k-2.6.x/sound/oss/dmasound/dmasound_core.c	Wed Jul 23 18:01:30 2003
@@ -1210,6 +1210,8 @@
 			shared_resources_initialised = 0 ;
 		return result ;
 		break ;
+	case SOUND_PCM_READ_RATE:
+		return IOCTL_OUT(arg, dmasound.soft.speed);
 	case SNDCTL_DSP_SPEED:
 		/* changing this on the fly will have weird effects on the sound.
 		   Where there are rate conversions implemented in soft form - it

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
