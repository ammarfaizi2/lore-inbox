Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSKNAlo>; Wed, 13 Nov 2002 19:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264741AbSKNAlo>; Wed, 13 Nov 2002 19:41:44 -0500
Received: from rj.SGI.COM ([192.82.208.96]:46035 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S264724AbSKNAlk>;
	Wed, 13 Nov 2002 19:41:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.5 is available for kernel 2.4.19
Date: Thu, 14 Nov 2002 11:47:03 +1100
Message-ID: <16464.1037234823@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.5/

  kdb-v2.5-2.4.19-common-1.bz2
  kdb-v2.5-2.4.19-i386-1.bz2
  kdb-v2.5-2.4.19-ia64-020821-1.bz2

Changelog extracts.

2.4.19-common-1

2002-11-14 Keith Owens  <kaos@sgi.com>

        * Fix processing with O(1) scheduler.
        * 'go' switches back to initial cpu first.
        * 'go <address>' only allowed on initial cpu.
        * 'go' installs the global breakpoints from the initial cpu before
           releasing the other cpus.
        * If 'go' has to single step over a breakpoint then it single steps just
          the initial cpu, installs the global breakpoints then releases the
          other cpus.
        * General clean up of handling for breakpoints and single stepping over
          software breakpoints.
        * Add kdb_notifier_block so other code can tell when kdb is in control.
        * kdb v2.5-2.4.19-common-1.

2.4.19-i386-1

2002-11-14 Keith Owens  <kaos@sgi.com>

        * General clean up of handling for breakpoints and single stepping over
          software breakpoints.
        * Accept ff 1x as well as ff dx for call *(%reg) in backtrace.
        * kdb v2.5-2.4.19-i386-1.

2.4.19-ia64-020821-1

2002-11-14 Keith Owens  <kaos@sgi.com>

        * General clean up of handling for breakpoints and single stepping over
          software breakpoints.
        * kdb v2.5-2.4.19-ia64-020821-1.


v2.5/README

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

 vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
 -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
	 -rc or whatever numbering system the kernel keepers have thought up this
	 week.
 -common The common kdb code.  Everybody needs this.
 -i386   Architecture dependent code for i386.
 -ia64   Architecture dependent code for ia64, etc.
 -n      If there are multiple kdb patches against the same kernel version then
	 the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb for i386 on kernel 2.4.19, apply
  kdb-v2.5-2.4.19-common-<n>            (use highest value of <n>)
  kdb-v2.5-2.4.19-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64-020821 on kernel 2.4.19, apply
  kdb-v2.5-2.4.19-common-<n>            (use highest value of <n>)
  kdb-v2.5-2.4.19-ia64-020821-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE90vKGi4UHNye0ZOoRAnVgAJ90mYkf/J9Z+VpGSTkflyGtrpAgeQCfV/qo
PyF/y4GznKnmInwP/6Z1CGc=
=S2jz
-----END PGP SIGNATURE-----

