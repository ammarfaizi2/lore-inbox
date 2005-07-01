Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263279AbVGAIYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbVGAIYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbVGAIYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:24:52 -0400
Received: from [84.77.109.143] ([84.77.109.143]:2281 "EHLO
	dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S263279AbVGAIYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:24:48 -0400
Date: Fri, 1 Jul 2005 10:24:47 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: route reload after interface restart
Message-ID: <20050701082447.GB4859@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <dc849d8505063004136573e59e@mail.gmail.com> <200506301418.04419.vda@ilport.com.ua> <dc849d850506300711a92042@mail.gmail.com> <42C492A8.3020702@trash.net> <42C49511.3060307@gmail.com> <42C498ED.4050400@trash.net> <42C4C964.2090200@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <42C4C964.2090200@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday, 01 July 2005, at 12:41:08 +0800,
Benbenshi wrote:

> i have done an experiment as follow:
>=20
> 1. default route was add to eth0
> 2.ifconfig eth0 down
> 3.ifconfig eth0 192.168.10.57 netmask 255.255.255.0 up
>=20
> no default route was re-added to kernel, failed!
>=20
And how the kernel is supposed to know what your desired default gateway is?

When you bring a network interface down, it wipes every route using that
interface. If you then bring the interface up again, and give it an IP and
network mask, there will be no more added routing information but the
route to the network where the interface is directly connected.

What you need is not the way the kernel works. Think about, for example, a
dial-up network interface with frequent IP changes. Suddenly the link goes
down, it makes the call, and gets a differente IP/mask _and_ default route
to the Internet. If the kernel somewhat remembered the previous default
route, if wouldn't work.

So, to make the default route persistent, script the thing.

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.13-rc1)


--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxP3Pao1/w/yPYI0RAmhzAJ44+KRTshF467orL32hJ1Gl8Y+MuACfWhi0
e5Bgfh4SU57ZQgdFLSgxhoA=
=lozq
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
