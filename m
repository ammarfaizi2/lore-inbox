Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSGUVit>; Sun, 21 Jul 2002 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSGUVit>; Sun, 21 Jul 2002 17:38:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.170]:50882 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314284AbSGUVir>; Sun, 21 Jul 2002 17:38:47 -0400
Date: Sun, 21 Jul 2002 23:41:52 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc3 build problem
Message-ID: <20020721214151.GD27075@mandel.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please disregard my previous mail. I forgot to run "make oldconfig".
Sorry.

I wanted to report a different problem anyway but I cannot reproduce
it. The error was:

make[2]: Entering directory `/mnt/linux-2.4.19-rc3/drivers/scsi'
mkdir -p /lib/modules/2.4.19-rc3/kernel/drivers/scsi/
cp aha1542.o g_NCR5380.o ppa.o sg.o sr_mod.o st.o /lib/modules/2.4.19-rc3/k=
ernel/drivers/scsi/
cp: aha1542.o: No such file or directory
make[2]: *** [_modinst__] Error 1
make[2]: Leaving directory `/mnt/linux-2.4.19-rc3/drivers/scsi'
make[1]: *** [_modinst_scsi] Error 2
make[1]: Leaving directory `/mnt/linux-2.4.19-rc3/drivers'
make: *** [_modinst_drivers] Error 2

during "make modules_install". In this configuration, aha1542 was disabled
and I did a "make oldconfig" and "make menuconfig", "make dep", and
"make clean" before the build.

Could there be a problem when the previous kernel configuration has
CONFIG_SCSI_AHA1542=3Dm and then a new configuration with CONFIG_SCSI_AHA15=
42
off is created?

Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment:  

iD8DBQE9OyqfLbySPj3b3eoRAnWVAKCR7ZcqxAZ3OP2vxvX2Kpzs8mXTngCgiatJ
bdBHdQoF6SKow2Q/MXdglNo=
=n398
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
