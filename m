Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267390AbUBSRLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267395AbUBSRLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:11:33 -0500
Received: from smtp.golden.net ([199.166.210.31]:65035 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S267390AbUBSRLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:11:31 -0500
Date: Thu, 19 Feb 2004 12:11:22 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: Nick Warne <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 RT8139too NIC problems
Message-ID: <20040219171122.GA17199@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Nick Warne <nick@ukfsn.org>, linux-kernel@vger.kernel.org
References: <4034E88C.24740.4C5D4B6@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <4034E88C.24740.4C5D4B6@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2004 at 04:47:08PM -0000, Nick Warne wrote:
> >From my config file:
>=20
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=3Dy
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_8139_RXBUF_IDX=3D is not set
>=20
> No other NIC drivers are used.
>=20
> I am also stuck as to what the new RXBUF_IDX is for.  It appears the=20
> new build needs it, as I cannot remove.
>=20
So read the help entry in Kconfig. Before this change went in, pretty much
everyone defaulted to a 32k receive ring size, which is also the current
default. If you had used the default value of 2 instead of trying to hack
around it, you might get better behavior from your driver..


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFANO461K+teJFxZ9wRAmybAJ4i7Digy6OW3AhlosBQht4pujs/nQCeLzOK
s98rzRz9YwuCEVQmiUxROXw=
=4RdE
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
