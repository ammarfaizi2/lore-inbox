Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265717AbTFXGRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 02:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbTFXGRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 02:17:35 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:26634 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265717AbTFXGRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 02:17:31 -0400
Date: Tue, 24 Jun 2003 08:31:38 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030624063137.GA6353@lug-owl.de>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <20030623235013.GZ6353@lug-owl.de> <Pine.SOL.4.30.0306240249410.5865-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3TjJaq4Yth4AkTaU"
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306240249410.5865-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3TjJaq4Yth4AkTaU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-24 02:53:29 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiew=
icz@elka.pw.edu.pl>
wrote in message <Pine.SOL.4.30.0306240249410.5865-100000@mion.elka.pw.edu.=
pl>:
> On Tue, 24 Jun 2003, Jan-Benedict Glaw wrote:
> > > TCQ shouldn't be enabled on hdc, you have two drives on second ide
> > > channel and current TCQ driver design allows only one drive per chann=
el,
> > > so proper fix is to not enable TCQ :-).
> >
> > Your patch works for me - TCQ gets no longer stitched on while I've
> > configured to default ON, queue depth 32:
> >
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx
> > PIIX4: IDE controller at PCI slot 00:07.1
> > PIIX4: chipset revision 1
> > PIIX4: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> > hda: WDC AC2850F, ATA DISK drive
> > hdb: IC35L040AVER07-0, ATA DISK drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > hdc: IC35L120AVV207-0, ATA DISK drive
> > hdd: Maxtor 4W100H6, ATA DISK drive
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: max request size: 128KiB
> > hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
> > hda: 1667232 sectors (854 MB) w/64KiB Cache, CHS=3D1654/16/63, DMA
> >  hda: hda1 hda2 hda3
> > hdb: max request size: 128KiB
> > hdb: host protected area =3D> 1
> > hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=3D79780/16/63, UD=
MA(33)
> >  hdb: hdb1 hdb2 hdb3 hdb4
> > hdc: max request size: 1024KiB
> > hdc: host protected area =3D> 1
> > hdc: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=3D15017/255/63,=
 UDMA(33)
> >  hdc: hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc14 hdc=
15 hdc16 hdc17 >
> > hdd: max request size: 128KiB
> > hdd: host protected area =3D> 1
> > hdd: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=3D194158/16/63,=
 UDMA(33)
> >  hdd: hdd1 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 hdd11 hdd12 hdd13 hdd14 >
>=20
> There is no info about IDE trying (then failing) to enable TCQ ?

No, there isn't. The box is now up'n'running for nearly 7 hours - that
should have been enough:) That's with your patch applied and the IDE
config as attached below.

Up to now, there's not a single IDE failure of any kind *knock on wood*.

MfG, JBG

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_IDE_TCQ=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=3D32
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy


--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--3TjJaq4Yth4AkTaU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9/BJHb1edYOZ4bsRArXAAJ9Oz7MdC8AfSJQZK35rJ/NpUqwbngCgkR9F
1ebs71I7EpBG+tRuyLpTIVU=
=2MP1
-----END PGP SIGNATURE-----

--3TjJaq4Yth4AkTaU--
