Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVCGIe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVCGIe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVCGIe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:34:57 -0500
Received: from faye.voxel.net ([69.9.164.210]:48326 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261707AbVCGIcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:32:14 -0500
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
From: Andres Salomon <dilinger@voxel.net>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050306151050.A29509@mail.kroptech.com>
References: <20050306151050.A29509@mail.kroptech.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p+jB5Y6qk0KBJGlq1JxV"
Date: Mon, 07 Mar 2005 03:32:14 -0500
Message-Id: <1110184334.7581.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p+jB5Y6qk0KBJGlq1JxV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-03-06 at 15:10 -0500, Adam Kropelin wrote:
> Andres Salomon <dilinger@voxel.net> wrote:
> > On Sat, 05 Mar 2005 11:43:05 +0100, Andries Brouwer wrote:
> > > On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:
> > >>  - It must fix a real bug that bothers people (not a, "This could be=
 a
> > >>    problem..." type thing.)
> >
> > An obvious fix is an obvious fix.  It shouldn't matter whether people h=
ave
> > triggered a bug or not; why discriminate?
>=20
> Because the sucker tree is purposely driven by real bug reports, not by
> developers who happen across a theoretical problem while traversing the
> code. If users aren't hitting it today, the fix can wait for 2.6.n+1.
>=20

Here's an example; if there's a theoretical integer under/overflow in
some part of the kernel, but no one is hitting it because (by chance,
not by design) there's no way for a user to stuff an incorrect value in
there.

Does it get fixed in 2.6.x.y?  According to the above rule, it does not.
However, it may be the case where a third party patch end up modifying
things such that the value in the sign integer is now not properly
sanity checked (ignore any security issues for the moment; assume only
root can stuff an incorrect value in there).  If it's a core function, a
third party module may end up calling it without checking the integer
value it's passing.  So, it's not a problem in 2.6.x; it becomes a
problem at some later point, thanks to an external patch or module.

Why not just fix it?  It still falls under the category of an obvious
fix; just because a user isn't triggering it now, doesn't mean they
won't be triggering it later.  An argument could be made that this would
mean a lot of extra work for the Suckers, but it's only up to the point
at which the next 2.6.x kernel is released.


> > >>  - It must fix a problem that causes a build error (but not for thin=
gs
> > >>    marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
> > >>  - No "theoretical race condition" issues, unless an explanation of =
how
> > >>    the race can be exploited.
> >
> > I disagree w/ this; if it's an obvious fix, there should be no need for
> > this.  Either it's a race that is clearly incorrect (after tracing thro=
ugh
> > the relevant code), or it's not.
>=20
> The sucker tree is not a dumping ground for every fix under the sun
> (even obvious ones). It's for solving problems hit by real users, right
> now.
>=20

I'm not saying fix every problem, but I would think that those that fix
a (potential) race, oops, hang, or security issue would be worth fixing.
But then, maybe I'm reading too much into this (as it's been stated
these are guidelines, not rules..)


> > >>  - It can not contain any "trivial" fixes in it (spelling changes,
> > >>    whitespace cleanups, etc.)
> >=20
> > This and the "it must fix a problem" are basically saying the same
> > thing.
>=20
> No. There's an important distinction and the key word is "contain". This
> rule specifically forbids patches that do fix a real problem but _also_
> contain unrelated trivial changes. See "setup_per_zone_lowmem_reserve()
> oops fix" for an example of a patch that could theoretically be rejected=20
> due to this rule.

Ah, yes.

--=20
Andres Salomon <dilinger@voxel.net>

--=-p+jB5Y6qk0KBJGlq1JxV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCLBGN78o9R9NraMQRAt42AJ4iroEnYKL9bbMw9tfC0NR1Kn/FLwCeLwkj
+LLOFvFhVauSxcCPuB20QTM=
=PEvm
-----END PGP SIGNATURE-----

--=-p+jB5Y6qk0KBJGlq1JxV--

