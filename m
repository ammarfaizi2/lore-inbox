Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTHaLKM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 07:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbTHaLKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 07:10:12 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:30124
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S261151AbTHaLKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 07:10:04 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F51D4A4.4090501@cyberone.com.au>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <3F51CB44.3080805@cyberone.com.au> <1062325465.5171.60.camel@big.pomac.com>
	 <3F51D0BD.8030307@cyberone.com.au> <1062326980.9959.65.camel@big.pomac.com>
	 <3F51D4A4.4090501@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-faU6QMxHFkxanlWPG38k"
Message-Id: <1062328131.5171.77.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 13:08:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-faU6QMxHFkxanlWPG38k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[Forgot to CC LKML last time, so i didn't remove old text ]

On Sun, 2003-08-31 at 12:57, Nick Piggin wrote:
> Ian Kumlien wrote:
> >On Sun, 2003-08-31 at 12:41, Nick Piggin wrote:
> >>Ian Kumlien wrote:
> >>>On Sun, 2003-08-31 at 12:17, Nick Piggin wrote:

> >>>>Search for "Nick's scheduler policy" ;)

> >>>Heh, yeah, i have been following your and con's work via
> >>>marc.theaimsgroup.com. =3D)

> >>Well, my patch does almost exactly what you describe.

> >Yes, i know =3D)... You and con should team up =3D)

> Heh, well we discuss stuff sometimes, but we disagree on things.
> Which is a good thing because now our eggs are in two baskets.

Yes, but sometimes it feels like a merger would be better... As long as
the propper quantum usage prevails =3D)

> >>>But wouldn't ingos off the shelf stuff work better with the quantum
> >>>values like that?

> >>That means more complexity and behaviour that is more difficult
> >>to trace. The interactivity stuff is already a monster to tune.

> >Oh, humm, how much did you change btw? =3D))

> Yeah quite a lot. Lots included removing the interactivity stuff.

Humm, yeah, that should work automatically with the "used the full
quantum" if thats still in that is... =3D)

> >>>And is the preempt min quantum in there?

> >>No. If you do that, you'll either break the priority concept very
> >>badly, or you'll break it a little bit and turn the scheduler into
> >>an O(n) one.

> >>Well I guess you could just break it a little bit without it being
> >>O(n)

> >Well, i just thought since each context switch/reschedule is costly...
> >Having something that prevents a freshly scheduled process from being
> >forced off before it can actually do something would be usefull.

> Yeah it is, but the process will still take a lot of the penalty,
> and if it is using a lot of CPU in context switching, then it will
> get a lower priority anyway. Possibly there could be a very small
> additional penalty per context switch, but so far it hasn't been
> a big problem AFAIK.

Well my idea was more... The highest pri gets MIN_QUANT and a preemt
can't happen faster than MIN_QUANT or so..=20
If i remember correctly, 2.6 spends much more time doing the actual
context switches (not time / context switch but amount during this
period). The new 1000 HZ thingy doesn't have to have that effect...

And since to many context switches are inefficient imho, some standoffs
would be good =3D)

--=20
Ian Kumlien <pomac@vapor.com>

--=-faU6QMxHFkxanlWPG38k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/UddD7F3Euyc51N8RAjSnAJ9jRryrfXglQi+ketPYmtmsA6gzXgCfSTJA
pT2sC8AxcNrOEy3EjLYVYoE=
=zO+V
-----END PGP SIGNATURE-----

--=-faU6QMxHFkxanlWPG38k--

