Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWBCUhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWBCUhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWBCUhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:37:55 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:21949 "EHLO
	osl1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S1751481AbWBCUhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:37:54 -0500
Date: Fri, 03 Feb 2006 21:44:20 +0100
From: Helge Hafting <helge.hafting@broadpark.no>
Subject: Unable to read DVDs - what could be wrong?
To: linux-kernel@vger.kernel.org
Message-id: <43E3C0A4.2080009@broadpark.no>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Using kernel 2.6.16rc2 on amd64)

I have this dvd writer:
hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive

It works well for reading and burning CDs, but it seem to be unable to
use DVDs.

I tried to mount a dvd, and got "No medium found".
cat /dev/hda also got that message, so it can't be a missing fs driver.

I only have one data dvd - it could theoretically be broken.
But attempts to play movies are equally fruitless, and I know those works.

Booting with a dvd in the drive gives me this in dmesg:

VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 94X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
hda: packet command error: error=0x44 { AbortedCommand 
LastFailedSense=0x04 }
ide: failed opcode was: unknown
ATAPI device hda:
   Error: Hardware error -- (Sense key=0x04)
   Tracking servo failure -- (asc=0x09, ascq=0x01)
   The failed "Read Cd/Dvd Capacity" packet command was:
   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "

I have upgraded the device from firmware 1.01 to the latest which is 
1.07.  That and a cold boot changed nothing.

Am I doing something wrong/stupid here?  Strange if it is broken,
I haven't used it that much and it is flawless with CDs.

Helge Hafting
