Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSJMMFQ>; Sun, 13 Oct 2002 08:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSJMMFQ>; Sun, 13 Oct 2002 08:05:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:47884 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261504AbSJMMFO>;
	Sun, 13 Oct 2002 08:05:14 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@linuxia64.org
Subject: Announce: ksymoops 2.4.7 is available
Date: Sun, 13 Oct 2002 22:10:42 +1000
Message-ID: <16842.1034511042@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.7.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.4.7-1.src.rpm	As above, in SRPM format
ksymoops-2.4.7-1.i386.rpm	Compiled with 2.96 20000731, glibc 2.2.2
ksymoops-2.4.7-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731, glibc-2.2.3
ksymoops-2.4.7-1.sparc.rpm	Compiled as 32 bit user space, it supports 64 bit kernels.
patch-ksymoops-2.4.7.gz		Patch from ksymoops 2.4.6 to 2.4.7.

Changelog extract

	* Add BFD_PREFIX, DEF_TARGET, DEF_ARCH, CROSS options to Makefile to
	  support building ksymoops for cross compilation and debugging.
	  Greg Banks, modified by Keith Owens.
	* Add cross compile documentation to INSTALL and man page.  Keith Owens.
	* Add DEF_TARGET, DEF_ARCH to ksymoops.c to build ksymoops for cross
	  compile.  Attempt to set the default value for the -e flag if build
	  and cross environments have different endianess.  Greg Banks.
	* Extends Oops_truncate_address() to deal with the ckseg0/ kseg0/xkphys
	  physical address alias confusion on mips64 (addresses appear in the
	  oops text as 0xffffffff8xxxxxxx, 0x8xxxxxxx, or 0xa80000000xxxxxxx,
	  but are all the same physical address).  Greg Banks.
	* Calls Oops_truncate_address() from Oops_trace_line() so that the call
	  trace is subject to the address fix.  Greg Banks.
	* Handle exported symbols in sbss sections.  Keith Owens.
	* White space cleanup.
	* Add IA64 MCA support.

The sbss support works best with modutils 2.4.21, but should work with
older modutils.

The ia64 MCA support was written for an SGI NUMA machine, that is the
only MCA sample output I have.  If other ia64 platforms have different
MCA formats, send me a sample output so I can add it to ksymoops.

Some people have reported problems building ksymoops, with unresolved
references in libbfd (htab_create, htab_find_slot_with_hash).  Try
http://www.cs.helsinki.fi/linux/linux-kernel/2002-13/0196.html first,
if that does not work, contact the binutils maintainers.  This is not a
ksymoops problem, ksymoops only uses libbfd.  Any unresolved references
from libbfd are a binutils problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9qWLAi4UHNye0ZOoRAtQCAKDwtQZpsRrl/dsyogu0lST++I7qFwCeMS6r
1ShTKZZ31tdo/CVwq4+vWeo=
=ecQM
-----END PGP SIGNATURE-----

