Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVGBUGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVGBUGP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 16:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVGBUGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 16:06:15 -0400
Received: from smtp1.irishbroadband.ie ([62.231.32.12]:10991 "EHLO
	smtp1.irishbroadband.ie") by vger.kernel.org with ESMTP
	id S261269AbVGBUFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 16:05:47 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: Tony Vroon <chainsaw@gentoo.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120333574.5073.26.camel@mulgrave>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>  <1120323691.5073.12.camel@mulgrave>
	 <1120324426.21967.1.camel@localhost>  <1120325613.5073.16.camel@mulgrave>
	 <1120326423.22057.3.camel@localhost>  <1120329389.5073.21.camel@mulgrave>
	 <1120331026.22021.2.camel@localhost>  <1120333574.5073.26.camel@mulgrave>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SFeEMHEjchRNKbTcUbV5"
Organization: Gentoo Linux
Date: Sat, 02 Jul 2005 21:04:54 +0100
Message-Id: <1120334694.21898.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SFeEMHEjchRNKbTcUbV5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-07-02 at 14:46 -0500, James Bottomley wrote:
> This should, therefore, get the whole lot booting again.
Confirmed. Thumbs up :)

For good measure, here is the relevant bit of dmesg output:
CPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level,
high) -> IRQ 17
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

 target0:0:0: asynchronous.
  Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s ST (12.5 ns, offset 127)
 target0:0:0: Ending Domain Validation
(scsi0:A:1:0): refuses WIDE negotiation.  Using 8bit transfers
 target0:0:1: asynchronous.
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:1: Beginning Domain Validation
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 7)
 target0:0:1: Ending Domain Validation
(scsi0:A:2:0): refuses WIDE negotiation.  Using 8bit transfers
 target0:0:2: asynchronous.
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:2: Beginning Domain Validation
 target0:0:2: Domain Validation skipping write tests
 target0:0:2: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:2: Ending Domain Validation
target0:0:3: asynchronous.
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:3: Beginning Domain Validation
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target0:0:3: Ending Domain Validation
 target0:0:5: asynchronous.
  Vendor: QUANTUM   Model: ATLAS10K3_36_SCA  Rev: 020W
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:5:0: Tagged Queuing enabled.  Depth 32
 target0:0:5: Beginning Domain Validation
 target0:0:5: wide asynchronous.
 target0:0:5: FAST-80 WIDE SCSI 160.0 MB/s ST (12.5 ns, offset 127)
 target0:0:5: Ending Domain Validation
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous.
 target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s ST (12.5 ns, offset 63)
 target0:0:6: Ending Domain Validation
SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71833096 512-byte hdwr sectors (36779 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 71833096 512-byte hdwr sectors (36779 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 5, lun 0
ttached scsi disk sdb at scsi0, channel 0, id 5, lun 0
SCSI device sdc: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sr2: scsi-1 drive
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg3 at scsi0, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg4 at scsi0, channel 0, id 5, lun 0,  type 0
Attached scsi generic sg5 at scsi0, channel 0, id 6, lun 0,  type 0


--=-SFeEMHEjchRNKbTcUbV5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCxvNmp5vW4rUFj5oRApktAJwPY0zDcba4Q96lFta3rVW+ZLi7bwCfT8Vg
nrcxoOe740TED/lhM+l9Z/Q=
=f55B
-----END PGP SIGNATURE-----

--=-SFeEMHEjchRNKbTcUbV5--

