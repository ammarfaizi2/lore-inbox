Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbTBCFUC>; Mon, 3 Feb 2003 00:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbTBCFUC>; Mon, 3 Feb 2003 00:20:02 -0500
Received: from zok.sgi.com ([204.94.215.101]:3995 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S265898AbTBCFUA>;
	Mon, 3 Feb 2003 00:20:00 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Announce: kdb v3.0 is available for kernel 2.4.20
Date: Mon, 03 Feb 2003 16:28:02 +1100
Message-ID: <32006.1044250082@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v3.0/

  kdb-v3.0-2.4.20-common-1.bz2
  kdb-v3.0-2.4.20-i386-1.bz2
  kdb-v3.0-2.4.20-ia64-021210-1.bz2

Changelog extracts since v2.5-2.4.20.  A special thanks goes to Sonic
Zhang for adding command history and editing to kdb, and pestering me
until I found time to accept it.

2.4.20-common-1

2003-02-03 Keith Owens  <kaos@sgi.com>

	* Register kdb commands early.
	* Decode oops via kallsyms if it is available.
	* Update copyright notices to 2003.
	* Add defcmd/endefcmd to allow users to package their own macros.
	* kdb commands that fail are ignored when prefixed with '-'.
	* Add selection options to bta command.
	* Add btc command (switch to each cpu and backtrace).
	* Do real time detection of dead cpus.
	* Clear ip adjusted flag when leaving kdb.
	* Clean up ps command.
	* Print ps output for each task when backtracing.
	* Bump to version v3.0 to reduce confusion between kdb and kernel
	  version numbers.
	* Add kdba_local_arch_setup/kdba_local_arch_cleanup to correct
	  keyboard freeze.  Ashish Kalra.
	* Refuse multiple breakpoints at the same address.
	* Add fl (file_lock) command, from XFS development tree.
	* Correct inode_pages, from XFS development tree.
	* Add command history and editing.  Sonic Zhang.
	* Extend command history and editing to handle vt100 escape sequences.
	* Allow tab completion at start of line.
	* Touch nmi watchdog on long running bta and btc commands.
	* Clean up ps output and standardize with bta codes.
	* Correctly handle escaped characters in commands.
	* Update man pages for btc and command history/editing.
	* kdb v3.0-2.4.20-common-1.

2.4.20-i386-1

2003-02-03 Keith Owens  <kaos@sgi.com>

	* Register kdb commands early.
	* Handle KDB_ENTER() when kdb=off.
	* Optimize __kdba_getarea_size when width is a constant.
	* Decode oops via kallsyms if it is available.
	* Update copyright notices to 2003.
	* Handle call *disp32(%reg) in backtrace.
	* Correct keyboard freeze.  Ashish Kalra.
	* Add command history and editing.  Sonic Zhang.
	* kdb_toggleled is conditional on KDB_BLINK_LED.  Bernhard Fischer.
	* Allow tab on serial line for symbol completion.
	* Ignore KDB_ENTER() when kdb is already running.
	* kdb v3.0-2.4.20-i386-1.

2.4.20-ia64-021210-1

2003-02-03 Keith Owens  <kaos@sgi.com>

	* Register kdb commands early.
	* Handle KDB_ENTER() when kdb=off.
	* Optimize __kdba_getarea_size when width is a constant.
	* Decode oops via kallsyms if it is available.
	* Update copyright notices to 2003.
	* Add commands to dump struct pt_regs and switch_stack.
	* Handle padding from unw_init_running for switch_stack.
	* Add dummy kdba_local_arch_setup/kdba_local_arch_cleanup.
	* Warning for pod mode.
	* Add command history and editing.  Sonic Zhang.
	* kdb_toggleled is conditional on KDB_BLINK_LED.  Bernhard Fischer.
	* Allow tab on serial line for symbol completion.
	* Ignore KDB_ENTER() when kdb is already running.
	* kdb v3.0-2.4.20-ia64-021210-1.


v3.0/README

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

For example, to use kdb for i386 on kernel 2.4.20, apply
  kdb-v3.0-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v3.0-2.4.20-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64-021210 on kernel 2.4.20, apply
  kdb-v3.0-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v3.0-2.4.20-ia64-021210-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE+Pf3fi4UHNye0ZOoRAsr0AJoCXacxDmlrp779EpIZ8kYLnDz9bQCgxqa7
fLFWChCxxjJomc4sl00s+uo=
=ZdNo
-----END PGP SIGNATURE-----

