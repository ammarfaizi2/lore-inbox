Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290112AbSAWVUi>; Wed, 23 Jan 2002 16:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290115AbSAWVUZ>; Wed, 23 Jan 2002 16:20:25 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:45062 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S290112AbSAWVSt>; Wed, 23 Jan 2002 16:18:49 -0500
Date: Wed, 23 Jan 2002 13:18:43 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.org>, linux-kernel@vger.kernel.org
Subject: Re: Daemonize() should re-parent its caller
Message-ID: <20020123131843.H31707@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0201231050440.687-100000@ida.rowland.org> <20020123205804.GA15259@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020123205804.GA15259@kroah.com>; from greg@kroah.com on Wed, Jan 23, 2002 at 12:58:04PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

He's looking at the "zombie-thread on unload" problem, which is different
from the "long delay at shutdown" problem.

Matt

On Wed, Jan 23, 2002 at 12:58:04PM -0800, Greg KH wrote:
> On Wed, Jan 23, 2002 at 10:54:44AM -0500, Alan Stern wrote:
> >=20
> > If the parent is init or another user process, we can reasonably
> > expect that the zombie will be reaped eventually.  But what if the
> > parent is another kernel thread?  This situation arises in the USB
> > mass-storage device driver, where the device manager and scsi
> > error-handler threads are spawned (indirectly) by the khubd kernel
> > thread.
>=20
> What problem are you seeing with the khubd and USB mass-storage kernel
> threads?  There is a patch in the most recent kernel versions that
> slightly modifies the usb-storage kernel thread logic, supposedly to fix
> a problem that people were having under very long scsi timeouts.
>=20
> thanks,
>=20
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Pitr!  That's brilliant!  Funded by Microsoft refunds.  What sweet irony!
					-- A.J.
User Friendly, 2/15/1999

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Tyizz64nssGU+ykRAo/0AKCTLC9ycImPXp4k2UX7p51UeWqItgCdF41D
xKbdjt6kv/PsKUzAuIpz7wc=
=a9L+
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
