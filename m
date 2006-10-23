Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWJWSgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWJWSgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWJWSgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:36:25 -0400
Received: from threatwall.zlynx.org ([199.45.143.218]:13185 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S964990AbWJWSgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:36:24 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Zan Lynx <zlynx@acm.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Giridhar Pemmasani <pgiri@yahoo.com>
In-Reply-To: <1161600064.19388.14.camel@localhost.localdomain>
References: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
	 <1161600064.19388.14.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q+ebL8+8G9ibCSgjq35V"
Date: Mon, 23 Oct 2006 12:36:21 -0600
Message-Id: <1161628581.8901.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q+ebL8+8G9ibCSgjq35V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 11:41 +0100, Alan Cox wrote:
> Ar Sul, 2006-10-22 am 22:41 -0700, ysgrifennodd Giridhar Pemmasani:
> > Note that when a driver is loaded, ndiswrapper does taint the kernel (t=
o be
> > more accurate, it should check if the driver being loaded is GPL or not=
, but
> > that is not done).
>=20
> However by then it has already dynamically linked with explicit GPLONLY
> symbols so it cannot then load a binary windows driver but should unload
> itself or refuse to load anything but the GPL ndis drivers (of which
> afaik only one exists), and even then they expect an environment
> incompatible with the Linux kernel.

The kernel itself links GPL code to non-GPL via the Posix API (the
syscall layer).  The kernel also links GPL code to non-GPL via the PCI
layer (all that proprietary firmware on the other side).  The
ndiswrapper links GPL code to non-GPL via the NDIS API.

No difference, really.  Implementing a well-defined interface
abstraction layer doesn't make either side of it derived from the other.
(Exactly how well-defined, how abstract, and how derived are all
arguments for the lawyers.)
--=20
Zan Lynx <zlynx@acm.org>

--=-Q+ebL8+8G9ibCSgjq35V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPQulG8fHaOLTWwgRAogfAJ9R/FSKFK3d0/S+hhjV7EU7r2PVWQCdFjoI
W9cD1Nf0c7kteI46nTkOpnY=
=8nsd
-----END PGP SIGNATURE-----

--=-Q+ebL8+8G9ibCSgjq35V--

