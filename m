Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270576AbTHETXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270586AbTHETXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:23:18 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:33464 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S270576AbTHETXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:23:13 -0400
Subject: Re: [2.6] Perl weirdness with ext3 and HTREE
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Christopher Li <chrisl@vmware.com>
Cc: KML <linux-kernel@vger.kernel.org>, akpm@digeo.com, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org
In-Reply-To: <20030805182847.GA20850@vmware.com>
References: <1059856625.14962.19.camel@nosferatu.lan>
	 <20030805182847.GA20850@vmware.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NQWHh1URDkmAUcKsonF+"
Message-Id: <1060111391.8355.15.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 05 Aug 2003 21:23:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NQWHh1URDkmAUcKsonF+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 at 20:28, Christopher Li wrote:
> I can take a look at it.
>=20
> Is there any way to reproduce this bug without installing the
> whole gentoo? It would be nice if I can just download some
> package to make it happen.
>=20

I cannot really see that it is a Gentoo specific problem, but who knows.
I will try to get a CD of another distro somewhere, and get that on a
box to test - currently work/whatnot just keeps me pretty tied up :(
Another reason why I posted, is now that 2.6 is more widely used/tested,
its not only me that gets this, but other users as well - thus I hoped
that somebody with more time wanted to have a crack at it.

Back to the problem - on the same system, a 2.4 kernel works fine, but
a 2.5/6 kernel activates a race that creates an invalid entry.  I guess
the primary reason why not many people see this, is because most
non-Gentoo folk do not compile perl-5.8.0 from source.

Just grab the perl source, if you want, I can mail you the ebuild that
should give some direction in how to compile it, or grab your local
.spec, configure it (maybe with install location not in /), and then
just compile and finally install to a ext3 FS with HTREE enabled.=20
Usually over here, it keeps on leaving an invalid entry to
..usr/share/man/man3/Hash::Util.tmp.

If it works fine (with a 2.6 kernel), I will go and bang my head against
a wall, and shutup until I can make time to try and track this - if not,
any ideas as to creating it outside the perl install (or rather the man
page part of the install process) would be great.


Thanks,

> Thanks,
>=20
> Chris
>=20
>=20
> On Sat, Aug 02, 2003 at 10:37:05PM +0200, Martin Schlemmer wrote:
> > Hi
> >=20
> > I have mailed about this previously, but back then it was not
> > really confirmed, so I have let it be at that.
> >=20
> > Anyhow, problem is that for some reason 2.5/2.6 ext3 with HTREE
> > support do not like what perl-5.8.0 does during installation.
> > It *seems* like one of the temporary files created during manpage
> > installation do not get unlinked properly, or gets into the
> > hash (this possible?) and cause issues.
> >=20
> > It seems to work flawless on 2.4 still.
> >=20
> > Also, to be honest, I do not have that much free time these days,
> > so if an interest in helping me/us debug this, it will be appreciated
> > if some direction in what is needed/suggestions can be given as to what
> > is required.  There are a few users that experience this issue, and
> > I am sure that we can get whatever info needed.
> >=20
> > A bug on our tracker is here with more (hopefully) complete info:
> >=20
> >   http://bugs.gentoo.org/show_bug.cgi?id=3D24991
> >=20
> >=20
> > Thanks,
> >=20
> > --=20
> >=20
> > Martin Schlemmer
> >=20
> >=20
> >=20
>=20
>=20
--=20

Martin Schlemmer




--=-NQWHh1URDkmAUcKsonF+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MAQeqburzKaJYLYRAmc+AJ9fu4kcYDYGhAPi61idbDgaDT/b0gCfe5NP
HtLNJbfjK1TB+x7XvmZY1wQ=
=0AP/
-----END PGP SIGNATURE-----

--=-NQWHh1URDkmAUcKsonF+--

