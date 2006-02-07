Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWBGRCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWBGRCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBGRCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:02:40 -0500
Received: from math.ut.ee ([193.40.36.2]:34262 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932171AbWBGRCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:02:39 -0500
Date: Tue, 7 Feb 2006 19:02:36 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139324653.18391.41.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0602071856520.11554@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor> 
 <1139310335.18391.2.camel@localhost.localdomain>  <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
  <1139312330.18391.14.camel@localhost.localdomain>
 <1139324653.18391.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've put up a -ide2 patch at
>
> http://zeniv.linux.org.uk/~alan/IDE

This time a report from an Intel ICH5 machine with 1 PATA disk and 1 
PATA cdrom, worked fine before. Now I got anb oops with previous kernel 
and the dmesg below ith current kernel (recoreded with netconsole). The 
previous fauls was also during partition table reading. This is fully 
reproducible, tried 3 times.

ata1: dev 0 ATA-6, max UDMA/100, 156301488 sectors: LBA
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
   Vendor: ATA       Model: WDC WD800BB-22HE  Rev: 14.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x24C8 irq 15
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
   Vendor: _NEC      Model: DVD_RW ND-3540A   Rev: 1.01
   Type:   CD-ROM                             ANSI SCSI revision: 05
PCI: Found IRQ 11 for device 0000:00:1f.2
PCI: Sharing IRQ 11 with 0000:00:1d.2
PCI: Sharing IRQ 11 with 0000:00:1f.1
ata3: SATA max UDMA/133 cmd 0x24F8 ctl 0x2812 bmdma 0x24D0 irq 11
ata4: SATA max UDMA/133 cmd 0x2800 ctl 0x2816 bmdma 0x24D8 irq 11
ata3: SATA port has no device.
scsi2 : ata_piix
ata4: SATA port has no device.
scsi3 : ata_piix
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Unknown interrupt or fault at EIP 00000286 00000060 c0112acd
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda:Unknown interrupt or fault at EIP 00000246 00000060 c010162b


-- 
Meelis Roos (mroos@linux.ee)
