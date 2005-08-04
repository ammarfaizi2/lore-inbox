Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVHDGyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVHDGyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVHDGyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:54:51 -0400
Received: from lug-owl.de ([195.71.106.12]:4023 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261752AbVHDGyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:54:51 -0400
Date: Thu, 4 Aug 2005 08:54:47 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050804065447.GB25606@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <21d7e99705080318347d6b58d5@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-04 11:34:27 +1000, Dave Airlie <airlied@gmail.com> wrote:
> On 8/1/05, Adrian Bunk <bunk@stusta.de> wrote:
> > This patch removes support for gcc < 3.2 .
> >=20
> > The advantages are:
> > - reducing the number of supported gcc versions from 8 to 4 [1]
> >   allows the removal of several #ifdef's and workarounds
> > - my impression is that the older compilers are only rarely
> >   used, so miscompilations of a driver with an old gcc might
> >   not be detected for a longer amount of time
> >=20
> >
>=20
> Another disadvantage is you'll really piss of the VAX developers (all
> 3 of us!!!, well me not so much anymore...)
>=20
> I think there is a gcc 4.x compiler nearly capable of building a
> kernel for the VAX...

-sh-3.00# cat cpuinfo
cpu             : VAX
cpu type        : KA43
cpu sid         : 0x0b000006
cpu sidex       : 0x04010002
page size       : 4096
BogoMIPS        : 10.08
-sh-3.00# cat version
Linux version 2.6.12 (jbglaw@d2) (gcc version 4.1.0 20050803 (experimental)=
) #2 Wed Aug 3 23:42:11 CEST 2005

Current GCC from CVS (plus minor configury patches) seems to work. We
had -fno-unit-at-a-time missing in our arch Makefile which hides a bug
in kernel's sources.

I guess that if you remove -fno-unit-at-a-time from i386 and use a
current GCC, you'll run into that fun, too.

MfG, JBG
PS: Yes, we lie about page size.

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC8bu3Hb1edYOZ4bsRAnv7AJ44STNoUnyhboWaxrIgDqrKGLce0gCgjZoK
GlLRHjX2VTUxpgZRB3FPGDQ=
=e6sd
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
