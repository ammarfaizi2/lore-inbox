Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTH2O6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTH2O5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:57:36 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:28985 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261317AbTH2OwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:07 -0400
Date: Fri, 29 Aug 2003 16:51:08 +0200
Message-Id: <200308291451.h7TEp8hY005914@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmasound SOUND_PCM_READ_RATE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmasound: Implement missing SOUND_PCM_READ_RATE ioctl (from Richard Zidlicky)

--- linux-2.4.23-pre1/drivers/sound/dmasound/dmasound_core.c	Mon Jul 21 23:39:01 2003
+++ linux-m68k-2.4.23-pre1/drivers/sound/dmasound/dmasound_core.c	Wed Jul 23 17:58:36 2003
@@ -1211,6 +1211,8 @@
 			shared_resources_initialised = 0 ;
 		return result ;
 		break ;
+	case SOUND_PCM_READ_RATE:
+		return IOCTL_OUT(arg, dmasound.soft.speed);
 	case SNDCTL_DSP_SPEED:
 		/* Changing this on the fly will have weird effects on the sound.
 		   Where there are rate conversions implemented in soft form - it

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
