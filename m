Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTJNSwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJNSvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:51:37 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:60800 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262373AbTJNSus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:50:48 -0400
Subject: Re: NULL pointer dereference in sysfs_hash_and_remove()
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20031013163200.43e5d1bf.shemminger@osdl.org>
References: <1065220892.31749.39.camel@tux.rsn.bth.se>
	 <20031013163200.43e5d1bf.shemminger@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0aUiYSDu5jwesMQwEtGO"
Message-Id: <1066157445.740.2.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 20:50:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0aUiYSDu5jwesMQwEtGO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-14 at 01:32, Stephen Hemminger wrote:
> On Sat, 04 Oct 2003 00:41:32 +0200
> Martin Josefsson <gandalf@wlug.westbo.se> wrote:
>=20
> > Hi
> >=20
> > I compiled 2.6.0-test6 and ran it on a laptop with cardbus.
> > I have an Xircom NIC and if I remove it during operation I get the bug
> > below.
> >=20
> > I have yenta_socket and xircom_cb loaded as modules.
>=20
>=20
> The driver was setting the statistics pointer after registration had occu=
rred,
> so on unregister the network code was removing a non-existent sysfs direc=
tory.
>=20
> Try this please.

I've applied this patch and=20
"[PATCH] sysfs -- don't crash if removing non-existant attribute group"
and now it works great.

Thanks.

--=20
/Martin

--=-0aUiYSDu5jwesMQwEtGO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/jEWFWm2vlfa207ERAhF8AKCAFiUOZUmcxjEvEmpw9uA7w+nk5wCdEwG+
xk/Ch/NO8NUa/06vTa1S/yA=
=g+ip
-----END PGP SIGNATURE-----

--=-0aUiYSDu5jwesMQwEtGO--
