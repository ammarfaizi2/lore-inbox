Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVB1OpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVB1OpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVB1OpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:45:14 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:59064 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261389AbVB1OnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:43:13 -0500
Message-ID: <42232DFC.6090000@andrew.cmu.edu>
Date: Mon, 28 Feb 2005 09:43:08 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex>
In-Reply-To: <20050228134410.GA7499@bytesex>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, are there any theories as to why it would work flawlessly, then 
after a hard lockup (due to what I think is a buggy V4L2 application), 
that the cards no longer work?  That was with 2.6.10, but after they 
started failing I tried 2.6.11-rc5 and it doesn't work either.  By the 
way, I sent the wrong output; what I sent was from 2.6.11-rc5.  The 
2.6.10 output is below, and looks similar except for generating a 
different error message.

An example of the kind of output I get from capture is here:
	http://sponge.coral.cs.cmu.edu/~jbruce/temp/img0000.jpg
Which has some of the right colors, but all in the wrong places. 
Tracking seems to be off because the capture happens at irregular 
intervals.  The following is the sort of thing a working card would produce:
	http://sponge.coral.cs.cmu.edu/~jbruce/temp/overhead-view.jpg
Note that the two images should not be the same however, as one is from 
almost a year ago.  I didn't save any of the recent working ones 
unfortunately.  The camera S-video link still looks fine on a monitor, 
and testing with a different camera and component video yields the same 
sort of scrambled results as the first image above.

The reason I think my problem is possibly important is that I think I 
potentially found a way to PERMANENTLY KILL a bttv card FROM USERSPACE 
(emphasis added for any bttv users only half reading at this point).

In our case these are cards bought by our lab, and they were only $40 
each, so they can be replaced.  It'd be nice to protect other users from 
this problem however, since they may not be able to replace their cards 
as readily.  Well also for me, since to get money for new cards I'd have 
to make the case that they wouldn't also blow up after a few days of use[1].

Thanks,
   Jim Bruce

[1] The cards are actually >1 year old, but they sat in a running Linux 
machine without the bttv drivers loaded.  They died after 3 days of 
working flawlessly in a new machine where they were actually being used.

Gerd Knorr wrote:
> On Fri, Feb 25, 2005 at 11:57:49PM -0500, James Bruce wrote:
> 
>>Hi I've read elsewhere that the following message:
>>  "tveeprom(bttv internal): Huh, no eeprom present (err=-121)?"
>>Means that a bttv card is dead.
> 
> 
> Or i2c communication to the eeprom failed.  There used to be some -mm
> kernels with experimental i2c stuff causing this ...
> 
>   Gerd
> 

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
bttv: readee error
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
bttv: readee error
bttv1: using tuner=-1
bttv1: i2c: checking for MSP34xx @ 0x80... not found
bttv1: i2c: checking for TDA9875 @ 0xb0... not found
bttv1: i2c: checking for TDA7432 @ 0x8a... not found
bttv1: i2c: checking for TDA9887 @ 0x86... not found
bttv1: registered device video1
bttv1: registered device vbi1
