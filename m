Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbTLFMRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 07:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTLFMRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 07:17:14 -0500
Received: from falka.mfa.kfki.hu ([148.6.72.6]:36992 "EHLO falka.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id S265130AbTLFMRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 07:17:10 -0500
Date: Sat, 6 Dec 2003 13:17:06 +0100
From: Gergely Tamas <dice@mfa.kfki.hu>
To: linux-kernel@vger.kernel.org
Subject: PDC20265 problems with 2.4.23
Message-ID: <20031206121706.GB6171@mfa.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following with kernel 2.4.23...

| [...]
|  PDC20265: IDE controller at PCI slot 00:0c.0
|  PDC20265: chipset revision 2
|  PDC20265: not 100%% native mode: will probe irqs later
|  PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
|      ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:pio
|      ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:DMA
| [...]
|  hde: Maxtor 5T040H4, ATA DISK drive
|  hdg: ST3120022A, ATA DISK drive
|  hdh: ST3120022A, ATA DISK drive
| [...]
|  ide2 at 0xcc00-0xcc07,0xd002 on irq 18
|  ide3 at 0xd400-0xd407,0xd802 on irq 18
|  hde: attached ide-disk driver.
|  hde: host protected area => 1
|  hde: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63
|  hdg: attached ide-disk driver.
|  hdg: host protected area => 1
|  hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63
|  hdh: attached ide-disk driver.
|  hdh: host protected area => 1
|  hdh: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=14593/255/63
|  Partition check:
|   hde: [PTBL] [4982/255/63] hde1
|   hdg: hdg1 hdg2
|   hdh: hdh1
| [...]
|  hdg: status error: status=0x58 { DriveReady SeekComplete DataRequest }
|  
|  hdg: drive not ready for command
|  hdg: status error: status=0x50 { DriveReady SeekComplete }
|  
|  hdg: no DRQ after issuing MULTWRITE
|  hdg: status timeout: status=0xd0 { Busy }
|  
|  PDC202XX: Secondary channel reset.
|  PDC202XX: Primary channel reset.
|  hdg: no DRQ after issuing WRITE
|  ide3: reset: master: error (0x00?)
| [...]
|  hde: status error: status=0x51 { DriveReady SeekComplete Error }
|  hde: status error: error=0x04 { DriveStatusError }
|  hde: no DRQ after issuing MULTWRITE
|  hde: status error: status=0x51 { DriveReady SeekComplete Error }
|  hde: status error: error=0x04 { DriveStatusError }
|  hde: no DRQ after issuing MULTWRITE
|  hde: status error: status=0x51 { DriveReady SeekComplete Error }
|  hde: status error: error=0x04 { DriveStatusError }
|  hde: no DRQ after issuing MULTWRITE
|  hde: status error: status=0x51 { DriveReady SeekComplete Error }
|  hde: status error: error=0x04 { DriveStatusError }
|  PDC202XX: Primary channel reset.
|  PDC202XX: Secondary channel reset.
|  hde: no DRQ after issuing WRITE
| [...]
|  ide2: reset: master: error (0x00?)
| [...]
|  hdg: lost interrupt
|  hdg: lost interrupt
|  hdg: lost interrupt
| .
| .
| .

$ grep PDC .config
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_BLK_DEV_ATARAID_PDC is not set


Thanks in advance,
Gergely
