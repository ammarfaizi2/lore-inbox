Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSAYTFO>; Fri, 25 Jan 2002 14:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290805AbSAYTEQ>; Fri, 25 Jan 2002 14:04:16 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:63939 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S290793AbSAYTD2>; Fri, 25 Jan 2002 14:03:28 -0500
Date: Fri, 25 Jan 2002 14:03:16 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org, simon@baydel.com
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Message-ID: <20020125190316.GM671@online.fr>
Mail-Followup-To: Christoph Hellwig <hch@ns.caldera.de>,
	linux-kernel@vger.kernel.org, simon@baydel.com
In-Reply-To: <20020125170642.GG671@online.fr> <200201251853.g0PIrcB28774@ns.caldera.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Content-Disposition: inline
In-Reply-To: <200201251853.g0PIrcB28774@ns.caldera.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2002 at 07:53:38PM +0100, Christoph Hellwig wrote:
> In article <20020125170642.GG671@online.fr> you wrote:
> > But IIRC these symbol were used only for the 2.2 kernel (that I assume
> > you are using?) and the support for 2.2 kernel was removed in the
> > opengfs fork.
>=20
> No - OpenGFS 0.0.9x still needs them even on 2.4.
> The next development series leading toward 0.2 will remove that
> requirement by resturcturing all the code that currently uses
> 64bit arithmetics without any real need.

Oh yes my mistake was that GFS for kernel 2.2 require a lfs patch and I
had in mind that it was this patch that requires 64bits arithmetics.
But this is definitevly not the case (otherwise this should be compiled
in the kernel and not as a module).

Then your module (divdi3.o I guess) is enough for the need of the
original poster of this thread.
But the best thing to do for him is to rewrite his module to avoid
these 64bits operations.

As a side note, I was a contributor for this part of GFS and Sistina
never contacted me to ask me to give them my right before their
relicensing. But perhaps they have dropped the ppc support.

Christophe

>=20
> 	Christoph
>=20
> --=20
> Of course it doesn't work. We've performed a software upgrade.

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Cats seem go on the principle that it never does any harm to ask for
what you want. --Joseph Wood Krutch

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8Uavzj0UvHtcstB4RAnbMAJ9nntxld2uldYLoxszooYWfE1R+ZQCeKMAI
6Y84NXKogTQYBtUY0XmttbM=
=Xk5d
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--
