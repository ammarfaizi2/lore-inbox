Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbSJHWnp>; Tue, 8 Oct 2002 18:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbSJHWmg>; Tue, 8 Oct 2002 18:42:36 -0400
Received: from jdike.solana.com ([198.99.130.100]:31362 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S263139AbSJHWmY>;
	Tue, 8 Oct 2002 18:42:24 -0400
Message-Id: <200210082250.g98MolK18213@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML updated to 2.5.41
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 18:50:47 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org/updates-2.5

It brings UML up to date with 2.5.41.

				Jeff

 arch/um/Makefile                        |    7 ---
 arch/um/drivers/Makefile                |    3 +
 arch/um/drivers/chan_kern.c             |    4 +-
 arch/um/drivers/line.c                  |    2 -
 arch/um/drivers/mconsole_kern.c         |   11 ++---
 arch/um/drivers/net_kern.c              |   34 ++++++++++++++---
 arch/um/drivers/port_kern.c             |    2 -
 arch/um/drivers/ubd_kern.c              |   64 ++++++++++++++++----------------
 arch/um/include/2_5compat.h             |    3 -
 arch/um/include/chan_kern.h             |    2 -
 arch/um/include/kern.h                  |    1 
 arch/um/include/line.h                  |    4 +-
 arch/um/include/sysdep-ppc/sigcontext.h |    4 +-
 arch/um/include/time_user.h             |   17 ++++++++
 arch/um/include/user_util.h             |    6 ---
 arch/um/kernel/Makefile                 |   18 ++++-----
 arch/um/kernel/process.c                |    1 
 arch/um/kernel/process_kern.c           |    4 +-
 arch/um/kernel/signal_kern.c            |   20 +++++-----
 arch/um/kernel/time.c                   |   22 +++++++++++
 arch/um/kernel/time_kern.c              |    1 
 arch/um/kernel/tlb.c                    |    4 +-
 arch/um/kernel/trap_user.c              |   10 ++++-
 arch/um/ptproxy/Makefile                |   24 ++----------
 arch/um/sys-i386/Makefile               |   16 ++++----
 arch/um/util/Makefile                   |    5 +-
 include/asm-um/pgtable.h                |   20 ++++++++--
 include/asm-um/topology.h               |    6 +++

ChangeSet@1.713, 2002-10-07 23:36:31-04:00, jdike@uml.karaya.com
  Added a missing directory to the arch/um/kernel Makefile.

ChangeSet@1.712, 2002-10-07 22:43:08-04:00, jdike@uml.karaya.com
  Updates to make UML build as 2.5.41.
  Applied Oleg Drokin's task --> work patch.
  Fixed the Makefiles to accomodate the fact the kbuild doesn't cd
  into subdirectories any more.
  Got rid of some compile warnings.

ChangeSet@1.711, 2002-10-07 20:56:50-04:00, jdike@uml.karaya.com
  Updated initializers in the block driver.
  Fixed a process exit bug.

ChangeSet@1.710, 2002-10-07 20:13:55-04:00, jdike@uml.karaya.com
  Merged Al's ubd changes with mine.

ChangeSet@1.663.11.2, 2002-10-03 20:59:00-04:00, jdike@uml.karaya.com
  I forgot to add include/asm-um/topology to the repo.

ChangeSet@1.663.11.1, 2002-10-02 10:14:48-04:00, jdike@uml.karaya.com
  Small changes to bring UML up to date with 2.5.40.

ChangeSet@1.663.3.1, 2002-10-01 10:02:05-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.579.15.2, 2002-09-23 21:09:49-04:00, jdike@uml.karaya.com
  Removed from user_util.h the declarations that are now in time_user.h.

ChangeSet@1.579.15.1, 2002-09-23 20:38:01-04:00, jdike@uml.karaya.com
  A number of bug fixes from UML 2.4.19-6 -
  
  Fixed the net crash seen when slab debugging is enabled
  Fixed PROT_NONE
  Fixed the 'tracing myself' bug seen on umlcoop.  This was caused by
  a number of SIGALRM handlers nesting on the idle thread stack because
  the system was busy enough that UML couldn't clear one before the
  next arrived.

