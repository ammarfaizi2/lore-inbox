Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932805AbWAORxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbWAORxb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbWAORxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:53:31 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:9887 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932805AbWAORxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:53:31 -0500
Message-ID: <43CA8C15.8010402@cfl.rr.com>
Date: Sun, 15 Jan 2006 12:53:25 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Damian Pietras <daper@daper.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net>
In-Reply-To: <20060115123546.GA21609@daper.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently working on improving the udftools package in ubuntu to 
make it actually usable.  In its current state it is only suitable for 
experimentation.  See the thread titled "[PATCH] pktcdvd & udf bugfixes" 
on this mailing list for more information.

Eject works fine for me though so I'm not sure what the problem is.  You 
might want to try using the stock 2.6.12 breezy kernel on your breezy 
install, instead of your home built 2.6.15-mm kernel.  I'm running the 
stock 2.6.15 kernel on my dapper install and eject works just fine once 
unmounted.

If you feel like building the package and testing it, it's up on REVU 
right now at http://revu.tauware.de/details.py?upid=1433

That contains a few bug fixes discussed in the other thread I refered 
you to.  I am still trying to get the package integrated with hal so 
it's all plug and play automagic, but running into some trouble there.

Damian Pietras wrote:
> Recently I bought a NEC ND-4551A CD/DVD writer. It works OK with one
> exception. When I have a packet device associated with the drive, there
> are problems with ejecting discs.
> 
> Here is an example:
> 
> 1. Insert a CD-R/DVD/CD-RW (whatever)
> 2. mount /media/cdrom0
> 3. umount /media/cdrom0
> 
> Now the eject button doesn't work, when I issue the eject command I get:
> 
> hda: irq timeout: status=0xd0 { Busy }
> ide: failed opcode was: unknown
> hda: DMA disabled
> hda: ATAPI reset complete
> 
> After few seconds eject ends with no result. Second eject command works.
> 
> There are no problems without the packet device association (turned
> off/on with pktsetup using /etc/init.d/udftools).
> 
> My system if Ubuntu 5.10
> The kernel is:
> Linux amd 2.6.15-mm3 #1 PREEMPT Sun Jan 15 12:31:14 CET 2006 i686
> GNU/Linux
> But it works the same way with 2.6.15.
> 
> Part of my dmesg related to IDE:
> 
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 10 (level, low)
>  -> IRQ 10
> PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 10
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>     ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: _NEC DVD_RW ND-4551A, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> Probing IDE interface ide1...
> Probing IDE interface ide1...
> 

