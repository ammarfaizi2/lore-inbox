Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVBIT72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVBIT72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVBIT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:59:28 -0500
Received: from lug-owl.de ([195.71.106.12]:16055 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261911AbVBIT64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:58:56 -0500
Date: Wed, 9 Feb 2005 20:58:54 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209195854.GJ10594@lug-owl.de>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JjsO4Ft8DCMnlCnY"
Content-Disposition: inline
In-Reply-To: <420A518A.9040500@grupopie.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JjsO4Ft8DCMnlCnY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 18:08:10 +0000, Paulo Marques <pmarques@grupopie.com>
wrote in message <420A518A.9040500@grupopie.com>:
> >>Additionally, there are two other things that need to be addressed (and
> >>I'm willing to actually write code for this, but need input from other
> >>parties, too:)
> >>
> >>	- Touchscreen calibration
> >>		Basically all these touchscreens are capable of being
> >>		calibrated. It's not done with just pushing the X/Y
> >>		values the kernel receives into the Input API. These
> >>		beasts may get physically mis-calibrated and eg. report
> >>		things like (xmax - xmin) <=3D 20, so resolution would be
> >>		really bad and kernel reported min/max values were only
> >>		"theoretical" values, based on the protocol specs.
> >>		I think about a simple X11 program for this. Comments?
>=20
> Touch screens doing this are severely brain-damaged. And yes, I've come=
=20
> across a few of them, but not lately.

That's IMHO not brain-damaged, but pure physics: just consider scratches
or dust (or other substances) applied to the touch foil. This happens
all the time, so the touch screen gets out of calibration. This won't
happen on a screen used only twice a day. But think about a touch screen
that's tortured all the day with pencils, finger rings, dirty fingers,
=2E..

> I would say that a tool to recover the touch screen into a "usable"=20
> state, by talking directly to the serial port, and "calibrating" it to=20
> max possible / min possible values would be the best way to deal with thi=
s.

Min/Max values (as of protocol theory) is possibly not the very best you
can do with the hardware. I more thing about submitting these (after
physical calibration) to the kernel driver to supply them to it's users.

> Modern touchscreens just send the A/D data to the PC, and let the real=20
> processor do the math (it can even do more complex calculations, like=20
> compensate for rotation, etc.). IMHO calibration should be handled by=20
> software.

Is this done eg. by Elo, Mutouch, Fujitsu, T-Sharc (to only name the
most common)? I don't think so...

> >>	- POS keyboards
> >>		These are real beasties. Next to LEDs and keycaps, they
> >>		can contain barcode scanners, magnetic card readers and
> >>		displays. Right now, there's no good API to pass
> >>		something as complex as "three-track magnetic stripe
> >>		data" or a whole scanned EAN barcode. Also, some
> >>		keyboards can be written to (change display contents,
> >>		switch on/off scanners, ...).
> >
> >
> >We probably don't want magnetic stripe data to go through the input
> >event stream (although it is possible to do that), so a new interface
> >would be most likely necessary.
>=20
> It's even worse. Most keyboards don't separate the real keys from=20
> magnetic stripe reader events, and just simulate key presses for MSR=20
> data. They expect the software to be in a state where it is waiting for=
=20
> that data, and will process it accordingly.

This only happens if you don't configurethe MSR properly :-) Most of
them can be configured to send quite complex (as in: structured) init
sequences that cannot be generated by a keyboard (ie multiple break
codes without make codes and the like).=20

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

--JjsO4Ft8DCMnlCnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCmt+Hb1edYOZ4bsRAolxAJ4606N0K1FHbL9MTNGQ93kWl9EFtgCfXPc6
8Hi/IxgwPj9C0FM9yZ+IL5o=
=3MCj
-----END PGP SIGNATURE-----

--JjsO4Ft8DCMnlCnY--
