Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWJYPSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWJYPSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWJYPSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:18:50 -0400
Received: from attila.bofh.it ([213.92.8.2]:34001 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S1030472AbWJYPSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:18:49 -0400
Date: Wed, 25 Oct 2006 17:18:37 +0200
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: major 442
Message-ID: <20061025151837.GB9999@wonderland.linux.it>
Mail-Followup-To: md@Linux.IT, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <20061025102030.GA5790@wonderland.linux.it> <20061025150846.GB23331@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20061025150846.GB23331@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 25, Greg KH <greg@kroah.com> wrote:

> As for what is trying to load the module, I have no idea, it must be
> some userspace tool...
Found it... I had this experimental udev rule which puts the devices in
/dev/bus/usb/ and pcscd keeps scanning the directory every second
looking for Cthulhu knows what:

SUBSYSTEM=3D=3D"usb_endpoint",      PROGRAM=3D"/bin/sh -c 'K=3D%k; E=3D$${K=
#*_}; K=3D$${K#usbdev}; K=3D$${K%%%%_*}; printf bus/usb/%%03i/%%03i_%%s $${=
K%%%%.*} $${K#*.} $$E'", \
                                NAME=3D"%c"

--=20
ciao,
Marco

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFP4BNFGfw2OHuP7ERAjnyAJ9OtjMSRU7ij9qgOGBy3x0tCATOFwCfTbSp
8vzlOtS2vXRowsgcwNvY8nQ=
=ZS0j
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
