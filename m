Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTIBUVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTIBUVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:21:20 -0400
Received: from coruscant.franken.de ([193.174.159.226]:8405 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S264061AbTIBUVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:21:12 -0400
Date: Tue, 2 Sep 2003 22:18:07 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bastian@schottelius.org
Subject: Re: [BUGS?: 2.6.0test4] iptables and tc problems
Message-ID: <20030902201807.GO1055@obroa-skai.de.gnumonks.org>
References: <20030901122818.GE5524@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Content-Disposition: inline
In-Reply-To: <20030901122818.GE5524@schottelius.org>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.0-test4
X-Date: Today is Setting Orange, the 26th day of Bureaucracy in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2003 at 02:28:18PM +0200, Nico Schottelius wrote:

> Then trying to match the ftp connections
> bruehe:~#  iptables -A OUTPUT -m owner --uid-owner 0 -j ACCEPT  =20
> iptables: Invalid argument
> bruehe:~# iptables -t mangle -A POSTROUTING -o ppp0 -m owner --uid-owner =
1001 -j MARK --set-mark 55
> iptables: Invalid argument
>=20
> Why does iptables or the kernel not accept that?

you will most likely have to recompile your iptables userspace program.
The owner match has recently undergone some changes in the structure
used for communication between kernel and userspace.

btw: you can easily match ftp data sessions (if you use
ip_conntrack_ftp) by matching with "-m helper --helper ftp"

please direct netfilter/iptables related questions to
netfilter@lists.netfilter.org in the future. =20

> Greetings,
> Nico

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/VPr+XaXGVTD0i/8RAiW/AJ4j6dRVlXvvusPUE8R/JCyx10DDWQCfarjB
i7t0u8fjwNN+9MET+S2sXZE=
=Plgv
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--
