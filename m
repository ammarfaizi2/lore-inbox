Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTFDSAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTFDSAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:00:55 -0400
Received: from coruscant.franken.de ([193.174.159.226]:30379 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S263771AbTFDSAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:00:53 -0400
Date: Wed, 4 Jun 2003 20:07:26 +0200
From: Harald Welte <laforge@netfilter.org>
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iptables & 2.5 problem
Message-ID: <20030604180726.GG29818@sunbeam.de.gnumonks.org>
References: <1054747598.12295.5.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <1054747598.12295.5.camel@localhost>
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Setting Orange, the 9th day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2003 at 12:26:38PM -0500, Shawn wrote:
> I really don't know how to track this problem to its source, so I was
> hoping someone could enlighten me.

Since this seems to be an iptables usage problem, please direct further
questions to netfilter@lists.netfilter.org (see=20
http://www.netfilter.org/contact.html for more info)

> The problem illustrated here:
> # iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> iptables: Invalid argument
>=20
> This box is a gentoo running iptables-1.2.8-r1 and linux-2.5.70-mm3.
> Config attached.

This sounds like your iptables userspace command was compiled for a
kernel with different headers.  Please rebuild iptables and make sure it
actually uses the headers of your 2.5.70-mm3 kernel.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+3jVeXaXGVTD0i/8RAgIVAKCZ6hpPCwHZ58b6uHrUp5MYpKz6fQCbBhQb
PuYNxuiF8ZzbGCxTBeLEj4Q=
=L+2/
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
