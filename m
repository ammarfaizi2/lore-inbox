Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274292AbRJAAVo>; Sun, 30 Sep 2001 20:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274298AbRJAAVe>; Sun, 30 Sep 2001 20:21:34 -0400
Received: from pyongsan.compgen.com ([158.155.0.1]:12552 "EHLO
	panmunjom.compgen.com") by vger.kernel.org with ESMTP
	id <S274292AbRJAAV1>; Sun, 30 Sep 2001 20:21:27 -0400
Date: Sun, 30 Sep 2001 20:21:46 -0400 (EDT)
From: Gary Aviv <gary.aviv@intec-telecom-systems.com>
To: linux-kernel@vger.kernel.org
cc: andre@linux-ide.org
Subject: IDE CDROM Hang
Message-ID: <Pine.LNX.4.21.0109301958060.9100-100000@trout.compgen.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed RedHat 7.1 with 2.4.2 (I get the same behavior on 2.4.10)
Configuration as follows:

hda: Maxtor 5T040H4, ATA DISK drive
hdc: Maxtor 91303D6, ATA DISK drive
hdd: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=4982/255/63, UDMA(33)
hdc: 25450992 sectors (13031 MB) w/512KiB Cache, CHS=25249/16/63, UDMA(33)

When I attmept to mount hdd, the system hangs. While this is a CD R/W 
I am only attempting to read at this point. I have 2.2.12 on hdc
(RedHat 6.2) and it handles the RICOH perfectly (I even write to it
under SCSI emulation.)

I attempted to add ide1=serialize with no change.

On the console I get the message:

hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA

light on CD on momentarily, drive revs up, then stops and system is
hung, requires hard reset.

Thank you,
-- 
Gary Aviv
e-mail: gary.aviv@compgen.com



