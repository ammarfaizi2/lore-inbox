Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRAWJ0z>; Tue, 23 Jan 2001 04:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRAWJ0p>; Tue, 23 Jan 2001 04:26:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:44762 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129401AbRAWJ0c>;
	Tue, 23 Jan 2001 04:26:32 -0500
Date: Sat, 20 Jan 2001 03:39:50 -0500
From: Andy Galasso <andy@adgsoftware.com>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
Message-ID: <20010120033950.A16350@adgsoftware.com>
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com>; from pgpkeys@hislinuxbox.com on Wed, Jan 17, 2001 at 02:02:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure how relevant it is, but FWIW here's what I've got:

MSI 694D Pro Motherboard 2xPIII-800 100MHz FSB
Linux-2.4.0-prerelease SMP
Promise FastTrak100 controller card
4 IBM DTLA-307030 drives attached to Promise card
boot params: ide2=0xac00 ide3=0xb400

Here's an excerpt of what I get when trying to boot:

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
  
-Andy Galasso


On Wed, Jan 17, 2001 at 02:02:17PM -0800, David D.W. Downey wrote:
> 
> Could those that were involved in the VIA chipset discussion email me
> privately at pgpkeys@hislinuxbox.com?
> 
> I'm truly interested in solving this issue. I personally think it's more
> than just the chipset causing the problems.
> 
> 
> I'm looking for members of the list that are using the kernel support for
> the following
> 
> 
> VIA chipset
> Promise controller (PDC2026# with specifics on the PDC20265 (ATA100))
> SMP support
> IDE + SCSI mix in the system.
> 
> 
> I'm trying to track a number of POSSIBLE bugs (can't say they are for
> sure) and any input from folks with this mix of drivers would be
> exponentially useful, even if for nothing more than discounting some of my
> thoughts.
> 
> 
> Also, can anyone summurize the already known and specific problems with
> combinations of the above requirements? I would truly appreciate that. 
> 
> David D.W. Downey
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
