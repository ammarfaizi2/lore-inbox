Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSHGLsJ>; Wed, 7 Aug 2002 07:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSHGLsJ>; Wed, 7 Aug 2002 07:48:09 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:41997 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317170AbSHGLsG>;
	Wed, 7 Aug 2002 07:48:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.3 is available for kernels 2.4.18 and 2.4.19
Date: Wed, 07 Aug 2002 21:51:33 +1000
Message-ID: <16412.1028721093@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.3/

  kdb-v2.3-2.4.18-common-1.bz2
  kdb-v2.3-2.4.18-i386-1.bz2
  kdb-v2.3-2.4.18-ia64-020722-1.bz2
  kdb-v2.3-2.4.19-common-1.bz2
  kdb-v2.3-2.4.19-i386-1.bz2

These patches are alpha quality, they have had limited testing.  The
usb keyboard code crashes on ia64 for me, set CONFIG_KDB_USB=n unless
you feel like fixing the problem.

Changelog extracts.

2.4.19-common-1

2002-08-07 Keith Owens <kaos@sgi.com>

       * Upgrade to 2.4.19.
       * Remove individual SGI copyrights, the general SGI copyright applies.
       * Handle md0.  Reported by Hugh Dickins, different fix by Keith Owens.
       * Use page_address() in kdbm_pg.c.  Hugh Dickins.
       * Remove debugging printk from kdbm_pg.c.  Hugh Dickins.
       * Move breakpoint address verification into arch dependent code.
       * Dynamically resize kdb command table as required.
       * Common code to support USB keyboard.  Sebastien Lelarge.

2.4.18-common-1 - as above, backported to 2.4.18.

2.4.19-i386-1

2002-08-06 Keith Owens  <kaos@sgi.com>

       * Upgrade to 2.4.19.
       * Remove individual SGI copyrights, the general SGI copyright applies.
       * New .text.lock name.  Hugh Dickins.
       * Set KERNEL_CS in kdba_getcurrentframe.  Hugh Dickins.
       * Clean up disassembly layout.  Hugh Dickins, Keith Owens.
       * Replace hard coded stack size with THREAD_SIZE.  Hugh Dickins.
       * Better stack layout on bt with no frame pointers.  Hugh Dickins.
       * Make i386 IO breakpoints (bpha <address> IO) work again.
         Martin Wilck, Keith Owens.
       * Remove fixed KDB_MAX_COMMANDS size.
       * Add set_fs() around __copy_to_user on kernel addresses.
         Randolph Chung.
       * Position i386 for CONFIG_NUMA_REPLICATE.

2.4.18-i386-1 - as above, backported to 2.4.18.

2.4.18-ia64-020722-1

2002-08-07 Keith Owens  <kaos@sgi.com>

       * Upgrade to 2.4.18-ia64-020722.
       * Remove individual SGI copyrights, the general SGI copyright applies.
       * Clean up disassembly layout.  Hugh Dickins, Keith Owens.
       * Remove fixed KDB_MAX_COMMANDS size.
       * Add set_fs() around __copy_to_user on kernel addresses.
          Randolph Chung.
       * Position ia64 for CONFIG_NUMA_REPLICATE.
       * Stacked registers modification support.  Sebastien Lelarge.
       * USB keyboard support.  Sebastien Lelarge.

v2.3/README

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

vx.y	The version of kdb.  x.y is updated as new features are added to kdb.
- -v.p.s	The kernel version that the patch applies to.  's' may include -pre,
	-rc or whatever numbering system the kernel keepers have thought up this
	week.
- -common	The common kdb code.  Everybody needs this.
- -i386	Architecture dependent code for i386.
- -ia64	Architecture dependent code for ia64, etc.
- -n	If there are multiple kdb patches against the same kernel version then
	the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb for i386 on kernel 2.4.19, apply
  kdb-v2.3-2.4.19-common-<n>		(use highest value of <n>)
  kdb-v2.3-2.4.19-i386-<n>		(use highest value of <n>)
in that order.  To use kdb for ia64-020722 on kernel 2.4.18, apply
  kdb-v2.3-2.4.18-common-<n>		(use highest value of <n>)
  kdb-v2.3-2.4.18-ia64-020722-<n>	(use highest value of <n>)
in that order.

Use patch -p1 for all patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9UQnEi4UHNye0ZOoRAr1zAKCxRN+04JUs6rBB17ypNzqCZrs1sgCfewoD
O/7sQN6M3O+jusxWDM1e+Mg=
=AkCQ
-----END PGP SIGNATURE-----

