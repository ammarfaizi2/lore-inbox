Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSIZVHo>; Thu, 26 Sep 2002 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSIZVHo>; Thu, 26 Sep 2002 17:07:44 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:19261 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261505AbSIZVHm>;
	Thu, 26 Sep 2002 17:07:42 -0400
Date: Thu, 26 Sep 2002 23:12:54 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Linux 2.5.38
Message-ID: <20020926211253.GD1892@jaquet.dk>
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
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

Two additional gendisk patches:


--- linux-2.5.38/drivers/cdrom/mcd.c	Sun Sep 22 06:25:12 2002
+++ linux-2.5.38-new/drivers/cdrom/mcd.c	Thu Sep 26 22:41:05 2002
@@ -227,7 +227,7 @@
 	.minor_shift	=3D 0,
 	.major_name	=3D "mcd",
 	.fops		=3D &mcd_bdops,
-	.flags		=3D GENHD_FL_CD;
+	.flags		=3D GENHD_FL_CD,
 };
=20
 #ifndef MODULE



--- linux-2.5.38/drivers/cdrom/sonycd535.c	Sun Sep 22 06:25:06 2002
+++ linux-2.5.38-new/drivers/cdrom/sonycd535.c	Thu Sep 26 22:48:36 2002
@@ -1462,6 +1462,7 @@
 	.minor_shift =3D 0,
 	.fops =3D &cdu_fops,
 	.major_name =3D "cdu"
+};
=20
 /*
  * Initialize the driver.


Regards,
  Rasmus

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9k3hVlZJASZ6eJs4RAtFRAJ4+Z17VJXofYzpykMRi9UxOgtWXXwCeIX/E
6/9cOyxCcSoJOdvYzBQ2E4o=
=TSJy
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
