Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVBJP4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVBJP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVBJP4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:56:25 -0500
Received: from lug-owl.de ([195.71.106.12]:43726 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262147AbVBJPzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:55:50 -0500
Date: Thu, 10 Feb 2005 16:55:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050210155548.GT10594@lug-owl.de>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
References: <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209195854.GJ10594@lug-owl.de> <420A77DF.6040108@grupopie.com> <20050209213930.GM10594@lug-owl.de> <20050209215335.GA2634@ucw.cz> <20050210104655.GO10594@lug-owl.de> <420B5C66.8040408@grupopie.com> <20050210134311.GP10594@lug-owl.de> <420B7F40.9080308@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvtG/WQWmfqkB9kQ"
Content-Disposition: inline
In-Reply-To: <420B7F40.9080308@grupopie.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tvtG/WQWmfqkB9kQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-10 15:35:28 +0000, Paulo Marques <pmarques@grupopie.com>
wrote in message <420B7F40.9080308@grupopie.com>:
> Jan-Benedict Glaw wrote:

> So you're seriously saying that a perfectly good touchscreen, that=20
> returned values in the range [350..3800] after being injured might give=
=20
> values in a range (xmax-xmin)<=3D20 ???  That's a pretty nasty injury...

Right. This is what I'm saying. And recalibration of the TS controller
can (in _most_ cases) fix that.

> a) you can get a resistive touch screen to give values (xmin-xmax)<=3D20=
=20
> just by injuring it, but in a way that it can be revived

With some digging, maybe I can even find such a beast somewhere around
here (working for a software company, I don't my hands on large
quantities of broken hardware...).

> b) you can revive it by just changing the calibration parameters on the=
=20
> TS controller
>=20
> I believe you can make a touch screen controller return values in a very=
=20
> short range if you try to use its internal calibration and mess up the=20
> values really badly. In this case, recalibrating will almost certainly=20
> make it work again.

:-) That's just messing up it's "proper" calibration and restoring
working parameters.

> >[...]
> >Right, but there are two kinds of calibration:
> >
> >(1) Mapping the raw capacity/resistor values (that only the TS controller
> >    is aware of) to something the HID API can output. (This, too, includ=
es
> >    that the kernel dictates the range of values that can be reached).
>=20
> I would really like to see a datasheet of a TS controller that actually=
=20
> does this, before we start working on a solution for it.

One of {elo,mu}touch does this. Unfortunately, the commands aren't
documented in the publically available sheets you can download from
their site. Using a serial sniffer, you can easily dismantle the
protocol to face the fact: these controller are a lot more clever than
the sheets will tell you :-)

> Why would a flash break if you never write to it? I would expect the TS=
=20
> layers to be damaged before any electronic part gets broken...

That's simple: some plastic/rubber shoes on equal ground, you can easily
load yourself with some 10000V. Touch it once, maybe it survives the
smoke. And possibly, the controller will loose it's flash contents...
Decalibrating by electrostatic discharge is even something that our
customers are able to _mention_ at the phone ("My finger hurt, it felt
like something bite me, the muscles and nerves hurt in my arm, the
computer crashed and upon reboot, I couldn't press the correct
pictograms...")

> >Ever tried to use a serial sniffer on vendor's original MS
> >Windows drivers? They almost always update the controller's internal
> >mapping, too.
>=20
> That is because they were done by the same brain-damaged people that=20
> didn't yet realize that a PC can do the couple of multiplications /=20
> divisions necessary in a few nanoseconds and still believe that the TS=20
> controller is "alleviating" the burden of the PC by doing that _complex_=
=20
> math itself :P

Yeah, right you are.

> >[...]
> >>Actually a calibration that can do scaling and rotation, can=20
> >>automatically compensate for mirroring and/or switched X/Y axes. We=20
> >>probably need the user to press 4 points for that, though (3 points are=
=20
> >>enough, but just barely enough).
> >
> >ACK. We'd do a lib for that and have a X11 driver to make use of it.
>=20
> Ok, lets start working on it then :)

Sure. (I'll write you off-list tomorrow.)

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

--tvtG/WQWmfqkB9kQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCC4QEHb1edYOZ4bsRAh8cAJ49doql6jxXRU3LaNzEYCyGhACj0QCdHEq+
s+6hZw3eUsm/V7wiG0O4ysU=
=1XRo
-----END PGP SIGNATURE-----

--tvtG/WQWmfqkB9kQ--
