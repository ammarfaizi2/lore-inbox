Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTDDACb (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 19:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTDDACa (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 19:02:30 -0500
Received: from host145.south.iit.edu ([216.47.130.145]:38302 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S263580AbTDDACY (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 19:02:24 -0500
Date: Thu, 3 Apr 2003 18:13:51 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: Gentoo Linux BUG 18612 - cfdisk
Message-ID: <20030404001351.GN26830@lostlogicx.com>
References: <20030403171148.GI26830@lostlogicx.com> <20030404000228.GA14072@win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20030404000228.GA14072@win.tue.nl>
X-Operating-System: Linux found 2.4.20-lolo-r2_pre5
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 04/04/03 at 02:02:28 +0200, Andries Brouwer wrote:
> On Thu, Apr 03, 2003 at 11:11:48AM -0600, Brandon Low wrote:
>=20
> > http://bugs.gentoo.org/show_bug.cgi?id=3D18612
> >=20
> > This bug appears to be caused by using cfdisk's default allocation
> > on the last partition on a drive.  From the looks of it on the user's
> > LBA mapped drive, cfdisk allocated a bunch of non-existant sectors
> > when the user allowed it to pick the default size for that last partiti=
on.
>=20
> (please break lines)

Heh, sorry about that.
>=20
> (in case something is wrong with cfdisk, tell the cfdisk maintainer,
> not the kernel list)
>=20
> (what kernel version is this? - I see, 2.4.20)
>=20
It is indeed 2.4.20 in the report.

> According to WD, this disk has 78,165,360 sectors.
> So, in case it was partitioned with such a size maybe nothing was wrong.
>=20
> The boot messages shown say:
>   kenny kernel: hda: setmax LBA 78165360, native  78125000
> How come setmax has the right value and native has not?
> Did other software clip the disk?
> What is the identify data for this drive?

Interesting, I wonder why stock 2.4.20 would report it differently than the
new IDE stuff that is in our kernel, as that seems to be the problem.
>=20
> Was the partitioning done with a kernel that had CONFIG_IDEDISK_STROKE
> enabled?

Haven't heard of that option, I'll check with the bug reporter.
>=20
>=20
> Andries
>=20
Thanks a lot for the reply, it has at least helped us much to narrow things
down.

--Brandon

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+jM4/HCCPbR8BLcYRAtDmAJwM+Dlg2PlUym+GksY1iPVxJt1rygCeJG3z
fegBVxIOG5mCE1m2tM+WLFw=
=Pfgg
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
