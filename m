Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSD1KRj>; Sun, 28 Apr 2002 06:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSD1KRi>; Sun, 28 Apr 2002 06:17:38 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25871 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292857AbSD1KRi>;
	Sun, 28 Apr 2002 06:17:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.16 is available 
Date: Sun, 28 Apr 2002 20:17:27 +1000
Message-ID: <12676.1019989047@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.16.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.16-1.src.rpm       As above, in SRPM format
modutils-2.4.16-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.16-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
modutils-2.4.16-1.sparc.rpm	Compiled for combined 32/64 sparc, with gcc
				2.95.4, glibc-2.2.5.
patch-modutils-2.4.16.gz        Patch from modutils 2.4.15 to 2.4.16.

Changelog extract

	* Print 'Module loaded, with warnings' for people who cannot tell the
	  difference between warnings and errors.
	* Tell the user where to find more information about tainted modules.
	* Add configure option TAINT_URL, default http://www.tux.org/lkml/#s1-18.
	* Workaround for ppc64 symbols that contain _R in the name.  Guy Streeter.
	* Add alias char-major-200 vxspec.  Tigran Aivazian.
	* Add "look in syslog or dmesg output" to hints for failing modules.
	  Suggested by Georg Acher.
	* Environment variable UNAME_MACHINE overides the value of uname machine.


Note to vendors who supply Linux systems that contain non-GPL modules.

  I _strongly_ suggest that you configure and ship modutils with a URL
  that points to your support policy, e.g.

    TAINT_URL='http://www.some_vendor.com/linux/support/\#taint' configure

  see the INSTALL file.  Then your users will contact you with
  questions instead of bothering the linux-kernel list and being told
  to go away.  Your users will be happier and l-k readers will be
  happier.

Note to ppc32/64 and hppa32/64 users.

  I have added environment variable UNAME_MACHINE to try to overcome
  the problems of building 64 bit modules in a 32 bit environment and
  vice versa.  When set, this variable overrides the value of uname -m
  in modutils.  In particular, if you are building 64 bit modules on a
  32 bit version of the same platform, doing

    export UNAME_MACHINE=ppc64 (or hppa64)

  should let modules_install handle the modules.  It has had limited
  testing, let me know if it does not work.

  UNAME_MACHINE only works for 32/64 bit versions of the build machine,
  and only when modutils was configured with --enable-combined-XXX.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8y8w2i4UHNye0ZOoRArlLAKDvpnDDpoy1gd8NsR/beG4nmLypCQCgq6dW
rv1RAihc6iVd9UsCpIwlEYg=
=u2H9
-----END PGP SIGNATURE-----

