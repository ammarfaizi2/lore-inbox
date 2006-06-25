Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWFYK6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWFYK6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWFYK6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:58:16 -0400
Received: from mx6.mail.ru ([194.67.23.26]:36656 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S932347AbWFYK6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:58:15 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA driver patch for 2.6.17
Date: Sun, 25 Jun 2006 14:58:10 +0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <1150740947.2871.42.camel@localhost.localdomain> <e79a9e$2kt$1@sea.gmane.org> <1150925002.15275.128.camel@localhost.localdomain>
In-Reply-To: <1150925002.15275.128.camel@localhost.localdomain>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606251458.11824.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 22 June 2006 01:23, Alan Cox wrote:
> Ar Maw, 2006-06-20 am 21:12 +0400, ysgrifennodd Andrey Borzenkov:
> > Running vanilla 2.6.17 + ide1 patch on ALi M5229 does not find CD-ROM.
> > Notice "ata2: command 0xa0 timeout" below.
>

I also tried the Tejun Heo patch for 2.6.17 (wihout PM) + pata_ali from Jeff 
Garik git tree with the same result; may be it gives more information about 
the error:

libata version 1.30 loaded.
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xEFF0 irq 14
scsi0 : pata_ali
ata1.00: configured for UDMA/33
  Vendor: ATA       Model: IC25N020ATDA04-0  Rev: DA3O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
scsi1 : pata_ali
ata2.00: configured for UDMA/33
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x21)
ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x21)
ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x21)
ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: limiting speed to UDMA/25
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (BMDMA stat 0x21)
ata2.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2.00: configured for UDMA/25
ata2: EH complete
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEnmxDR6LMutpd94wRAk7tAJ42j1L2FENW05f5SgbfFvSY9PJWDwCgjdwn
0p11xgxTLdnddgjPtBHEGVM=
=sZeN
-----END PGP SIGNATURE-----
