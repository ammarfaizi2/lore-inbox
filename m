Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVBIUEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVBIUEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVBIUEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:04:43 -0500
Received: from lug-owl.de ([195.71.106.12]:20663 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261909AbVBIUDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:03:54 -0500
Date: Wed, 9 Feb 2005 21:03:51 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Paulo Marques <pmarques@grupopie.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209200351.GK10594@lug-owl.de>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Paulo Marques <pmarques@grupopie.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209191817.GA1534@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VjpKO6h983+pAmpQ"
Content-Disposition: inline
In-Reply-To: <20050209191817.GA1534@ucw.cz>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VjpKO6h983+pAmpQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 20:18:17 +0100, Vojtech Pavlik <vojtech@suse.cz>
wrote in message <20050209191817.GA1534@ucw.cz>:
> > I would say that a tool to recover the touch screen into a "usable"=20
> > state, by talking directly to the serial port, and "calibrating" it to=
=20
> > max possible / min possible values would be the best way to deal with t=
his.
>=20
> I agree with that. It could possibly even be put into the inputattach
> init routine for the specific touchscreen.

At least, inputattach should only recalibrate if asked for that. POS
*users* are not very computer-skilled (typically, at least over here)
and even automated recalibration (ie. the cashier software forces it
because it detects that the user presses besides the actual images) are
kind of stress to them...

> > It's even worse. Most keyboards don't separate the real keys from=20
> > magnetic stripe reader events, and just simulate key presses for MSR=20
> > data. They expect the software to be in a state where it is waiting for=
=20
> > that data, and will process it accordingly.
>=20
> In that case I'm not sure if the kernel should care at all what the data
> is.

The problematic part is that this needs to be done at a quite low level,
since POS keyboards may send quite a lot more than make/break codes in
"proper" order...

> > What we've done in our application is to use the timings and sequence o=
f=20
> > key presses to distinguish between normal key presses and MSR data :P
>=20
> Yes, embedded and single purpose systems are often full of hacks like
> this.

=2E..and especially this problem can be better solved by reprogramming the
MCR readers :-)

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

--VjpKO6h983+pAmpQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCmynHb1edYOZ4bsRAqa2AJ9z9ywOn2cw7M26KMVX65s1BzujsgCgj0WZ
cXZ3NcDK+kVyVN50TCuK5QE=
=SvoE
-----END PGP SIGNATURE-----

--VjpKO6h983+pAmpQ--
