Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWFWRUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWFWRUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWFWRUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:20:42 -0400
Received: from mx6.mail.ru ([194.67.23.26]:35858 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1751800AbWFWRUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:20:41 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver patch for 2.6.17
Date: Fri, 23 Jun 2006 21:20:37 +0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <1150740947.2871.42.camel@localhost.localdomain> <200606222050.34248.arvidjaar@mail.ru> <1151076278.4549.49.camel@localhost.localdomain>
In-Reply-To: <1151076278.4549.49.camel@localhost.localdomain>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606232120.38232.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 23 June 2006 19:24, Alan Cox wrote:
> Ar Iau, 2006-06-22 am 20:50 +0400, ysgrifennodd Andrey Borzenkov:
> > Anything else I could try to help pinpoint the problem?
>
> Set the controller to support PIO only and see what happens.
>
> [ie set .udma_mask = 0 i nthe ali_init_one entries]
>
> If that works it implies the DMA tuning may be involved.

this works (sr is module)

libata version 1.20 loaded.
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ata1: PATA max PIO4 cmd 0x1F0 ctl 0x3F6 bmdma 0xEFF0 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:49a8 84:4003 85:f469 86:0800 87:4003 
88:103f
ata1: dev 0 ATA-5, max UDMA/100, 39070080 sectors: LBA
ata1: dev 0 configured for PIO4
scsi0 : ali
  Vendor: ATA       Model: IC25N020ATDA04-0  Rev: DA3O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max PIO4 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for PIO4
scsi1 : ali
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

next step? :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEnCLlR6LMutpd94wRArNuAJ9gqT7pSW5GwKN7xHlKP6EwNAAE9wCdH2gt
cwtcRFOix65bcL6fm4AlnKA=
=eCqh
-----END PGP SIGNATURE-----
