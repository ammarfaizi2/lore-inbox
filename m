Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTBSTrQ>; Wed, 19 Feb 2003 14:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTBSTrQ>; Wed, 19 Feb 2003 14:47:16 -0500
Received: from dhcp43.ists.dartmouth.edu ([129.170.249.143]:36737 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S263991AbTBSTrP>;
	Wed, 19 Feb 2003 14:47:15 -0500
Message-Id: <200302192000.h1JK0dQ16431@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Feb 2003 15:00:39 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/updates-2.5

This updates UML to 2.5.62 -
	fixed the sigprocmask name clash with libc
	updated ptrace
	fixed UML's module.h
	cleaned up page.h and bug.h
	updated the signal handling

				Jeff

 arch/um/Makefile                |    6 ++++--
 arch/um/kernel/init_task.c      |    1 +
 arch/um/kernel/ptrace.c         |    7 ++-----
 arch/um/kernel/signal_kern.c    |    4 ++--
 include/asm-um/bug.h            |    4 ++--
 include/asm-um/module-generic.h |    6 ++++++
 include/asm-um/module-i386.h    |   13 +++++++++++++
 include/asm-um/module.h         |   13 -------------
 include/asm-um/page.h           |    1 -
 include/asm-um/thread_info.h    |    2 ++
 10 files changed, 32 insertions(+), 25 deletions(-)

ChangeSet@1.1065, 2003-02-19 09:50:28-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/updates-2.5

ChangeSet@1.988.17.3, 2003-02-18 17:50:30-05:00, jdike@uml.karaya.com
  Copied a ptrace change from i386.

ChangeSet@1.988.17.2, 2003-02-18 16:39:59-05:00, jdike@uml.karaya.com
  Changed the kernel sigprocmask to kernel_sigprocmask to avoid a
  conflict with libc.

ChangeSet@1.988.17.1, 2003-02-12 09:40:44-05:00, jdike@uml.karaya.com
  Applied a bunch of patches from Oleg to get UML working in 2.5.60
  and to clean up some other things.
