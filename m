Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbUC2Xyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUC2Xyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:54:36 -0500
Received: from mhub-w5.tc.umn.edu ([160.94.160.35]:10880 "EHLO
	mhub-w5.tc.umn.edu") by vger.kernel.org with ESMTP id S263202AbUC2Xy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:54:26 -0500
Subject: Re: older kernels + new glibc?
From: Matthew Reppert <repp0017@tc.umn.edu>
To: DervishD <raul@pleyades.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040329222710.GA8204@DervishD>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
	 <Pine.LNX.4.53.0403291602340.2893@chaos>  <20040329222710.GA8204@DervishD>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sMbQPhsQ4bFUCAMmxltg"
Message-Id: <1080604519.32741.8.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 17:55:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sMbQPhsQ4bFUCAMmxltg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-03-29 at 16:27, DervishD wrote:
>     Hi Richard :)
>=20
>  * Richard B. Johnson <root@chaos.analogic.com> dixit:
> > For glibc compatibility you need to get rid of the sym-link(s)
> > /usr/include/asm and /usr/include/linux in older distributions.
> > You need to replace those with headers copied from the kernel
> > in use when the C runtime library was compiled. If you can't find
> > those, you can either upgrade your C runtime library, or copy
> > headers from some older kernel that was known to work.
> > In any event, you need to remove the sym-link that ends up
> > pointing to your 'latest and greatest' kernel.
>=20
>     Mmm, I'm confused. As far as I knew, you *should* use symlinks to
> your current (running) kernel includes for /usr/include/asm and
> /usr/include/linux. I've been doing this for years (in fact I
> compiled my libc back in the 2.2 days IIRC), without problems. Why it
> should be avoided and what kind of problems may arise if someone
> (like me) has those symlinks?

See http://www.kernelnewbies.org/faq/index.php3#headers

The correct place, I've read, to get the headers for the current running
kernel is /lib/modules/$(uname -r)/build/include ... which of course
assumes that you keep your kernel in the same place you built it from,
but that's not a worse assumption than whatever you'd assume for
/usr/include/{linux,asm} symlinks to work I'm sure.

Basically, the potential problem as I understand it is binary
incompatibility with the currently installed glibc.

Matt

--=-sMbQPhsQ4bFUCAMmxltg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAaLdmA9ZcCXfrOTMRAjOnAJ0Yoak9YRM+dKIlv4VOBOYef8tlkgCfacTH
6FMIemJ5txkot81Si8Ak0fo=
=pVRm
-----END PGP SIGNATURE-----

--=-sMbQPhsQ4bFUCAMmxltg--

