Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUADWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUADWAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:00:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63705 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265808AbUADWAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:00:20 -0500
Date: Sun, 4 Jan 2004 23:00:05 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davej@redhat.com
Subject: Re: 2.6.1-rc1 arch/i386/kernel/setup.c   wrong parameter order to request resources ?
Message-ID: <20040104220005.GA10814@devserv.devel.redhat.com>
References: <20040104153928.GB2416@devserv.devel.redhat.com> <Pine.LNX.4.58.0401041305440.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401041305440.2162@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 04, 2004 at 01:08:52PM -0800, Linus Torvalds wrote:
>=20
>=20
> On Sun, 4 Jan 2004, Arjan van de Ven wrote:
> >=20
> > in setup.c  the kernel tries to reserve ram resources for system ram etc
> > etc. However it seems it's done with the parameters to request_resource=
 in
> > the wrong order (it certainly is opposite order from other neighboring
> > code). Can someone confirm I'm not overlooking something?
>=20
> You've overlooked something.
>=20
> The core uses the rigth order: it's literally trying to find _which_ of=
=20
> the e820 resources contains the "code" and "data" resource.
>=20
> In other words: the code and data resources don't contain anything. They=
=20
> are contained _in_ something, but we don't know which one off-hand, so we=
=20
> try to register them in all the memory resources we find.=20

> and not used for anything else.

ok fair enough; maybe deserves more comment but it makes sense.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/+IzkxULwo51rQBIRAouSAJ9R/idYX2X+FfBjGi/GRA+vtfXlmACfSlB0
q6bVKG9rc2IGFa37MUjSJ4Y=
=zjZH
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
