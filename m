Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUBUBgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUBUBgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:36:25 -0500
Received: from netmagic.net ([206.14.125.10]:12756 "EHLO mail.netmagic.net")
	by vger.kernel.org with ESMTP id S261471AbUBUBgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:36:23 -0500
Subject: NFS serving Solaris Jumpstart clients
From: Per Nystrom <centaur@netmagic.net>
Reply-To: pnystrom@netmagic.net
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rlNOGgsMxJ1HPUjiy4Kf"
Message-Id: <1077327381.3712.45.camel@spike>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 17:36:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rlNOGgsMxJ1HPUjiy4Kf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to use my Linux laptop to serve Solaris Jumpstarts.  The long
and short of it is, kernel 2.4.19 serves NFS to Jumpstart clients just
fine, but after that release something changed.  With subsequent
releases (including 2.6.3), the Solaris Jumpstart client just hangs
after mounting the miniroot.  It's still ping-able, but it doesn't go
any further.  If it's any help, here are the last few lines of tcpdump
output up to the point where the client hangs:

16:46:48.456226 10.42.42.100.nfs > 10.42.42.241.2876172689: reply ok 236
lookup
[|nfs] (DF)
16:46:48.456441 10.42.42.241.2876172690 > 10.42.42.100.nfs: 100 access
[|nfs] (DF)
16:46:48.456471 10.42.42.100.nfs > 10.42.42.241.2876172690: reply ok 120
access
c 0000 (DF)
16:46:48.456755 10.42.42.241.2876172691 > 10.42.42.100.nfs: 100 lookup
[|nfs] (DF)
16:46:48.456782 10.42.42.100.nfs > 10.42.42.241.2876172691: reply ok 236
lookup
[|nfs] (DF)
16:46:48.457110 10.42.42.241.2876172692 > 10.42.42.100.nfs: 100 remove
[|nfs] (DF)
16:46:48.457135 10.42.42.100.nfs > 10.42.42.241.2876172692: reply ok 120
remove
ERROR: Read-only file system (DF)
16:46:48.457445 10.42.42.241.2876172693 > 10.42.42.100.nfs: 100 lookup
[|nfs] (DF)
16:46:48.457475 10.42.42.100.nfs > 10.42.42.241.2876172693: reply ok 236
lookup
[|nfs] (DF)
16:46:48.457695 10.42.42.241.2876172694 > 10.42.42.100.nfs: 132 link
[|nfs] (DF)16:46:48.457718 10.42.42.100.nfs > 10.42.42.241.2876172694:
reply ok 124 link ERROR: Read-only file system (DF)
16:46:48.457946 10.42.42.241.2876172695 > 10.42.42.100.nfs: 104 lookup
[|nfs] (DF)
16:46:48.457977 10.42.42.100.nfs > 10.42.42.241.2876172695: reply ok 236
lookup
[|nfs] (DF)

Note -- the read only file system errors also show up during a
successful run using kernel 2.4.19.

Any help is greatly appreciated -- I don't want to have to dual-boot
Solaris x86 just so I can serve Jumpstarts in the field (for that
matter, I'm not convinced Solaris x86 has the drivers to support my
laptop anyway).

Thanks,
Per Nystrom



--=-rlNOGgsMxJ1HPUjiy4Kf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBANrYUuQMWIGtm8TQRAkAeAKCSAkLmp0ZJeq8W8QHToqowhw+EnACfW6VZ
MB6+LfQo/sfyBuEL7OcejSA=
=bKXb
-----END PGP SIGNATURE-----

--=-rlNOGgsMxJ1HPUjiy4Kf--

