Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWC3H1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWC3H1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWC3H1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:27:04 -0500
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:20241 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932087AbWC3H1C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:27:02 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: 2.6.16git14 - resume from suspend to ram faild on SATA hard drive
Date: Thu, 30 Mar 2006 09:26:56 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200603300926.56307.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to do suspend to ram on 2.6.16git14 kernel on ThinkPad Z60m with 
SATA hard drive.

Suspend/resume almost works. Unfortunately there is a problem with resume of 
hard drive.

After resume hard drive is borking and I only get bunch of SCSI errors:
http://www.t17.ds.pwr.wroc.pl/~misiek/rozne/libata-suspend1.jpg

The interesting thing is that kernel 2.6.14.7 resumes fine (just it takes 
several seconds for hard drive to respond after resume).

Should it resume properly with this hardware? AFAIK all needed patches are 
already merged in 2.6.16git14...

SATA stuff used:
ata_piix                9348  2
libata                 59020  1 ata_piix
scsi_mod               88840  3 sr_mod,sd_mod,libata

boot log:

SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1880 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:7f69 84:6063 85:f469 86:3c49 87:6063 
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 195371568 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: HTS541010G9SA00   Rev: MBZI
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1888 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: MATSHITA  Model: DVD-RAM UJ-830Sx  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
