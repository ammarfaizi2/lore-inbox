Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRLIAsp>; Sat, 8 Dec 2001 19:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRLIAsf>; Sat, 8 Dec 2001 19:48:35 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10254
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S277380AbRLIAsX>; Sat, 8 Dec 2001 19:48:23 -0500
Date: Sat, 8 Dec 2001 16:44:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ben Pharr - Lists <ben-lists@benpharr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE SeekComplete Error
In-Reply-To: <5.1.0.14.0.20011128173852.00a28440@sunset.olemiss.edu>
Message-ID: <Pine.LNX.4.10.10112081642530.15878-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That just means the device aborted the command and it does not support
setfeatures opt codes for changing the transfer rates.

Andre Hedrick
Linux ATA Development


On Wed, 28 Nov 2001, Ben Pharr - Lists wrote:

> I have been getting a DriveReady SeekComplete Error at bootup from my CD 
> burner. Below are the excerpts from dmesg. I have a script that turns off 
> DMA on the writer, but it hasn't been reached yet when this error occurs. 
> This occurred on my first boot of 2.4.17-pre1, but I'm not positive it 
> hasn't been happening with earlier kernels. I doesn't seem to be causing 
> any problems.
> 
> Ben Pharr
> 
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev f9
> PIIX4: chipset revision 2
> PIIX4: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
> hda: QUANTUM FIREBALLlct15 20, ATA DISK drive
> hdc: SAMSUNG DVD-ROM SD-612, ATAPI CD/DVD-ROM drive
> hdd: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=2482/255/63, UDMA(33)
> hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>   hda: hda1 hda2 hda4
> 
> SCSI subsystem driver Revision: 1.00
> hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hdd: set_drive_speed_status: error=0x04
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>    Vendor: SAMSUNG   Model: CD-R/RW SW-408B   Rev: BS02
>    Type:   CD-ROM                             ANSI SCSI revision: 02
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

