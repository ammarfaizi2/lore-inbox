Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSEBJvx>; Thu, 2 May 2002 05:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSEBJvw>; Thu, 2 May 2002 05:51:52 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:4881 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S314325AbSEBJvv>;
	Thu, 2 May 2002 05:51:51 -0400
Date: Thu, 2 May 2002 11:51:23 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] ide-2.4.19-p7.all.convert.8.patch piix_dmaproc/ide_dmaproc
Message-ID: <20020502095123.GA17480@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
when running 2.4.19-pre7 + ide-2.4.19-p7.all.convert.8.patch i get
a crash on booting while detection of the onboard IDE controller.

00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (r=
ev 11) (prog-if 80 [Master])
	Subsystem: Siemens Nixdorf AG: Unknown device 0055
	Flags: bus master, medium devsel, latency 0
	I/O ports at 2400 [size=3D16]

Oops is a "Null pointer dereference at 00000040"
EIP is "ide_dmaproc" + 1e
Call trace "piix_dmaproc" "ide_register_subdriver" "idedisk_init"=20

Decoded by hand. I tried with and with taskfile ..

Config snippet:

CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_IDE_TASKFILE_IO=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_PIIX_TUNING=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_BLK_DEV_IDE_MODES=3Dy

Flo
BTW: It seems linux/ide.h misses an include of linux/pci.h
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE80QwbUaz2rXW+gJcRAqydAJ4n/sSLDounH7sRkWTFL8dMnI6ZbgCgpvJG
eslvGrt62QgkwyrijO09CPg=
=KEci
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
