Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131982AbRCYNP2>; Sun, 25 Mar 2001 08:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131985AbRCYNPS>; Sun, 25 Mar 2001 08:15:18 -0500
Received: from die-macht.oph.RWTH-Aachen.DE ([137.226.147.190]:10111 "EHLO
	die-macht") by vger.kernel.org with ESMTP id <S131982AbRCYNPI>;
	Sun, 25 Mar 2001 08:15:08 -0500
Date: Sun, 25 Mar 2001 15:14:27 +0200 (CEST)
From: Stefan Becker <stefan@oph.rwth-aachen.de>
To: linux-kernel@vger.kernel.org
cc: Gerd Knorr <kraxel@strusel007.de>
Subject: Problem with bttv in 2.4.3-pre[567]
Message-ID: <Pine.LNX.4.21.0103251456470.27626-100000@die-macht>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.4.3pre5 must have changed something so that the bttv driver doesn't work
here anymore. Pre6 and pre7 the same, pre4 works.

I've diff'ed 2.4.3pre4/drivers/media/video and
2.4.3pre5/drivers/media/video but there were no changes. 

Excerpt from the syslog (I've set unsigned int bttv_debug = 1; in
bttv-driver.c)

unknown kernel: bttv0: open called
unknown kernel: bttv0: resetting chip
unknown kernel: bttv0: irq loop=0 risc=0, bits: HSYNC OFLOW HLOCK* VPRES*   HLOC => yes   PRES => yes
unknown kernel: bttv0: PLL: 28636363 => 35468950 ... <7>bttv0: irq loop=0 risc=0, bits: HSYNC HLOCK*   HLOC => no
unknown kernel: ok
unknown kernel: bttv0: open called
unknown last message repeated 2 times
unknown kernel: bttv0: irq loop=0 risc=0, bits: VSYNC HSYNC HLOCK*   HLOC => yes
unknown kernel: bttv0: open called
unknown last message repeated 6 times
unknown kernel: bttv0: irq loop=0 risc=0, bits: VSYNC HSYNC HLOCK* VPRES*   HLOC => no   PRES => no
unknown kernel: bttv0: irq loop=0 risc=0, bits: HSYNC HLOCK* VPRES*   HLOC => yes   PRES => yes
unknown kernel: bttv0: open called
unknown last message repeated 2 times
unknown kernel: Display at df600000 is 384 by 288, bytedepth 2, bpl 768
unknown kernel: bttv0: clip: ro=17e80000 re=17e78000
unknown kernel: bttv0: irq loop=0 risc=0, bits: VSYNC HSYNC OCERR*
unknown kernel: bttv0: irq: OCERR risc_count=df600304
unknown kernel: bttv0: irq loop=0 risc=0, bits: HSYNC SCERR*
unknown kernel: bttv0: irq: SCERR risc_count=17e80014
unknown kernel: bttv0: irq loop=1 risc=0, bits: HSYNC SCERR*
unknown kernel: bttv0: irq: SCERR risc_count=17e8001c
unknown kernel: bttv0: irq loop=0 risc=0, bits: VSYNC HSYNC OCERR*
unknown kernel: bttv0: irq: OCERR risc_count=17e8001c
unknown kernel: bttv0: irq loop=0 risc=0, bits: VSYNC HSYNC OCERR*
unknown kernel: bttv0: irq: OCERR risc_count=17e8001c
unknown kernel: bttv0: aiee: error loops

After that, the contents of the xawtv window freezes.

Greetings,
Stefan Becker

