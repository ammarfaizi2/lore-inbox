Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269083AbUJKPKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269083AbUJKPKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUJKPFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:05:51 -0400
Received: from lug-owl.de ([195.71.106.12]:43423 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S269063AbUJKPBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:01:11 -0400
Date: Mon, 11 Oct 2004 17:01:09 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Tony Howat <tony@i-r-genius.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bit by bit parallel port  control
Message-ID: <20041011150109.GN5033@lug-owl.de>
Mail-Followup-To: Tony Howat <tony@i-r-genius.com>,
	linux-kernel@vger.kernel.org
References: <20041011141018.M62685@i-r-genius.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VP5QyDw/Nx1A2h9y"
Content-Disposition: inline
In-Reply-To: <20041011141018.M62685@i-r-genius.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VP5QyDw/Nx1A2h9y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-10-11 15:10:13 +0100, Tony Howat <tony@i-r-genius.com>
wrote in message <20041011141018.M62685@i-r-genius.com>:
> I have tried using the /dev/port method and putb - I can seemingly set bi=
ts=20
> on the port OK. However, checking with a meter shows the line changing fo=
r a=20
> few milliseconds then returning to 0v. I need the levels to hold. I belie=
ve=20
> that's what SHOULD happen...

Don't mess with the hardware on your own! That's almost always a bug and
will cost you any later portability. Instead, just use the interface

Please use the userspace parport driver interface (provided by
ppdev.ko). Additionally it'll give you full portability to non-PC
hardware for free:-)

> There's plenty of sample code around, so I'm pretty confident I'm doing=
=20
> things right. My test code is here :
>=20
> http://www.i-r-genius.com/paralleltest.c

Not all that right:-)  You access the hardware directly which is wrong.
Use the ppdev interface instead.

I've just put the program online
(http://lug-owl.de/~jbglaw/software/steckdose/steckdose.c) which
drives my relay box (basically a shift register + relay driver).

I guess the parport locking code isn't yet correct, but it should give
you a start to using ppdev...

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

--VP5QyDw/Nx1A2h9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBaqA1Hb1edYOZ4bsRAgw5AJ4g+MsjaZ13sjCG2ulzoZ+dm8YKeQCdGszD
BdUE9kQ3qjQRiLjvxtulovo=
=gGEW
-----END PGP SIGNATURE-----

--VP5QyDw/Nx1A2h9y--
