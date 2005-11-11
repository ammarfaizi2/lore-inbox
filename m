Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVKKPQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVKKPQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKKPQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:16:00 -0500
Received: from mx.laposte.net ([81.255.54.11]:14001 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750807AbVKKPQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:16:00 -0500
Subject: Re: How to speed up raid1 resync ?
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1131717619.4133.13.camel@rousalka.dyndns.org>
References: <1131717619.4133.13.camel@rousalka.dyndns.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fhXxFHBoSfthyj7+Xgbz"
Organization: Perso
Date: Fri, 11 Nov 2005 16:15:44 +0100
Message-Id: <1131722145.4802.6.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fhXxFHBoSfthyj7+Xgbz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On the original system I have :

# /sbin/sysctl dev.raid.speed_limit_min
dev.raid.speed_limit_min =3D 1000
# /sbin/sysctl dev.raid.speed_limit_max
dev.raid.speed_limit_max =3D 200000

After the suggested change the sync starts flying and the system is
still very responsive. Thanks a lot Anton, looks like the default is
much too conservative for my system!

BTW since I'll be doing some pvmoves later on does a similar tunable
exist to speed it up too ? (will move the LVM which is on this raid to
another software raid array)

Regards,

--=20
Nicolas Mailhot

--=-fhXxFHBoSfthyj7+Xgbz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkN0tZ8ACgkQI2bVKDsp8g1/VACdHaqku36+QEix0B19xNQdblzi
4moAoL4oyhG7rWJoWx94UT/qOVFL5T8V
=uvG5
-----END PGP SIGNATURE-----

--=-fhXxFHBoSfthyj7+Xgbz--

