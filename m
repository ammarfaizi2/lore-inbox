Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWHSGS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWHSGS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 02:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHSGS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 02:18:29 -0400
Received: from ozlabs.org ([203.10.76.45]:23225 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750892AbWHSGS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 02:18:28 -0400
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Thomas Klein <osstklei@de.ibm.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
In-Reply-To: <44E5DFA6.7040707@de.ibm.com>
References: <200608181333.23031.ossthema@de.ibm.com>
	 <20060818140506.GC5201@martell.zuzino.mipt.ru>
	 <44E5DFA6.7040707@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NFcgwjM1giwsjnU4Nx34"
Date: Sat, 19 Aug 2006 16:18:24 +1000
Message-Id: <1155968305.1388.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NFcgwjM1giwsjnU4Nx34
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-08-18 at 17:41 +0200, Thomas Klein wrote:
> Hi Alexey,
>=20
> first of all thanks a lot for the extensive review.
>=20
>=20
> Alexey Dobriyan wrote:
> >> +	u64 hret =3D H_HARDWARE;
> >=20
> > Useless assignment here and everywhere.
> >=20
>=20
> Initializing returncodes to errorstate is a cheap way to prevent
> accidentally returning (uninitalized) success returncodes which
> can lead to catastrophic misbehaviour.

If you try to return an uninitialized value the compiler will warn you,
you'll then look at the code and realise you missed a case, you might
save yourself a bug. By unconditionally initialising you are lying to
the compiler, and it can no longer help you.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-NFcgwjM1giwsjnU4Nx34
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE5q0wdSjSd0sB4dIRAl0lAKCckSJpdvVFn0urhSL2CWjX9M/E6wCfc8V6
zPTSmq9+N6RQnWIopVsfV4U=
=5H4K
-----END PGP SIGNATURE-----

--=-NFcgwjM1giwsjnU4Nx34--

