Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWF0LzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWF0LzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWF0LzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:55:25 -0400
Received: from mx1.mail.ru ([194.67.23.121]:23333 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932466AbWF0LzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:55:23 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: lib(p)ata SMART support?
Date: Tue, 27 Jun 2006 15:55:12 +0400
User-Agent: KMail/1.9.3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271555.13330.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Using legacy drivers I can use any SMART tools out there; HDD does support 
SMART. Running libata + pata_ali, smartctl claims device does not support 
SMART. This is sort of regression when switching from legacy drivers.

- -andrey

libata version 1.30 loaded.
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xEFF0 irq 14
scsi0 : pata_ali
ata1.00: configured for UDMA/33
  Vendor: ATA       Model: IC25N020ATDA04-0  Rev: DA3O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
scsi1 : pata_ali
ata2.00: configured for PIO4
  Vendor: TOSHIBA   Model: DVD-ROM SD-C2502  Rev: 1313
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda

{pts/0}% sudo smartctl -i /dev/sda
smartctl version 5.36 [i586-mandriva-linux-gnu] Copyright (C) 2002-6 Bruce 
Allen
Home page is http://smartmontools.sourceforge.net/

Device: ATA      IC25N020ATDA04-0 Version: DA3O
Serial number:          63A63GY1081
Device type: disk
Local Time is: Tue Jun 27 15:54:27 2006 MSD
Device does not support SMART
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEoRyhR6LMutpd94wRAh/6AJsENQEibwUqGrP2q7cSIpDy9fIedgCfV6Y2
COg2D+QL58CNlKBGXvnrM6Q=
=DDES
-----END PGP SIGNATURE-----
