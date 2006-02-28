Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWB1Kl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWB1Kl2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWB1Kl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:41:27 -0500
Received: from mail.gmx.de ([213.165.64.20]:13193 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932166AbWB1Kl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:41:27 -0500
X-Authenticated: #2308221
Date: Tue, 28 Feb 2006 11:41:23 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add =?iso-8859-1?Q?pata=5Fpdc?=
	=?iso-8859-1?Q?=5F2=DF27x_to_Kconfi?=
	=?iso-8859-1?Q?g?= and Makefile (was: Re: libata PATA patch for 2.6.16-rc5)
Message-ID: <20060228104123.GA13125@zeus.uziel.local>
References: <1141054370.3089.0.camel@localhost.localdomain> <20060228003039.GA13335@zeus.uziel.local> <1141120189.3089.47.camel@localhost.localdomain> <20060228102052.GB19574@zeus.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20060228102052.GB19574@zeus.uziel.local>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi Alan,

the pata_pdc2027x driver works flawlessly AFAICT - the only weird thing about it would
be some duplicated init messages in dmesg:

pata_pdc2027x 0000:00:0c.0: version 0.73
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
pata_pdc2027x 0000:00:0c.0: PLL input clock 20020 kHz
ata3: PATA max UDMA/133 cmd 0xF08217C0 ctl 0xF0821FDA bmdma 0xF0821000 irq 3
ata4: PATA max UDMA/133 cmd 0xF08215C0 ctl 0xF0821DDA bmdma 0xF0821008 irq 3
ata3: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:407f
ata3: dev 0 ATA-7, max UDMA/133, 234493056 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : pata_pdc2027x
ata4: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:407f
ata4: dev 0 ATA-7, max UDMA/133, 234493056 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : pata_pdc2027x
  Vendor: ATA       Model: SAMSUNG SV1203N   Rev: TQ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234493056 512-byte hdwr sectors (120060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 2:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: SAMSUNG SV1203N   Rev: TQ10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 234493056 512-byte hdwr sectors (120060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 3:0:0:0: Attached scsi disk sdb

It appears to me that some part of drive detection is done twice - at
least the output is generated redundantly. If this is a bug and not a
feature, maybe one issue of the output could be trimmed in the end.

There have been rumours about some Promise controller having trouble
with UDMA6 and the Linux drivers, but I am running this configuration
for quite some time now and never had the slightest problem.


Thanks, everyone, for the good stuff : )

Chris

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iQIVAwUBRAQo012m8MprmeOlAQLX+hAAhl0PrQKDOVOXNn9+fmL2m+jJzuysWy+n
K4/fvBMKwZwTzBuJr+cvVW4ewtOcjacy5+JYu6PpGzhMcE7Jff+YUfgbCLT0krOa
RfJFZb87OxNKlgF2bvsxYp2hiJSEPB9DvDX61dnf1V/ACTAwyhBb9ZrJX/B84QX2
SA/Vk9rUv2Uw1gtEwt9WTvmT2WDJM9ki+VcU0g/35cUXWRj8d/PKX80F1b7dGoF9
UK0nb9pnSLsxPcBx9Co7g/bLy+57+UqfHaxr9nTeyTVHYdvQphWClm0IwnScvPkD
r1KpXpUZeUUaaezNaS6YfNjyhNFi8LTxks6jl585zrYebVNL2LvMZv1hU7hMNaF2
IX1OnX9n2rEkxHhzpyiIR7IB5dmkvPlZxVzw4QUV9JuKwoOGGMsvl/0i3EzkChLe
GNQNICk8lhOaRGqsm3JbKrOe1DB9s5K/Fe4CLQ94Af569HkJmoaaDTK1AWzU9ZLh
2/GKcTryjfnHTnEZXAQz0/RbaXYkm7CPJhz6IQzdCWm4QFVh/i0zS2oI9wUtAcmE
/0+W1XTYF92K4guNuNQuIRcPgM/TiGFkrM1PX9RaiCi0OrVxzEDvxFjLhrg0e9ZB
NMMX8YKvf8d2Bkv9ag7tnwdvQt/i9xrSpkXOs3LytDPCoVVAsFARrGJPgdFfWiSX
CDpQ9sKE32U=
=Iv2F
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

