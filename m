Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265086AbSJaB0X>; Wed, 30 Oct 2002 20:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265087AbSJaB0X>; Wed, 30 Oct 2002 20:26:23 -0500
Received: from rj.sgi.com ([192.82.208.96]:34444 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S265086AbSJaB0W>;
	Wed, 30 Oct 2002 20:26:22 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.4 is available for kernel 2.4.19
Date: Thu, 31 Oct 2002 12:31:19 +1100
Message-ID: <511.1036027879@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.4/

  kdb-v2.4-2.4.19-common-1.bz2
  kdb-v2.4-2.4.19-i386-1.bz2
  kdb-v2.4-2.4.19-ia64-020821-1.bz2

Changelog extracts.

2.4.19-common-1

2002-10-31 Keith Owens  <kaos@sgi.com>

	* Add defcmd/endefcmd feature.
	* Remove kdb_eframe_t.
	* Clear bp data before using.
	* Sanity check if we have pt_regs.
	* Force LINES > 1.
	* Remove special case for KDB_REASON_PANIC, use KDB_ENTER() instead.
	* Remove kdba_getcurrentframe().
	* Coexist with O(1) scheduler.
	* Add lines option to dmesg, speed up dmesg.
	* kdb v2.4-2.4.19-common-1.

2.4.19-i386-1

2002-10-31 Keith Owens  <kaos@sgi.com>

	* Avoid KDB_VECTOR conflict with DUMP_VECTOR.
	* Remove kdb_eframe_t.
	* Sanity check if we have pt_regs.
	* Remove kdba_getcurrentframe().
	* Reinstate missing nmi_watchdog/kdb hook.
	* kdb v2.4-2.4.19-i386-1.

2.4.19-ia64-020821-1

2002-10-31 Keith Owens  <kaos@sgi.com>

	* Remove kdb_eframe_t.
	* Sanity check if we have pt_regs.
	* Remove kdba_getcurrentframe().
	* Comments for coexistence with O(1) scheduler.
	* kdb v2.4-2.4.19-ia64-020821-1.


v2.4/README

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
  kdb-v2.4-2.4.19-common-<n>            (use highest value of <n>)
  kdb-v2.4-2.4.19-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64-020821 on kernel 2.4.19, apply
  kdb-v2.4-2.4.19-common-<n>            (use highest value of <n>)
  kdb-v2.4-2.4.19-ia64-020821-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9wIfki4UHNye0ZOoRAl6YAJ4zija2wSRcEa4xEz3+Rfu6XPleBgCg6jyO
ynTgn9ZrBlOoYGAkq1vNvWU=
=z/nO
-----END PGP SIGNATURE-----

