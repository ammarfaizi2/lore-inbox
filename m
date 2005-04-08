Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVDHF5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVDHF5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVDHF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:57:46 -0400
Received: from 57.16.168.202.velocitynet.com.au ([202.168.16.57]:53891 "EHLO
	hope.sourcefrog.net") by vger.kernel.org with ESMTP id S262693AbVDHF5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:57:25 -0400
Subject: Re: Kernel SCM saga..
From: Martin Pool <mbp@sourcefrog.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <20050406193911.GA11659@stingr.stingr.net>
	 <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
	 <20050407014727.GA17970@havoc.gtf.org>
	 <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
	 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
	 <1112852302.29544.75.camel@hope>
	 <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pB6dJqRpscvxIzVxlN/n"
Date: Fri, 08 Apr 2005 15:56:09 +1000
Message-Id: <1112939769.29544.161.camel@hope>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pB6dJqRpscvxIzVxlN/n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 16:27 -0700, Linus Torvalds wrote:
>=20
> On Thu, 7 Apr 2005, Martin Pool wrote:
> >=20
> > Importing the first snapshot (2004-01-01) took 41.77s user, 1:23.79
> > total.  Each subsequent day takes about 10s user, 30s elapsed to commit
> > into bzr.  The speeds are comparable to CVS or a bit faster, and may be
> > faster than other distributed systems. (This on a laptop with a 5400rpm
> > disk.)  Pulling out a complete copy of the tree as it was on a previous
> > date takes about 14 user, 60s elapsed.
>=20
> If you have an exportable tree, can you just make it pseudo-public, tell
> me where to get a buildable system that works well enough, point me to
> some documentation, and maybe I can get some feel for it?

Hi,

There is a "stable" release here:
http://www.bazaar-ng.org/pkg/bzr-0.0.3.tgz

All you should need to do is unpack that and symlink bzr onto your path.

You can get the current bzr development tree, stored in itself, by
rsync:

  rsync -av ozlabs.org::mbp/bzr/dev ~/bzr.dev

Inside that directory you can run 'bzr info', 'bzr status --all', 'bzr
unknowns', 'bzr log', 'bzr ignored'. =20

Repeated rsyncs will bring you up to date with what I've done -- and
will of course overwrite any local changes.=20

If someone was going to development on this then the method would
typically be to have two copies of the tree, one tracking my version and
another for your own work -- much as with bk.  In your own tree, you can
do 'bzr add', 'bzr remove', 'bzr diff', 'bzr commit'.

At the moment all you can do is diff against the previous revision, or
manually diff the two trees, or use quilt, so it is just an archival
system not a full SCM system.  In the near future there will be some
code to extract the differences as changesets to be mailed off.

I have done a rough-as-guts import from bkcvs into this, and I can
advertise that when it's on a server that can handle the load.=20

At a glance this looks very similar to git -- I can go into the
differences and why I did them the other way if you want.

--=20
Martin


--=-pB6dJqRpscvxIzVxlN/n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCVhz5PGPKP6Cz6IsRAjc3AKC+q0YgPKb55cM3CsLEHBKrmK7aqACcC4oZ
n8jUcvIyU++Z3X8awv1Tylw=
=u7R8
-----END PGP SIGNATURE-----

--=-pB6dJqRpscvxIzVxlN/n--
