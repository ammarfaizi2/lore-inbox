Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTLDIr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 03:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTLDIr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 03:47:57 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:69 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263260AbTLDIrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 03:47:52 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v4.3 is available for kernel 2.6.0-test11 ia64 
Date: Thu, 04 Dec 2003 19:47:46 +1100
Message-ID: <3908.1070527666@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v4.3/

This is alpha code.  It has had minimal testing with a small set of
config options.  In particular it has not been tested with
CONFIG_PREEMPT.  It only works on vanilla ia64 boxes using serial
console and PC keyboard/VT.  Patches to port the kdb USB console
support from 2.4 to 2.6 will be gratefuly accepted.

These 2.6.0-test11 patches must be applied in this order, against
2.6.0-test11 plus David Mosberger's linux-2.6.0-test11-ia64-031126
patch.

  kdb-v4.3-2.6.0-test11-common-1.bz2
  kdb-v4.3-2.6.0-test11-salinfo.bz2 (brings salinfo processing up to 2.4.23)
  kdb-v4.3-2.6.0-test11-xfsidbg.bz2 (corrects out of date XFS debug code)
  kdb-v4.3-2.6.0-test11-ia64-031126-1.bz2

This is a clone from kdb v4.3-2.4.23, with changes from several people
for 2.6, thanks to Xavier Bru and Jim Houston for 2.6 changes to kdb.
Changelog extracts from 2.4.23.

common

2003-12-03 Keith Owens  <kaos@sgi.com>

	* Reconcile 2.6-test versions from Xavier Bru (Bull), Greg Banks (SGI),
	  Jim Houston (Concurrent Computer Corp).
	* Reconcile with kdb v4.3-2.4.23-common-2.
	* Clean up CONFIG_KDB changes to {scripts,kernel}/kallsyms.c.
	* Correct handling of kdb command line arguments.
	* Make hooks into module code less intrusive.
	* Delete kdb_active_task, not required with O(1) scheduler.
	* Port kdbm_task.c from 2.4.
	* Disable debug check in exit.c::next_thread() when kdb is running.
	* Remove "only bh_disable when interrupts are set".  BH must be disabled
	  in kdb to prevent deadlock on breakpoints in interrupt handlers.
	* Add kdb to drivers/char/sn_serial.c.
	* kdb v4.3-2.6.0-test11-common-1.

2003-11-11 Xavier Bru   <xavier.bru@bull.net>
	* Merge to 2.6.0-test9
2003-10-17 Xavier Bru   <xavier.bru@bull.net>
	* fix NUll ptr in kdb_ps at early prompt.
2003-10-14 Xavier Bru   <xavier.bru@bull.net>
	* fix NUll ptr in kdb_ps when cpu not present.
2003-10-06 Xavier Bru   <xavier.bru@bull.net>
	* Merge to 2.6.0-test5
	* fix compile error with CONFIG_MODULES not set.


ia64

2003-12-03 Keith Owens  <kaos@sgi.com>

	* Reconcile 2.6-test versions from Xavier Bru (Bull), Greg Banks (SGI),
	  Jim Houston (Concurrent Computer Corp).
	* Reconcile with kdb v4.3-2.4.23-ia64-0312??-1.
	* Reconcile with salinfo changes.
	* Port WAR for backtrace from spinlock contention from 2.4 to 2.6.
	* Merge PGS FIFO tweak with SERIAL_IO_MEM and concurrent support for
	  multiple consoles (no USB consoles yet).
	* Update pt_regs output to match the order of struct pt_regs.
	* KDB wrappers for interrupts handlers now return the handler's return code.
	* tpa and tpav commands from Anonymous.
	* kdb v4.3-2.6.0-test11-ia64-031126-1.

2003-10-22 Xavier Bru   <xavier.bru@bull.net>
	* Merge to 2.6.0-test7
2003-10-20 Philippe Garrigues <Philippe.Garrigues@bull.net>
	* Enable FIFO in UART
2003-09-08 Xavier Bru   <xavier.bru@bull.net>
	* Merge to 2.6.0-test4
2003-03-21 Xavier Bru <xavier.bru@bull.net>
	* Merge kdb v4.0 on 2.5.64 ia64
	* new kernel parameters support
	* new kallsyms support


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE/zvSyi4UHNye0ZOoRAildAKCVD4gOaT9ONFhdQIP7bfnYVZWwrgCgp7C6
inbj9TA181+ZYXoBq/UblmY=
=hKWY
-----END PGP SIGNATURE-----

