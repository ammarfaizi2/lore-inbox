Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTFVOqn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 10:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTFVOqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 10:46:42 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:29192 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263930AbTFVOqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 10:46:01 -0400
Date: Sun, 22 Jun 2003 17:00:05 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Isapnp warning
Message-ID: <20030622150005.GG6353@lug-owl.de>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200306151836.h5FIaqv2008285@callisto.of.borg> <1056198688.25975.25.camel@dhcp22.swansea.linux.org.uk> <200306221607.15232.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WFYXJKyHTUiGqOmp"
Content-Disposition: inline
In-Reply-To: <200306221607.15232.phillips@arcor.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WFYXJKyHTUiGqOmp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-22 16:07:14 +0200, Daniel Phillips <phillips@arcor.de>
wrote in message <200306221607.15232.phillips@arcor.de>:
> Hi Alan,
>=20
> On Saturday 21 June 2003 14:31, Alan Cox wrote:
> > On Sul, 2003-06-15 at 19:36, Geert Uytterhoeven wrote:
>=20
> How about:
>=20
>    #define if_pci(tokens...) tokens
>=20
>    int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_i=
rq *data)
>    {
> 	if_pci(int i);
> 	...
>    }
>=20
> Admittedly uglier than just having the warning disabled by default.

Even whilest I don't like defining variables where I need them (at an
opening "{" or like in "for (int i, i < x, i++)" as Linus suggested it),
this is quite ugly, too. "if_pci(int i)" looks linke an uglyfied
function call, and even while being ugly, it should basically "work"
like a function call. Here, it doesn't, so I consider this a Bad Thing.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--WFYXJKyHTUiGqOmp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9cR0Hb1edYOZ4bsRAvEqAJwN1XA5xr90HB7Fyh06sm2hsvCKzgCeIc0C
6GZfBvvKhKMFBcf7hQIS3p0=
=uMvn
-----END PGP SIGNATURE-----

--WFYXJKyHTUiGqOmp--
