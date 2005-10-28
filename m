Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVJ1KhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVJ1KhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVJ1KhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:37:07 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:2394 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S964893AbVJ1KhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:37:06 -0400
Message-ID: <4362001D.1070004@sara.nl>
Date: Fri, 28 Oct 2005 12:40:29 +0200
From: Bram Stolk <bram@sara.nl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: assertion failure in libata-core
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


When enabling atapi, I got the following assertion failure:

Assertion failed! qc->flags &
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3232

This is when booting my 2.6.14-rc5 kernel with two sata devices:
a maxtor hd, and a plextor dvd writer.

   Bram
-------------------------------------
Some context for the failure:

ata1: SATA max UDMA/133 cmd 0xF8806100 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF8806180 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF8806200 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF8806280 ctl 0x0 bmdma 0x0 irq 19
ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:001f
ata1: dev 0 ATAPI, max UDMA/66
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/66
scsi0 : ahci
ata2: no device found (phy stat 00000000)
scsi1 : ahci
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
ata3: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.07
   Type:   CD-ROM                             ANSI SCSI revision: 05
ata1: error occurred, port reset
ata1: error occurred, port reset
Assertion failed! qc->flags &
ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3232
  0:0:0:0: timing out command, waited 18s
  0:0:0:0: timing out command, waited 18s
   Vendor: ATA       Model: Maxtor 6L250S0    Rev: BANC
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 < sda5 > sda3
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
sr 0:0:0:0: timing out command, waited 90s
sr 0:0:0:0: timing out command, waited 90s
sr 0:0:0:0: timing out command, waited 90s
sr 0:0:0:0: timing out command, waited 90s
sr 0:0:0:0: timing out command, waited 90s
sr 0:0:0:0: timing out command, waited 90s
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0


