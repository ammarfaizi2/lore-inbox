Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbTC1UlG>; Fri, 28 Mar 2003 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263140AbTC1UlG>; Fri, 28 Mar 2003 15:41:06 -0500
Received: from mnh-1-18.mv.com ([207.22.10.50]:50437 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263139AbTC1UlC>;
	Fri, 28 Mar 2003 15:41:02 -0500
Message-Id: <200303282050.PAA03174@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Mar 2003 15:50:37 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

This brings UML up to date with 2.5.66:
	added the pte_file changes
	fixed show_interrupts
	added the console initialization section to the linker scripts
	include cleanups
	new system calls hooked up
	fixed the sigprocmask name conflict

				Jeff

 arch/um/Makefile                   |    6 ++-
 arch/um/drivers/Makefile           |    2 -
 arch/um/drivers/chan_kern.c        |    1 
 arch/um/drivers/stdio_console.c    |    4 +-
 arch/um/drivers/xterm_kern.c       |    1 
 arch/um/kernel/init_task.c         |    9 -----
 arch/um/kernel/irq.c               |   63 ++++++++++++++-----------------------
 arch/um/kernel/process_kern.c      |    4 ++
 arch/um/kernel/ptrace.c            |    7 +---
 arch/um/kernel/sigio_kern.c        |    1 
 arch/um/kernel/signal_kern.c       |    4 +-
 arch/um/kernel/smp.c               |   36 +++++++++++++--------
 arch/um/kernel/sys_call_table.c    |   18 ++++++++++
 arch/um/kernel/tt/process_kern.c   |    5 ++
 include/asm-um/bug.h               |    4 +-
 include/asm-um/common.lds.S        |    4 ++
 include/asm-um/module-generic.h    |    6 +++
 include/asm-um/module-i386.h       |   13 +++++++
 include/asm-um/module.h            |   13 -------
 include/asm-um/page.h              |    1 
 include/asm-um/pgtable.h           |   59 +++++++++++++++++++++++++++-------
 include/asm-um/processor-generic.h |    4 --
 include/asm-um/thread_info.h       |    3 +
 23 files changed, 165 insertions(+), 103 deletions(-)

ChangeSet@1.1079, 2003-03-27 21:38:37-05:00, jdike@uml.karaya.com
  2.5.66 updates to irq.c and pgtable.h.

ChangeSet@1.889.363.3, 2003-03-27 13:46:11-05:00, jdike@uml.karaya.com
  Some small changes to get 2.5.65 working.

ChangeSet@1.889.363.2, 2003-03-27 10:28:06-05:00, jdike@uml.karaya.com
  Added the con_initcall section to common.lds.S.

ChangeSet@1.889.289.3, 2003-03-07 12:36:29-05:00, jdike@uml.karaya.com
  Added a bunch of include fixes from Oleg.

ChangeSet@1.889.291.2, 2003-03-05 12:47:32-05:00, jdike@uml.karaya.com
  Deleted free_task_struct since it is implemented in fork.c now.

ChangeSet@1.889.203.4, 2003-02-25 00:24:29-05:00, jdike@uml.karaya.com
  Added declarations for the new system calls and fixed the includes
  of asm/signal.h.

ChangeSet@1.889.203.3, 2003-02-24 23:00:04-05:00, jdike@uml.karaya.com
  Updated to 2.5.63 and made a minor build cleanup.

ChangeSet@1.889.203.2, 2003-02-23 14:49:44-05:00, jdike@uml.karaya.com
  Applied some minor updates to fix things that broke in .62.

ChangeSet@1.889.203.1, 2003-02-19 09:50:28-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.889.138.3, 2003-02-18 17:50:30-05:00, jdike@uml.karaya.com
  Copied a ptrace change from i386.

ChangeSet@1.889.138.2, 2003-02-18 16:39:59-05:00, jdike@uml.karaya.com
  Changed the kernel sigprocmask to kernel_sigprocmask to avoid a
  conflict with libc.

ChangeSet@1.889.138.1, 2003-02-12 09:40:44-05:00, jdike@uml.karaya.com
  Applied a bunch of patches from Oleg to get UML working in 2.5.60
  and to clean up some other things.




