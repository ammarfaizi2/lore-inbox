Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUIXKwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUIXKwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbUIXKwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:52:25 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:60893 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S268680AbUIXKwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:52:09 -0400
Date: Fri, 24 Sep 2004 12:52:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol __udivsi3_i4
Message-ID: <20040924105207.GH22710@lug-owl.de>
Mail-Followup-To: Pawe?? Sikora <pluto@pld-linux.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040924021050.689.qmail@web53608.mail.yahoo.com> <200409240801.57848.pluto@pld-linux.org> <Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b+Jngg6VfPgvparx"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b+Jngg6VfPgvparx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-24 10:33:12 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
wrote in message <Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be>:
> On Fri, 24 Sep 2004, [utf-8] Pawe? Sikora wrote:
> > On Friday 24 of September 2004 04:10, Donald Duckie wrote:
> > > can somebody please help me how to overcome this
> > > problem:
> > > unresolved symbol __udivsi3_i4
> > # objdump -T /lib/libgcc_s.so.1|grep div
> > 000024c0 g    DF .text  00000162  GLIBC_2.0   __divdi3
> > 00002b80 g    DF .text  000001ed  GCC_3.0     __udivmoddi4
> > 00002870 g    DF .text  00000120  GLIBC_2.0   __udivdi3
> >=20
> > you can link module with libgcc.a or fix it.
>=20
> Just add an implementation for __udivsi3_i4 to arch/sh/lib/. They already=
 have
> udivdi3.c over there.

Either that (which I don't like!), or have a try compiling the kernel
with -ffreestanding, if your toolchain accepts that. Maybe that doesn't
create these external function calls at all...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--b+Jngg6VfPgvparx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBU/xXHb1edYOZ4bsRAougAJ9sgS54peb5RHhEo+VtwEyNZUW9MgCggbIu
1RYtoZICYVEecp7oK7tUQvU=
=WYLc
-----END PGP SIGNATURE-----

--b+Jngg6VfPgvparx--
