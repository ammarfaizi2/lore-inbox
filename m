Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267317AbUHST0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbUHST0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUHSTYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:24:05 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:37826 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S267295AbUHSTU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:20:58 -0400
Subject: Re: 2.6.8.1-mm1 Tty problems?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: Tonnerre <tonnerre@thundrix.ch>, Olaf Hering <olh@suse.de>,
       ismail d?nmez <ismail.donmez@gmail.com>,
       Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040819172846.GA15361@thundrix.ch>
References: <2a4f155d0408171116688a87f1@mail.gmail.com>
	 <4122501B.7000106@microgate.com>
	 <2a4f155d04081712005fdcdd9b@mail.gmail.com>
	 <41225D16.2050702@microgate.com>
	 <2a4f155d040817124335766947@mail.gmail.com>
	 <41226512.9000405@microgate.com> <20040818062210.GB22332@suse.de>
	 <2a4f155d040817233463d2b78d@mail.gmail.com>
	 <20040818064229.GD22332@suse.de> <1092855516.8998.34.camel@nosferatu.lan>
	 <20040819172846.GA15361@thundrix.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oPzYef8AJCC/xvSOODI/"
Message-Id: <1092943461.8998.50.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 21:24:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oPzYef8AJCC/xvSOODI/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-19 at 19:28, Tonnerre wrote:
> Saut,
>=20
> On Wed, Aug 18, 2004 at 08:58:37PM +0200, Martin Schlemmer wrote:
> > Ismail, what tries to use /dev/tty anyhow?
>=20
> It's  the standard  UN*X way  of  finding your  controlling TTY:  open
> /dev/tty and  do an  isatty on it.  So I'd  suppose around 90%  of the
> console software does that.
>=20

Yes sorry, I was on drugs.

Greg, below patch should be in order.

---
--- /etc/udev/rules.d/50-udev.rules.orig        2004-08-19 21:17:08.9479115=
36 +0200
+++ /etc/udev/rules.d/50-udev.rules     2004-08-19 21:22:48.804245520 +0200
@@ -65,7 +65,7 @@

 # pty devices
 KERNEL=3D"pty[p-za-e][0-9a-f]*", NAME=3D"pty/m%n", SYMLINK=3D"%k"
-KERNEL=3D"tty[p-za-e][0-9a-f]*", NAME=3D"tty/s%n", SYMLINK=3D"%k"
+KERNEL=3D"tty[p-za-e][0-9a-f]*", NAME=3D"pty/s%n", SYMLINK=3D"%k"

 # ramdisk devices
 KERNEL=3D"ram[0-9]*", NAME=3D"rd/%n", SYMLINK=3D"%k"
---

--=20
Martin Schlemmer

--=-oPzYef8AJCC/xvSOODI/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJP5lqburzKaJYLYRAjn2AJwKxHTQEUcMnte4AQA/wDg76RzppwCcCXiD
TB9XcC47k38ogu5BU5CF5B0=
=4pYg
-----END PGP SIGNATURE-----

--=-oPzYef8AJCC/xvSOODI/--

