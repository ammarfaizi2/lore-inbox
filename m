Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267653AbTBNNib>; Fri, 14 Feb 2003 08:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268385AbTBNNib>; Fri, 14 Feb 2003 08:38:31 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11648 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267653AbTBNNia>; Fri, 14 Feb 2003 08:38:30 -0500
Message-Id: <200302141348.h1EDmHwZ004754@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Matt Porter <porter@cox.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs 
In-Reply-To: Your message of "Thu, 13 Feb 2003 15:58:17 MST."
             <20030213155817.B1738@home.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain> <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
            <20030213155817.B1738@home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1264025974P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Feb 2003 08:48:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1264025974P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 Feb 2003 15:58:17 MST, Matt Porter said:

> Yes, and on embedded SoC devices we have watchdog facilities sitting
> on an internal chip bus.  It would be nice to find access points in
> a uniform place on any Linux system.  i.e. PCI watchdog on my x86 desktop
> is in the same place as the on-chip watchdog on my PPC44x system.
> 
> IMHO, anything else would be a logical step backwards from accessing
> /dev/watchdog across platforms.

I admit not having thoroughly read the source to check - is the userspace API
for accessing  all these chips fairly uniform and rational, so that a user
program can be reasonably sure that if stat("/dev/watchdog") returns zero, that
it knows how to deal with it?  Or are they all sufficiently close to the "keep
reloading a countdown timer from userspace, and if it ever doesn't get reloaded,
kick the kernel in the seat of the pants" programming model?  Of course, even
a disagreement on the units of the timer could be bad - a seconds/milliseconds
clash could result is a *real* fast lack-of-joy situation.. ;)


--==_Exmh_-1264025974P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+TPOhcC3lWbTT17ARAo3eAJwO5sba0GLmVKJf+4HA6SbLp0afUwCfdCiO
g/7HECdmeJmoYqc7HKbmYk8=
=0Jy3
-----END PGP SIGNATURE-----

--==_Exmh_-1264025974P--
