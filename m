Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUJWMnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUJWMnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 08:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUJWMnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 08:43:05 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:65526 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261157AbUJWMmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:42:36 -0400
Subject: Re: 2.6.10-rc1 initramfs busted [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023133120.A28178@flint.arm.linux.org.uk>
References: <20041023133120.A28178@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RYoc8T2XDFtQNOS/jIQf"
Date: Sat, 23 Oct 2004 14:42:08 +0200
Message-Id: <1098535328.668.13.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RYoc8T2XDFtQNOS/jIQf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-10-23 at 13:31 +0100, Russell King wrote:
> A build using O=3D does this:
>=20
>   HOSTCC  usr/gen_init_cpio
>   GEN_INITRAMFS_LIST usr/initramfs_list
> Using shipped usr/initramfs_list
>   CPIO    usr/initramfs_data.cpio
> ERROR: unable to open 'usr/initramfs_list': No such file or directory
>=20
> Usage:
>         ./usr/gen_init_cpio <cpio_list>
>=20
> <cpio_list> is a file containing newline separated entries that
> describe the files to be included in the initramfs archive:
>=20
> The source tree contains this in usr:
>=20
> -rw-r--r--  1 rmk rmk 1657 Oct 23 11:41 Makefile
> -rw-r--r--  1 rmk rmk 8335 Oct 23 11:41 gen_init_cpio.c
> -rw-r--r--  1 rmk rmk 1024 Aug  1  2003 initramfs_data.S
> -rw-r--r--  1 rmk rmk  146 Oct 23 11:41 initramfs_list
>=20
> and the build tree usr contains:
>=20
> -rwxr-xr-x  1 rmk rmk 10834 Oct 23 13:29 gen_init_cpio
> -rw-r--r--  1 rmk rmk     0 Oct 23 13:29 initramfs_data.cpio
>=20
> Running with V=3D1 shows:
>=20
> make -f /home/rmk/build/linux-v2.6-local/scripts/Makefile.build obj=3Dusr
>   echo Using shipped usr/initramfs_list
> Using shipped usr/initramfs_list
>   ./usr/gen_init_cpio usr/initramfs_list > usr/initramfs_data.cpio
> ERROR: unable to open 'usr/initramfs_list': No such file or directory
>=20
> so it's referencing the wrong directory.
>=20

Yep.  Please see the

 [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image=
 updates

thread for latest patch to fix this and other issues.  There are some
other patches floating around that is slightly smaller, but I would
appreciate testing and feedback.


Cheers,

--=20
Martin Schlemmer


--=-RYoc8T2XDFtQNOS/jIQf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBelGgqburzKaJYLYRAt8UAKCbx9DhtoidqVakISOygjC8m2AyegCeL1r1
DFv2Ly0jWQxmVXMKbZ70FUM=
=P52V
-----END PGP SIGNATURE-----

--=-RYoc8T2XDFtQNOS/jIQf--

