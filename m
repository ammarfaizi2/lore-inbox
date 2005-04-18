Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVDRSLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVDRSLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVDRSLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:11:24 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:53632 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262173AbVDRSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:10:47 -0400
Subject: Re: [PATCH] RLIMIT_NPROC enforcement during execve() calls
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050418174346.GA28790@infradead.org>
References: <1113845937.17341.29.camel@localhost.localdomain>
	 <20050418174346.GA28790@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g/PWEq8SJlGTzkuFli4h"
Date: Mon, 18 Apr 2005 20:07:04 +0200
Message-Id: <1113847624.17341.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g/PWEq8SJlGTzkuFli4h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 18-04-2005 a las 18:43 +0100, Christoph Hellwig escribi=F3:
> On Mon, Apr 18, 2005 at 07:38:57PM +0200, Lorenzo Hern?ndez Garc?a-Hierro=
 wrote:
> > Enforces the RLIMIT_NPROC limit by adding an additional check for
> > execve(), as
> > such limit is checked only during fork() calls.
>=20
> What's the point? exec doesn't create new process and exec() shouldn't
> start to fail just because someone lowered the rlimit a short while ago.

The limit is only checked when process is created on a fork() call, but
during execution it's uid can change, thus, the limit for the new uid
could be exceed.

It comes from the Openwall kernel patch, as well implemented in
grSecurity and vSecurity.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-g/PWEq8SJlGTzkuFli4h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCY/dIDcEopW8rLewRAsFiAKDfUb0AIQje73QnJZly30u9chi0NQCgp3CT
Zrfb4kCnkjFOyOGGjX6vIzA=
=fy+0
-----END PGP SIGNATURE-----

--=-g/PWEq8SJlGTzkuFli4h--

