Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWH3W0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWH3W0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWH3W0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:26:46 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:16361 "EHLO
	pan.var.cx") by vger.kernel.org with ESMTP id S932197AbWH3W0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:26:45 -0400
Date: Thu, 31 Aug 2006 00:26:47 +0200
From: Frank v Waveren <fvw@var.cx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-ID: <20060830222647.GC21353@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain> <20060830214441.GA21353@var.cx> <1156975503.29250.220.camel@localhost.localdomain> <20060830220836.GA21987@var.cx> <1156976556.29250.230.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <1156976556.29250.230.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2006 at 12:22:36AM +0200, Thomas Gleixner wrote:
> Well, the point is that pre hrtimer kernels did just sleep as long as
> they internaly could. So the hrtimers / ktime_t merge changed the
> userspace interface behaviour, which is breakage.
=2E..

Ok, that's a convincing argument, your patch is the better solution.

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFE9hCn+gB9UUaNYsgRAgarAKCjwqcPEQhs6fYNQxlzcP1XhOx0WwCgn98n
SFS8VxC08KplVcMFcl8+N08=
=Xkl9
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
