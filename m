Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbVHEVl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbVHEVl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVHEVjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:39:01 -0400
Received: from lug-owl.de ([195.71.106.12]:17072 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261896AbVHEVhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:37:15 -0400
Date: Fri, 5 Aug 2005 23:37:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050805213714.GG7464@lug-owl.de>
Mail-Followup-To: Martin Drab <drab@kepler.fjfi.cvut.cz>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com> <20050804065447.GB25606@lug-owl.de> <20050804203831.GD4029@stusta.de> <20050805211410.GE7464@lug-owl.de> <Pine.LNX.4.60.0508052328040.21975@kepler.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0508052328040.21975@kepler.fjfi.cvut.cz>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-05 23:30:04 +0200, Martin Drab <drab@kepler.fjfi.cvut.cz> w=
rote:
> > init/main.c:212: error: __setup_str_quiet_kernel causes a section type =
conflict
> > init/main.c:220: error: __setup_str_loglevel causes a section type conf=
lict
> > init/main.c:298: error: __setup_str_init_setup causes a section type co=
nflict
> > init/main.c:543: error: __setup_str_initcall_debug_setup causes a secti=
on type conflict
> > make[1]: *** [init/main.o] Error 1
> > make: *** [init] Error 2
>=20
> I guess kernel may not yet be ready to be compiled by the latest CVS GCC=
=20
> 4.1.x (currently HEAD). But it should (at least works for me) do the=20
> latest CVS GCC 4.0.x.

As I worte previously, I now again do regular compile runs with gcc-HEAD
for the VAX port and it works. ...but only, if -fno-unit-at-a-time is
supplied.

So I actually suspect two bugs: one in the kernel's sources (missing
"const" or rw/ro attributes) and -fno-unit-at-a-time disables some
gcc-internal tests that should have fired.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC89wKHb1edYOZ4bsRAsU8AJsGDxkHm5myc06dhRKTIi4/qPRM1wCeMgDB
Y+tAG8ph7O9Gmauzf2B8/OM=
=BO1l
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
