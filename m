Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbTEAOEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbTEAOEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:04:04 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:23686 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261272AbTEAODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:03:54 -0400
Message-ID: <3EB12C98.7090604@t-online.de>
Date: Thu, 01 May 2003 16:18:00 +0200
From: Dominik.Strasser@t-online.de (Dominik Strasser)
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Brown <jbrown@emergence.uk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bootsector corruption
References: <3EB0FA98.2080508@t-online.de> <1051790436.16621.8.camel@localhost>
In-Reply-To: <1051790436.16621.8.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Brown wrote:
> I had that problem also and also with an IBM disk. However the rest of
> my setup is very different fom yours:
> 
> abit be6-II
> highpoint hpt366 ide
> acpi on
> grub
> kernel 2.4.20
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> HPT366: onboard version of chipset, pin1=1 pin2=2
> HPT366: IDE controller on PCI bus 00 dev 98
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
> ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio
> HPT366: IDE controller on PCI bus 00 dev 99
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
> ide3: BM-DMA at 0xec00-0xec07, BIOS settings: hdg:pio, hdh:pio
> hda: Pioneer DVD-ROM ATAPIModel DVD-104S 020, ATAPI CD/DVD-ROM drive
> hdc: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
> hde: IC35L080AVVA07-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xd800-0xd807,0xdc02 on irq 11
> blk: queue c038f47c, I/O limit 4095Mb (mask 0xffffffff)
> hde: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63,
> UDMA(66)
> Partition check:
> /dev/ide/host2/bus0/target0/lun0: [PTBL] [10011/255/63] p1 p2 p3 p4
> 
> the disk that I had the problem with was actually a more recent 80Gb
> disk than this. I changed back to my old one partly because of the
> problem.
> 
> I am becoming highly suspicious of IBM hard drives.
Hi Jonathan,
it somehow seems to be Linux related as it never happens with Win98 
which is installed as dual-boot on the same HW.

Regards

Dominik
> 
> Jonathan Brown
> 
> 
> On Thu, 2003-05-01 at 11:44, Dominik Strasser wrote:
> 
>>Hi,
>>I experience the following problem which occurs randomly.
>>
>>After a reboot, the Bootsector is often corrupted. The errors reported 
>>by lilo differ.
>>Today I had 99 (invalid second stage index sector).
>>The problem occurs both on cold and on warm boots.
>>
>>Re-installing lilo helps (until the next corruption).
>>
>>I have a 2.4.20 kernel but the probelem occurs since many kernel revisions.
>>
>>My MoBo is a Gigabyte GA-5AA which is an AT sized ATX board with an ATX 
>>power supply. It has an ALI1543 chipset.
>>APM is active, ACPI isn't.
>>
>>The relevant boot messages are:
>>Uniform Multi-Platform E-IDE driver Revision: 6.31
>>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>>ALI15X3: IDE controller on PCI bus 00 dev 78
>>PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try 
>>using pci=biosirq.
>>ALI15X3: chipset revision 193
>>ALI15X3: not 100% native mode: will probe irqs later
>>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
>>hda: IBM-DJNA-351520, ATA DISK drive
>>hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
>>hdd: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
>>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>ide1 at 0x170-0x177,0x376 on irq 15
>>blk: queue c03781c4, I/O limit 4095Mb (mask 0xffffffff)
>>hda: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=1869/255/63, UDMA(33)
>>hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, (U)DMA
>>Uniform CD-ROM driver Revision: 3.12
>>
>>The CD burner is used via ide-scsi:
>>scsi1 : SCSI host adapter emulation for IDE ATAPI devices
>>   Vendor: LITE-ON   Model: LTR-48246S        Rev: SS0C
>>   Type:   CD-ROM                             ANSI SCSI revision: 02
>>
>>which seems to have some (small) problems which do not affect the 
>>functionality (burning works flawlessly):
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 64
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 66
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 68
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 70
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 72
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 74
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 76
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 78
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 64
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 66
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 68
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 70
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 72
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 74
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 76
>>ide-scsi: hdd: unsupported command in request queue (0)
>>end_request: I/O error, dev 16:40 (hdd), sector 78
>>cdrom: open failed.
>>
>>Any help is greatly appreciated.
>>
>>
>>Regards
>>
>>Dominik
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 


