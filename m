Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287138AbRL2FLe>; Sat, 29 Dec 2001 00:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287139AbRL2FLZ>; Sat, 29 Dec 2001 00:11:25 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:1809 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S287138AbRL2FLR>; Sat, 29 Dec 2001 00:11:17 -0500
Date: Fri, 28 Dec 2001 21:11:13 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Hard Lockup on 2.4.16 with Via ieee1394 (sbp2 mode)
Message-ID: <20011228211113.A15125@one-eyed-alien.net>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200112290321.fBT3GCSs007627@svr3.applink.net> <3C2D3DBB.6ADE1CC5@zip.com.au>, <3C2D3DBB.6ADE1CC5@zip.com.au>; <20011228204041.A14736@one-eyed-alien.net> <3C2D4DA5.E688FF43@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2D4DA5.E688FF43@zip.com.au>; from akpm@zip.com.au on Fri, Dec 28, 2001 at 08:59:17PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It should be using scsi_done()... it actually seems to use whatever was
given as a done function at the queuecommand point, which is, I think,
scsi_done().

Matt

On Fri, Dec 28, 2001 at 08:59:17PM -0800, Andrew Morton wrote:
> Matthew Dharm wrote:
> >=20
> > Hrm...
> >=20
> > Does this apply to usb-storage also?  Under what conditions do you need=
 to
> > hold the io_request_lock when calling the done function?
> >=20
>=20
> That's scsi_old_done().  I don't think scsi_done() cares whether
> io_request_lock is held or not.
>=20
> And io_request_lock *must* be held by the caller of scsi_old_done() - it
> assumes this.   I think we'd have heard by now if usb was getting this
> wrong.  Looks like it's using scsi_done(), yes?
>=20
> -

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Sir, for the hundreth time, we do NOT carry 600-round boxes of belt-fed=20
suction darts!
					-- Salesperson to Greg
User Friendly, 12/30/1997

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8LVBxz64nssGU+ykRAjKjAJ0QbPaYwuiHSil/3OUjvwQhiL3C2ACg9AIW
KyU3J37Ht9DA4gKcqaHIyog=
=wVod
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
