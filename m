Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262771AbSJCHUd>; Thu, 3 Oct 2002 03:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262772AbSJCHUd>; Thu, 3 Oct 2002 03:20:33 -0400
Received: from rj.sgi.com ([192.82.208.96]:45020 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S262771AbSJCHUc>;
	Thu, 3 Oct 2002 03:20:32 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.3 is available for kernel 2.5.40
Date: Thu, 03 Oct 2002 17:24:33 +1000
Message-ID: <4970.1033629873@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.3/

  kdb-v2.3-2.5.40-common-1.bz2
  kdb-v2.3-2.5.40-i386-1.bz2

These patches are alpha quality, they have had limited testing.

The usb keyboard patch has been merged from kdb v2.3-2.4.19-{common,i386}.
It does not compile on 2.5.40, the APIs have changed.  If you can help
with usb polling support for kdb, grep for CONFIG_KDB_USB.  Without
community support, the usb support will be dropped.

Changelog extracts.

2.5.40-common-1

2002-10-03 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.5.40.
	* kdb v2.3-2.5.40-common-1.

2002-09-24 Keith Owens  <kaos@sgi.com>

	* Sync with kdb v2.3-2.4.19-common-2.
	* Sync with 2.5.x-xfs (2.5.38).
	* Replace kdb_port with kdb_serial to support memory mapped I/O.
	  David Mosberger.
	* Remove individual SGI copyrights, the general SGI copyright applies.
	* Handle md0.  Reported by Hugh Dickins, different fix by Keith Owens.
	* Use page_address() in kdbm_pg.c.  Hugh Dickins.
	* Remove debugging printk from kdbm_pg.c.  Hugh Dickins.
	* Move breakpoint address verification into arch dependent code.
	* Dynamically resize kdb command table as required.
	* Common code to support USB keyboard.  Sebastien Lelarge.
	  Note: broken in 2.5 until somebody who understands USB can fix it.
	* Add dmesg command.
	* Clean up copyrights, Eric Sandeen.
	* Syntax check mdWcN commands.

2.5.40-i386-1

2002-10-03 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.5.40.
	* kdb v2.3-2.5.40-i386-1.

2002-10-01 Keith Owens  <kaos@sgi.com>

	* Sync with kdb v2.3-2.4.19.
	* Sync with xfs 2.5.38.
	* Replace kdb_port with kdb_serial to support memory mapped I/O.
	* Use -fno-optimize-sibling-calls for kdb if gcc supports it.
	* .text.lock does not consume an activation frame.
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

For example, to use kdb for i386 on kernel 2.5.40, apply
  kdb-v2.3-2.5.40-common-<n>		(use highest value of <n>)
  kdb-v2.3-2.5.40-i386-<n>		(use highest value of <n>)
in that order.

Use patch -p1 for all patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9m/Cvi4UHNye0ZOoRAt4IAJ9OSYFKt7dFB9Z+Nrdlo15zL3QfcQCgzfVP
CPd1KElWxMs9ShMrI1d3I0s=
=R9CW
-----END PGP SIGNATURE-----

