Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTDJHwE (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 03:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTDJHwE (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 03:52:04 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62215
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263997AbTDJHwC (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 03:52:02 -0400
Date: Thu, 10 Apr 2003 01:02:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Michael Frank <mflt1@micrologica.com.hk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre7, 2.5.66, IDE Errors during boot - just a nuisance
 ?
In-Reply-To: <200304101552.25091.mflt1@micrologica.com.hk>
Message-ID: <Pine.LNX.4.10.10304100102180.12558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All it is an aborted command.
just a nuisanse and noise maker!

On Thu, 10 Apr 2003, Michael Frank wrote:

> Noticed this for some time in 2.5.64 and up, and now also in 2.4.21-pre6 and pre7. It was OK 2.4.20. No functional problems were encountered  with 2.4.21, 2.5.6x so far.
> 
> Its a  P1, lspci follows
> 
> 00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)
> 00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
> 00:09.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
> 00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 01)
> 
> 
> Apr 10 15:17:30 mhfl1 kernel: Linux version 2.4.21-pre7-mhf18-np (mhf@mhfl3) (gcc version 2.95.3 20010315 (release)) #2 
> 
> Apr 10 15:12:42 mhfl1 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
> Apr 10 15:12:42 mhfl1 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Apr 10 15:12:42 mhfl1 kernel: PIIX3: IDE controller at PCI slot 00:07.1
> Apr 10 15:12:42 mhfl1 kernel: PIIX3: chipset revision 0
> Apr 10 15:12:42 mhfl1 kernel: PIIX3: not 100%% native mode: will probe irqs later
> Apr 10 15:12:42 mhfl1 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
> Apr 10 15:12:42 mhfl1 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> Apr 10 15:12:42 mhfl1 kernel: hda: QUANTUM BIGFOOT2550A, ATA DISK drive
> Apr 10 15:12:42 mhfl1 kernel: blk: queue c0347ae0, I/O limit 4095Mb (mask 0xffffffff)
> Apr 10 15:12:42 mhfl1 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Apr 10 15:12:43 mhfl1 kernel: hda: attached ide-disk driver.
> 
> ------------------------------\/
> Apr 10 15:12:43 mhfl1 kernel: hda: task_no_data_intr: status=0x53 { DriveReady SeekComplete Index Error }
> Apr 10 15:12:43 mhfl1 kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
> 
> Apr 10 15:12:43 mhfl1 kernel: hda: 5033952 sectors (2577 MB) w/87KiB Cache, CHS=624/128/63, DMA
> Apr 10 15:12:43 mhfl1 kernel: Partition check:
> Apr 10 15:12:43 mhfl1 kernel:  hda: hda1 hda2 hda3
> 
> ----------
> Mar 30 15:46:51 mhfl1 kernel: Linux version 2.5.66-mhf2 (mhf@mhfl2) (gcc version 2.95.3 20010315 (release)) #12 Sat Mar 29 
> 
> Mar 30 15:47:05 mhfl1 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Mar 30 15:47:05 mhfl1 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Mar 30 15:47:05 mhfl1 kernel: PIIX3: IDE controller at PCI slot 00:07.1
> Mar 30 15:47:05 mhfl1 kernel: PIIX3: chipset revision 0
> Mar 30 15:47:05 mhfl1 kernel: PIIX3: not 100%% native mode: will probe irqs later
> Mar 30 15:47:05 mhfl1 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
> Mar 30 15:47:05 mhfl1 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> Mar 30 15:47:05 mhfl1 kernel: hda: QUANTUM BIGFOOT2550A, ATA DISK drive
> Mar 30 15:47:05 mhfl1 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 
> ------------------------------\/
> Mar 30 15:47:05 mhfl1 kernel: hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> Mar 30 15:47:05 mhfl1 kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
> 
> Mar 30 15:47:05 mhfl1 kernel: hda: 5033952 sectors (2577 MB) w/87KiB Cache, CHS=4994/16/63, DMA
> Mar 30 15:47:05 mhfl1 kernel:  hda: hda1 hda2 hda3
> 
> Regards
> Michael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

