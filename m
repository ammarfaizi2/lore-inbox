Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTFLSFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbTFLSFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:05:05 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:18955 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S264930AbTFLSE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:04:57 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Thu, 12 Jun 2003 20:18:42 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: ide0: reset: master: ECC circuitry error
Message-ID: <Pine.OSF.4.51.0306121955001.303628@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  with linux kernel-2.4.21-rc8-acpi-20030522 and

I see the following in dmesg output:

Freeing unused kernel memory: 132k freed
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: status timeout: status=0xd0 { Busy }

hda: DMA disabled
hda: drive not ready for command
hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete DataRequest }
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04 { DriveStatusError }
ide0: reset: master: ECC circuitry error


I saw this with earlier kernels ... In principle the laptop ASUS 3800C
works fine. It happens only when "hdparm -d1 /dev/discs/disc0/disc" is
executed during boot. The ide devices are:

hda: HITACHI_DK23EA-60, ATA DISK drive
blk: queue c04429a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117210240 sectors (60012 MB) w/2048KiB Cache, CHS=7296/255/63, UDMA(100)
hdc: attached ide-scsi driver.
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1713
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray


Any ideas how to reproduce this or even better, how to get rid of it?
Thanks.
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
