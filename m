Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSFLXjl>; Wed, 12 Jun 2002 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSFLXjk>; Wed, 12 Jun 2002 19:39:40 -0400
Received: from opus.INS.CWRU.Edu ([129.22.8.2]:38632 "EHLO opus.INS.cwru.edu")
	by vger.kernel.org with ESMTP id <S316886AbSFLXji>;
	Wed, 12 Jun 2002 19:39:38 -0400
From: "Braden McGrath" <bwm3@po.cwru.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Kernel 2.4.18 Promise driver (IDE) hangs @ boot with Promise 20267
Date: Wed, 12 Jun 2002 19:42:09 -0400
Message-ID: <007201c2126a$c4abc520$ceaa1681@z>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <1023894033.31270.195.camel@flory.corp.rackablelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, at Samuel Flory's suggestion I tried 2.4.19-pre10-ac2.

Same problem, it hangs whilst trying to find the drives attached to the
Promise controller.    Manually adding the geometries makes it panic,
similar to with 2.4.18.

Mr. Flory mentioned earlier that some of my omitted lines during the
boot process were helpful, so I will include them ALL here...

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
PDC20267: IDE controller on PCI bus 00 dev 68
PCI: Found IRQ 7 for device 00:0d.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 10 for device 00:13.0
PCI: Sharing IRQ 10 with 00:13.1
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide4: BM-DMA at 0xb400-0xb407, BIOS settings: hdi:pio, hdj:pio
HPT366: IDE controller on PCI bus 00 dev 99
PCI: Found IRQ 10 for device 00:13.1
PCI: Sharing IRQ 10 with 00:13.0
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide5: BM-DMA at 0xc000-0xc007, BIOS settings: hdk:pio, hdl:pio
hda: Maxtor 91024U4, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
hde: Maxtor 91366U4, ATA DISK drive
hdf: Maxtor 52049U4, ATA DISK drive
hdg: Maxtor 93073U6, ATA DISK drive
hdh: MAXTOR 4K080H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9400-0x9407,0x9802 on irq 7
ide3 at 0x9c00-0x9c07,0xa002 on irq 7
hda: 19999728 sectors (10240 MB) w/2048KiB Cache, CHS=1244/255/63,
UDMA(33)
***********
hde: 26684784 sectors (13663 MB) w/2048KiB Cache, CHS=26473/16/63
hdf: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63
hdg: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63
hdh: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
 hde: [PTBL] [1661/255/63] hde1
 hdf: hdf1
 hdg: hdg1
 hdh: hdh1
... [Etc] ...

This is my boot process with my old kernel, which has the standard IDE,
PIIX, and HPT366 compiled in but NO Promise driver.  Obviously, the
drives are found fine here and they do work... Just slow.  :/  The line
with the ******* is where output stops when I use a kernel with the
Promise driver compiled.  I don't WANT to use the HPT366 anymore, but
there is NO way to disable it on my motherboard.  Part of me wonders if
it is causing a problem, but I don't see any resources being shared...

--Braden

