Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVGJQ6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVGJQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 12:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVGJQ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 12:58:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9990 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261918AbVGJQ6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 12:58:44 -0400
Date: Sun, 10 Jul 2005 18:58:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: mchehab@brturbo.com.br, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: saa7134 card no longer working
Message-ID: <20050710165839.GQ28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I observed the following problem with a Tevion MD 9717 card:

It works in 2.6.12-rc6-mm1, but AFAIR this was the last kernel where it 
worked, in more recent kernels (including 2.6.13-rc2-mm1) tvtime only 
says "no signal".

dmesg output with 2.6.12-rc6-mm1:
saa7134[0]: found at 0000:00:0a.0, rev: 1, irq: 6, latency: 32, mmio: 0xcfffcc00
saa7134[0]: subsystem: 1131:0000, board: Tevion MD 9717 [card=6,insmod option]
saa7134[0]: board init: gpio is 100a0
saa7134[0]: Huh, no eeprom present (err=-5)?
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
tuner 4-0060: chip found @ 0xc0 (saa7134[0])
tuner 4-0060: type set to 5 (Philips PAL_BG (FI1216 and compatibles))

In 2.6.13-rc2-mm1 there's an additional line
tuner 4-0060: All bytes are equal. It is not a TEA5767

I'm always saying "saa7134.card=6" at the kernel command line since I 
got a "no eeprom present" message from the driver without this.

The card is working with 2.6.12-rc6-mm1, but during running, I 
occasionally get the following message in the syslog:
saa7134[0]/audio: audio carrier scan failed, using 5.500 MHz [last detected]

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

