Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUCWIMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 03:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUCWIMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 03:12:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32912 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262378AbUCWIMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 03:12:43 -0500
Subject: Re: [PATCH][RELEASE] megaraid 2.10.2 Driver
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
In-Reply-To: <405F71CB.7000902@pobox.com>
References: <0E3FA95632D6D047BA649F95DAB60E570230C77A@exa-atlanta.se.lsil.com>
	 <405F71CB.7000902@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QZuH8Ey5KHL0ZnSoGFsi"
Organization: Red Hat, Inc.
Message-Id: <1080029556.5296.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Mar 2004 09:12:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QZuH8Ey5KHL0ZnSoGFsi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-03-23 at 00:07, Jeff Garzik wrote:
> Bagalkote, Sreenivas wrote:
> > Hello,
> > @@ -45,6 +46,10 @@
> > =20
> >  #include "megaraid2.h"
> > =20
> > +#ifdef LSI_CONFIG_COMPAT
> > +#include <asm/ioctl32.h>
> > +#endif
> > +
>=20
> For upstream, this should just be CONFIG_COMPAT I presume.

well we should fix all arch's to provide a dummy header I guess so that
we don't need fugly ifdefs.
> > =20
> > +#ifdef LSI_CONFIG_COMPAT
> > +		/*
> > +		 * Register the 32-bit ioctl conversion
> > +		 */
> > +		register_ioctl32_conversion(MEGAIOCCMD,
> > megadev_compat_ioctl);
> > +#endif
> > +
>=20
> ditto

ditto about providing a stub register_ioctl32_conversion().




--=-QZuH8Ey5KHL0ZnSoGFsi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAX/F0xULwo51rQBIRAtsKAKCVMezlJEz8SKL2kkK+Yx7bTNtP/wCfd++j
rnLTi2xp20KsKgG5vj/Vdi4=
=4Sh7
-----END PGP SIGNATURE-----

--=-QZuH8Ey5KHL0ZnSoGFsi--

