Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268852AbTBZSD3>; Wed, 26 Feb 2003 13:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268851AbTBZSC2>; Wed, 26 Feb 2003 13:02:28 -0500
Received: from dhcp63.ists.dartmouth.edu ([129.170.249.163]:10881 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S268850AbTBZSCX>;
	Wed, 26 Feb 2003 13:02:23 -0500
Message-Id: <200302261816.h1QIG7r11230@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updates 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Feb 2003 13:16:07 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

This updates UML to 2.5.63 -
	fixed the sigprocmask name clash with libc
	updated ptrace
	fixed UML's module.h
	cleaned up page.h and bug.h
	updated the signal handling
	added the new clock and timer syscalls
	fixed some build breakage

				Jeff

 arch/um/Makefile                   |    6 ++++--
 arch/um/drivers/Makefile           |    2 +-
 arch/um/drivers/xterm_kern.c       |    1 +
 arch/um/kernel/init_task.c         |    1 +
 arch/um/kernel/ptrace.c            |    7 ++-----
 arch/um/kernel/sigio_kern.c        |    1 +
 arch/um/kernel/signal_kern.c       |    4 ++--
 arch/um/kernel/smp.c               |   36 +++++++++++++++++++++++-------------
 arch/um/kernel/sys_call_table.c    |   18 ++++++++++++++++++
 arch/um/kernel/tt/process_kern.c   |    5 ++++-
 include/asm-um/bug.h               |    4 ++--
 include/asm-um/module-generic.h    |    6 ++++++
 include/asm-um/module-i386.h       |   13 +++++++++++++
 include/asm-um/module.h            |   13 -------------
 include/asm-um/page.h              |    1 -
 include/asm-um/processor-generic.h |    1 -
 include/asm-um/thread_info.h       |    3 +++
 17 files changed, 81 insertions(+), 41 deletions(-)

ChangeSet@1.914.185.4, 2003-02-25 00:24:29-05:00, jdike@uml.karaya.com
  Added declarations for the new system calls and fixed the includes
  of asm/signal.h.

ChangeSet@1.914.185.3, 2003-02-24 23:00:04-05:00, jdike@uml.karaya.com
  Updated to 2.5.63 and made a minor build cleanup.

ChangeSet@1.914.185.2, 2003-02-23 14:49:44-05:00, jdike@uml.karaya.com
  Applied some minor updates to fix things that broke in .62.

ChangeSet@1.914.185.1, 2003-02-19 09:50:28-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.914.131.3, 2003-02-18 17:50:30-05:00, jdike@uml.karaya.com
  Copied a ptrace change from i386.

ChangeSet@1.914.131.2, 2003-02-18 16:39:59-05:00, jdike@uml.karaya.com
  Changed the kernel sigprocmask to kernel_sigprocmask to avoid a
  conflict with libc.

ChangeSet@1.914.131.1, 2003-02-12 09:40:44-05:00, jdike@uml.karaya.com
  Applied a bunch of patches from Oleg to get UML working in 2.5.60
  and to clean up some other things.
