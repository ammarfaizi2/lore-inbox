Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbRAAWe5>; Mon, 1 Jan 2001 17:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130833AbRAAWes>; Mon, 1 Jan 2001 17:34:48 -0500
Received: from adsl-141-154-69-10.bostma.adsl.bellatlantic.net ([141.154.69.10]:6916
	"EHLO monty.adgsoftware.com") by vger.kernel.org with ESMTP
	id <S130664AbRAAWeh>; Mon, 1 Jan 2001 17:34:37 -0500
Date: Mon, 1 Jan 2001 17:07:41 -0500
From: Andy Galasso <andy@adgsoftware.com>
To: linux-kernel@vger.kernel.org
Subject: Promise PDC20267 irq timeout
Message-ID: <20010101170741.A14537@adgsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to use a Promise FastTrak100 in native Ultra100 mode. Anyone
have any idea how to get this working?

Linux-2.4.0-prerelease SMP
Promise FastTrak100 - no array defined in adapter BIOS
4 IBM DTLA-307030 drives
boot params: ide2=0xac00 ide3=0xb400

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:pio
PDC20267: IDE controller on PCI bus 00 dev 70
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
PDC20267: neither IDE port enabled (BIOS)
hde: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hde: IBM-DTLA-307030, ATA DISK drive
hdf: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hdf: IBM-DTLA-307030, ATA DISK drive
hdg: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hdg: IBM-DTLA-307030, ATA DISK drive
hdh: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hdh: IBM-DTLA-307030, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xac00-0xac07,0xae06 on irq 16
ide3 at 0xb400-0xb407,0xb606 on irq 16 (shared with ide2)
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
hdf: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
hdg: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
hdh: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63
Partition check:
 hde:hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
ide2: reset: master: error (0x00?)
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: irq timeout: status=0x50 { DriveReady SeekComplete }
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
ide2(?): unexpected interrupt, status=0x58, count=1
ide2: reset: master: error (0x00?)
hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
 hdf:hdf: irq timeout: status=0x50 { DriveReady SeekComplete }
hdf: irq timeout: status=0x50 { DriveReady SeekComplete }
hdf: irq timeout: status=0x50 { DriveReady SeekComplete }
hdf: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
ide2(?): unexpected interrupt, status=0x58, count=2
ide2: reset: master: error (0x00?)
hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdf: drive not ready for command
hdf: irq timeout: status=0x50 { DriveReady SeekComplete }
hdf: irq timeout: status=0x50 { DriveReady SeekComplete }
hdf: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
ide2(?): unexpected interrupt, status=0x58, count=3
ide2: reset: master: error (0x00?)
hdf: status error: status=0x58 { DriveReady SeekComplete DataRequest }
end_request: I/O error, dev 21:40 (hdf), sector 0
hdf: drive not ready for command
 unable to read partition table
...
(similar for hdg ... hdh ...)
...


Thanks,

Andy Galasso
andy@adgsoftware.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
