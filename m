Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUC3XE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUC3XCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:02:32 -0500
Received: from mail.thundernet.cz ([81.31.16.114]:23564 "EHLO
	mail.thundernet.cz") by vger.kernel.org with ESMTP id S261619AbUC3W7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:59:13 -0500
Message-ID: <4069FBC3.2080104@scssoft.com>
Date: Wed, 31 Mar 2004 00:59:15 +0200
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla Thunderbird 0.5+ (Windows/20040326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com>
In-Reply-To: <4064E691.2070009@pobox.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig52D0B45A228C3CD6B5028EFD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig52D0B45A228C3CD6B5028EFD
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
sata drive anymore...

I am seeing this:
-------------------------------------------------------------------
libata version 1.02 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC802 bmdma 0xD400 irq 20
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xD002 bmdma 0xD408 irq 20
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_via
Using anticipatory io scheduler
   Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write through
  sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
--------------------------------------------------------------------
instead of this:
libata version 1.00 loaded.
sata_via version 0.11
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC802 bmdma 0xD400 irq 20
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xD002 bmdma 0xD408 irq 20
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:407f
ata2: dev 0 ATA, max UDMA/133, 72303840 sectors (lba48)
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
Using anticipatory io scheduler
   Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 1.00
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 1.00
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write through
  sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sdb: drive cache: write through
  sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0

Regards,
Petr


--------------enig52D0B45A228C3CD6B5028EFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAafvDir6eWjmOQ6cRAnH7AJ4nrb2Z5+FQwFX5mgFy/KtIEF6/OwCeJy0R
Wow3Ehc5QitSy5G1fVDBBe0=
=i1l2
-----END PGP SIGNATURE-----

--------------enig52D0B45A228C3CD6B5028EFD--
