Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTAUBJ3>; Mon, 20 Jan 2003 20:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbTAUBJ3>; Mon, 20 Jan 2003 20:09:29 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:7689 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S266941AbTAUBJ2>; Mon, 20 Jan 2003 20:09:28 -0500
Date: Mon, 20 Jan 2003 17:18:29 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Peter Nome <peter@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 USB storage (SCSI emulation)
Message-ID: <20030120171829.D9795@one-eyed-alien.net>
Mail-Followup-To: Peter Nome <peter@cogweb.net>,
	linux-kernel@vger.kernel.org
References: <200301101336.h0ADaDG10038@devserv.devel.redhat.com> <1043109692.3e2c973c61f8f@webmail.cogweb.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1043109692.3e2c973c61f8f@webmail.cogweb.net>; from peter@cogweb.net on Mon, Jan 20, 2003 at 04:41:32PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2003 at 04:41:32PM -0800, Peter Nome wrote:
>=20
> Booting 2.4.20 (Debian sid official release 5) with an Archos Jukebox Rec=
order 20, a=20
> USB storage device running a SCSI emulation with the ISD200 driver, produ=
ces a host=20
> of messages in the log, but it works fine.  I'm getting Bad target number=
 and an=20
> apparently failed "Attempting to get CSW" -- any ideas what's going on? W=
hat I DON'T=20
> get is a message telling me where the device is, as I should and used to =
-- e.g.,=20
> "Detected scsi disk sda at scsi1, channel 0, id 0, lun 0". However, mount=
ing=20
> /dev/sda1 works:
>=20
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
>  sda:<7>usb-storage: queuecommand() called
>  sda1
>=20
> In sum, two minor bugs: the queuecommand() is fruitlessly trying to do so=
mething,=20
> and the user is not informed where the device is placed.

To answer, the SCSI layer should tell you where it is.  In 2.5.x (in a few
more days, hopefully), devfs will tell you this.

As for queuecommand() trying to do something, this is all normal.  It's
showing you that it is properly throwing away things that don't make sense
for a USB device like this.  Turn off debugging if you don't like it.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

THEY CASTRATED MY QUAKE BITS! I WANT THEM BACK!!!!
					-- Greg
User Friendly, 3/27/1998

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+LJ/lIjReC7bSPZARAi3SAKDWL9bK0xcIx52vmpk3g8AKRbCuZgCgytwY
eSwcOAZOrtLwGwGmUoH4FkA=
=KZez
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
