Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbTHaWmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTHaWmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:42:40 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:15554
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S262992AbTHaWmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:42:38 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062359478.1313.9.camel@boobies.awol.org>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
	 <1062358285.5171.101.camel@big.pomac.com>
	 <1062359478.1313.9.camel@boobies.awol.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Dmrrqda+frqP4AAxPKrB"
Message-Id: <1062369684.9959.166.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 01 Sep 2003 00:41:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dmrrqda+frqP4AAxPKrB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-08-31 at 21:51, Robert Love wrote:
> On Sun, 2003-08-31 at 15:31, Ian Kumlien wrote:
>=20
> > Since they would have a high pri still, and preempt is there... it
> > should be back on the cpu pretty quick.
>=20
> Ah, but no!  You assume we do not have an expired list and round robin
> scheduling.

hummm, I assume that a high pri process can preempt a low pri process...
The rest sounds sane to me =3D), Please tell me what i'm missing.. =3D)

> Once a task exhausts its timeslice, it cannot run until all other tasks
> exhaust their timeslice.  If this were not the case, high priority tasks
> could monopolize the system.

All other? including sleeping?... How many tasks can be assumed to run
on the cpu at a time?....

Should preempt send the new quantum value to all "low pri, high quantum"
processes?

Damn thats a tough cookie, i still think that the priority inversion is
bad. Don't know enough about this to actually provide a solution...=20
Any one else that has a view point?

> > But, it also creates problems for when a interactive process becomes a
> > cpu hog. Like this the detection should be faster, but should be slowed
> > down somewhat.
>=20
> I agree, although I do think it responds fairly quick.  But, regardless,
> this is why I am interested in Nick's work.  The interactivity estimator
> can never be perfect.

Hummm, the skips in xmms tells me that something is bad..=20
(esp since it works perfectly on the previus scheduler)

> > But, hogs would instead cause a context switch hell and lessen the
> > throughput on server loads...
>=20
> Hm, why?

Since it's rescheduled after a short runtime or, might be.
=46rom someones mail i saw (afair), there was much more context switches
in 2.6 than in 2.4. And each schedule consumes time and cycles.

> > I don't see how priorities would be questioned... Since, all i say is
> > that a task that gets preempted should have a guaranteed time on the cp=
u
> > so that we don't waste cycles doing context switches all the time.=20
>=20
> But latency is important.

Oh yes, but otoh, if you are really keen on the latency then you'll do
realtime =3D)

--=20
Ian Kumlien <pomac@vapor.com>

--=-Dmrrqda+frqP4AAxPKrB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/UnmU7F3Euyc51N8RAryOAKCaObXywUHlz9flXu6BGDlXYBXgIwCgl4zo
p4D+kNsiQrVtY8voFkbNs4U=
=FgQo
-----END PGP SIGNATURE-----

--=-Dmrrqda+frqP4AAxPKrB--

