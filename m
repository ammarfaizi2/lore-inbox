Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVCOAdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVCOAdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVCOAcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:32:08 -0500
Received: from alog0178.analogic.com ([208.224.220.193]:21700 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262156AbVCOAa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:30:57 -0500
Date: Mon, 14 Mar 2005 19:28:59 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Awful long timeouts for flash-file-system
Message-ID: <Pine.LNX.4.61.0503141916420.6463@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello IDE experts.

I am trying to use a SanDisk SDCFB-256, CFA DISK drive. This
is supposed to emulate an IDE drive and does (sort of). However,
upon boot, the boot-code keeps trying and trying and trying to
do SOMETHING that aparently isn't even necessary because the
virtual disk is accessible and can be written/read and I can
even boot from it.

But when it is on a system that is booting from a real drive,
I get the following errors, each one taking 15 seconds to time-
out. This runs the boot-time of a workstation that's supposed
to write stuff to these disks up to unacceptible limits
(5 minutes). It's like booting an old VAX.

Is there a fix for whatever the startup-code is trying to do?

Also, note that even though I told the BIOS to use PIO and
even though it was reported correctly, somebody decided
that I didn't really know what I wanted and set the damn
interface to UDMA 100 anyway. These are DMA timeout-errors!


RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
     ide0: BM-DMA at 0xf800-0xf807, BIOS settings: hda:pio, hdb:pio
Probing IDE interface ide0...
hda: Maxtor 6E040L0, ATA DISK drive
hdb: SanDisk SDCFB-256, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4 < hda5 >
hdb: max request size: 128KiB
hdb: 501760 sectors (256 MB) w/1KiB Cache, CHS=980/16/32, DMA
hdb: cache flushes not supported
  hdb:<4>hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
  hdb1

[SNIPPED...]

  hdb:<4>hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
  hdb1
hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
  hdb:<4>hdb: dma_timer_expiry: dma status == 0x61
hdb: DMA timeout error
hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown


Everyone of these is 15 seconds!

  hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1
  hdb: hdb1

That last group takes 3 minutes!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
