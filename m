Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRJNCgi>; Sat, 13 Oct 2001 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273783AbRJNCg3>; Sat, 13 Oct 2001 22:36:29 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:49674
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S273619AbRJNCgK>; Sat, 13 Oct 2001 22:36:10 -0400
Date: Sat, 13 Oct 2001 19:36:35 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Ed Tomlinson <tomlins@CAM.ORG>, linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <20011013193635.B1356@one-eyed-alien.net>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Ed Tomlinson <tomlins@CAM.ORG>, linux-kernel@vger.kernel.org
In-Reply-To: <20011013234121.31B3B24D64@oscar.casa.dyndns.org> <Pine.GSO.4.21.0110132157160.3903-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110132157160.3903-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Oct 13, 2001 at 10:01:06PM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Media change is broken for the SDDR-09 driver.  That's why it's
experimental, among other reasons.

Don't worry about that, but if you've got a non-media change related
problem, then I would look at that.

Matt

On Sat, Oct 13, 2001 at 10:01:06PM -0400, Alexander Viro wrote:
>=20
>=20
> On Sat, 13 Oct 2001, Ed Tomlinson wrote:
>=20
> > Oct 13 19:28:31 oscar kernel: usb-uhci.c: interrupt, status 2, frame# 1=
147
> > Oct 13 19:28:31 oscar kernel:  I/O error: dev 08:01, sector 0
> > Oct 13 19:28:31 oscar kernel: FAT: unable to read boot sector
> > Oct 13 19:28:31 oscar kernel: VFS: Disk change detected on device sd(8,=
1)
> > Oct 13 19:28:31 oscar kernel: SCSI device sda: 131072 512-byte hdwr sec=
tors (67 MB)
> > Oct 13 19:28:31 oscar kernel: sda: Write Protect is on
> > Oct 13 19:28:31 oscar kernel:  sda: sda1
> >=20
> > The device is a usb smartmedia reader using the sddr-09 support.
>=20
> OK, looks like:
> 	a) ->check_media_change() is screwed for that device.
> 	b) we are hanging on something interesting.  It isn't ->s_umount
> and it's very unlikely to be ->s_lock or mount_sem.  What it might be,
> though... I suspect that ->bd_sem is screwed.
>=20
> 	Could you reproduce the hang and then do Alt-Sysrq-T?  That should
> give you stack traces.  I'm especially interested in stack trace of hung
> mount(8).  It's nice to know that it ends on down(), but knowing what had
> called that down() would help big way.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

NYET! The evil stops here!
					-- Pitr
User Friendly, 6/22/1998

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7yPozz64nssGU+ykRArRTAJ0cBQNoQSClTGrxHAyKQ/1kDUHOSwCg+o37
ou8Jb28rbEgXGjQtXYgpqjI=
=fmik
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
