Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270532AbTGSTzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270522AbTGSTzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:55:24 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:35979 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S270535AbTGSTx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:53:27 -0400
Subject: Re: libata driver update posted
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Catalin BOIE <util@deuroconsult.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20030718154322.GB27152@gtf.org>
References: <3F1711C8.6040207@pobox.com>
	 <Pine.LNX.4.53.0307180924020.19703@hosting.rdsbv.ro>
	 <3F17F28C.9050105@pobox.com>
	 <1058542771.13515.1599.camel@workshop.saharacpt.lan>
	 <20030718154322.GB27152@gtf.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XTaLagbB9D6wgYWlYhtT"
Message-Id: <1058645294.23174.7.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 22:08:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XTaLagbB9D6wgYWlYhtT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-18 at 17:43, Jeff Garzik wrote:
> On Fri, Jul 18, 2003 at 05:39:32PM +0200, Martin Schlemmer wrote:
> > How is performance compared to the default driver for the ICH5 SATA ?
>=20
> I haven't done any comparisons because the "default driver" just flat
> out doesn't work for me.
>=20
> However, if performance is lower, then I consider that a bug.
>=20

Slower this side.  The Maxtor 40GB (ata133) is however just set to
udma33, where the Seagate 20GB (ata100) driver is set correctly to
udma100.

The Seagate start off ok (about 35mb/s), but then after doing some heavy
disk io, it also just drops to the 20mb/s region.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Normal ATA driver=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

---------------------------------------------------------------------
nosferatu root # hdparm -Tt /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   3364 MB in  2.00 seconds =3D 1682.26 MB/sec
 Timing buffered disk reads:  120 MB in  3.01 seconds =3D  39.82 MB/sec
nosferatu root # hdparm -Tt /dev/hde

/dev/hde:
 Timing buffer-cache reads:   3368 MB in  2.00 seconds =3D 1684.26 MB/sec
 Timing buffered disk reads:  124 MB in  3.01 seconds =3D  41.19 MB/sec
nosferatu root # hdparm -Tt /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   3372 MB in  2.00 seconds =3D 1683.73 MB/sec
 Timing buffered disk reads:  120 MB in  3.01 seconds =3D  39.86 MB/sec
nosferatu root # hdparm -Tt /dev/hde

/dev/hde:
 Timing buffer-cache reads:   3384 MB in  2.00 seconds =3D 1691.41 MB/sec
 Timing buffered disk reads:  124 MB in  3.01 seconds =3D  41.20 MB/sec
nosferatu root #
---------------------------------------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: ASUS DVD-ROM E616, ATAPI CD/DVD-ROM drive
hdb: ASUS CRW-2410A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MAXTOR 6L040J2, ATA DISK drive
hdd: LS-120 COSM 04 UHD Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 18
    ide2: BM-DMA at 0xef60-0xef67, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xef68-0xef6f, BIOS settings: hdg:pio, hdh:pio
hde: ST320011A, ATA DISK drive
ide2 at 0xefe0-0xefe7,0xefae on irq 18
hdc: max request size: 128KiB
hdc: host protected area =3D> 1
hdc: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=3D77557/16/63,
UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1
hde: max request size: 128KiB
hde: host protected area =3D> 1
hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=3D38792/16/63,
UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4
end_request: I/O error, dev hda, sector 0
hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: ASUS      Model: CRW-2410A         Rev: 1.0
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: LS-120 COSM   04  Rev: 0270
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
sr0: scsi-1 drive
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
---------------------------------------------------------------------

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
The libata driver =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

---------------------------------------------------------------------
nosferatu root # hdparm -tT /dev/sda

/dev/sda:
 Timing buffer-cache reads:   3412 MB in  2.00 seconds =3D 1705.41 MB/sec
 Timing buffered disk reads:   66 MB in  3.08 seconds =3D  21.43 MB/sec
nosferatu root # hdparm -tT /dev/sdb

/dev/sdb:
 Timing buffer-cache reads:   3368 MB in  2.00 seconds =3D 1683.41 MB/sec
 Timing buffered disk reads:   68 MB in  3.03 seconds =3D  22.46 MB/sec
nosferatu root # hdparm -tT /dev/sda

/dev/sda:
 Timing buffer-cache reads:   3376 MB in  2.00 seconds =3D 1688.26 MB/sec
 Timing buffered disk reads:   66 MB in  3.08 seconds =3D  21.42 MB/sec
nosferatu root # hdparm -tT /dev/sdb

/dev/sdb:
 Timing buffer-cache reads:   3396 MB in  2.00 seconds =3D 1698.26 MB/sec
 Timing buffered disk reads:   68 MB in  3.03 seconds =3D  22.45 MB/sec
nosferatu root #
-------------------------------------------------------------------
ata_piix version 0.92
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata1: unhandled bus state 0
ata1: dev 0 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:043f
ata1: dev 0 ATAPI, max UDMA/100
ata1: dev 1 cfg 49:0b00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0407
ata1: dev 1 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
ata1: dev 1 configured for UDMA/33
scsi0 : ata_piix
  Vendor: ASUS      Model: DVD-ROM E616      Rev: Z.2
  Type:   CD-ROM                             ANSI SCSI revision: 00
  Vendor: ASUS      Model: CRW-2410A         Rev: 1.0
  Type:   CD-ROM                             ANSI SCSI revision: 00
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
ata2: unhandled bus state 0
ata2: dev 0 cfg 49:0f00 82:346b 83:5b01 84:4003 85:3469 86:1a01 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 78177792 sectors
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: ATA       Model: MAXTOR 6L040J2    Rev: 0.65
  Type:   Direct-Access                      ANSI SCSI revision: 05
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 18
ata4: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 18
ata3: dev 0 cfg 49:2f00 82:346b 83:4b01 84:4000 85:3469 86:0201 87:4000
88:203f
ata3: dev 0 ATA, max UDMA/100, 39102336 sectors
ata3: dev 0 configured for UDMA/100
scsi2 : ata_piix
  Vendor: ATA       Model: ST320011A         Rev: 0.65
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata4: thread exiting
scsi3 : ata_piix
libata version 0.65 loaded.
SCSI device sda: 78177792 512-byte hdwr sectors (40027 MB)
SCSI device sda: drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0: p1
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 39102336 512-byte hdwr sectors (20020 MB)
SCSI device sdb: drive cache: write through
 /dev/scsi/host2/bus0/target0/lun0: p1 p2 p3 p4
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr1: scsi-1 drive
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi2, channel 0, id 0, lun 0,  type 0
---------------------------------------------------------


Thanks,

--=20

Martin Schlemmer




--=-XTaLagbB9D6wgYWlYhtT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/GaUuqburzKaJYLYRAjoyAJsF0x75CU/hwnL6IoQaEwTbY2DWvACfXDv6
8vSx7KheMKh2WkItpKJ1p/k=
=Hyfe
-----END PGP SIGNATURE-----

--=-XTaLagbB9D6wgYWlYhtT--

