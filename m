Return-Path: <linux-kernel-owner+willy=40w.ods.org-S379803AbUKAW6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S379803AbUKAW6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S323083AbUKAW6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:58:24 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:58765 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S320921AbUKAVfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:35:21 -0500
Date: Mon, 1 Nov 2004 13:35:01 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 USB storage problems
Message-ID: <20041101213501.GD18227@one-eyed-alien.net>
Mail-Followup-To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>,
	bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <200410121424.59584.worf@sbox.tu-graz.ac.at> <200411011850.47870.worf@sbox.tu-graz.ac.at> <20041101191036.GA18227@one-eyed-alien.net> <200411012040.33285.worf@sbox.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <200411012040.33285.worf@sbox.tu-graz.ac.at>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 01, 2004 at 08:40:32PM +0100, Wolfgang Scheicher wrote:
> Am Montag, 1. November 2004 20:10 schrieb Matthew Dharm:
> > You're using the UB driver.  Does it work if you turn that off and use =
the
> > usb-storage driver instead?
>=20
> Damn, you are right - this is a new driver...
> I didn't notice that, i did rely on hotplug to load the correct modules.
>=20
> Removed the ub driver and everything is fine now.
>=20
> That means - just unloadin ub and loading usb-storage didn't work.=20
>=20
> I had to remove it from the kernel config and rebuild the modules. Actual=
ly=20
> usb-storage was the only module being rebuilt. Looks like usb-storage's=
=20
> functionality is different if ub is built.
>=20
> So, my system works fine again, thank you.
> But it leaves the question: why does ub perform so badly?

Talk to Pete Zaitcev about that.

> And: could maybe somebody put some hints into the ub help?
> "This driver supports certain USB attached storage devices such as flash=
=20
> keys." didn't sound so bad to me...

That should definately happen.  Along with a note that this blocks
usb-storage from working with many devices if enabled.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I think the problem is there's a nut loose on your keyboard.
					-- Greg to Customer
User Friendly, 1/5/1999=20

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBhqwFIjReC7bSPZARAonHAJ4u0k4iCkgByFynUOVsRneRMzxTTwCePLmK
ON8labjx9tWIq3DUGgcNBPY=
=fAF+
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
