Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWJVMTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWJVMTl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 08:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWJVMTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 08:19:41 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:21510 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751782AbWJVMTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 08:19:40 -0400
Message-ID: <453B61D9.9060707@xs4all.nl>
Date: Sun, 22 Oct 2006 14:19:37 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sata_via issue for VIA Epia SP8000 in 2.6.18[.1]?
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2.6.17.13 works OK on this VIA Epia SP8000.
(remember vaguely about some (PCI?) fixups to get things going)

Now I try to get 2.6.18.1 working. SATA is detected by this kernel but
disk gives timeout while 2.6.17.13 boots fine.

Some burbs:

Links is up but  SStatus 113 SControl 300
qc timeout (cmd 0xec)
failed to IDENTIFY
This results in a kernel panic.

Any ideas?

2.6.17.13 gives stuff like this:

scsi0 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023
88:40ff
ata2: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: ZM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 1:0:0:0: Attached scsi disk sda


Udo
