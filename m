Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWDFVXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWDFVXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 17:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDFVXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 17:23:43 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:28848 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751334AbWDFVXm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 17:23:42 -0400
Subject: Re: [OOPS] related to swap?
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux-kernel@vger.kernel.org
In-Reply-To: <44339031.4040307@yahoo.com.au>
References: <1144225363.7112.10.camel@localhost>
	 <44339031.4040307@yahoo.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NxgmHOLEUaYotlMBh/WZ"
Date: Thu, 06 Apr 2006 23:28:04 +0200
Message-Id: <1144358884.30252.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NxgmHOLEUaYotlMBh/WZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-05 at 19:38 +1000, Nick Piggin wrote:
> Ian Kumlien wrote:
> >>Ian Kumlien wrote:
> >>
> >>
> >>>Yes, i run a tainted kernel! either live with it or ignore this mail
> >>>=3D)
> >>
> >>>starting swap lead to a deadlock within 15 mins
> >>
> >>>I have never had the energy to perform a full memtext86+
> >>
> >>It would be useful if you could perform a memtest overnight one night,
> >>then run a non-patched and non-tained 2.6.16.1 kernel, and try to
> >>reproduce the problems.
> >=20
> >=20
> > As i said, i really doubt that the memory is at fault here, it has done
> > several passes over the memory but not all tests. I can give it a go
> > though, but i really doubt it'll find anything.
> >=20
>=20
> If it doesn't cost you much time (ie. do it overnight) it could save some
> developers a lot of time.

Yes, i'll try to do it this weekend... Since i need to keep this box
running most of the time.

> > The kernel i run is a plain 2.6.16.1 from kernel.org (i have heard that
> > you can actually compile gentoos own these days)
>=20
> OK, good.

Kernel.org, it's the only flavor =3D)

> > Since this is my *cough* desktop, running it without that ability is
> > kinda a show stopper, thats why i included the thing above.
>=20
> But if the problem can be reproduced in 15 minutes, it shouldn't be
> too hard to get a trace without nvidia loaded.

The major bit is, this worked with single core with reiser... Someone
else reported problems with XFS lately though, i'll have to read all
about it...=20

> > But the thing is, my laptop runs with the same compiler, "same" nvidia
> > driver and the "same" kernel ("same" as in 32 bit not 64 bit).
> > Eventhough "same" in this case usually means nothing, i doubt that one
> > would have a serius bug and the other wouldn't, ie it's most likley a
> > bug related to 64 bits or one or more of the drivers involved.
> >=20
> > The only errors i get in dmesg atm is:
> > KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c
> > (283)
> > KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c
> > (150)
> >=20
> > Which is related to TSO, from what i gather, but i can't turn off tso o=
n
> > forcedeth... (i suspected this to cause corruption a while back....)
>=20
> If your network hardware or driver is flakey, try compiling a kernel
> without that as well before reproducing this swap problem.

Well, flakey and flakey, it's been running with pretty heavy network and
io load for 4 days now... (with forcedeth, but there is no ethtool
interface for disabling TSO, if that is the problem)

The sky2 driver tended to just die and lockup the box after a while, but
i haven't tested Stepehns recent changes yet since i want something
reliable first, to i have a base for comparison.

Oh, Btw:
free
             total       used       free     shared    buffers
cached
Mem:       3056436    3039052      17384          0       4804
2001672
-/+ buffers/cache:    1032576    2023860
Swap:            0          0          0

If the memory was faulty, i'd have a corrupt filesystem by now imho...
=3D)

Btw, sorry about being unclear, i spotted it after i mailed, but...
Running without nvidia drivers on a nvdidia card is pretty horrible on a
desktop machine, the kind of resolutions you can get would have been ok
on a amiga, but with X, everything is sooo much bigger... =3DP

Also, sorry about the CC comment, but it took a day for your mail to hit
my inbox, ie a day after it appeared on lkml, must be the greylists
being overly efficient... =3DP

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-NxgmHOLEUaYotlMBh/WZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQBENYfk7F3Euyc51N8RAnsAAJ9REOQztTb2sO+wZu23taQCKPVU4wCfT/q9
Tpqlvj6yZAi7tk2Y7sVFNLA=
=DQKY
-----END PGP SIGNATURE-----

--=-NxgmHOLEUaYotlMBh/WZ--

