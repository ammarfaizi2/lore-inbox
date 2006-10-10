Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWJJKpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWJJKpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 06:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWJJKpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 06:45:42 -0400
Received: from hentges.net ([81.169.178.128]:7145 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1751293AbWJJKpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 06:45:41 -0400
Subject: Re: sky2 (was Re: 2.6.18-mm2)
From: Matthias Hentges <oe@hentges.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20061009094504.7b58eb2d@freekitty>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	 <451C5599.80402@garzik.org> <20060928161956.5262e5d3@freekitty>
	 <1159930628.16765.9.camel@mhcln03>
	 <20061003202643.0e0ceab2@localhost.localdomain>
	 <1160250529.4575.7.camel@mhcln03> <1160314905.4575.21.camel@mhcln03>
	 <20061008092001.0c83a359@localhost.localdomain>
	 <1160326801.4575.27.camel@mhcln03> <1160332296.4575.31.camel@mhcln03>
	 <20061009094504.7b58eb2d@freekitty>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CI9lP+dSyM/mTNVZ7Fyh"
Date: Tue, 10 Oct 2006 12:45:45 +0200
Message-Id: <1160477145.4575.71.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CI9lP+dSyM/mTNVZ7Fyh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

Am Montag, den 09.10.2006, 09:45 -0700 schrieb Stephen Hemminger:
> On Sun, 08 Oct 2006 20:31:36 +0200
> Matthias Hentges <oe@hentges.net> wrote:
>=20
> >=20
> > Oops, I forgot the "x" in lspci -vvvx, new dumps are attached.
>=20
>=20
> I think I know what the problem is. The PCI access routines to access pci=
 express
> registers (ie reg > 256), only work if using MMCONFIG access. For some re=
ason
> your configuration doesn't want to use/allow that.
>=20
> When it happened before, I ended up just not using the pci_read_config_XX=
X
> routines and using the device map.  I'll revert the patch that started us=
ing
> pci_find_ext_capabablity.

the new patch still freezes the box on network loss :\
Tested w/ 2.6.19-rc1-git5

The last kernel message is "eth1: tx timeout"
--=20
Matthias 'CoreDump' Hentges=20

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-CI9lP+dSyM/mTNVZ7Fyh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFK3nZAq2P5eLUP5IRAny4AKC2TW0ZHNY7cEpvWfDid/WNrOKUNwCgpZVP
Vz/W+zKtRjZUxdR9GKI9s4g=
=tLCW
-----END PGP SIGNATURE-----

--=-CI9lP+dSyM/mTNVZ7Fyh--

