Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVLTAdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVLTAdB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 19:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVLTAdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 19:33:01 -0500
Received: from mx.pathscale.com ([64.160.42.68]:60331 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750713AbVLTAdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 19:33:01 -0500
Subject: Re: [openib-general] Re: [PATCH 13/13] [RFC] ipath Kconfig and
	Makefile
From: Robert Walsh <rjwalsh@pathscale.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051218192356.GB9145@mars.ravnborg.org>
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com>
	 <200512161548.lokgvLraSGi0enUH@cisco.com>
	 <20051218192356.GB9145@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7gppYFErif7fQYpAaY4F"
Date: Mon, 19 Dec 2005 16:32:55 -0800
Message-Id: <1135038775.7306.18.camel@hematite.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7gppYFErif7fQYpAaY4F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > @@ -0,0 +1,15 @@
> > +EXTRA_CFLAGS +=3D -Idrivers/infiniband/include
> If this is needed then some header files should be moved to include/rdma

Actually, this is done by other IB drivers, too, so I assumed it was OK.
Roland, have you any comments on this?

> > +
> > +ipath_core-objs :=3D ipath_copy.o ipath_driver.o \
> > +	ipath_dwordcpy.o ipath_ht400.o ipath_i2c.o ipath_layer.o \
> > +	ipath_lib.o ipath_mlock.o
> > +
> > +ib_ipath-objs :=3D ipath_mad.o ipath_verbs.o
>=20
> Please use:
> ipath_core-y :=3D ...
> ib_ipath-y   :=3D ...
>=20
> Use of -y let you do better Kconfig selection in the makefile, and is
> preferred compared to -objs

No problem.

Regards,
 Robert.

--=20
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043

--=-7gppYFErif7fQYpAaY4F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iQEVAwUAQ6dRN/zvnpzTd9fxAQJ5yQf+I7MMCN+fhoddyFVBDDQzulvzQUvsJM2y
B7TPclT6DsnKPR9iRj7rfSgiUk+qhwNrhnTSCl5lla2R2+sQxLLZ/uZZZmrNfy5Z
a391wfS7hOmpJ7CxGko4zogcJZL2CUZJR0zJ4WbnSlYtmVp6Ahf6y28bsFKsaCHx
xgnxiOLS/w9Ed4ufdUah8/7AEG69aWVqufEMGsydshmT5Pq6AbgIStgo6OMtsraN
KphZIe7cb3QRvVJB5uqCjsuaQbmTPMLsBCpLtwMHib/fsicsT20xzYmaDbsuuwaN
i+6ovXKC9QvgIiIWcL0K7uiNEjJrwqCF8bPKep+FBqb+SghrjImHdg==
=k8MD
-----END PGP SIGNATURE-----

--=-7gppYFErif7fQYpAaY4F--

