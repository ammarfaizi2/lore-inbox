Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbTIBSAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTIBRyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:54:07 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:14038
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263751AbTIBRYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:24:23 -0400
Subject: Re: [SHED] Questions.
From: Ian Kumlien <pomac@vapor.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
In-Reply-To: <3F547A4B.7060309@cyberone.com.au>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <200309011707.20135.phillips@arcor.de>
	 <1062457396.9959.243.camel@big.pomac.com>
	 <200309021023.24763.kernel@kolivas.org>
	 <1062498307.5171.267.camel@big.pomac.com>
	 <3F547A4B.7060309@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-egKWEQM9uW08wJ0eb0ih"
Message-Id: <1062523374.5171.321.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 19:22:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-egKWEQM9uW08wJ0eb0ih
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-09-02 at 13:08, Nick Piggin wrote:
> Ian Kumlien wrote:
> >You could say that the problem the current scheduler has is that it's
> >not allowed to starve anything, thats why we add stuff to give
> >interactive bonus. But if it *was* allowed to starve but gave bonus to
> >the starved processes that would make most of the interactive detection
> >useless (yes, we still need the "didn't use their timeslice" bit and
> >with a timeslice that gets smaller the higher the pri we'd automagically
> >balance most processes).
> >
> >(As usual my assumptions might be really wrong...)
>=20
> First off, no general purpose scheduler should allow starvation depending
> on your definition. The interactivity stuff, and even dynamic priorities
> allow short term unfairness.

When you reach a certain load you *have to* allow starvation. Ie, you
can't work around it... All i say is that if we have a more relaxed
method we might benefit from it.

> Hmm... what else? The "didn't use their timeslice" thing is not
> applicable: a new timeslice doesn't get handed out until the previous one
> is used. The priorities thing is done based on how much sleeping the
> process does.

And not the amount of cpu consumed by the app / go?

> Its funny, everyone seems to have very similar ideas that they are
> expressing by describing different implementations they have in mind.

Yes =3D), I'm mailing Con directly now as well, to save some unwanted
traffic here =3D). I just hope that we'll reach a agreement somewhere
about whats sane or not...

Mail me if you're interested as well.

--=20
Ian Kumlien <pomac@vapor.com>

--=-egKWEQM9uW08wJ0eb0ih
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VNHu7F3Euyc51N8RAi5IAKCNI56iZ0mful/K9W7W80jtQrY+wgCcCg9l
djNJe1fHezFE5pbJsXyFr0c=
=H7mi
-----END PGP SIGNATURE-----

--=-egKWEQM9uW08wJ0eb0ih--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-egKWEQM9uW08wJ0eb0ih
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-09-02 at 13:08, Nick Piggin wrote:
> Ian Kumlien wrote:
> >You could say that the problem the current scheduler has is that it's
> >not allowed to starve anything, thats why we add stuff to give
> >interactive bonus. But if it *was* allowed to starve but gave bonus to
> >the starved processes that would make most of the interactive detection
> >useless (yes, we still need the "didn't use their timeslice" bit and
> >with a timeslice that gets smaller the higher the pri we'd automagically
> >balance most processes).
> >
> >(As usual my assumptions might be really wrong...)
>=20
> First off, no general purpose scheduler should allow starvation depending
> on your definition. The interactivity stuff, and even dynamic priorities
> allow short term unfairness.

When you reach a certain load you *have to* allow starvation. Ie, you
can't work around it... All i say is that if we have a more relaxed
method we might benefit from it.

> Hmm... what else? The "didn't use their timeslice" thing is not
> applicable: a new timeslice doesn't get handed out until the previous one
> is used. The priorities thing is done based on how much sleeping the
> process does.

And not the amount of cpu consumed by the app / go?

> Its funny, everyone seems to have very similar ideas that they are
> expressing by describing different implementations they have in mind.

Yes =3D), I'm mailing Con directly now as well, to save some unwanted
traffic here =3D). I just hope that we'll reach a agreement somewhere
about whats sane or not...

Mail me if you're interested as well.

--=20
Ian Kumlien <pomac@vapor.com>

--=-egKWEQM9uW08wJ0eb0ih
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VNHu7F3Euyc51N8RAi5IAKCNI56iZ0mful/K9W7W80jtQrY+wgCcCg9l
djNJe1fHezFE5pbJsXyFr0c=
=H7mi
-----END PGP SIGNATURE-----

--=-egKWEQM9uW08wJ0eb0ih--

