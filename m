Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312772AbSEAOXr>; Wed, 1 May 2002 10:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312920AbSEAOXq>; Wed, 1 May 2002 10:23:46 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:34061 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312772AbSEAOXp>;
	Wed, 1 May 2002 10:23:45 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Date: Thu, 02 May 2002 00:23:33 +1000
Message-ID: <20507.1020263013@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
It is faster, better documented, easier to write build rules in, has
better install facilities, allows separate source and object trees, can
do concurrent builds from the same source tree and is significantly
more accurate than the existing kernel build system.

The arch independent kbuild 2.5 code (core and common) is up to date
with 2.5.12, as are i386 and sparc64.  ia64 support is at 2.5.10, which
was the last ia64 patch against 2.5.  Work is proceeding on arch
dependent kbuild 2.5 rules for superh, s390[x] and ppc.

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

iD8DBQE8z/pii4UHNye0ZOoRAlZnAKCm+kmvXHZnGAAwRXl8sFj+cQ+U8ACgwgBG
2tKEQ0ADLtX7NuKxN7x1R4Y=
=cB0p
-----END PGP SIGNATURE-----

