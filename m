Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132595AbRBRFPs>; Sun, 18 Feb 2001 00:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132653AbRBRFP1>; Sun, 18 Feb 2001 00:15:27 -0500
Received: from toscano.org ([64.50.191.142]:8917 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S132595AbRBRFPV>;
	Sun, 18 Feb 2001 00:15:21 -0500
Date: Sun, 18 Feb 2001 00:15:16 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: Thomas Molina <tmolina@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1ac17 hang on mounting loopback fs
Message-ID: <20010218001516.A29803@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	Thomas Molina <tmolina@home.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010217191930.A12036@bubba.toscano.org> <Pine.LNX.4.30.0102172126430.686-100000@wr5z.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102172126430.686-100000@wr5z.localdomain>; from tmolina@home.com on Sat, Feb 17, 2001 at 09:28:27PM -0600
X-Unexpected: The Spanish Inquisition
X-Uptime: 12:14am  up  2:42,  3 users,  load average: 0.35, 0.38, 0.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Excellent!  Thanks, that worked.

pete

On Sat, 17 Feb 2001, Thomas Molina wrote:

> On Sat, 17 Feb 2001, Pete Toscano wrote:
>=20
> > reading this, I see now why mkbootdisk was locking in the D state with
> > the loop mounted... Would this also explain not being able to seek
> > forward while writing a floppy?
> >
> > I was trying to make the GRUB boot disk by writing the stage 1 and 2
> > loaders to the floppy (as per the GRUB docs) with dd:
> >
> > [root@bubba grub]# dd of=3D/dev/fd0 if=3Dstage1 bs=3D512 count=3D1
> > 1+0 records in
> > 1+0 records out
> > [root@bubba grub]# dd of=3D/dev/fd0 if=3Dstage2 bs=3D512 seek=3D1
> > dd: advancing past 1 blocks in output file `/dev/fd0': Permission denied
>=20
> Different problem.  Add conv=3Dnotrunc to the dd command to make it work.
>=20

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6j1pksMikd2rK89sRAmsKAJ0eULEKZRDtsbuBNgj8vuBIwRQLewCcCufC
KmwwWW18WeIiUj2O/RnOELg=
=0taR
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
