Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUBCEKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUBCEKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:10:22 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:62343 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265778AbUBCEKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:10:17 -0500
Subject: Re: udev depends on /usr
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040202224419.GA1158@kroah.com>
References: <20040126215036.GA6906@kroah.com>
	 <20040202223221.GC2748@werewolf.able.es>  <20040202224419.GA1158@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cOrtb3RS8G68KiTACUvG"
Message-Id: <1075781426.6931.120.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 06:10:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cOrtb3RS8G68KiTACUvG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 00:44, Greg KH wrote:
> On Mon, Feb 02, 2004 at 11:32:21PM +0100, J.A. Magallon wrote:
> >=20
> > On 2004.01.26, Greg KH wrote:
> > > I've released the 015 version of udev.  It can be found at:
> > >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz
> > >=20
> >=20
> > Little problem ;)
> > I have some modules in /etc/modprobe.preload. Subject of this mail is
> > ide-cd.
> >=20
> > When ide-cd gets loaded, the kernel/udev chain calls
> > /etc/udev/scripts/ide-devfs.sh, wich uses 'expr'. I my system
> > (Mandrake 10) and on a RedHat 9 'expr' lives in /usr/bin, and /usr can
> > be still unmounted when rc.modules is called...
> >=20
> > Solution ? Change udev, change coreutils locations...
>=20

Maybe try to change:

 HOST=3D`expr ${HOST} - 1`

to

 Host=3D$((HOST - 1))

?  It should be sh compatible, but having used bash too long, I
am not sure 8) (although sh -c 'foo=3D2; echo $((foo + 1))' work
with bash in sh mode ..)


Cheers,

--=20
Martin Schlemmer

--=-cOrtb3RS8G68KiTACUvG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHx8yqburzKaJYLYRAgqEAJ0ZX7DoL5URVfKb3kwknS5Mw8SCwgCeP0T3
LKLfKua+rwkIgJ9WhOAodOk=
=Rd3y
-----END PGP SIGNATURE-----

--=-cOrtb3RS8G68KiTACUvG--

