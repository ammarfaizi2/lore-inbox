Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSEPWmd>; Thu, 16 May 2002 18:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSEPWmc>; Thu, 16 May 2002 18:42:32 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:12806 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315167AbSEPWma>;
	Thu, 16 May 2002 18:42:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Date: Fri, 17 May 2002 08:42:18 +1000
Message-ID: <3038.1021588938@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Third and final attempt.  Original sent on May 2, second mail sent on
May 14, still no response from Linus.

Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
It is faster, better documented, easier to write build rules in, has
better install facilities, allows separate source and object trees, can
do concurrent builds from the same source tree and is significantly
more accurate than the existing kernel build system.

The current state is

  kbuild-2.5-core-14		Fits any 2.4 and 2.5 kernel.
  kbuild-2.5-common-2.5.15-4	2.5.15 arch independent files.

There are several arch dependent files for 2.5.15 or earlier kernels.

  kbuild-2.5-i386-2.5.15-2
  kbuild-2.5-sparc64-2.5.15-1
  kbuild-2.5-s390-2.5.15-1
  kbuild-2.5-s390x-2.5.15-1
  kbuild-2.5-ppc-2.5.14-1
  kbuild-2.5-sh-2.5.12-1 (also fits 2.5.13)
  kbuild-2.5-ia64-2.5.10-020426-1 (last Mosberger patch)

That covers most of the architectures that currently build on 2.5.


This version has only been tested on CML1.  kbuild 2.5 has support for
an older version of CML2 but it has not been tested on newer versions
of CML2.

Before I send you the kbuild 2.5 patch, how do you want to handle it?

* Coexist with the existing kernel build for one or two releases or
  delete the old build system when kbuild 2.5 goes in?

  Coexistence for a few days gives a backout, just in case.  It also
  gives a kernel release where the old and new code can be compared,
  useful for architectures that have not been converted yet.

  Deleting the old system at the same time means that unconverted
  architectures cannot build.  OTOH many architectures are already
  broken in the 2.5 kernel.

* I need a quiet period of 24-48 hours (no changes at all) after a new
  kernel release to bring kbuild 2.5 up to the latest release, before
  sending you the complete patch.  Which kernel release do you want
  kbuild 2.5 against?

I would like kbuild 2.5 to go in in the near future.  Keeping up to
date with kernel changes is a significant effort, Makefiles change all
the time, especially when major subsystems like sound and usb are
reorganised.  There are also some changes to architecture code to do it
right under kbuild 2.5 and tracking those against kernel changes can be
painful.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE85DXKi4UHNye0ZOoRAsRyAJwP52HqsmJhZKNIiJKQUScLjD/cOgCffzTc
Uj1qHkvIszUfOYQtInekCYY=
=sxcO
-----END PGP SIGNATURE-----

