Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318552AbSIKJHQ>; Wed, 11 Sep 2002 05:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSIKJHQ>; Wed, 11 Sep 2002 05:07:16 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:530 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318552AbSIKJHP>; Wed, 11 Sep 2002 05:07:15 -0400
Date: Wed, 11 Sep 2002 11:11:56 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kwijibo@zianet.com, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <20020830.164350.04709191.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209111103380.8874-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

On Fri, 30 Aug 2002, David S. Miller wrote:

> 
> Hey Roland, can you give these patches a try for your problem?
> I am very confident it will fix your bug.
> 
Sorry for the big delay, but only today I was allowed to reboot one of the 
machines. Sorry again for not being of any help: I could not boot 2.4.20-pre5! 
It stopped inside the AGPGART code (part of this is taken from a clean 2.4.19 
boot because someone had to read it from screen and tell me by phone):

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD400BB-00CAA1, ATA DISK drive
hdc: LTN526D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected AMD 760MP chipset
spurious 8259A interrupt: IRQ7.

Normally it would print the aperture size, but this did not happen, the machine 
simply froze. However, it took some time for the spurious interrupt to appear.

I would be glad to test your patches with 2.4.19, but as I understand I would 
have to incorporate the NAPI changes as well? Would it be possible to create a 
patch for 2.4.19?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

"If you think NT is the answer, you didn't understand the question."
						- Paul Stephens

