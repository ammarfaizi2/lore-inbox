Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSG2Ufv>; Mon, 29 Jul 2002 16:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318088AbSG2Ufv>; Mon, 29 Jul 2002 16:35:51 -0400
Received: from grendel.firewall.com ([66.28.56.41]:44739 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S318085AbSG2Ufu>; Mon, 29 Jul 2002 16:35:50 -0400
Date: Mon, 29 Jul 2002 22:39:10 +0200
From: Marek Habersack <grendel@caudium.net>
To: Stefan Kleyer <kleyer@foni.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3-ac4 parse error
Message-ID: <20020729203910.GA1722@thanes.org>
Reply-To: grendel@caudium.net
References: <20020729221759.1576dd0d.kleyer@foni.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20020729221759.1576dd0d.kleyer@foni.net>
User-Agent: Mutt/1.4i
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2002 at 10:17:59PM +0200, Stefan Kleyer scribbled:
> Hi,
>=20
> I get this error while compiling:=20
My guess is that you're using gcc 2.95 possibly from Debian? (Other distros
might be affected too, I don't know). The cpp shipped with the Debian's gcc
2.95-15 doesn't parse the ##arg part of the varargs macro DRM_ERROR (or any
other) for that matter. It is supposed, per docs, to remove the comma should
the variable args (the "rest") be empty - it leaves the comma there instead,
which renders incorrect C code. I have submitted the bug to the Debian
gcc maintainers.

greetings,

marek

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Raftq3909GIf5uoRAko8AJ4mjiJzykrSDeahkxz5Rst1InPSegCfc3y4
3PAuqg6Sx+klkUbMReV3mF4=
=Aipg
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
