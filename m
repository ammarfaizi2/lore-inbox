Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRDWX3X>; Mon, 23 Apr 2001 19:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRDWX3A>; Mon, 23 Apr 2001 19:29:00 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:24706 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S132574AbRDWX1q>; Mon, 23 Apr 2001 19:27:46 -0400
Date: Mon, 23 Apr 2001 18:27:23 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010423182722.B942@draal.physics.wisc.edu>
In-Reply-To: <20010411125731.B6472@draal.physics.wisc.edu> <E14nOzo-0007Ew-00@the-village.bc.nu> <20010413084805.B3118@draal.physics.wisc.edu> <20010417170717.H2696@athlon.random> <20010417102840.B21824@draal.physics.wisc.edu> <20010419112117.E22687@draal.physics.wisc.edu> <20010419191706.D752@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010419191706.D752@athlon.random>; from andrea@suse.de on Thu, Apr 19, 2001 at 07:17:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrea Arcangeli [andrea@suse.de] wrote:
> On Thu, Apr 19, 2001 at 11:21:17AM -0500, Bob McElrath wrote:
> > I'm at 2 days uptime now, and have not seen the process-table-hang.
> > Looks like this fixed it.  Previously I would get a hang in the first
> > day or so.  I'm using your alpha-numa-3 and rwsem-generic-4 against
> > 2.4.4pre3.
>=20
> good, thanks for the report.
>=20
> BTW, if you upgrade to 2.4.4pre4 you can apply those two patches:
>=20
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.=
4pre4aa1/00_alpha-numa-4
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.=
4pre4aa1/00_rwsem-generic-6
>=20
> really the first is not necessary anymore unless you're using a wildfire.=
 The
> second also resurrect the optimized rwsemaphores for all archs but alpha =
and
> ia32.

Well, take that back, I just got it to hang.  Again, this is 2.4.4pre3
with alpha-numa-3 and rwsem-generic-4.  I saw it upon starting mozilla.
I also saw some scary filesystem errors that may or may not be related:
    Apr 23 18:09:40 draal kernel: EXT2-fs error (device sd(8,2)):=20
        ext2_new_block: Free blocks count corrupted for block group 252=20

There has been a lot of discussion on the topic of rwsems (that,
admittedly, I haven't followed very closely).  It looks like
rwsem-generic-6 is the latest from Andrea, I'll build a new 2.4.4pre4
kernel with these patches and let you know the results.  Have you made
changes between rwsem-generic-4 and rwsem-generic-6 that would
fix/prevent a deadlock?

Let me know if there are any useful tests I could perform.  Would it be
useful for me to run the rwsem benchmarks you've been using?  Could
these detect a deadlock situation?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrkuloACgkQjwioWRGe9K2qpQCdE4ofnUFgeI7auBtuMTlWySZp
leoAmgIt0V+uYuLZC3iMahGAkfJ2ltlr
=4x9X
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
