Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSIZUfJ>; Thu, 26 Sep 2002 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbSIZUfJ>; Thu, 26 Sep 2002 16:35:09 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:7997 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261517AbSIZUfH>;
	Thu, 26 Sep 2002 16:35:07 -0400
Date: Thu, 26 Sep 2002 22:40:18 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Linux 2.5.38
Message-ID: <20020926204018.GC1892@jaquet.dk>
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2002 at 09:34:18PM -0700, Linus Torvalds wrote:
>=20
> Trying to be a bit more timely about releases, especially since some=20
> people couldn't use 2.5.37 due to the X lockup that should hopefully
> be fixed (no idea _why_ that old bug only started to matter recently, the=
=20
> bug itself was several months old).

This trivial patch fixes a trivial bug in drivers/cdrom/gscd.c:


--- linux-2.5.38/drivers/cdrom/gscd.c	Sun Sep 22 06:24:58 2002
+++ linux-2.5.38-new/drivers/cdrom/gscd.c	Thu Sep 26 22:38:11 2002
@@ -901,7 +901,7 @@
 static struct gendisk gscd_disk =3D {
 	.major =3D MAJOR_NR,
 	.first_minor =3D 0,
-	,minor_shift =3D 0,
+	.minor_shift =3D 0,
 	.fops =3D &gscd_fops,
 	.major_name =3D "gscd"
 };

Regards,
  Rasmus

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9k3CylZJASZ6eJs4RAphyAKCTUBaAPNxfAQtFeEtv/85k9ejR0QCcDlYZ
CyjrNFgBRWENKwtE6ETXJ28=
=Xt9T
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
