Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWCMWbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWCMWbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWCMWbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:31:38 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:55448 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S964818AbWCMWbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:31:36 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Mon, 13 Mar 2006 23:31:29 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1142262431.25773.25.camel@localhost.localdomain>
In-Reply-To: <1142262431.25773.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3464782.krDxg1OKmr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603132331.33129.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3464782.krDxg1OKmr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I tried your ide1 patch with 2.6.16-rc6 and NFORCE2 board, thus using the A=
MD=20
driver (and sil sata driver).

I get this in dmesg:

libata version 1.20 loaded.
sata_sil 0000:01:0b.0: version 0.9
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) =
=2D>=20
IRQ 18
ata1: SATA max UDMA/100 cmd 0xF0806080 ctl 0xF080608A bmdma 0xF0806000 irq =
18
ata2: SATA max UDMA/100 cmd 0xF08060C0 ctl 0xF08060CA bmdma 0xF0806008 irq =
18
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4773 85:7c69 86:3e01 87:4763=20
88:207f
ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
  Vendor: ATA       Model: Maxtor 7V300F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
pata_amd 0000:00:09.0: version 0.1.3
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata3: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=20
88:0407
ata3: dev 0 ATAPI, max UDMA/33
ata3: PIO error
ata3: dev 0 configured for UDMA/33
scsi2 : pata_amd
  Vendor: NU        Model: DVDRW DDW-081     Rev: BX32
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
ATA: abnormal status 0x7F on port 0x177
ata4: dev 0 cfg 49:0e00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000=20
88:0000
ata4: no dma
ata4: dev 0 not supported, ignoring
scsi3 : pata_amd
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 > sda3
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 12x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 2:0:0:0: Attached scsi generic sg1 type 5


Though log gives a PIO error (see above) for the DVD+RW drive, it seems to=
=20
work w/o problems in a quick test. But I have a ATAPI ZIP-100 drive connect=
ed=20
to the secondary master port and this device doesn't show up. The log seems=
=20
to indicate some problems. I know it is a PIO0 device, so maybe this is the=
=20
problem? PIO not implemented, yet? Or have I missed a SCSI option to be=20
enabled?

I will see how the DVD+RW drive behaves and let you know whether it makes=20
troubles. :-)

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart3464782.krDxg1OKmr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEFfLFxU2n/+9+t5gRAo08AKCf+zMB16TSsjbYmUt2OBoC9wIUeQCfaJ8r
vwU1esYIz3N32NRNc7TtZ4I=
=Q6IL
-----END PGP SIGNATURE-----

--nextPart3464782.krDxg1OKmr--
