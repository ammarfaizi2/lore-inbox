Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSGVHms>; Mon, 22 Jul 2002 03:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSGVHms>; Mon, 22 Jul 2002 03:42:48 -0400
Received: from zok.SGI.COM ([204.94.215.101]:9641 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316576AbSGVHmr>;
	Mon, 22 Jul 2002 03:42:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.18 is available 
Date: Mon, 22 Jul 2002 17:45:47 +1000
Message-ID: <29877.1027323947@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.18.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.18-1.src.rpm       As above, in SRPM format
modutils-2.4.18-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.18-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.18.gz        Patch from modutils 2.4.17 to 2.4.18.

Changelog extract

	* Optionally only check the numeric part of the kernel and module
	  version, insmod -N.  This option is always set for kernel >= 2.5, it
	  defaults to off for earlier kernels.

This change should have been in modutils 2.4.17 but it slipped through
my TODO list.  This patch goes with the 2.5 kernel change
http://marc.theaimsgroup.com/?l=linux-kernel&m=102595659604735&w=2

Checking the complete version string (including EXTRAVERSION) is a
waste of time.  For historical reasons, insmod only checks the first
32 characters of the version string, many users have longer version
strings.  Users make significant changes to their config and kernel but
do not change the version string, as a test for compatibility this is
pointless.  Above all, storing the full string in kernel module.h
forces a complete rebuild when you change one character in
EXTRAVERSION.  So you have a test that is incomplete, unreliable and
has horrible side effects, time to kill it.

As always, the default for modutils on stable kernels is no change to
existing behaviour, unless the user requests it.

For kernel 2.5 and later, insmod only checks the numeric version
number.  With modutils 2.4.18 and the above kernel patch, changing
EXTRAVERSION no longer forces a complete kernel rebuild.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9O7gqi4UHNye0ZOoRAjxdAKCB7UZxLxexChP0y+3nFquk0VubKQCgsLnp
L9FoBM+sIAqWvvf1IOTL0HM=
=4VET
-----END PGP SIGNATURE-----

