Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286732AbRLVIvS>; Sat, 22 Dec 2001 03:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286731AbRLVIvJ>; Sat, 22 Dec 2001 03:51:09 -0500
Received: from rj.sgi.com ([204.94.215.100]:64435 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S285047AbRLVIuy>;
	Sat, 22 Dec 2001 03:50:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Announce: kdb v2.0 is available for kernel 2.4.17
Date: Sat, 22 Dec 2001 19:50:37 +1100
Message-ID: <7539.1009011037@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.0/

  kdb-v2.0-2.4.17-common-1.bz2
  kdb-v2.0-2.4.17-i386-1.bz2

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
- -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
        -rc or whatever numbering system the kernel keepers have thought up this
        week.
- -common The common kdb code.  Everybody needs this.
- -i386   Architecture dependent code for i386.
- -ia64   Architecture dependent code for ia64, etc.
- -n      If there are multiple kdb patches against the same kernel version then
        the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb v2.0 for i386 on kernel 2.4.17, apply
  kdb-v2.0-2.4.17-common-1
  kdb-v2.0-2.4.17-i386-1
in that order.


This release is functionally equivalent to kdb v1.9-2.4.16, the only
change is the reorganisation.  I have a backlog of kdb changes which
were on hold until the patches had been split, it was getting too messy
trying to maintain at least six versions of the common kdb code and
keep them in sync.  I hope to clear the backlog soon.

Ethan Solomita (ethan@cs.columbia.edu) has done a port of kdb to
sparc64 against 2.4.13.  I will upgrade that to 2.4.17 and issue
kdb-v2.0-2.4.17-sparc64-1.bz2 "soon".  kdb for ia64 has to wait until
the 2.4.17-ia64 kernel patch is issued.

Changelog extract.

2001-12-22 Keith Owens  <kaos@sgi.com>

        * Upgrade to 2.4.17.
        * Clean up ifdef CONFIG_KDB.
        * Add ifdef CONFIG_KDB around include kdb.h.
        * Delete dummy kdb.h files for unsupported architectures.
        * Delete arch i386 and ia64 specific files.  This changelog now
          applies to kdb common code only.
        * Release as kdb v2.0-2.4.17-common-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8JElbi4UHNye0ZOoRArPiAKCYlVUzS3EYrE5XC8sn3Xz8L9mBeQCeLHGn
Wdx2YfBSiLgCmg6nlUPr+8A=
=BFtm
-----END PGP SIGNATURE-----

