Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291160AbSBGPGH>; Thu, 7 Feb 2002 10:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291161AbSBGPFv>; Thu, 7 Feb 2002 10:05:51 -0500
Received: from florin.dsl.visi.com ([209.98.146.184]:33836 "HELO
	beaver.iucha.org") by vger.kernel.org with SMTP id <S291160AbSBGPFc>;
	Thu, 7 Feb 2002 10:05:32 -0500
Date: Thu, 7 Feb 2002 09:05:25 -0600
To: Matt_Domsch@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: SIS900 driver unresolved dependency crc32_be in 2.5.3
Message-ID: <20020207150525.GA4629@iucha.net>
Mail-Followup-To: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a K7S5A with onboard LAN.=20

I am compiling the driver (SIS900) as module and I have crc32 lib built
in the kernel. When I run "make modules_install" or "modprobe sis900"
afterwards I get=20

bear:~# modprobe sis900
/lib/modules/2.5.3-xfs-k7/kernel/drivers/net/sis900.o: unresolved symbol
crc32_be
/lib/modules/2.5.3-xfs-k7/kernel/drivers/net/sis900.o: insmod
/lib/modules/2.5.3-xfs-k7/kernel/drivers/net/sis900.o failed
/lib/modules/2.5.3-xfs-k7/kernel/drivers/net/sis900.o: insmod sis900
failed

Relevant portions of .config:

# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
CONFIG_SIS900=3Dm
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set

#
# Library routines
#
CONFIG_CRC32=3Dy
CONFIG_ZLIB_INFLATE=3Dm
# CONFIG_ZLIB_DEFLATE is not set  =20

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Ype1NLPgdTuQ3+QRAjTvAJ45FQgr5rOtmPCAHt6KmWfP1Zv+7QCfS7eX
9LCZqo5vSvsgMR+sUCN0MQA=
=eE+/
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
