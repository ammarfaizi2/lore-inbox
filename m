Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133051AbRD3EZQ>; Mon, 30 Apr 2001 00:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133050AbRD3EZG>; Mon, 30 Apr 2001 00:25:06 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:59655
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S133056AbRD3EYy>; Mon, 30 Apr 2001 00:24:54 -0400
Date: Sun, 29 Apr 2001 21:24:43 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Gregory Maxwell <greg@linuxpower.cx>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Sony Memory stick format funnies...
Message-ID: <20010429212443.D8349@one-eyed-alien.net>
Mail-Followup-To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	"H. Peter Anvin" <hpa@transmeta.com>,
	Gregory Maxwell <greg@linuxpower.cx>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3AEC7A9F.17EBEE57@transmeta.com> <200104292045.WAA25392@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104292045.WAA25392@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Sun, Apr 29, 2001 at 10:45:41PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've seen something similar with USB memory stick devices... they don't
seem to report a media change in a way that the VFS layer will understand.

I think this deserves some _serious_ debugging, personally, as this is
going to come back to haunt us over and over again with some types of
memory stick (and possibly other) media devices.

I'd do it, but I don't have a memory stick reader.  Rogier, can you
volunteer some time for this?

Matt

On Sun, Apr 29, 2001 at 10:45:41PM +0200, Rogier Wolff wrote:
> H. Peter Anvin wrote:
>=20
> > Rogier Wolff wrote:
>=20
> > > The image of the disk (including partition table) is at:
> > >=20
> > >         ftp://ftp.bitwizard.nl/misc_junk/formatted.img.gz
> > >=20
> > > It's 63kb and uncompresses to the 64Mb (almost) that it's sold as.
> > >=20
> >=20
> > And on at least this kernel (2.4.0) there is nothing funny about it:
> >=20
> > : tazenda 13 ; ls -l /mnt
> > total 0
> > -r-xr-xr-x    1 root     root            0 May 23  2000 memstick.ind*
> > : tazenda 14 ;=20
> >=20
> > Mounting msdos, vfat or umsdos, no change.
>=20
> OK. I rebooted the laptop:=20
>=20
>   Linux version 2.2.13 (root@Mandelbrot.suse.de) (gcc version
>   egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Nov 8
>   15:37:25 CET 1999
>=20
> which seems to have cleared it. Somehow that directory was still
> cached somewhere (not in the buffer cache) from when there were images
> on the memory stick.
>=20
> So, I'm suspecting a dcache bug, that allows something to stay over
> after swapping a removable media device.... And all this is irrelevant
> as this was on a very old kernel. Sorry to have been wasting your
> time.
>=20
> 			Roger.
>=20
> --=20
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
> *-- BitWizard writes Linux device drivers for any device you may have! --*
> * There are old pilots, and there are bold pilots.=20
> * There are also old, bald pilots.=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

S:  Another stupid question?
G:  There's no such thing as a stupid question, only stupid people.
					-- Stef and Greg
User Friendly, 7/15/1998

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67OkLz64nssGU+ykRAl2GAJ0Sc2gD0RsZkCPuzBmT1i8qANJMwgCg1THx
LaaRrH5g6YvmxI/rcuTa5K8=
=t+YZ
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
