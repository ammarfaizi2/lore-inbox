Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbTIEWBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbTIEWBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:01:31 -0400
Received: from rrba-bras-194-08.telkom-ipnet.co.za ([165.165.194.8]:60032 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S265753AbTIEWAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:00:42 -0400
Subject: Re: [PATCH] fix IO hangs
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030905083106.GC6658@suse.de>
References: <3F5833BA.5090909@cyberone.com.au>
	 <20030905070426.GP840@suse.de> <3F583861.6070109@cyberone.com.au>
	 <20030905071852.GQ840@suse.de>  <20030905083106.GC6658@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3sjcBvU/BI3GbNGg1VLz"
Message-Id: <1062799434.11604.1.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 06 Sep 2003 00:03:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3sjcBvU/BI3GbNGg1VLz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-05 at 19:04, Jens Axboe wrote:
> On Fri, Sep 05 2003, Jens Axboe wrote:
> > > Jens, if insert_here is dead, there is no point to passing back a hin=
t
> > > because it can't get back to the elevator anyway.
> > >=20
> > > I'd very much like to kill insert_here and be done with it. If anothe=
r
> > > io scheduler comes along with a good use for it then the writers can
> > > come up with an elegant solution ;) Hey, if they know a NO_MERGE retu=
rn
> > > means an insert will soon happen under the same lock, they could keep
> > > it cached privately.
> >=20
> > Agree, lets just kill it off.
>=20
> Here's the patch that kills it and its associated logic off completely.
> Nick, I'm not too sure what the logic was for stopping anticipation in
> as_insert_request() (the insert_here tests were somewhat convoluted :),
> I've added what I think makes most sense: stop anticipating if someone
> puts a request at the head of the dispatch list.
>=20
> It also makes the *_insert_request strategies much easier to follow,
> imo.
>=20

Hmm, do not know if its just me, but I just got two processes (cp's)
in D state.  They did complete though, but throughput was not good.
Any tips on getting it debugged ?


Thanks,

--=20

Martin Schlemmer




--=-3sjcBvU/BI3GbNGg1VLz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/WQhKqburzKaJYLYRAopHAJ9hL6gW2jWbg75f1/kv6czU/04ErQCfRfI8
q0xqIy4C6Z7kMYjZfPf3s9Q=
=I5QX
-----END PGP SIGNATURE-----

--=-3sjcBvU/BI3GbNGg1VLz--

