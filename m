Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWHFOLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWHFOLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWHFOLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:11:32 -0400
Received: from tornado.reub.net ([202.89.145.182]:64459 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932074AbWHFOLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:11:31 -0400
Message-ID: <44D5F88D.2080809@reub.net>
Date: Mon, 07 Aug 2006 02:11:25 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 2.0a1 (Windows/20060806)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.18-rc3-mm2
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/08/2006 10:08 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
> - 2.6.18-rc3-mm1 gets mysterious udev timeouts during boot and crashes in
>   NFS.  This kernel reverts the patches which were causing that.
> 
> 
> 
> Changes since 2.6.18-rc3-mm1:
> 
> 
> +revert-x86_64-mm-i386-remove-lock-section.patch
> 
>  Revert patch which caues udev timeouts.
> 
> -knfsd-make-rpc-threads-pools-numa-aware-fix.patch
> 
>  Folded into knfsd-make-rpc-threads-pools-numa-aware.patch
> 
> +revert-knfsd-make-rpc-threads-pools-numa-aware.patch
> 
>  Revert patch which causes nfs crashes.

Seems to work well.

The only outstanding issue I have is with the "Generic ATA support" option which 
I believe should be detecting and driving my ATA DVD-RW.  However it is giving 
this still on boot - it has never worked:

ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC2000000E100 ctl 0x0 bmdma 0x0 irq 314
ata2: SATA max UDMA/133 cmd 0xFFFFC2000000E180 ctl 0x0 bmdma 0x0 irq 314
ata3: SATA max UDMA/133 cmd 0xFFFFC2000000E200 ctl 0x0 bmdma 0x0 irq 314
ata4: SATA max UDMA/133 cmd 0xFFFFC2000000E280 ctl 0x0 bmdma 0x0 irq 314
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 31/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
   Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
scsi4 : ata_piix
ata5.00: ATAPI, max UDMA/66
ata5.00: configured for UDMA/66
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: limiting speed to UDMA/44
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)

And no DVD-RW :-(

I posted some information about it to LKML on 10/07/06

  ATAPI CD-ROM, with removable media
         Model Number:       PIONEER DVD-RW  DVR-111D
         Serial Number:      FADC005671WL
         Firmware Revision:  1.23
  + more

but had no feedback.

Should I continue to ask/report it or should I just disable it for now and try 
again in a few months to see if it works?

Reuben
