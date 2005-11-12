Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVKLIPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVKLIPF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 03:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVKLIPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 03:15:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:48579 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932193AbVKLIPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 03:15:04 -0500
Message-ID: <4375A522.9010308@punnoor.de>
Date: Sat, 12 Nov 2005 09:17:38 +0100
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-dvb-maintainer@linuxtv.org
Subject: [PATCH] Linux 2.6.15-rc1; fix b2c2 dvb undefined symbol
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB019D926C9A744B9147F1503"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB019D926C9A744B9147F1503
Content-Type: multipart/mixed;
 boundary="------------090401060900050307020505"

This is a multi-part message in MIME format.
--------------090401060900050307020505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

(I hope I mailed the right people.)

Problem:
drivers/built-in.o: In function `flexcop_frontend_init':
: undefined reference to `lgdt330x_attach'

Solution:
--- linux/drivers/media/dvb/b2c2/Kconfig.old	2005-11-12
09:07:05.638999080 +0100
+++ linux/drivers/media/dvb/b2c2/Kconfig	2005-11-12 09:07:17.502195600 +0=
100
@@ -7,6 +7,7 @@
 	select DVB_NXT2002
 	select DVB_STV0297
 	select DVB_BCM3510
+	select DVB_LGDT330X
 	help
 	  Support for the digital TV receiver chip made by B2C2 Inc. included i=
n
 	  Technisats PCI cards and USB boxes.



(how to tell tb not to mangle patches? I attached it therefore...)


New Problem:
I really dislike that dvb people want to include every possible frontend
into the kernel - I only need the mt312 one for my Skystar2 card. I'd
highly appreciate it this would be made selectable again...


Signed-off-by: Prakash Punnoor <prakash@punnoor.de>


--=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--------------090401060900050307020505
Content-Type: text/plain;
 name="b2c2_select_lgdt330x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b2c2_select_lgdt330x.patch"

--- linux/drivers/media/dvb/b2c2/Kconfig.old	2005-11-12 09:07:05.638999080 +0100
+++ linux/drivers/media/dvb/b2c2/Kconfig	2005-11-12 09:07:17.502195600 +0100
@@ -7,6 +7,7 @@
 	select DVB_NXT2002
 	select DVB_STV0297
 	select DVB_BCM3510
+	select DVB_LGDT330X
 	help
 	  Support for the digital TV receiver chip made by B2C2 Inc. included in
 	  Technisats PCI cards and USB boxes.

--------------090401060900050307020505--

--------------enigB019D926C9A744B9147F1503
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdaUixU2n/+9+t5gRAppTAJ9oEYZoaF2u5F969cZYa7ERsjcuBQCdHMZ3
tEVPKwYIMD1jWA/mxptNOOk=
=iGEv
-----END PGP SIGNATURE-----

--------------enigB019D926C9A744B9147F1503--
