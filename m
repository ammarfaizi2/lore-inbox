Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSJUEGi>; Mon, 21 Oct 2002 00:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSJUEGi>; Mon, 21 Oct 2002 00:06:38 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:13840 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S264723AbSJUEGh>; Mon, 21 Oct 2002 00:06:37 -0400
Date: Sun, 20 Oct 2002 21:12:38 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Container_of considered harmful - was Re: usb storage sddr09
Message-ID: <20021020211238.A26407@one-eyed-alien.net>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <200210172155.49349.tomlins@cam.org> <20021018193523.GA25316@win.tue.nl> <200210200952.23430.tomlins@cam.org> <20021020182436.GA25975@win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021020182436.GA25975@win.tue.nl>; from aebr@win.tue.nl on Sun, Oct 20, 2002 at 08:24:36PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Actually, I've seen this one with 2.5.44 and no USB storage devices
attached.  Just load usb-storage and it OOPSes.

I haven't been able to find it yet, but I haven't looked as hard as I
could.

Matt

On Sun, Oct 20, 2002 at 08:24:36PM +0200, Andries Brouwer wrote:
> > Both of these are fixed with 2.4.44
>=20
> Yes, there is progress. Not to say that there are no oopses left,
> but with 2.5.44 the oopses are different.
>=20
> Let me just report one, don't know whether I'll have time to track
> what happens.
>=20
> Insert and remove a usb-storage device while usb-storage
> is not loaded. Now load usb-storage. Oops.
>=20
> The oops is a dereference of fffffff0 in base/bus.c:driver_attach().
> I have seen several such oopses lately, various places in the kernel.
> The cause here is a NULL pointer that is turned into fffffff0 by
> container_of() and then fed to get_device(). And get_device() tests
> that it gets a non-NULL pointer, but that does not protect against
> fffffff0.
>=20
> Andries
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:
> Access Your PC Securely with GoToMyPC. Try Free Now
> https://www.gotomypc.com/s/OSND/DD
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

What, are you one of those Microsoft-bashing Linux freaks?
					-- Customer to Greg
User Friendly, 2/10/1999

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9s362IjReC7bSPZARAlYmAJ9ciz8cuixRWHWwgrpvR14PDLsXOACgss+C
hHCkPP7SX2usEuwzChSWYNU=
=vP0+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
