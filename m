Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSDEL0b>; Fri, 5 Apr 2002 06:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSDEL0W>; Fri, 5 Apr 2002 06:26:22 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:38416 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292870AbSDEL0O>;
	Fri, 5 Apr 2002 06:26:14 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 2.0 is available
Date: Fri, 05 Apr 2002 21:26:08 +1000
Message-ID: <7022.1018005968@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Oops, hit encrypt instead of sign.

Release 2.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 2.0.

... You know what they say about .0 releases ...  User beware.

This announcement is for the base kbuild 2.5 code, i386 against 2.4.16.
It uses 2.4.16 because that gives a useful comparison against the
previous release and a decent branch point from kernel  2.4 to 2.5.

Patches for other architectures and kernels will be out in the next few
days, it takes time to generate and test patches for multiple
architectures against different kernel trees.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release of kbuild 2.5.

Changelog:

   New, faster core code, thanks to Larry McVoy for providing the
   memory mapped database code.

   Patches are now split into core (kernel independent), common
   (architecture independent but kernel dependent) and arch
   (architecture and kernel dependent) files.  The core patch applies
   to all kernels, both 2.4 and 2.5.  The common and arch files apply
   to specific kernels and hardware.


Other than being split into separate patches, kbuild 2.5 for the common
and i386 directories is almost unchanged from release 1.12.  Tom
Duffy's patch for drivers/sbus/{audio,char}/Makefile.in has been
included.  There are some minor changes where the more rigorous error
checking of this release found errors in kbuild 2.4 Makefiles.

The real change is the complete rewrite of the core code.  Instead of
using a text file that is read by every compile step (slow!), kbuild
2.5 uses Larry McVoy's memory mapped database from BitKeeper (mdbm is
both GPL and BKL).

<strong><gloat>

Full 2.4.16 .config, everything that compiles built in.  4 x Pentium
III (Cascades) @700MHz, 5600 Bogomips, 1Gb RAM, SCSI, 2.4.17-xfs.

kbuild 2.4:
  make oldconfig		 0:07
  make dep			 0:37 (make -j dep is unsafe on some architectures)
  make -j8 bzImage modules	14:16
  Total			        15:00
  make -j8 bzImage modules	 2:10 (second run, no changes, spurious rebuilds)

kbuild 2.5:
  make -j8 oldconfig installable 8:51 (no make dep needed :)
  make -j8 oldconfig installable  :14 (second run, no changes)

</gloat></strong>

More accurate kernel build, easier to write and understand Makefiles,
30% faster than kbuild 2.4.  Now the nay-sayers will have to find
something else to complain about!

I have not tried this release of kbuild 2.5 with a recent version of
CML2.  It used to work on CML2 1.9.15, but probably needs some work for
the latest CML2.  Note that kbuild 2.5 and CML2 are independent, each
can function without the other, complaints about CML2 have nothing to
do with kbuild 2.5.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8rYnPi4UHNye0ZOoRArydAJ0SJk5jLqarn1pXtmX0JTsrPJKQSgCfYBLW
dD/osGKC7/q3SSlIxVXUEQA=
=gZmM
-----END PGP SIGNATURE-----

