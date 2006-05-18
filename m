Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWEROi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWEROi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 10:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWEROi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 10:38:27 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:18308 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751088AbWEROi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 10:38:27 -0400
Date: Thu, 18 May 2006 16:38:24 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Florent Thiery <Florent.Thiery@int-evry.fr>
Cc: openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
Message-ID: <20060518143824.GC17897@sunbeam.de.gnumonks.org>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org> <446C5780.7050608@int-evry.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="je2i5r69C8+2chMc"
Content-Disposition: inline
In-Reply-To: <446C5780.7050608@int-evry.fr>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--je2i5r69C8+2chMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2006 at 01:16:16PM +0200, Florent Thiery wrote:
>=20
> > As of now, I return
> >   X_ABS, Y_ABS and PRESSURE values between 0 and 1000 (each).
> > =20
> Are you kidding ??? Does the touchscreen support pressure sensitivity?
> Normally it wouldn't, you'd have only two values... Because
> sensitivity touchscreens really are rare... That's why wacom does=20
> use the pen to report pressure info on their tablets

No, this touchscreen actually has fairly reasonable pressure reporting.
I know that this is unusual.  But I get reproducible numbers when trying
soft stylus press, hard stylus press.  And things like finger touching.
Also I can actually distinguish a thumb from an index finger press ;)

> >1) where does touchscreen calibration happen?  The EZX phones (like many
> >   other devices, I believe) only contain resistive touchscreens that
> >   appear pretty uncalibrated.   I'm sure the factory-set calibration
> >   data must be stored somewhere in flash, but it's definitely handled
> >   in the proprietary EZX userland, since their old kernel driver
> >   doesn't have any calibration related bits.
> > =20
> I would say touchscreen calibration =3D scaling (to resolution) + referen=
ce points

see the other comments. apparently that is left to userspace.

> I would say the best would be to watch pressure evolution.... If it
> springs from 0 to 400 in less than sotg like 200 ms, then you got the
> "button" event. Is it feasable?

that would require rerlatively small polling intervals.  please note
that the hardware generates interrupts when pressure !=3D 0.  We could
start a high-granularity timer =20

> I got a question: does stylus usage on original A780 show the pressure
> sensitivity?

not that I've ever noted.  But Motorola ignores many of the hardwares
capability..

> Another one: you say you're workin on building X-e. Are you talking about=
 kdrive?

I have no idea, just replaying the package names that OE uses ;)

I now have Xfbdev running on the A780.  Unfortunately due to some
strange black magic, the ts driver ceases to receive interrupts as soon
as X is started. reproducible.  The same happens with ts_test.

ts_print works very good, though.

Will do more debugging

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--je2i5r69C8+2chMc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbIbgXaXGVTD0i/8RAoaVAJ9gP3/fs/oM15yLauxiMHge9PJTBACgl+68
RfEz6F4s//NFdVkAj/SnP/E=
=HssF
-----END PGP SIGNATURE-----

--je2i5r69C8+2chMc--
