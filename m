Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUHSTm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUHSTm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUHSTmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:42:55 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:25545 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S267306AbUHSTml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:42:41 -0400
Subject: Re: 2.6.8.1-mm1 Tty problems?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Olaf Hering <olh@suse.de>
Cc: Greg KH <greg@kroah.com>, Tonnerre <tonnerre@thundrix.ch>,
       ismail d?nmez <ismail.donmez@gmail.com>,
       Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040819192401.GA11475@suse.de>
References: <2a4f155d04081712005fdcdd9b@mail.gmail.com>
	 <41225D16.2050702@microgate.com>
	 <2a4f155d040817124335766947@mail.gmail.com>
	 <41226512.9000405@microgate.com> <20040818062210.GB22332@suse.de>
	 <2a4f155d040817233463d2b78d@mail.gmail.com>
	 <20040818064229.GD22332@suse.de> <1092855516.8998.34.camel@nosferatu.lan>
	 <20040819172846.GA15361@thundrix.ch>
	 <1092943461.8998.50.camel@nosferatu.lan>  <20040819192401.GA11475@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Vd07qp4BD5DRoRDpv4ox"
Message-Id: <1092944764.8998.57.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 21:46:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Vd07qp4BD5DRoRDpv4ox
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-19 at 21:24, Olaf Hering wrote:
>  On Thu, Aug 19, Martin Schlemmer wrote:
>=20
> > Greg, below patch should be in order.
> >=20
> > ---
> > --- /etc/udev/rules.d/50-udev.rules.orig        2004-08-19 21:17:08.947=
911536 +0200
> > +++ /etc/udev/rules.d/50-udev.rules     2004-08-19 21:22:48.804245520 +=
0200
> > @@ -65,7 +65,7 @@
> >=20
> >  # pty devices
> >  KERNEL=3D"pty[p-za-e][0-9a-f]*", NAME=3D"pty/m%n", SYMLINK=3D"%k"
> > -KERNEL=3D"tty[p-za-e][0-9a-f]*", NAME=3D"tty/s%n", SYMLINK=3D"%k"
> > +KERNEL=3D"tty[p-za-e][0-9a-f]*", NAME=3D"pty/s%n", SYMLINK=3D"%k"
>=20
> Dont forget to update Documentation/devices.txt

Its part of the udev 'devfs compat' ruleset, so not what would
have been created standard.  I checked the code again and devfs
use /dev/pty/s# and not /dev/tty/s#, so it somewhere that either
I or one of the others made a boo-boo that did the original of
that rule file ...

--=20
Martin Schlemmer

--=-Vd07qp4BD5DRoRDpv4ox
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJQN8qburzKaJYLYRAtVuAJ4hPhnlYv1KUYCb2pgu3Meikhz/HwCeIGSJ
4LcXcYRuII3CDXa2XvTRZZw=
=0VyD
-----END PGP SIGNATURE-----

--=-Vd07qp4BD5DRoRDpv4ox--

