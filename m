Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWERX1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWERX1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWERX1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:27:40 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:40605 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751056AbWERX1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:27:39 -0400
Date: Fri, 19 May 2006 01:27:37 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Florent Thiery <Florent.Thiery@int-evry.fr>,
       openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
Message-ID: <20060518232737.GL17897@sunbeam.de.gnumonks.org>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org> <446C5780.7050608@int-evry.fr> <20060518143824.GC17897@sunbeam.de.gnumonks.org> <20060518231613.GA19731@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VmY8g3XFtK+hx8d"
Content-Disposition: inline
In-Reply-To: <20060518231613.GA19731@elf.ucw.cz>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2VmY8g3XFtK+hx8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2006 at 01:16:13AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > > Another one: you say you're workin on building X-e. Are you talking a=
bout kdrive?
> >=20
> > I have no idea, just replaying the package names that OE uses ;)
> >=20
> > I now have Xfbdev running on the A780.  Unfortunately due to some
> > strange black magic, the ts driver ceases to receive interrupts as soon
> > as X is started. reproducible.  The same happens with ts_test.
>=20
> Just poll the touchscreen, then... I have similar problems with
> battery hardware and touchscreen sharing ADCs on collie... but
> hopefully Motorola did not do _that_ mistake.

oh yes, the ADC is multiplexed with dozens (well, actually 14)  inputs.
But you can actually very carefully prorgram which ones to read into
what register, and have you notified once completed.

Oh, and to make it even better: The ADC is used by two processors, by
the Application Processor (that runs linux) and the Baseband Processor
;)

I've now fixed that interrupt problem, but I have some other issues in
the state machine that is required for alternating pressure/xy reads.

Confident that those things can be fixed, though.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--2VmY8g3XFtK+hx8d
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbQLpXaXGVTD0i/8RAglwAKCxvlKLrUjRmNnAaVyph/+uTbIVxACeMKTn
IlSl9I9nUOdLx0RMLC67PPM=
=0VyH
-----END PGP SIGNATURE-----

--2VmY8g3XFtK+hx8d--
