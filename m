Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTLBH2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 02:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLBH2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 02:28:03 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:27091 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261305AbTLBH2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 02:28:00 -0500
Subject: Re: [2.4.23] compile / link error in net/ipv4/netfilter
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Chris Frey <cdfrey@netdirect.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031202014328.A10101@netdirect.ca>
References: <20031201202853.A31914@netdirect.ca>
	 <20031202014328.A10101@netdirect.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wcu8HI/hkIItqih+c6N0"
Message-Id: <1070350075.18456.62.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Dec 2003 08:27:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wcu8HI/hkIItqih+c6N0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-02 at 07:43, Chris Frey wrote:
> On Mon, Dec 01, 2003 at 08:28:53PM -0500, Chris Frey wrote:
> > When compiling 2.4.23, it stops during the compile with these errors:
> ...
> > iptable_nat.o(.text+0x2830): first defined here
> > ipchains.o(.text+0x77c0): In function `place_in_hashes':
> > : multiple definition of `place_in_hashes'
>=20
> Just posting the answer I found in case someone else needs it.
>=20
> This was due to turning off Loadable module support after loading a
> config in menuconfig that had some modules previously enabled, without
> going through and turning them all off before compiling.

Ok, hopefully that's why you had iptables, ipchains, ipfwadm all
selected to be compiled into your kernel. You shouldn't be able to
select all of them, just one, when not compiling as modules.

--=20
/Martin

--=-wcu8HI/hkIItqih+c6N0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/zD77Wm2vlfa207ERAnPwAJwKnJU83qlFAo75UdN6bfdz+K4GXACgmqQ6
8IWXAYc3ndhUsjXbKMK+hoA=
=LifZ
-----END PGP SIGNATURE-----

--=-wcu8HI/hkIItqih+c6N0--
