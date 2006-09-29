Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWI2UUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWI2UUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWI2UUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:20:40 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:40665 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S932349AbWI2UUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:20:39 -0400
In-Reply-To: <451D7DE8.8020504@freescale.com>
References: <451D7DE8.8020504@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BA55C0C9-B58F-473E-9412-B582411D017A@bootc.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: SATA: "unknown partition table" error, fdisk can't fix, works in 2.6.13
Date: Fri, 29 Sep 2006 21:20:36 +0100
To: Timur Tabi <timur@freescale.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur,

fdisk manipulates DOS-style partition maps. Have you compiled these  
into your latest kernel? You don't actually have any errors in the  
below messages, other than the partition map being unreadable...

Chris

On 29 Sep 2006, at 21:11, Timur Tabi wrote:

> I have a SATA drive attached to a PowerPC 8349E board, using the  
> SIL 3114 controller.  I'm running the latest code from Paul  
> Mackerras (PowerPC maintainer) (2.6.18-blabla).
>
> I'm experiencing a number of I/O errors with the SATA drive.  fdisk  
> can see the partition table, but when I issue the "w" command, I  
> get this output:
>
> Calling ioctl() to re-read partition table.
> SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back
>  sda: unknown partition table
> SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back
>  sda: unknown partition table
> Syncing disks.
>
> I cannot mount any partitions.  On boot, I see this:
>
> sata_sil 0000:00:10.0: Applying R_ERR on DMA activate FIS errata fix
> ata1: SATA max UDMA/100 cmd 0xD100E080 ctl 0xD100E08A bmdma  
> 0xD100E000 irq 22
> ata2: SATA max UDMA/100 cmd 0xD100E0C0 ctl 0xD100E0CA bmdma  
> 0xD100E008 irq 22
> ata3: SATA max UDMA/100 cmd 0xD100E280 ctl 0xD100E28A bmdma  
> 0xD100E200 irq 22
> ata4: SATA max UDMA/100 cmd 0xD100E2C0 ctl 0xD100E2CA bmdma  
> 0xD100E208 irq 22
> scsi0 : sata_sil
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth  
> 0/32)
> ata1.00: ata1: dev 0 multi count 0
> ata1.00: configured for UDMA/100
> scsi1 : sata_sil
> ata2: SATA link down (SStatus 0 SControl 310)
> scsi2 : sata_sil
> ata3: SATA link down (SStatus 0 SControl 310)
> scsi3 : sata_sil
> ata4: SATA link down (SStatus 0 SControl 310)
> scsi 0:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ:  
> 0 ANSI: 5
> SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back
> SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back
>  sda: unknown partition table
> sd 0:0:0:0: Attached scsi disk sda
> sd 0:0:0:0: Attached scsi generic sg0 type 0
>
> The odd thing is that this works in 2.6.13, so something is  
> broken.  I don't know if it's a bug in the sata_sil driver, or a  
> configuration issue.  Can anyone help?
>
> -- 
> Timur Tabi
> Linux Kernel Developer @ Freescale
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


