Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbRANJDh>; Sun, 14 Jan 2001 04:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129967AbRANJD1>; Sun, 14 Jan 2001 04:03:27 -0500
Received: from [64.160.188.242] ([64.160.188.242]:32011 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S130194AbRANJDP>; Sun, 14 Jan 2001 04:03:15 -0500
Date: Sun, 14 Jan 2001 01:03:13 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Tony Parsons <mpsons@cix.compulink.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.21.0101140010470.17798-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.21.0101140054530.18042-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I feel it important to note that the distrib in use for all of this is of
my own design. The specs are at www.kixolinux.com.

Why do I feel this is important? Possibly something I've done in the
distrib could be affecting this as well. I remember reading some weeks ago
about the 2.4.0-test## series + SCSI + SMP were having some problems.

The drives are as follows

    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:DMA
hda: WDC WD153AA, ATA DISK drive
hda: 30064608 sectors (15393 MB) w/2048KiB Cache, CHS=1871/255/63, UDMA(66)

    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:DMA
hdb: WDC WD300BB-00AUA1, ATA DISK drive
hdb: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3649/255/63, UDMA(66)

    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
hdc: SAMSUNG CD-ROM SC-148F, ATAPI CDROM drive
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA

The errors are as follows 

hdc: timeout waiting for DMA
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 929520
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev 16:00 (hdc), sector 929522
 


I get the same thing for hda and hdb though not as frequently as with
hdc. (Controller doesn't like switchign between DMA and PIO modes
possibly? ::shrug::)


David D.W. Downey


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
