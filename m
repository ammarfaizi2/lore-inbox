Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSGDI6V>; Thu, 4 Jul 2002 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317381AbSGDI6U>; Thu, 4 Jul 2002 04:58:20 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:16693 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id <S317380AbSGDI6R>;
	Thu, 4 Jul 2002 04:58:17 -0400
Message-ID: <3D240EB9.33B93BFA@vtc.edu.hk>
Date: Thu, 04 Jul 2002 17:00:42 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cmd649 not working with 2 CPU box
References: <Pine.LNX.4.10.10202151709100.10501-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Folks,

Andre Hedrick wrote:

> On Fri, 15 Feb 2002, Nick Urbanik wrote:
>
> > Dear folks,
> >
> > I have tried cmd649 ATA pci cards; they work great with single CPU
> > kernels, not at all with SMP kernels.  The SMP kernel just does not make
> > an entry in /proc/ide.  Some details are in my post on 13 Feb, with
> > subject: cmd649 ok 1 cpu, 2 cpus, not working.  I would appreciate any
> > pointers that may lead to getting them working.

[snip]

> LOL, I had the same question asked to me by CMD and probed to them it
> works.  Obviously you have not configured something correct :-/

I'm sorry to be so thick, but I do not understand why the CMD-649 card is not
getting an interrupt with a 2-CPU kernel, but gets one with a single CPU
kernel.  I have spent some time on trying to get it to work.  I would appreciate
any pointers that anyone can offer.  I will send any information that my be
helpful.  We have had this problem for more than a year.  I have lost sleep over
it!

I have included excerpts from dmesg, and some files from /proc in an earlier
post, but perhaps did not include sufficient info.

Here is part of it again:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x98c0-0x98c7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x98c8-0x98cf, BIOS settings: hdc:DMA, hdd:DMA
CMD649: IDE controller on PCI bus 00 dev 40
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
CMD649: ROM enabled at 0x82100000
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
hda: ATAPI CD-ROM DRIVE 50X MAXIMUM, ATAPI CD/DVD-ROM drive
hdc: ST360021A, ATA DISK drive
hde: ST320420A, ATA DISK drive
hde: IRQ probe failed (0xfffffef8)
hdf: IRQ probe failed (0xfffffef8)
hdf: IRQ probe failed (0xfffffef8)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2: DISABLED, NO IRQ
^^^^^^^^^^^^^^^^^^^^^^____________Oh dear!!!!

> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development

If you can point me to any source of information about these interrupts on SMP
systems, and how they are (or are not) allocated, I would be grateful.

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8579          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



