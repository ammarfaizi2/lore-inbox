Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUK0LOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUK0LOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 06:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUK0LOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 06:14:16 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:34198 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261186AbUK0LNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 06:13:49 -0500
Date: Sat, 27 Nov 2004 03:13:46 -0800
To: davem@redhat.com, linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: sparclinux@vger.kernel.org
Subject: [PATCH 2.6.9] Fix drivers/video/bw2.c compilation
Message-ID: <20041127111346.GA30214@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, davem@redhat.com,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	sparclinux@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dave,

Here's a patch that allows bw2.c to compile on 2.6.9, just redeclares a
char* that suddenly went missing. Please apply.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bw2.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.6.9/drivers/video/bw2.c~	2004-11-26 20:01:21.167388608 =
-0500
+++ kernel-source-2.6.9/drivers/video/bw2.c	2004-11-26 20:03:25.636466432 -=
0500
@@ -385,6 +385,7 @@
 {
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
+	char *option =3D NULL;
=20
 	if (fb_get_options("bw2fb", &option))
 		return -ENODEV;

--82I3+IH0IqGh5yIs--

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQahhaqOILr94RG8mAQKjDg/+LBh9LCDrkxC7YQo+GyITe8Y/MVAQM7Vm
asz7+uK0EtDPopuu2VylSKHiOOQrdG9Z775rUyTw5kEKNOYAOHQx4Yu8uIYs3ZE+
eK3x6p4DhVH4nCe1KAz2TGA+HLrbXPr8pMZ2StkdkS2s/sb8ayQWDdk1e40Th5LH
cQK8DXFn3+yAFDX1DdvOeyULmNTp3qER8CrlZCVRdEcBO4QSK7g8nhy5Ei8RzQ8W
0H+5hKu5pRpYxavAiMjxQvDbO1g6Pkfi8biQTMcNDepDeGlam5B9tM9akDzjEf6b
HUULjIPQLCYLGVLVxL5HeHs2S6onM4BSsF3ucvF0h9ACIyQL54BGIvkuE0Nm9jSX
PWT3MSaPgBJwJNMGW5O178uSMCNug+btB0XlZZs8K4nXb+SI31jte3B7cnaGaAcJ
DrCEPKtr9IvSRFNydgygseF75uWHC8101bYQ6lCuNvVFUFszDVfPqnTKhAq/TQH9
pS19mPVr/XHGCZC0ljcxbVB/gOY7ZgEgYOGDZ0U/3WkBBY86sUwLlZ61ad/fvPEg
KZloKFdIm9XB54aOxT151J0O6UDrVOAcFWWlbtoVpGvy79iflPpyS+5XI6RzU/Fs
WOw+AUphXn3MdmpzvMg7YQuY/Uf9gSeGi8KIyiBiE8UoY2slSGzJv3TgLf5UY9HD
DqoH5c0ZOro=
=+0VM
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
