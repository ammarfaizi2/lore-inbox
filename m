Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTFTKke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFTKjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:39:00 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:4225
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S262742AbTFTKix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:38:53 -0400
Date: Fri, 20 Jun 2003 12:51:20 +0200
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620105120.GA2450@ghanima.endorphin.org>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620101452.GA2233@ghanima.endorphin.org> <20030620102455.GC26678@wotan.suse.de> <20030620103538.GA28711@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20030620103538.GA28711@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2003 at 12:35:38PM +0200, J=F6rn Engel wrote:
> On Fri, 20 June 2003 12:24:55 +0200, Andi Kleen wrote:
> > On Fri, Jun 20, 2003 at 12:14:52PM +0200, Fruhwirth Clemens wrote:
> > > There is no cryptoloop installation which is affected by this. Read m=
y mail
> > > properly. Every cryptoloop setup out there uses loop-AES or kerneli's
> > > patch-int. And both fixed this issue a _long_ time ago. (Have a look =
at
> >=20
> > That's completely wrong. I know of several independent implementation
> > and installations.
>=20
> That leaves the question of what the default behaviour should be.  If
> we have to switch to 512Byte in the long run anyway, there is little
> point in postponing the pain.  Make it the default, and old behaviour
> depends on the flag.

Let's see. If there is flag based fix and we make the old behavior default
we will trick many new users into using the old broken IV metric. If we make
the new metric default the user can't mount his old images.=20

As there is no autodetection for default behavior, there will be no way to
avoid the pain. Well, almost. We could allocate a new major for a different
metric, and create  /dev/loop-ng*. That'd be feasible, but actually just a
pain transfer .. from the user to the developer :)

> If we can avoid the pain completely, use that better fix instead, even
> if it isn't ready before 2.7, and ignore the problem until then.

No please, I don't wanna patch my kernel for another 2 years. Andrew Morton
is right when he puts this issue on his must-fix list.

Clemens

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+8ucoW7sr9DEJLk4RAsp7AKCL1CAR3CYi/uAOwRkwI3UCwf0ENQCfQwIA
8LKaI/8fmZlx9mLMnMX0sz0=
=078E
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
