Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVA0QwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVA0QwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVA0QwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:52:06 -0500
Received: from pop-a065c32.pas.sa.earthlink.net ([207.217.121.247]:10662 "EHLO
	pop-a065c32.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262662AbVA0Qvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:51:45 -0500
Subject: Re: confguring grub to load new kernel
From: David Hollis <dhollis@davehollis.com>
To: sudhir@digitallink.com.np
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <18910-220051427616499@M2W055.mail2web.com>
References: <18910-220051427616499@M2W055.mail2web.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zN9IP/wzcTmSVcfYXCA4"
Date: Thu, 27 Jan 2005 11:50:38 -0500
Message-Id: <1106844638.5105.6.camel@dhollis-lnx.centricconsulting.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zN9IP/wzcTmSVcfYXCA4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-27 at 01:01 -0500, sudhir@digitallink.com.np wrote:
> Hi,
>=20
> I just compiled kernel 2.6.10 and now wondering how to make the grub to
> load the newkernel.
>=20
> The grub.conf file is configured as:
>=20
> #boot=3D/dev/hda
> default=3D1
> timeout=3D10
> splashimage=3D(hd0,5)/boot/grub/splash.xpm.gz
> title Red Hat Linux (2.4.20-8)
>         root (hd0,5)
>         kernel /boot/vmlinuz-2.4.20-8 ro root=3DLABEL=3D/
>         initrd /boot/initrd-2.4.20-8.img
> title DOS
>         rootnoverify (hd0,0)
>         chainloader +1
>                                                                          =
  =20
>    =20
> How should I change the configuration?

Upgrade your modutils to the one from Fedora Core 2.  It supports the
2.6 modules as well as 2.4 so you are covered in either case.  FC3 now
uses module-init-tools which only works with 2.6.  You should be able to
just run a 'make install' which will use /sbin/installkernel to setup
the proper files in /boot.

The Fedora kernel RPMS use this kind of statement to add the entries to
grub:

[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --package kernel --
mkinitrd --depmod --install 2.6.10-1.741_FC3


Should work for you as well with no issues.

--=20
David Hollis <dhollis@davehollis.com>

--=-zN9IP/wzcTmSVcfYXCA4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB+RvdxasLqOyGHncRAmceAJ4sc4J71XVp0zuNJ6lUqx7GMQJxqwCcDlRf
3Llyzb8R606qaf2YD9IEzms=
=cGzg
-----END PGP SIGNATURE-----

--=-zN9IP/wzcTmSVcfYXCA4--

