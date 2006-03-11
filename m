Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWCKWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWCKWCR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 17:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWCKWCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 17:02:16 -0500
Received: from fw.bitband.com ([213.8.50.174]:4938 "EHLO mail1.bitband.com")
	by vger.kernel.org with ESMTP id S1751066AbWCKWCQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 17:02:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problem with sata driver
Date: Sun, 12 Mar 2006 00:03:30 +0200
Message-ID: <83CA05F64804AF43B8F733C4ABDFAA51010DF25A@mail1.bitband.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with sata driver
Thread-Index: AcZFIDE/3HxiWHBhQvOaMf+N5heEqgANz2IQ
From: "Sion Khalaf" <Sion@bitband.com>
To: "Ed Tomlinson" <edt@aei.ca>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amd 64, with Slackware 9.1
Any ideas ?

10x 

-----Original Message-----
From: Ed Tomlinson [mailto:edt@aei.ca] 
Sent: Saturday, March 11, 2006 5:25 PM
To: Sion Khalaf
Subject: Re: Problem with sata driver

Debian?  amd64?

I got the same same errors with debain install disks....  gentoo had no
problems.

Ed Tomlinson


On Saturday 11 March 2006 10:08, you wrote:
> Hi,
> 
> I am having problem with Sata Drive /dev/sda
> 
> Board from SuperMicro With Nvidia ChipSet - H8DCE The board has 8 x 
> SATA ports, but only one SATA Drive is connected (Maxtor 500 GB )
> 
> Kernel 2.6.15
> I insert the module :  insmod sata_nv.ko Then, udevstart
> 
> Fdisk Output:
> -------------------------------------------------------------------
> [root@880-TEST root]$ fdisk -l
> 
> Disk /dev/hda: 262 MB, 262144000 bytes
> 16 heads, 32 sectors/track, 1000 cylinders Units = cylinders of 512 * 
> 512 = 262144 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/hda1   *           1         998      255487+  83  Linux
> 
> Disk /dev/sda: 500.1 GB, 500107862016 bytes
> 255 heads, 63 sectors/track, 60801 cylinders Units = cylinders of 
> 16065 * 512 = 8225280 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> [root@880-TEST root]$
>  
> ----------------------------------------------------------------------
> --
> ----
> When trying to repartition the disk, I got into hangs.
> (Trying to save changes - w )
> 
> Attached is the dmesg, since inserting the module.
> 
> What is wrong ?
> 
> Thank you in advanced,
> Sion
> 
> **********************************************************************
> **
> **********
> 
> sata_nv 0000:00:07.0: version 0.8
> ACPI: PCI Interrupt Link [LTID] enabled at IRQ 11
> PCI: setting IRQ 11 as level-triggered
> ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 11 (level,
> low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xB800 irq 11
> ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xBC02 bmdma 0xB808 irq 11
> ata1: no device found (phy stat 00000000) scsi0 : sata_nv
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_nv
> ACPI: PCI Interrupt Link [LTIE] enabled at IRQ 9
> ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LTIE] -> GSI 9 (level, 
> low)
> -> IRQ 9
> PCI: Setting latency timer of device 0000:00:08.0 to 64
> ata3: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA400 irq 9
> ata4: SATA max UDMA/133 cmd 0xAC00 ctl 0xA802 bmdma 0xA408 irq 9
> ata3: no device found (phy stat 00000000)
> scsi2 : sata_nv
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4773 85:7c69 86:3e01 
> 87:4763 88:407f
> ata4: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> ata4: dev 0 configured for UDMA/133
> scsi3 : sata_nv
>   Vendor: ATA       Model: Maxtor 7H500F0    Rev: HA43
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB) SCSI 
> device sda: drive cache: write back SCSI device sda: 976773168 
> 512-byte hdwr sectors (500108 MB) SCSI device sda: drive cache: write 
> back
>  sda:<4>nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> 
> sd 3:0:0:0: Attached scsi disk sda
> sd 3:0:0:0: Attached scsi generic sg0 type 0
> ACPI: PCI Interrupt 0000:80:07.0[A] -> Link [LNKB] -> GSI 9 (level, 
> low)
> -> IRQ 9
> PCI: Setting latency timer of device 0000:80:07.0 to 64
> ata5: SATA max UDMA/133 cmd 0xF800 ctl 0xF402 bmdma 0xE800 irq 9
> ata6: SATA max UDMA/133 cmd 0xF000 ctl 0xEC02 bmdma 0xE808 irq 9
> ata5: no device found (phy stat 00000000)
> scsi4 : sata_nv
> ata6: no device found (phy stat 00000000)
> scsi5 : sata_nv
> ACPI: PCI Interrupt 0000:80:08.0[A] -> Link [LNKA] -> GSI 9 (level, 
> low)
> -> IRQ 9
> PCI: Setting latency timer of device 0000:80:08.0 to 64
> ata7: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xD400 irq 9
> ata8: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xD408 irq 9
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> ata7: no device found (phy stat 00000000)
> scsi6 : sata_nv
> ata8: no device found (phy stat 00000000)
> scsi7 : sata_nv
> ata4: command 0x35 timeout, stat 0xd0 host_stat 0x21
> ata4: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata4: status=0xd0 { Busy }
> sd 3:0:0:0: SCSI error: return code = 0x8000002
> sda: Current: sense key=0xb
>     ASC=0x47 ASCQ=0x0
> end_request: I/O error, dev sda, sector 0 Buffer I/O error on device 
> sda, logical block 0 lost page write due to I/O error on sda SCSI 
> device sda: 976773168 512-byte hdwr sectors (500108 MB) SCSI device 
> sda: drive cache: write back
>  sda:<4>ATA: abnormal status 0xD0 on port 0xAC07
> ATA: abnormal status 0xD0 on port 0xAC07
> ATA: abnormal status 0xD0 on port 0xAC07 [root@880-TEST root]$
> **********************************************************************
> **
> *********
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
