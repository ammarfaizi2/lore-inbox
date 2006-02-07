Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWBGRbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWBGRbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBGRbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:31:00 -0500
Received: from math.ut.ee ([193.40.36.2]:39628 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932260AbWBGRa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:30:59 -0500
Date: Tue, 7 Feb 2006 19:30:56 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139324653.18391.41.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0602071919550.11554@math.ut.ee>
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

Success on a slightly newer VIA KT133 mainboard with Duron 1200, Seagate 
40G disk and CDROM on secondary ide channel, 80 pin cable. It also 
survived reading the HDD with dd into devnull. CDROM was used as the 
root filesystem, successfully. Nothing on primary IDE channel.

PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xD000 irq 14
ATA: abnormal status 0x8 on port 0x1F7
ata1: disabling port
scsi0 : pata_via
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xD008 irq 15
ata2: dev 0 ATA-6, max UDMA/100, 78165360 sectors: LBA48
ata2: dev 1 ATAPI, max MWDMA2
via_do_set_mode: Mode=12 ast broken=N udma=66 mul=2
via_do_set_mode: Mode=68 ast broken=N udma=66 mul=2
ata2: dev 0 configured for UDMA/66
via_do_set_mode: Mode=12 ast broken=N udma=66 mul=2
via_do_set_mode: Mode=34 ast broken=N udma=66 mul=2
ata2: dev 1 configured for MWDMA2
scsi1 : pata_via
   Vendor: ATA       Model: ST340014A         Rev: 3.04
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: SAMSUNG   Model: CD-ROM SC-148C    Rev: B100
   Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3
sd 1:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 8x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sd 1:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:1:0: Attached scsi generic sg1 type 5


-- 
Meelis Roos (mroos@linux.ee)
