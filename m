Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVKUA11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVKUA11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKUA11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:27:27 -0500
Received: from mx.laposte.net ([81.255.54.11]:36660 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932132AbVKUA11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:27:27 -0500
Subject: Re: Does Linux support powering down SATA drives?
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: marc@perkel.com, asmith@vtrl.co.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SdGp/R0zyFs0WfPzPnQ5"
Organization: Perso
Date: Mon, 21 Nov 2005 01:27:08 +0100
Message-Id: <1132532829.3498.6.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SdGp/R0zyFs0WfPzPnQ5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> I would agree with your view on IDE becoming obsolete on hard drives,
> but I as yet, am not aware of any CD/DVD drives with a SATA interface.

$  cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: DVDR   PX-716A   Rev: 1.09
  Type:   CD-ROM                           ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6L300S0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6L300S0   Rev: BANC
  Type:   Direct-Access                    ANSI SCSI revision: 05
$ /sbin/lspci | grep -i scsi
$ /sbin/lspci | grep -i ata
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
(rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
(rev f3)
01:09.0 Mass storage controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)

And BTW,

#  /sbin/hdparm -M 128 /dev/hda

/dev/hda:
 setting acoustic management to 128
 acoustic     =3D  0 (128=3Dquiet ... 254=3Dfast)

(failure but I don't care the drive is old and already in AAM mode)

#  /sbin/hdparm -M 128 /dev/sda

/dev/sda:
 setting acoustic management to 128
 HDIO_GET_ACOUSTIC failed: Inappropriate ioctl for device

(This drive however is not and needs it dearly. Plus it's the Linux
drive, so it's used most of the time)

Regards,

--=20
Nicolas Mailhot

--=-SdGp/R0zyFs0WfPzPnQ5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkOBFFsACgkQI2bVKDsp8g2k2ACgpSeUrdVnXjqlydY+R0cKDKX5
Qb4AoIHWfNz/f0VMRj4sQyyMyd7Q6REI
=NmS6
-----END PGP SIGNATURE-----

--=-SdGp/R0zyFs0WfPzPnQ5--

