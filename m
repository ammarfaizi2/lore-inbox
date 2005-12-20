Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVLTNSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVLTNSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVLTNSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:18:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6154 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750993AbVLTNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:18:12 -0500
Date: Tue, 20 Dec 2005 14:18:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: 2.6.15-rc6: boot failure in saa7134-alsa.c
Message-ID: <20051220131810.GB6789@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15-rc6 doesn't boot on my computer with an Oops that has 
drivers/media/video/saa7134/saa7134-alsa.c prominently in it's trace.

A picture of the Oops is at [1] (I won't get a price for the best 
picture for it, but it's readable...).

Kernels up to 2.6.14.4 boot fine, 2.6.15-rc1 is the one that introduced 
the problem.

I must give saa7134.card=6 at the lilo prompt for getting my card 
working.

The saa7134 part of the dmesg in 2.6.14.4:

<--  snip  -->

saa7134[0]: found at 0000:00:0e.0, rev: 1, irq: 18, latency: 32, mmio: 0xed800000
saa7134[0]: subsystem: 1131:0000, board: Tevion MD 9717 [card=6,insmod option]
saa7134[0]: board init: gpio is 100a0
saa7134[0]: Huh, no eeprom present (err=-5)?
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
tuner 4-0060: chip found @ 0xc0 (saa7134[0])
tuner 4-0060: All bytes are equal. It is not a TEA5767
tuner 4-0060: type set to 5 (Philips PAL_BG (FI1216 and compatibles))

<--  snip  -->

cu
Adrian

[1] http://www.fs.tum.de/~bunk/TMP/bootcrash.jpg

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

