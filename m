Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUAPF7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUAPF7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:59:45 -0500
Received: from mcgroarty.net ([64.81.147.195]:2945 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S265279AbUAPF7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:59:43 -0500
Date: Thu, 15 Jan 2004 23:59:41 -0600
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB KVM breaks under 2.6.0
Message-ID: <20040116055941.GB2174@mcgroarty.net>
References: <20040114064032.GA3247@mcgroarty.net> <20040116005041.GG23253@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20040116005041.GG23253@kroah.com>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2004 at 04:50:41PM -0800, Greg KH wrote:
> On Wed, Jan 14, 2004 at 12:40:32AM -0600, Brian McGroarty wrote:
> > I have a Belkin Omniview SE 4, a four port KVM, with keyboard and
> > mouse provided to a Linux box via USB.
> >=20
> > Under 2.4.23, the device works well. The keyboard and mouse are
> > detected.
> >=20
> > Under 2.6.0 (Debian build), the keyboard is not recognized.
>=20
> NEVER use the usbkbd driver, unless you _really_ know what you are
> doing.  Please read the config help entry for that item.

I had two problems. Once the second problem was resolved, pulling
usbkbd from the picture made operation more consistent between
directly-plugged and KVM-switched keyboards.

For the second problem, the uhci driver changed names from 2.4 to
2.6. If others google(v) for this problem and find this post, you want
the module "uhci_hcd" and not "usb-uhci" when going from 2.4 to 2.6

The original USB loader daemon I was using recognized the change, but
the second I had tried and was still using did not. I've sent notes to
ask Documentation/input/input.txt to be updated, and I've filed a bug
against the second daemon.


Thanks for the help!

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAB33N2PBacobwYH4RAmL4AJ9qnM+K+RBBFa/HXbNQpJLZGpfOfwCeKLqg
rvprx8YDYLh/3Ca0IJywqU4=
=f8Po
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
