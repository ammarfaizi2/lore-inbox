Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSKTGay>; Wed, 20 Nov 2002 01:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSKTGay>; Wed, 20 Nov 2002 01:30:54 -0500
Received: from bg77.anu.edu.au ([150.203.223.77]:23216 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S265844AbSKTGaw>;
	Wed, 20 Nov 2002 01:30:52 -0500
Date: Wed, 20 Nov 2002 17:37:55 +1100
To: linux-kernel@vger.kernel.org
Subject: Re: Separate obj/src dir
Message-ID: <20021120063754.GE21437@himi.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021119201110.GA11192@mars.ravnborg.org> <20021119205154.9616.qmail@escalade.vistahp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <20021119205154.9616.qmail@escalade.vistahp.com>
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2002 at 02:51:54PM -0600, Brian Jackson wrote:
> Sam Ravnborg writes:=20
>=20
> <snip>
> >Another drawback is that when a .h file exist in the
> >SRCTREE but not in the OBJTREE the generated dependencies
> >will point out the .h file located in SRCTREE.
> >This happens for generated .h files, and therefore a simple
> >check is made in kbuild to check that the SRCTREE is
> >cleaned/mrpropered.
>=20
> I wonder how hard it would be to do this for other files types. It would =
be=20
> sort of handy to be able to copy a single file out of the source tree int=
o=20
> the build tree, and have the build use the copy in the build tree. Exampl=
e:=20
> you want to test a one liner in drivers/scsi/sd.c, you could just copy sd=
.c=20
> into the build tree, and make the change and test it out. That could be a=
=20
> huge space savings. That would help out those of us that are stuck with=
=20
> tiny hard drives in our laptops :)=20
>=20
For that you probably want to use the hardlinked trees approach.
Just do a cp -al linux-2.5 scratch; then change your file and build
from the copy.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE92y3CQPlfmRRKmRwRAg7AAKC46+HS864YnCYzPTN6rV59K8vEbwCeINOm
XpIcqsjpGSZmQJsoD2HhNWw=
=sOV1
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
