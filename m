Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275384AbTHGO7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275362AbTHGO5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:57:24 -0400
Received: from dhcp75.ists.dartmouth.edu ([129.170.249.155]:49280 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S275384AbTHGOy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:54:58 -0400
Message-Id: <200308071459.h77ExAf9001975@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@odsl.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Aug 2003 10:59:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This update fixes a number of UML bugs.

				Jeff

 arch/um/drivers/chan_kern.c           |    1 
 arch/um/drivers/chan_user.c           |    4 -
 arch/um/drivers/hostaudio_kern.c      |   77 +++++++++++++++++++++++++++++++---
 arch/um/drivers/mconsole_kern.c       |   26 +++++------
 arch/um/drivers/ubd_user.c            |   50 +++++++++++++---------
 arch/um/include/kern_util.h           |    7 +--
 arch/um/include/mem.h                 |    1 
 arch/um/include/os.h                  |    2 
 arch/um/include/user_util.h           |    1 
 arch/um/kernel/mem.c                  |   11 +---
 arch/um/kernel/mem_user.c             |   10 ++--
 arch/um/kernel/process.c              |    4 -
 arch/um/kernel/process_kern.c         |    7 ++-
 arch/um/kernel/skas/include/mode.h    |    1 
 arch/um/kernel/skas/include/uaccess.h |    2 
 arch/um/kernel/skas/process.c         |   16 ++++++-
 arch/um/kernel/skas/process_kern.c    |   12 ++---
 arch/um/kernel/skas/util/mk_ptregs.c  |    1 
 arch/um/kernel/time.c                 |   12 +++--
 arch/um/kernel/time_kern.c            |    2 
 arch/um/kernel/trap_kern.c            |    6 ++
 arch/um/kernel/trap_user.c            |    2 
 arch/um/kernel/tt/include/uaccess.h   |   31 +++++++------
 arch/um/kernel/tt/process_kern.c      |   37 +++++++---------
 arch/um/kernel/tt/ptproxy/proxy.c     |    8 +--
 arch/um/kernel/tt/tracer.c            |    4 -
 arch/um/kernel/tt/uaccess_user.c      |   14 ++++++
 arch/um/kernel/um_arch.c              |   19 +++++---
 arch/um/kernel/umid.c                 |   47 +++++++++++---------
 arch/um/kernel/user_util.c            |   11 ----
 arch/um/os-Linux/file.c               |   31 +++++++++++++
 arch/um/util/mk_constants_kern.c      |    4 +
 32 files changed, 310 insertions(+), 151 deletions(-)

ChangeSet@1.1455.16.1, 2003-07-25 01:23:07-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.6.0-test1
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.1310.128.2, 2003-07-23 23:41:57-04:00, jdike@uml.karaya.com
  Fixed the NSEC_PER_SEC problem, which was that this was a kernel
  constant in a userspace file, by adding it to mk_constants, and
  including that in time.h.

ChangeSet@1.1310.128.1, 2003-07-18 13:22:14-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5.72
  into uml.karaya.com:/home/jdike/linux/2.5/fixes-2.5

ChangeSet@1.1215.148.1, 2003-07-17 10:28:18-04:00, jdike@uml.karaya.com
  Untangling my repositories - this adds the fixes that came over from
  the 2.4 pool.

