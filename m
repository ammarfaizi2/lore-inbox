Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264559AbSIQTxZ>; Tue, 17 Sep 2002 15:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264560AbSIQTxZ>; Tue, 17 Sep 2002 15:53:25 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:15366 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S264559AbSIQTxX>; Tue, 17 Sep 2002 15:53:23 -0400
Date: Tue, 17 Sep 2002 12:58:17 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Thomas Dodd <ted@cypress.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: Problems accessing USB Mass Storage
Message-ID: <20020917125817.B11583@one-eyed-alien.net>
Mail-Followup-To: Thomas Dodd <ted@cypress.com>,
	linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net> <3D878788.2030603@cypress.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D878788.2030603@cypress.com>; from ted@cypress.com on Tue, Sep 17, 2002 at 02:50:32PM -0500
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The device may not actually have the beginning few sectors.  Use skip=3D to
try to read something from the middle of the media.

Yes, I actually have seen this before.  The firmware 'fakes' a partition
table on the first attempt to read one, but sector 0 really isn't there.

Matt

On Tue, Sep 17, 2002 at 02:50:32PM -0500, Thomas Dodd wrote:
>=20
> Mark C. Wrote:
>  >>> [root@stimpy dev]# dd if=3D/dev/sda of=3D/dev/null bs=3D1k count=3D1
>  >>> dd: reading `/dev/sda': Input/output error
>  >>> 0+0 records in
>  >>> 0+0 records out
>=20
>=20
> Randy.Dunlap wrote:
> > On Tue, 17 Sep 2002, Jonathan Corbet wrote:
> >=20
> > |
> > | You might try just using dd to copy your card to disk with an offset =
of 25
> > | sectors, and see of you can mount the resulting image.
> >=20
> > This is a bit like what we (JE, David Brownell, and I) saw at
> > the USB plugfest in 1999.  We had a camera device that we
> > couldn't mount as a filesystem, but we could dd it.
> > When we did that and studied the dd-ed file, we could see a
> > FAT filesystem beginning after the first <N> blocks (but more than
> > 25 sectors IIRC -- more like after 50-100 KB, or maybe even more).
>=20
> See the above form Mark's post. He tried to dd a 1K block
> and it failed. Granted, The first few blocks may need to be skipped,
> but right now he cannot even get the raw data out.
>=20
> If we can get the data, we can use the loop device to mount it.
>=20
> Any ideas to figure out the why the dd fails?
>=20
> 	-Thomas
>=20
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

How would you like this tie wrapped around your hairy round head?
					-- Greg
User Friendly, 9/2/1998

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9h4lZIjReC7bSPZARAtgVAKC6yX0Rw43+oy4tzx4DPyUcKpiA1ACffKlQ
J9ZAxD6fyyJihwLV2WMadMg=
=he+K
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
