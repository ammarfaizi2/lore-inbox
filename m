Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTLQTiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTLQTiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:38:13 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:24458 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264522AbTLQTiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:38:08 -0500
Subject: Re: scsi_id segfault with udev-009
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200312171017.28358.dsteklof@us.ibm.com>
References: <1071682198.5067.17.camel@nosferatu.lan>
	 <200312171017.28358.dsteklof@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gxN4JEk3KnkvK1bvX8l9"
Message-Id: <1071690009.11705.2.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 21:40:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gxN4JEk3KnkvK1bvX8l9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-17 at 20:17, Daniel Stekloff wrote:
> On Wednesday 17 December 2003 09:29 am, Martin Schlemmer wrote:
> > Hi
> >
> > Getting this with scsi_id and udev-009:
>=20
>=20
> Hi,
>=20
> Scsi_id hasn't been changed to use the latest libsysfs changes. The=20
> "directory" in the sysfs_class_device is now considered "private" and onl=
y=20
> should be accessed using functions. Treating the structures as handles le=
ts=20
> us only load information when it's needed, reducing caching or stale=20
> information and also helping performance.=20
>=20
> Here's the problem.
>=20
> static inline char *sysfs_get_attr(struct sysfs_class_device *dev,
>                                     const char *attr)
> {
>         return sysfs_get_value_from_attributes(dev->directory->attributes=
,
>                                                attr);
> }
>=20
> Please try this quick fix:
>=20

Yep, that fixes it, thanks.  Btw, any reason it wont actually display
anything ?


Thanks,

--=20

Martin Schlemmer
Gentoo Linux Developer, Desktop/System Team Developer
Cape Town, South Africa



--=-gxN4JEk3KnkvK1bvX8l9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4LEZqburzKaJYLYRAvtKAJ91SnnOwQweyXIAApRwC+4DT9IN8QCeJyNP
rW3M35FVTpHtvu97l+ZmE+Q=
=TxU2
-----END PGP SIGNATURE-----

--=-gxN4JEk3KnkvK1bvX8l9--

