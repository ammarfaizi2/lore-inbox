Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbSLQXPC>; Tue, 17 Dec 2002 18:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbSLQXOT>; Tue, 17 Dec 2002 18:14:19 -0500
Received: from jdike.solana.com ([198.99.130.100]:64640 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S267029AbSLQXNR>;
	Tue, 17 Dec 2002 18:13:17 -0500
Message-Id: <200212172323.gBHNNwF03265@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update UML to 2.5.52
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Dec 2002 18:23:58 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

This patch brings UML up to date with 2.5.52:
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

ChangeSet@1.985, 2002-12-17 02:28:31-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.984, 2002-12-17 02:22:54-05:00, jdike@uml.karaya.com
  Updated to 2.5.52.  A couple of changes relating to system call
  restarting.

ChangeSet@1.981.1.1, 2002-12-17 01:34:58-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/updates-2.5

ChangeSet@1.983, 2002-12-17 00:44:15-05:00, jdike@uml.karaya.com
  Applied updates from 2.5.51 and 2.5.52.

ChangeSet@1.982, 2002-12-16 15:16:49-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.797.173.3, 2002-12-06 21:29:24-05:00, jdike@uml.karaya.com
  Merge jdike.stearns.org:linux/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.797.173.2, 2002-12-06 21:23:55-05:00, jdike@uml.karaya.com
  Updated to 2.5.50.

ChangeSet@1.797.193.1, 2002-12-06 19:15:18-05:00, jdike@jdike.wstearns.org
  Merge jdike.wstearns.org:/home/jdike/linux/linus-2.5
  into jdike.wstearns.org:/home/jdike/linux/updates-2.5

ChangeSet@1.797.173.1, 2002-11-30 14:18:23-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.797.132.2, 2002-11-23 19:25:48-05:00, jdike@uml.karaya.com
  Updated to 2.5.49, which involved fixing the calls to do_fork.

ChangeSet@1.797.71.4, 2002-11-21 23:21:41-05:00, jdike@uml.karaya.com
  Removed the checksum.S symlink from arch/um/sys-i386/Makefile.

ChangeSet@1.797.71.3, 2002-11-21 14:05:13-05:00, jdike@uml.karaya.com
  Changed the config to pull in zlib.

ChangeSet@1.797.71.2, 2002-11-18 20:03:13-05:00, jdike@uml.karaya.com
  A few more fixes to get 2.4.48 to boot.

ChangeSet@1.797.71.1, 2002-11-18 15:57:00-05:00, jdike@uml.karaya.com
  Updated to 2.5.48


