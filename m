Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261671AbSI2Njy>; Sun, 29 Sep 2002 09:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262474AbSI2Njy>; Sun, 29 Sep 2002 09:39:54 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37506 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261671AbSI2Njx>;
	Sun, 29 Sep 2002 09:39:53 -0400
Date: Sun, 29 Sep 2002 15:45:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephan Maciej <stephan@maciej.muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Startup: "DMA disabled" on VIA vt82c686b IDE UDMA100, Kernel 2.5.38
Message-ID: <20020929154511.A10879@ucw.cz>
References: <200209270313.20670.stephan@maciej.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209270313.20670.stephan@maciej.muc.de>; from stephan@maciej.muc.de on Fri, Sep 27, 2002 at 03:13:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 03:13:20AM +0200, Stephan Maciej wrote:

> I just managed to compile and boot a 2.5.38 kernel on my Sony Vaio Laptop. I 
> run the kernel for about half an hour now, XWindows, KDE working fine, even 
> my USB mouse is working --  but I can't use my touchpad in parallel... :-(

What's the problem with the touchpad exactly?

> Nevertheless, great work so far. But I have found this in my startup dmesg:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
> hda: HITACHI_DK23CA-20, ATA DISK drive
> hda: DMA disabled
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
> hdc: DMA disabled
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63, UDMA(100)
>  hda: hda1 hda2 hda3
> hdc: ATAPI 61X DVD-ROM drive, 512kB Cache, UDMA(33)
> 
> [ Ahem, well, my DVD ROM drive was supposed to be 24x CD/8x DVD, but that's 
> okay. ]
> 
> /proc/ide/via says that my HD is running UDMA100 and my 61x ;-) DVD-ROM runs 
> UDMA33. As a hdparm -t -T tells me about 150Mb/sec throughput (buffered) and 
> 20Mb/sec (disk) reads, I suppose BMDMA is really on.
> 
> Why does this message appear then?

Its disabled only during boot.

-- 
Vojtech Pavlik
SuSE Labs
