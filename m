Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272717AbRI3G50>; Sun, 30 Sep 2001 02:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272736AbRI3G5Q>; Sun, 30 Sep 2001 02:57:16 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:25477 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S272717AbRI3G5H>;
	Sun, 30 Sep 2001 02:57:07 -0400
Date: Sun, 30 Sep 2001 08:57:31 +0200
From: Ookhoi <ookhoi@dds.nl>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine) (solved)
Message-ID: <20010930085730.G9327@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010929162224.E9327@humilis> <200109300011.f8U0BGY58130@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109300011.f8U0BGY58130@aslan.scsiguy.com>
User-Agent: Mutt/1.3.19i
X-Uptime: 20:50:40 up 1 day, 9 min,  9 users,  load average: 0.08, 0.12, 0.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

> >The new driver for the Adaptec 7892B gives me the following problems
> >(see dmesg) on a asus a7v mobo with kernel 2.4.9-ac17.
> >
> >I have to run the system underclocked to make it boot at all. As soon
> >as I run it at 1000 or 1200 MHz, it does a Kernel panic: for safety
> >during the scsi boot part. It is a 1200MHz processor. The system runs
> >fine after the (long) boot.
> 
> IIRC, the a7v is an AMD processor with VIA chipset. If you go into the
> MB BIOS and disable all of the "Make my PCI bus go as fast as possible
> even if this means violating the spec" options, the "new" aic7xxx
> driver should work fine. I wish VIA would get a clue.

It is indeed an AMD system with the VIA KT133 chipset.

I played with the bios settings to find out with which option it would
or would not give trouble. Under Advanced, CHIP Configuration the option
Byte Merge has to be disabled to make the kernel boot fine with the new
aic7xxx driver. This is with kernel 2.4.9-ac18

The bios manual says:
Byte Merge [Enabled by default]
To optimize the data transfer on PCI, this merges a sequence of
individual memory writes (bytes or words) into a single 32-bit block of
data. However, byte merging may only be done when the bytes within a
data phase are in a prefetchable address range. Configuration options:
[Disabled] [Enabled]

Why does the old driver boot fine with this enabled, and has the new
driver troubles booting then? The system seemed to run fine after the
long boot with the new driver and byte merge enabled, so it seemes that
only the boot gives troubles. The system didn't always boot till the end
with the new kernel and byte merge enabled btw, as it sometimes stopped
with the message: Kernel panic: for safety

Anyway, thank you for the hint! It all works fine now. :-)

	Ookhoi
