Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269456AbUHZTht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269456AbUHZTht (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269466AbUHZTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:36:36 -0400
Received: from dsl092-149-163.wdc2.dsl.speakeasy.net ([66.92.149.163]:5893
	"EHLO localhost") by vger.kernel.org with ESMTP id S269485AbUHZTWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:22:43 -0400
Subject: Sandisk 256MB Compact Flash (SDCFH-256) hangs on access (2.4.26)
From: Brian Beattie <beattie@beattie-home.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1093548140.2903.35.camel@kokopelli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 15:22:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a better forum for this question, please let me know.

I'm running Debian Sarge/2.4.26-1-i686-smp, trying to access this
compact flash using a CF/IDE adapter from ACS (ACS-CF-IDEToCFA).  This
works fine for every other CF I have tried (128 and 64).  I have a
number of these parts and they all act the same and they work fine in an
PCMCIA/CF adapter and a USB CF reader.   I have set up what I think is
the simplest case, I have run fdisk and mkfs on another machine using
the PCMCIA adapter.

When I try to mount the CF it hangs and I start getting "lost
interrupt",  does anybody have experience or clues that might help me?

------------------------
Linux version 2.4.26-1-686-smp (horms@tabatha) (gcc version 3.3.4
(Debian 1:3.34
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000f7efd000 (usable)
 BIOS-e820: 00000000f7efd000 - 00000000f7f00000 (ACPI NVS)
 BIOS-e820: 00000000f7f00000 - 00000000f7f80000 (usable)
 BIOS-e820: 00000000f7f80000 - 00000000f8000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
3071MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6810

...

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: SanDisk SDCFH-256, CFA DISK drive
hdc: CD-232E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-cdrom driver.
hdc: ATAPI 32X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12

...

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Eagle3:~# sfdisk -l /dev/hda
hda: attached ide-disk driver.
hda: 501760 sectors (257 MB) w/1KiB Cache, CHS=980/16/32
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

Disk /dev/hda: 980 cylinders, 16 heads, 32 sectors/track
Units = cylinders of 262144 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls    #blocks   Id  System
/dev/hda1          0+    640     641-    164080   83  Linux
/dev/hda2        641     673      33       8448   83  Linux
/dev/hda3        674     979     306      78336   83  Linux
/dev/hda4          0       -       0          0    0  Empty
Eagle3:~# mount /dev/hda1 /mnt/tmp
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hda: lost interrupt
hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
ide0: reset: master: error (0x00?)
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command

hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt

-- 
Brian Beattie   LFS12947 | "Honor isn't about making the right choices.
beattie@beattie-home.net | It's about dealing with the consequences."
www.beattie-home.net     | -- Midori Koto


