Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268316AbTAMWdb>; Mon, 13 Jan 2003 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268383AbTAMWbl>; Mon, 13 Jan 2003 17:31:41 -0500
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:61320
	"EHLO efix.biz") by vger.kernel.org with ESMTP id <S268378AbTAMW3y>;
	Mon, 13 Jan 2003 17:29:54 -0500
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400
From: Edward Tandi <ed@efix.biz>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1042495829.1223.10.camel@sun>
References: <1042495829.1223.10.camel@sun>
Content-Type: text/plain
Organization: 
Message-Id: <1042497524.2819.51.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Jan 2003 22:38:44 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 22:10, Soeren Sonnenburg wrote:
> [...]
> > I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard.
> > The processor is a 1.5GHz Athlon XP. I started experimenting with
> > new-ish kernels again because of the general lack of kernel support
> > for this chipset in stock kernels. 3 questions below:
> 
> Hey finally someone with my setup :-))
> 
> > 1) I have 1GB ram, but I cannot get high memory support to work. It
> > falls over during boot. I've seen discussions about AMD cache issues,
> > but has it been fixed yet? Is it supposed to work?
> 
> I am using older kernels (2.4.20) and it seems to work...

Yes, but as you mention below, it is unstable.

> > 2) The audio driver. It works and this is the main reason why I use
> > this version of the kernel. The issue I have with it, is that if I
> > start certain applications (gaim, macromedia flash player 6 for
> > example), esd gets itself into some kind of hung/blocked state. When
> > this happens, I need to kill -9 esd and re-start it. Games and xmms
> > work however. The reason I ask about this is that the downloaded
> > driver from the viaarena works on a stock kernel without this glitch.
> > Is this a known problem?
> 
> I use the alsa 0.9 driver and never had a problem like that...

OK. I am using the OSS driver. Still, it should work normally.

> 3) I get the following messages at boot-time:
> [...]
> > Jan 13 18:23:05 wires kernel: hda: dma_intr: error=0x84 {
> > DriveStatusError BadCRC }
> > Jan 13 18:23:05 wires kernel: blk: queue c0437940, I/O limit 4095Mb
> > (mask 0xffffffff)
> > Jan 13 18:23:05 wires kernel: hdb: DMA disabled
> > Jan 13 18:23:05 wires kernel: ide0: reset: success
> > Jan 13 18:23:05 wires kernel: spurious 8259A interrupt: IRQ7.
> 
> > Naturally, this is quite alarming. Everything works though, so am I
> > safe in just ignoring this noise?
> 
> That sounds like a bad cable. Do you use 80wires ide cables, connectors
> attached to the ends ?

No, but my drives are old and only support UDMA 2 anyway. I get most
things off the LAN. It should really enable UDMA 2.

> however I also get this spurious interrupt and it might be alarming...
> 
> > 4) Does anyone know whether I can get the ethernet interface to work
> > using stock kernel net device drivers (yes VIA supply the source, but
> > I'd rather use stock drivers)? I thought it was the via-rhine driver,
> > but it doesn't seem to recognise the chip. Anyone got it working?
> 
> just have a look at the cdrom supplied with your mainboard. there is a
> GPLed bcm4400 driver on that disk... 

This is good to know. It would be nice to see it in the 2.4 kernel
though. I believe the 2.5 series already has a driver.

> > I'd appreciate some help with this (great) motherboard.
> 
> well I have all kinds of trouble here (-> freezes)... I still hope that
> it is not the via chipset nor the mainboard causing it this time.

Mine is rock solid (as long as I don't enable highmem). Also, I still
compile with gcc 2.96 and the "athlon" option.

Thanks, I will try the bcm4400 driver.

Ed-T.


