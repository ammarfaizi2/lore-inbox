Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSGYPaN>; Thu, 25 Jul 2002 11:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSGYPaN>; Thu, 25 Jul 2002 11:30:13 -0400
Received: from coruscant.franken.de ([193.174.159.226]:64698 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S315202AbSGYPaL>; Thu, 25 Jul 2002 11:30:11 -0400
Date: Thu, 25 Jul 2002 09:28:11 +0200
From: Harald Welte <laforge@gnumonks.org>
To: zhengchuanbo <zhengcb@netpower.com.cn>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: about the performance of netfilter
Message-ID: <20020725092811.Z15533@sunbeam.de.gnumonks.org>
References: <200207242128878.SM00796@zhengcb>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3IyuMspwcGTbYISR"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200207242128878.SM00796@zhengcb>; from zhengcb@netpower.com.cn on Wed, Jul 24, 2002 at 09:24:56PM +0800
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Setting Orange, the 59th day of Confusion in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3IyuMspwcGTbYISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2002 at 09:24:56PM +0800, zhengchuanbo wrote:
>=20
> we use a linux router. i just tested the performance of the router. when =
the
> kernel  is build without netfilter support,the throughput of 64bytes fram=
e is
> about 45%. when i build the kernel with netfilter (only the ip_filter
> module),the throughput dropped to 24%, without any rules.

I assume you are talking about the iptable_filter module?=20

The loss from 45 to 25 percent sounds reasonable.  You add computational=20
overhead to the codepath for every packet. =20

That initially you only achieve 45% (of what input packet rate?) indicates =
that
your system is in severe need of tuning. =20

Please look through the mailinglist archives to find out about NAPI and
related work.

> zhengcb@netpower.com.cn

--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+=
=20
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

--3IyuMspwcGTbYISR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9P6iLXaXGVTD0i/8RAnXAAKCWYXBpBNsRcliNsK8TAZt7lNL2jQCfQM4t
uMgvsKLy/b+yfQs0WR4gFKc=
=CrvV
-----END PGP SIGNATURE-----

--3IyuMspwcGTbYISR--
