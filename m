Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbULRL7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbULRL7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 06:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbULRL7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 06:59:23 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:8380 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262141AbULRL7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 06:59:17 -0500
Subject: Re: ip=dhcp problem...
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Charles-Henri Collin <charlie.collin@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41C40326.3070303@free.fr>
References: <41C40326.3070303@free.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QFSpPdGe1EyqtfDivfRw"
Message-Id: <1103371154.12078.61.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 18 Dec 2004 12:59:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QFSpPdGe1EyqtfDivfRw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-12-18 at 11:15, Charles-Henri Collin wrote:
> Hi,
>=20
> I've got the following problem with linux 2.6.8.1:
> I'm nfs-rooting a diskless client with kernel parameter ip=3Ddhcp.
> My dhcpd.conf  has a "option domain-name-servers X.X.X.X;" statement and=20
> "get-lease-hostnames true;"
> Now when the diskless clients boot, no name-server configured and they=20
> cant resolv.
> dmesg gives me, for instance:
>=20
> IP Config: Complete:
>     device=3Deth0, addr=3D192.168.0.237, mask=3D255.255.255.0, gw=3D192.1=
68.0.1,
>     host=3DclientFSB-237.fsb.net, domain=3Dfsb.net, nis-domain=3DFSBnis,
>     boot-server=3D192.168.0.254, rootserver=3D92.168.0.254, rootpath=3D
>=20
> So as you can see, everything is almost set up, except a nameserver!
> Has anyone heard about that problem before? Are there any fixes?

The fix is to make sure you have a nameserver in your /etc/resolv.conf
The kernel has no idea how to resolve names into addresses. That's a
userspace thing. I'm not sure if you can extract the dhcp info from the
kernel after the boot, otherwise you'll just have to run a userspace
dhcp client, I use dhclient.

--=20
/Martin

--=-QFSpPdGe1EyqtfDivfRw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBxBuSWm2vlfa207ERAussAJoCW2Nt2sE/ipeOj5tOUmZo6tH4HwCfRE6G
fdEYPZSqjtTlYhbdFZLhUHY=
=C0Is
-----END PGP SIGNATURE-----

--=-QFSpPdGe1EyqtfDivfRw--
