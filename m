Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbRLaWz0>; Mon, 31 Dec 2001 17:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287675AbRLaWzQ>; Mon, 31 Dec 2001 17:55:16 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:43791 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S287682AbRLaWzC>; Mon, 31 Dec 2001 17:55:02 -0500
Date: Mon, 31 Dec 2001 14:54:55 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jens Axboe <axboe@suse.de>
Cc: Peter Osterlund <petero2@telia.com>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20011231145455.C6465@one-eyed-alien.net>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Peter Osterlund <petero2@telia.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011231125157.D1246@suse.de>; from axboe@suse.de on Mon, Dec 31, 2001 at 12:51:57PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jens --

Thanks for the info.  It may have been discussed 'here' (tho, this is
crosposted to two different lists), but I've been focused on 2.4 bugs (one
more left!) and hadn't seen this item.

I think for the first 2.5 kernels, we'll o with your 'vaddr' line, but I
think that being able to set highmem_io is a worthwhile thing.  Which leads
me to two questions:
(1) Do the USB HCDs support highmem?  I seem to recall they do, but I'm not
certain.
(2) How do I pass a highmem address to the HCDs?  The URB structures we use
don't seem particularly well-suited for this.

Matt

On Mon, Dec 31, 2001 at 12:51:57PM +0100, Jens Axboe wrote:
> On Sun, Dec 30 2001, Matthew Dharm wrote:
> > If it shouldn't be used, it should be removed from the structure to for=
ce
> > people to change.
>=20
> It will be soonish. Davem has practically finished this already.
>=20
> > This is probably why usb-storage broke, and it wasn't obvious to me what
> > went wrong.
>=20
> It's been discussed here before, both wrt 2.5 and 2.4 with the block
> highmem patches.
>=20
> > So now I guess I need to either (a) compute the address for the USB lay=
er,
> > or (b) figure out how to pass the memory parameters directly, so we can=
 use
> > highmem.
>=20
> If you don't set highmem_io in the scsi host structure, then you can
> always do
>=20
> 	vaddr =3D page_address(sg->page) + sg->offset;
>=20
> --=20
> Jens Axboe
>=20
>=20
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

My mother not mind to die for stoppink Windows NT!  She is rememberink=20
Stalin!
					-- Pitr
User Friendly, 9/6/1998

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8MOy/z64nssGU+ykRAjooAJ91v5P78RbRwhl6gowqUrG2yOWWqwCfWqM/
P50gABDJXHwdTLT9tVXMxIA=
=YqRD
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
