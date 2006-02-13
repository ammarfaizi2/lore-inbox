Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWBMMD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWBMMD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWBMMD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:03:56 -0500
Received: from sipsolutions.net ([66.160.135.76]:50696 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1751754AbWBMMDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:03:55 -0500
Subject: Re: [RFC 2/4] firewire: dynamic cdev allocation below firewire
	major
From: Johannes Berg <johannes@sipsolutions.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <1139815941.2997.9.camel@laptopd505.fenrus.org>
References: <1138919238.3621.12.camel@localhost>
	 <1138920012.3621.19.camel@localhost>
	 <20060213035150.GE3072@conscoop.ottawa.on.ca>
	 <1139815941.2997.9.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9pGNb9hzn/7LQlUw0D3x"
Date: Mon, 13 Feb 2006 13:02:54 +0100
Message-Id: <1139832174.6388.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9pGNb9hzn/7LQlUw0D3x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-13 at 08:32 +0100, Arjan van de Ven wrote:
> > I don't really like this.  There's no benefit to using the 1394 major
> > number.  I'd rather see an improved alloc_chrdev_region() that does
> > something like this but for the whole kernel (currently it "wastes" an
> > entire major even if you only want 1 minor, and for what you're doing,
> > grabbing 1 minor at a time makes the most sense.)
>=20
> why bother? There's a LOT of majors nowadays (12 bits) so... what's the
> problem with keeping the kernel side simple?
> (it's not as if userspace needs to care about the exact numbers anyway
> for almost everything)

Uh, ok. Seems pretty weird to effectively allocate 256 device numbers
for just a single device, but ok :)
I'll drop the patch and make it allocate a new major for every device
plugged in.

johannes

--=-9pGNb9hzn/7LQlUw0D3x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAQ/B1baVg1VMiehFYAQJOYw//U0dCJTiTylegiJP+YIWejKTmFrZMcJTe
q7VBVxhAESzZQO0FEC5BYRFe9CKAQ+q3M52y3kUVYgcNsKzZYzSFCyEcpbWURu8b
W12iS1houFW7GU/M1W8r5V1PtOTbwzOWwhdGdBo64T2hUXRvAUMxy9GaVsn1eYj7
ZFPppcTHk0fpVk/7gQhf0xDOFAuZnXPiKe5G+1QcsUrEuIDPOE6sSPeO7k2YoSFL
Dy6rZCilBAqltnC8PxQpIVIPjnaHcWXBaa9MMO73pLD2wxt0dSYQ5rRhX3V4JwDh
Pw1twlz+foRqlkBBGAJhZURiYFFD8XzQElICNR24cqeojatUuUkD2AZWnxqajprz
Ghw3Wfyav6veXgJYdK4x0kpwhsMTn9kAjxMaQAD0QlWayMjuJ7GDNcFfx9r4QhD3
HPNLE8RhRw25DmekEvFdZy6OF5UXXPtY2HEy1qmAC6JQ1oPDwO2XulSo4zn4incy
bqyOTZ3Q8uW9Brxr70SK7tEEOX6Z4GQIcHGYMtKxi+rnd0Fv0vXrNL8EwpICP5s0
o+CXpvxrLj/YGSS0Qngtur4ZzX5YrSvegeOVueQHKNoqyJRnE+GDbaxW+7cDV/fK
MILI0iv4FPx0BDTJFvbGiCawZM7muCnYL4V8/CVZdwevsZkUgcIi7o9x5rm7VxtW
PK/sMDo1PWc=
=OOcT
-----END PGP SIGNATURE-----

--=-9pGNb9hzn/7LQlUw0D3x--

