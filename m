Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUFULgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUFULgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbUFULgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:36:17 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:42442 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266196AbUFULgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:36:15 -0400
Message-ID: <40D6C80B.2020202@ics.muni.cz>
Date: Mon, 21 Jun 2004 13:35:39 +0200
From: Miroslav Ruda <ruda@ics.muni.cz>
Organization: UVT MU
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: cs, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com, jgarzik@pobox.com
CC: linux-kernel@vger.kernel.org
Subject: sata promise problems on x86_64
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.3.18
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I have problems with SATA promise driver from  2.4.27-rc1 on x86_64 arch (MB ASUS SK8V).
Kernel 2.4.27-rc1 reports

scsi0: SCSI host adapter emulation for IDE ATAPI devices
ata1: SATA max UDMA/133 ...
ata2: SATA max UDMA/133 ...
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors
ata1: dev 0 configured for UDMA/133
ata2: no device found (phy stat 00000000)
scsi1: sata_promise
scsi2: sata_promise
 Vendor: ATA       Model: WDC WD800JD-00HK  Rev: 13.0
 Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Partition check:
 sda: <3>ata1: DMA timeout

and is frozen, while with 2.6.5 it works ok:

SCSI subsystem initialized
libata version 1.02 loaded.
sata_promise version 0.92
ata1: SATA max UDMA/133 cmd 0xFFFFFF000205F200 ctl 0xFFFFFF000205F238 bmdma 0x0 
irq 18
ata2: SATA max UDMA/133 cmd 0xFFFFFF000205F280 ctl 0xFFFFFF000205F2B8 bmdma 0x0 
irq 18
ata1: dev 0 cfg 49:2f00 82:346b 83:5b01 84:4003 85:3469 86:1801 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_promise
  Vendor: ATA       Model: WDC WD800JD-00HK  Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: dev 0 max request 124KB
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Any idea what's wrong?
-- 
                  Mirek Ruda 
