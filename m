Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282707AbRLGL1T>; Fri, 7 Dec 2001 06:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285462AbRLGL1G>; Fri, 7 Dec 2001 06:27:06 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:20405 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S285455AbRLGL0s>;
	Fri, 7 Dec 2001 06:26:48 -0500
Message-ID: <3C115106.BED6616D@sltnet.lk>
Date: Fri, 07 Dec 2001 17:30:14 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-lightening i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: IDE-DMA woes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.
	I run Linux on an IBM PC300GL with Intel's
82371AB PIIX4 chipset. With DMA enabled (by doing a
hdparm -d1 /dev/hda) on the hdd, I
_sometimes_ get the following message from the kernel
after resuming from APM standby mode:

ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hda: status error: error=0x84 { DriveStatusError BadCRC }
hda: drive not ready for command

then the drive stalls for a few seconds, and the driver
disables DMA. This behaviour doesn't seem to depend on the
kernel version (current: 2.4.14; error seen with 2.2 series also.)
The weird thing is that this is not reliably reproducable; most of
the time the system goes to apm standby (not suspend) and resumes fine.

Other (possibly relevent) boot-time messages (in order
of appearance):

IBM machine detected. Enabling interrupts during APM calls.
kernel: PIIX4: IDE controller on PCI bus 00 dev 11
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL EX3.2A, ATA DISK drive
hdc: SONY CD-ROM CDU5221, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
