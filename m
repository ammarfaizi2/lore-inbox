Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292415AbSBZRbL>; Tue, 26 Feb 2002 12:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292421AbSBZRbC>; Tue, 26 Feb 2002 12:31:02 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:8088 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S292415AbSBZRap>; Tue, 26 Feb 2002 12:30:45 -0500
Date: Tue, 26 Feb 2002 12:30:38 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 3c59x and cardbus
Message-ID: <20020226173038.GD803@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When you remove a 3c59x-based cardbus, the fonction vortex_remove_one
is called and this function end with kfree(dev).

I was looking why enable_wol loose its value after a remove/insert cycle
but this value is store in the private part of dev so it's free with
dev.

The driver is not unloaded during the remove/insert cycle so it's a
kernel space problem.

Have I missed something here ?

Christophe


--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

There is no snooze button on a cat who wants breakfast.

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8e8Y+j0UvHtcstB4RAkYjAKCUW3N0AJPdH+J79u4gY293oZCNnwCgjjMV
tnaFE9X8+l4LWH4oP84DNbQ=
=YyTH
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
