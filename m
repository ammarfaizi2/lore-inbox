Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVLSR1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVLSR1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLSR1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:27:39 -0500
Received: from lug-owl.de ([195.71.106.12]:51396 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932261AbVLSR1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:27:39 -0500
Date: Mon, 19 Dec 2005 18:27:35 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Bug] mlockall() not working properly in 2.6.x
Message-ID: <20051219172735.GL13985@lug-owl.de>
Mail-Followup-To: Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051218212123.GC4029@mjk.myfqdn.de> <20051219022108.307e68b8.akpm@osdl.org> <20051219114231.GA2830@mjk.myfqdn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xCod2j9FiOMpaQ8M"
Content-Disposition: inline
In-Reply-To: <20051219114231.GA2830@mjk.myfqdn.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xCod2j9FiOMpaQ8M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-12-19 12:42:31 +0100, Marc-Jano Knopp <pub_ml_lkml@marc-jano.d=
e> wrote:
> On Mon, 19 Dec 2005 at 02:21 (-0800), Andrew Morton wrote:
> > Marc-Jano Knopp <pub_ml_lkml@marc-jano.de> wrote:
> > > A year ago, I wrote a small mlockall()-wrapper ("noswap") to make
> > > certain programs unswappable. It used to work perfectly, until I
> > > upgraded to kernel 2.6.x (2.6.13.1 in my case, but that shouldn't
> > > matter), which made the mlockall() execute without error, but also
> > > without any effect (the "L" in the STAT column of "ps axf" which
> > > indicates locked pages is missing).
> > Prior to 2.4.18 the kernel would allow MCL_FUTURE to propagate into chi=
ld
> > processes.  But that was disabled in 2.4.18 and later.  I seem to recall
> > that we did this because inheriting MCL_FUTURE is standards-incorrect.
>=20
> Oh! So how can I make programs unswappable with kernel 2.6.x then?

That would mean that you cannot just exec() another program that will
also be mlockall()ed. The new program has to do that on its own...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--xCod2j9FiOMpaQ8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDpu2HHb1edYOZ4bsRAkyjAJ9ELYmBnbz5GSHMSL1owWKuvEqmqACdEvjH
ETQhB/yIzuKPV5+ZBjdrSO8=
=ldMS
-----END PGP SIGNATURE-----

--xCod2j9FiOMpaQ8M--
