Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbQLVWzd>; Fri, 22 Dec 2000 17:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbQLVWzO>; Fri, 22 Dec 2000 17:55:14 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:261 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S132411AbQLVWzG>; Fri, 22 Dec 2000 17:55:06 -0500
Message-ID: <3A43D48D.B1825354@dm.ultramaster.com>
Date: Fri, 22 Dec 2000 17:24:13 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: cdrom changes in test13-pre2 slow down cdrom access by 70%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, 

The cdrom changes that went into test13-pre2 really kill the performance
of my cdrom.  I'm using cdparanoia to read audio data, and it normally
reads at 2-3x.  Since test13-pre2 it's  down to .6 - .7x.  I've reverted
the following files to the ones from test13-pre1 and it's back to
normal:

drivers/cdrom/cdrom.c
drivers/ide/ide-cd.c
drivers/ide/ide-cd.h
drivers/scsi/sr.c
drivers/scsi/sr.h
drivers/scsi/sr-ioctl.c
drivers/scsi/sr-vendor.c
include/linux/cdrom.h

My hardware is:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: CREATIVE CD5230E, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11

The only IDE device (as you can see) is the cdrom drive.

This is a huge patch, is there some way I could break it apart to see
what the relevant changes are?

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
