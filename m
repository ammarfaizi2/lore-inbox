Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264507AbSIWEvK>; Mon, 23 Sep 2002 00:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264535AbSIWEvK>; Mon, 23 Sep 2002 00:51:10 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:19563 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S264507AbSIWEvJ>;
	Mon, 23 Sep 2002 00:51:09 -0400
Date: Sun, 22 Sep 2002 23:56:17 -0500
To: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020923045617.GA726@iucha.net>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <20020921161702.GA709@iucha.net> <597384533.1032600316@[10.10.2.3]> <20020921185939.GA1771@iucha.net> <20020921202353.GA15661@win.tue.nl> <20020922043050.GU3530@holomorphy.com> <20020922062702.GA652@iucha.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20020922062702.GA652@iucha.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2002 at 01:27:02AM -0500, Florin Iucha wrote:
> On Sat, Sep 21, 2002 at 09:30:50PM -0700, William Lee Irwin III wrote:
> > On Sat, Sep 21, 2002 at 01:59:39PM -0500, Florin Iucha wrote:
> > >> X is not locked up, as it eats all the CPU. And 2.5.36 works just fi=
ne.
> >=20
> > On Sat, Sep 21, 2002 at 10:23:53PM +0200, Andries Brouwer wrote:
> > > I noticed that the pgrp-related behaviour of some programs changed.
> > > Some programs hang, some programs loop. The hang occurs when they
> > > are stopped by SIGTTOU. The infinite loop occurs when they catch SIGT=
TOU
> > > (and the same signal is sent immediately again when they leave the
> > > signal routine).
> > > Have not yet investigated details.
> >=20
> > Linus seems to have put out 2.5.38 with some X lockup fixes. Can you
> > still reproduce this? If so, are there non-X-related testcases where
> > you can trigger this? My T21 Thinkpad doesn't see this at all.
> >=20
> > I'm still prodding the SIGTTOU path trying to trigger it until then.
>=20
> Weird. 2.5.38 works just fine but the head from few hours ago (which
> supposedly had the fix) doesn't. Oh well, it works fine now on both the
> desktop and the laptop.

I take that back. 2.5.38 works fine on the laptop. On the desktop the
situation is tricky:
   * I have compiled 2.5.38 under 2.5.34+xfs,
   * rebooted with 2.5.38 and
   * spent all day long in 2.5.38,
   * rebooted temporarily in Windows
   * then all boots into 2.5.38 resulted in a lock up.
The lockup happens with all kernels since 2.5.35 and it is random. It
happens in xdm waiting for login, in starting up KDE, in starting up
daemons at boot up.

Even when hanging in X, the Alt-SysRq still works to SUB.

2.5.34+xfs (from the SGI CVS) works fine. I will try a recent snapshot
from them, with a more recent kernel.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jp7wNLPgdTuQ3+QRAk5DAJ9phApkix56DTcs7Ty3hT+3t/XW6gCeMi23
33hIPigw6ndPfMNyn+5lgoI=
=vVVy
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
