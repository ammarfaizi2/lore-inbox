Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266084AbUAFG5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUAFG5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:57:06 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:58258 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266084AbUAFG5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:57:02 -0500
Date: Mon, 5 Jan 2004 22:56:55 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Javier Marcet <javier@marcet.info>
Cc: linux-kernel@vger.kernel.org, usb-storage@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net
Subject: Re: [usb-storage] Re: usb-storage && iRIVER flash player problem
Message-ID: <20040106065655.GA10031@one-eyed-alien.net>
Mail-Followup-To: Javier Marcet <javier@marcet.info>,
	linux-kernel@vger.kernel.org, usb-storage@one-eyed-alien.net,
	linux-usb-users@lists.sourceforge.net
References: <20040105125948.GA9257@hiroshi> <20040105190204.GA4547@one-eyed-alien.net> <20040105200333.GA11318@hiroshi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20040105200333.GA11318@hiroshi>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2004 at 09:03:33PM +0100, Javier Marcet wrote:
> * Matthew Dharm <mdharm-kernel@one-eyed-alien.net> [040105 20:02]:
>=20
> >It looks like your device is choking over the ALLOW_MEDIUM_REMOVAL comma=
nd
> >-- I've never seen a device broken in this particular way before.
>=20
> >If you edit drivers/scsi/sd.c to remove the sending of that command (it's
> >normally used to lock the media-eject button on devices that support it),
> >we should be able to test this theory.  If this is the case, then we may
> >need to modify the SCSI layer to only send that command if the RMB bit is
> >set.
>=20
> That did it, with this fix I have no problems. fdisk still reports
> mangled partitions, parted OTOH reports one partition filling the whole
> device. I can mount either /dev/sda or /dev/sda4 and get the same
> correct results.
>=20
> Thanks a lot :) You've made me happy for the coming days ;)
> Until your message I was messing around with unusual_devs.h to no
> avail...

Hrm... what's the easiest way for Javier to figure out if his device sets
the RMB or not?

I feel another SCSI enhancement coming on....

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm just trying to think of a way to say "up yours" without getting fired.
					-- Stef
User Friendly, 10/8/1998

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/+lw3IjReC7bSPZARArO7AKDCW39baFhi/ZFbNdyaqwSjIcI+9wCghPLI
FaV1Cewxq03Qq2RVXvRScmA=
=Jnhi
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
