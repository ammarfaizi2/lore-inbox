Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130076AbQLTRO0>; Wed, 20 Dec 2000 12:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130536AbQLTROQ>; Wed, 20 Dec 2000 12:14:16 -0500
Received: from avalon.student.liu.se ([130.236.230.76]:34472 "EHLO
	mail.student.liu.se") by vger.kernel.org with ESMTP
	id <S130076AbQLTROC>; Wed, 20 Dec 2000 12:14:02 -0500
Message-ID: <3A40E1B1.88008025@student.liu.se>
Date: Wed, 20 Dec 2000 17:43:29 +0100
From: Robert Högberg <robho956@student.liu.se>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Extreme IDE slowdown with 2.2.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having problems with the performance of my harddrives after I
upgraded my kernel from 2.2.17 to 2.2.18.
The performancedrop is noticable on every IDE drive.

Here are some numbers to show what I mean:

2.2.17:
/dev/hdc:
 Timing buffered disk reads:  64 MB in  4.32 seconds =14.81 MB/sec

2.2.18:
/dev/hdc:
 Timing buffered disk reads:  64 MB in 10.49 seconds = 6.10 MB/sec

These are hdparm -t outputs and the performance drop is pretty noticable
:-/

I also copied a 600Mb file from my HDD to /dev/null and the results
were:

2.2.17: 1 minute 9 seconds
2.2.18: 1 minute 38 seconds

My system consists of:
FIC VA-503+ motherboard with the MVP3 chipset
K6-2 500MHz
128Mb SDRAM
3 IDE disks (see below)
Slackware 7.0

dmesg output for the IDE system (no differences between .17 and .18):

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL ST6.4A, ATA DISK drive
hdb: QUANTUM FIREBALL SE4.3A, ATA DISK drive
hdc: IBM-DJNA-352030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: QUANTUM FIREBALL ST6.4A, 6149MB w/81kB Cache, CHS=784/255/63
hdb: QUANTUM FIREBALL SE4.3A, 4110MB w/80kB Cache, CHS=524/255/63
hdc: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63

When I performed the tests I used similiar .17 and .18 kernels with a
minimum components included. No network, SCSI, sound and such things.
.config files can be supplied if needed.

Does anyone know what could be wrong? Have I forgot something? Is this a
known problem with the 2.2.18 kernel?

Thanks in advance!

Robert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
