Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVCBMSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVCBMSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 07:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVCBMSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 07:18:00 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:45496 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262276AbVCBMRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 07:17:45 -0500
Date: Wed, 2 Mar 2005 14:17:44 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disallow modular framebuffers
Message-ID: <20050302121744.GA2871@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Adrian Bunk <bunk@stusta.de>, adaplas@pol.net,
	linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050301024118.GF4021@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20050301024118.GF4021@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2005 at 03:41:18AM +0100, Adrian Bunk wrote:
> Do modular framebuffers really make sense?
>=20
Yes, at least these are quite common with embedded systems, quite often
without fbcon. It makes little sense to keep the driver constantly loaded
if the device is not being used as a console and is only seeing
occasional use.

It seems more sensible to just fix up the drivers that don't do this
right.. most of the broken drivers seem to be geared at x86 anyways where
people generally don't seem to care.

It may not make a lot of sense with distributions on x86, though it is
useful if you are doing driver development on a secondary device. This is
certainly a corner case though.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCJa7o1K+teJFxZ9wRAmzXAKCGjNhPV3QJclqFGwKkOofuc6U2uQCdHAbt
Qka7Zg9YoBwLEQZNVPMTgP4=
=zZ2e
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
