Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTL1Xxq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 18:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTL1Xxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 18:53:46 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:27309 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262283AbTL1Xxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 18:53:44 -0500
Subject: Re: mount from debian to 44bsd, chown bug report?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Peter Leftwich <Hostmaster@Video2Video.Com>
Cc: debian-bsd@lists.debian.org, debian-user@lists.debian.org,
       owner-linux-kernel@vger.kernel.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031228183005.G86605@rocket.alienwebshop.com>
References: <20031228183005.G86605@rocket.alienwebshop.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dGQwxeW6JACoV/xAE8y+"
Message-Id: <1072655768.6994.125.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 01:56:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dGQwxeW6JACoV/xAE8y+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-29 at 01:43, Peter Leftwich wrote:
> Hello everyone.  I am booting up into a bootable Knoppix 3.2 (Debian Linu=
x)
> CD-R (www.knoppix.net) and trying to mount my FreeBSD 4.7-RELEASE partiti=
on.
>=20
> The working command-line is:
> `mount -t ufs -o ufstype=3D44bsd /dev/hda2 /mnt/fbsd`
>=20
> At one time I was naturally able to read/write files to the partition onc=
e
> it was mounted, but then I chowned the root directory to "knoppix."  Now
> here is what's happening:
>=20
>   # whoami ; mount | grep 44bsd
>   root
>   /dev/hda2 on /mnt/test type ufs (rw,ufstype=3D44bsd)
>=20
>   # ls -al /mnt | grep knoppix
>   drwxr-x--x   25 knoppix  root         1024 Dec 18 22:10 /mnt/test
>=20
>   # grep ufs /proc/filesystems
>   ufs
>=20
>   # chown root /mnt/test
>   chown: changing ownership of `test': Read-only file system
>=20
> The error above contradicts the "mount" info, namely, the "rw" part!!
>=20

Uhm, if /mnt/test is in a ro filesystem, mounting a partition to it
rw will still not get you to change /mnt/test - sure, you will be
able to chown /mnt/test/foo ....


--=20
Martin Schlemmer

--=-dGQwxeW6JACoV/xAE8y+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/722YqburzKaJYLYRAsPrAJ9TRTESncicJAoJipxoP4j3bWAaJACgjPOp
E0Fyf5XhCC3wq+3I9dUiidk=
=OZKZ
-----END PGP SIGNATURE-----

--=-dGQwxeW6JACoV/xAE8y+--

