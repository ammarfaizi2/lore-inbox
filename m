Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSL1PgU>; Sat, 28 Dec 2002 10:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSL1PfD>; Sat, 28 Dec 2002 10:35:03 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:44804 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264842AbSL1Pew>;
	Sat, 28 Dec 2002 10:34:52 -0500
Message-Id: <200212281547.KAA02137@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update UML to 2.5.53
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 10:47:11 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/updates-2.5
or	http://jdike.stearns.org:5000/updates-2.5

This patch brings UML up to date with 2.5.53:
	build cleanups
	an updated defconfig
	bug fixes in the console and serial line drivers
	the block driver again supports partitions
	more symbols exported
	SMP fixes
	interrupt handling fixes
	hook in the new system calls
	sys_restart_syscall support

				Jeff


 arch/um/Kconfig                 |    1 +
 arch/um/drivers/line.c          |    1 +
 arch/um/kernel/process_kern.c   |    2 +-
 arch/um/kernel/signal_kern.c    |    8 ++++++++
 arch/um/kernel/sys_call_table.c |   19 ++++++++++---------
 arch/um/kernel/syscall_kern.c   |   12 ++++++++----
 arch/um/kernel/sysrq.c          |    8 ++++----
 arch/um/sys-i386/Makefile       |   36 +++++++++++++++++-------------------
 arch/um/uml.lds.S               |   12 +++++++++++-
 include/asm-um/pgtable.h        |    6 +++---
 include/asm-um/thread_info.h    |   10 ++++------
 include/asm-um/uaccess.h        |    2 +-
 12 files changed, 69 insertions(+), 48 deletions(-)

ChangeSet@1.865.21.4, 2002-12-17 02:28:31-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.865.21.3, 2002-12-17 02:22:54-05:00, jdike@uml.karaya.com
  Updated to 2.5.52.  A couple of changes relating to system call
  restarting.

ChangeSet@1.865.25.1, 2002-12-17 01:34:58-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/updates-2.5

ChangeSet@1.865.21.2, 2002-12-17 00:44:15-05:00, jdike@uml.karaya.com
  Applied updates from 2.5.51 and 2.5.52.

ChangeSet@1.865.21.1, 2002-12-16 15:16:49-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.797.179.3, 2002-12-06 21:29:24-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.797.179.2, 2002-12-06 21:23:55-05:00, jdike@uml.karaya.com
  Updated to 2.5.50.

ChangeSet@1.797.201.1, 2002-12-06 19:15:18-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/updates-2.5

ChangeSet@1.797.179.1, 2002-11-30 14:18:23-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.797.137.2, 2002-11-23 19:25:48-05:00, jdike@uml.karaya.com
  Updated to 2.5.49, which involved fixing the calls to do_fork.

ChangeSet@1.797.71.4, 2002-11-21 23:21:41-05:00, jdike@uml.karaya.com
  Removed the checksum.S symlink from arch/um/sys-i386/Makefile.

ChangeSet@1.797.71.3, 2002-11-21 14:05:13-05:00, jdike@uml.karaya.com
  Changed the config to pull in zlib.

ChangeSet@1.797.71.2, 2002-11-18 20:03:13-05:00, jdike@uml.karaya.com
  A few more fixes to get 2.4.48 to boot.

ChangeSet@1.797.71.1, 2002-11-18 15:57:00-05:00, jdike@uml.karaya.com
  Updated to 2.5.48


