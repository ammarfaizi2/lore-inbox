Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266759AbUGLI3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266759AbUGLI3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUGLI3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:29:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266761AbUGLI3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:29:53 -0400
Subject: Re: [PATCH] Instrumenting high latency
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040712003418.02997a12.akpm@osdl.org>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org>
	 <20040712003418.02997a12.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Rf9MlCvmrOw7BMGznYnQ"
Organization: Red Hat UK
Message-Id: <1089620980.2806.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 10:29:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rf9MlCvmrOw7BMGznYnQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-12 at 09:34, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> >
> > He hacked=20
> >  together this simple patch which times periods according to the preemp=
t=20
> >  count.
>=20
> OK, small problem.  We have code which does, effectively,
>=20
> 	if (need_resched()) {
> 		drop_the_lock();
> 		schedule();
> 		grab_the_lock();
> 	}
>=20
> so if need_resched() stays false then this will hold the lock for a long
> time and bogus reports are generated:

... or reset the time(r) in need_resched() under the assumption that all
need_resched() callers will yield when it returns true...

--=-Rf9MlCvmrOw7BMGznYnQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8kvzxULwo51rQBIRArUkAKCDNcBKYKgnv1fTEjWAR39i8KjepwCgkhbQ
kuOFjPPmF89dVQKJOtUXe+4=
=JW4D
-----END PGP SIGNATURE-----

--=-Rf9MlCvmrOw7BMGznYnQ--

