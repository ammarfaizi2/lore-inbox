Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbUBQBxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 20:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265754AbUBQBxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 20:53:33 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:24361 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265714AbUBQBxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 20:53:22 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.3 is available for kernel 2.6.3-rc3
Date: Tue, 17 Feb 2004 12:53:06 +1100
Message-ID: <4682.1076982786@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v4.3/

With many thanks to Jim Houston and Xavier Bru.

Current versions are :-
  kdb-v4.3-2.6.3-rc3-common-1.bz2
  kdb-v4.3-2.6.3-rc3-i386-1.bz2
  kdb-v4.3-2.6.3-rc3-ia64-1.bz2

Warning: the 2.6 versions of kdb have had minimal testing.  In
particular they have not been tested with CONFIG_PREEMPT.


Changelog extracts.

common

2004-02-17 Keith Owens  <kaos@sgi.com>

	* Convert longjmp buffers from static to dynamic allocation, for large
	  cpu counts.
	* Tweak kdbm_task for SMP/UP.
	* Reconcile with kdb-v4.3 2.4.25-rc1-common-1.
	* Simplify coexistence with NPTL patches.
	* Support kill command on new scheduler.
	* Do not refetch data when printing a value as characters.
	* Document the pid command.
	* Work around 2.6 kallsyms 'feature'.
	* Upgrade to 2.6.3-rc3.
	* WAR for incorrect console registration patch.
	* kdb v4.3-2.6.3-rc3-common-1.

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

2003-09-08 Xavier Bru   <xavier.bru@bull.net>
	* Merge to 2.6.0-test4

2003-07-10 Xavier Bru   <xavier.bru@bull.net>

	* Merge kdb v4.3 to 2.5.72 ia64
	* don't call local_bh_enable() with interrupts masked.

2003-04-07 Xavier Bru   <xavier.bru@bull.net>

	* Merge kdb v4.1 to 2.5.64 ia64
	* new kernel parameters support
	* new module format
	* new kallsyms support


i386

2004-02-17 Keith Owens  <kaos@sgi.com>

	* Pick up changes from Jim Houston for 2.6.
	* Sync with kdb v4.3-2.4.25-rc1-i386-1.
	* Adjust for LDT changes in i386 mainline.
	* Convert longjmp buffers from static to dynamic allocation, for large
	  cpu counts.
	* Do not use USB keyboard if it has not been probed.
	* Do not print section data, 2.6 kallsyms does not support sections :(.
	* kdb v4.3-2.6-3-rc3-i386-1.


ia64

2004-02-17 Keith Owens  <kaos@sgi.com>

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
	* Reconcile with mca changes.
	* Upgrade to 2.6.3-rc3.
	* kdb v4.3-2.6.3-rc3-ia64-1.

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

iD8DBQFAMXQCi4UHNye0ZOoRAmBhAKCg5ahf+x0tNsslcqWOJIqavlcWGwCfeWk6
wu810CJxeBDAsrYw/GNLSCc=
=YZLB
-----END PGP SIGNATURE-----

