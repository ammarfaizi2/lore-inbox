Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSJNI35>; Mon, 14 Oct 2002 04:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbSJNI35>; Mon, 14 Oct 2002 04:29:57 -0400
Received: from rj.sgi.com ([192.82.208.96]:36068 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S261874AbSJNI34>;
	Mon, 14 Oct 2002 04:29:56 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v2.3 is available for kernel 2.5.42
Date: Mon, 14 Oct 2002 18:33:43 +1000
Message-ID: <27994.1034584423@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.3/

  kdb-v2.3-2.5.42-common-1.bz2
  kdb-v2.3-2.5.42-i386-1.bz2

The usb keyboard patch has been merged from kdb v2.3-2.4.19-{common,i386}.
It does not compile on 2.5.42, the APIs have changed.  If you can help
with usb polling support for kdb, grep for CONFIG_KDB_USB.  Without
community support, the usb support will be dropped.

Changelog extracts.

2.5.42-common-1

2002-10-14 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.5.42.
	* kdb v2.3-2.5.42-common-1.

2.5.42-i386-1

2002-10-14 Keith Owens  <kaos@sgi.com>

	* Upgrade to 2.5.42.
	* kdb v2.3-2.5.42-i386-1.


No kdb patch for ia64 until there is a more recent ia64 kernel patch
for 2.5.


v2.3/README

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

 vx.y	 The version of kdb.  x.y is updated as new features are added to kdb.
 -v.p.s	 The kernel version that the patch applies to.  's' may include -pre,
	 -rc or whatever numbering system the kernel keepers have thought up this
	 week.
 -common The common kdb code.  Everybody needs this.
 -i386	 Architecture dependent code for i386.
 -ia64	 Architecture dependent code for ia64, etc.
 -n	 If there are multiple kdb patches against the same kernel version then
	 the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb for i386 on kernel 2.5.42, apply
  kdb-v2.3-2.5.42-common-<n>		(use highest value of <n>)
  kdb-v2.3-2.5.42-i386-<n>		(use highest value of <n>)
in that order.

Use patch -p1 for all patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9qoFmi4UHNye0ZOoRAvf9AJ4j5uiE0xRbHZvjKSGwZh2PwrkZNgCeP0b5
8ySDOp9lGpLVrjSOBCPIKMg=
=9uh6
-----END PGP SIGNATURE-----

