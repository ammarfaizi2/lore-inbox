Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTEAKac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 06:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbTEAKac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 06:30:32 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:12451 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261203AbTEAKaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 06:30:30 -0400
Message-ID: <3EB0FA98.2080508@t-online.de>
Date: Thu, 01 May 2003 12:44:40 +0200
From: Dominik.Strasser@t-online.de (Dominik Strasser)
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bootsector corruption
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I experience the following problem which occurs randomly.

After a reboot, the Bootsector is often corrupted. The errors reported 
by lilo differ.
Today I had 99 (invalid second stage index sector).
The problem occurs both on cold and on warm boots.

Re-installing lilo helps (until the next corruption).

I have a 2.4.20 kernel but the probelem occurs since many kernel revisions.

My MoBo is a Gigabyte GA-5AA which is an AT sized ATX board with an ATX 
power supply. It has an ALI1543 chipset.
APM is active, ACPI isn't.

The relevant boot messages are:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try 
using pci=biosirq.
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DJNA-351520, ATA DISK drive
hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03781c4, I/O limit 4095Mb (mask 0xffffffff)
hda: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=1869/255/63, UDMA(33)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12

The CD burner is used via ide-scsi:
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: LITE-ON   Model: LTR-48246S        Rev: SS0C
   Type:   CD-ROM                             ANSI SCSI revision: 02

which seems to have some (small) problems which do not affect the 
functionality (burning works flawlessly):
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 64
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 66
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 68
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 70
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 72
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 74
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 76
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 78
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 64
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 66
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 68
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 70
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 72
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 74
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 76
ide-scsi: hdd: unsupported command in request queue (0)
end_request: I/O error, dev 16:40 (hdd), sector 78
cdrom: open failed.

Any help is greatly appreciated.


Regards

Dominik

