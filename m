Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDSQWB>; Thu, 19 Apr 2001 12:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDSQVv>; Thu, 19 Apr 2001 12:21:51 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:57731 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S131157AbRDSQVe>; Thu, 19 Apr 2001 12:21:34 -0400
Date: Thu, 19 Apr 2001 11:21:17 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010419112117.E22687@draal.physics.wisc.edu>
In-Reply-To: <20010411125731.B6472@draal.physics.wisc.edu> <E14nOzo-0007Ew-00@the-village.bc.nu> <20010413084805.B3118@draal.physics.wisc.edu> <20010417170717.H2696@athlon.random> <20010417102840.B21824@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010417102840.B21824@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Tue, Apr 17, 2001 at 10:28:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bob McElrath [mcelrath+linux@draal.physics.wisc.edu] wrote:
> Andrea Arcangeli [andrea@suse.de] wrote:
> >
> > So please try to reproduce the hang with 2.4.4pre3 with those two
> > patches applied:
> >=20
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.=
4.4pre3aa3/00_alpha-numa-3
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.=
4.4pre3aa3/00_rwsem-generic-1
> >=20
> > All alpha users should run with at least the above two patches applied
> > to compile their tree and to make sure to have rock solid rwsemaphores.
>=20
> Excellent!  I'll give it a try.
>=20
> Note that I recently saw the X hang with the 2.2.19 kernel, but I still
> haven't seen the process-table-hang with 2.2.19 (about 4 days running
> with 2.2.19).  It is *far* easier to get the X hang in 2.4 than 2.2.
> (minutes for 2.4, days for 2.2)  Also note that this is not an SMP
> machine (single processor 21164a, LX164 mobo).
>=20
> But I'll apply your patch tonight and let you know the results.

Status report:
I'm at 2 days uptime now, and have not seen the process-table-hang.
Looks like this fixed it.  Previously I would get a hang in the first
day or so.  I'm using your alpha-numa-3 and rwsem-generic-4 against
2.4.4pre3.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrfEH0ACgkQjwioWRGe9K1CsQCgs/YY+5Y+kVW9PysCcFwKfOE5
dvIAn2JZ1U+98QguQh7xpUMZVaplApAD
=CfKi
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
