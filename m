Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVBZE6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVBZE6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 23:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVBZE6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 23:58:46 -0500
Received: from CYRUS.andrew.cmu.edu ([128.2.10.174]:3804 "EHLO
	mail-fe4.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S261756AbVBZE5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 23:57:55 -0500
Message-ID: <422001CD.7020806@andrew.cmu.edu>
Date: Fri, 25 Feb 2005 23:57:49 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org, bruce@andrew.cmu.edu
Subject: Potentially dead bttv cards from 2.6.10
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I've read elsewhere that the following message:
   "tveeprom(bttv internal): Huh, no eeprom present (err=-121)?"
Means that a bttv card is dead.  If so, then I've apparently found a way 
to kill bttv cards in vanilla 2.6.10.  They worked fine a few days ago, 
but after running some "cleaned up" userspace caputure code today it led 
to a hard lockup.  Even after power-cycling the machine the cards no 
longer seem to work in that captured video is garbled.

I was testing only one card, but two were installed in the machine and 
both appear to no longer work, using either S-video or composite input. 
  I don't use the TV-tuners but they are present on the cards.

I can gather more information, and I even have a third card still in its 
box, but obviously I'm hesitant to test anything immediately.  Before 
proceeding I'd like to know any general pointers about how to find out 
what may be wrong, and if anyone knows any potential causes offhand.

I can supply a test case, but It's a large C++ program and kind of 
unweildy.  I'd narrow it down to a small test case but I don't have 
log(N) cards to fry in the process of searching for the root cause.

I would have expected a dud card, but these cards worked flawlessly just 
a few days ago, and both of them died at exactly the same time.

Thanks,
   Jim Bruce

#### Capture Card Model ####
   V-Stream Xpert TV-PVR 878
On the card, the following chip is visible:
   Conexant FUSION 878A
   25878-13
   E403069.1
   0330 TAIWAN

#### Relevant dmesg output ####
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
PCI: Found IRQ 12 for device 0000:00:0b.0
PCI: Sharing IRQ 12 with 0000:00:0b.1
bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 12, latency: 32, mmio: 
0xe3001000
bttv0: using:  *** UNKNOWN/GENERIC ***  [card=0,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=003fffff [init]
tveeprom(bttv internal): Huh, no eeprom present (err=-121)?
bttv0: using tuner=-1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv: Bt8xx card found (1).
PCI: Found IRQ 11 for device 0000:00:0c.0
PCI: Sharing IRQ 11 with 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:0c.1
bttv1: Bt878 (rev 17) at 0000:00:0c.0, irq: 11, latency: 32, mmio: 
0xe3003000
bttv1: using:  *** UNKNOWN/GENERIC ***  [card=0,autodetected]
bttv1: gpio: en=00000000, out=00000000 in=003fffff [init]
tveeprom(bttv internal): Huh, no eeprom present (err=-121)?
bttv1: using tuner=-1
bttv1: i2c: checking for MSP34xx @ 0x80... not found
bttv1: i2c: checking for TDA9875 @ 0xb0... not found
bttv1: i2c: checking for TDA7432 @ 0x8a... not found
bttv1: i2c: checking for TDA9887 @ 0x86... not found
bttv1: registered device video1
bttv1: registered device vbi1
