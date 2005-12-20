Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVLTBnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVLTBnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 20:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVLTBnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 20:43:23 -0500
Received: from mx.pathscale.com ([64.160.42.68]:19634 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750729AbVLTBnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 20:43:22 -0500
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217123827.32f119da.akpm@osdl.org>
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	 <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	 <20051217123827.32f119da.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z3V8eu65Bwg921cqxYKa"
Date: Mon, 19 Dec 2005 17:43:17 -0800
Message-Id: <1135042997.7306.26.camel@hematite.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z3V8eu65Bwg921cqxYKa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > +#ifdef IPATH_COSIM
> > +extern __u32 sim_readl(const volatile void __iomem * addr);
> > +extern __u64 sim_readq(const volatile void __iomem * addr);
>=20
> The driver has a strange mixture of int32_t, s32 and __s32.  s32 is
> preferred.

The cosim stuff has been nuked, as it was old code anyway.  With those
functions gone, we now use int32_t (and related 8-, 16-, 32- and 64-bit
signed and unsigned versions) consistently throughout the code.  We'd
prefer to keep it that way, instead of changing over to s32 and friends,
as some of our header files are used by userland programs.  Unless we
put in magic typedef for s32 and friends in userland, that won't work,
hence we use the C standard typedefs.

Is this a problem?

Regards,
 Robert.

--=20
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043

--=-Z3V8eu65Bwg921cqxYKa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iQEVAwUAQ6dhtfzvnpzTd9fxAQKEQAf/R3P/z/t4kaV7nL4H7TZh8bdeVedDuSTc
xzvPfWFNqQucUc96FCMyqx/Wua4hNSM5ZXOGicbeggyEdmP/tiDZn8exDz8hukp2
qiLzXnay057/vXBlpKADZSJANvgmIqwMFkM3cIc8XcBXgX8ZEB3HAXkS0qy3hga6
R8QuP5bIvI7jNOLgMJCVcvBeoOk5yaEHbkHU8fg6zpRdi9D7e0aqHQ+X6mKQVF/x
DZq8BIGGVVTinYx4DrQPSxg2jsx+0u71ocltYO7VHYj+k/r+No+xiSPU4c5Y5qSf
xp360W9i2C82XwuyMd+/X3HSH6u6mt99OhckGTHGLscVy5CS88ZXUg==
=+tQo
-----END PGP SIGNATURE-----

--=-Z3V8eu65Bwg921cqxYKa--

