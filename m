Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSL1Pev>; Sat, 28 Dec 2002 10:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSL1Pev>; Sat, 28 Dec 2002 10:34:51 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:44292 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S264799AbSL1Pet>;
	Sat, 28 Dec 2002 10:34:49 -0500
Message-Id: <200212281547.KAA02101@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Miscellaneous UML bug fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 10:47:06 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/fixes-2.5
or	http://jdike.stearns.org:5000/fixes-2.5

This update fixes a number of small bugs:
	strtoul calls are checked such that an empty string doesn't look like
zero
	fixed some ubd driver error checking
	a host helper is searched for if it's not in its usual location
	fixed a check for an irq being disabled

				Jeff


 arch/um/Makefile                |    4 ----
 arch/um/boot/Makefile           |    3 ---
 arch/um/drivers/fd.c            |    2 +-
 arch/um/drivers/mcast_kern.c    |    4 ++--
 arch/um/drivers/port_kern.c     |   22 +++++++++++-----------
 arch/um/drivers/port_user.c     |   38 +-------------------------------------
 arch/um/drivers/ubd_kern.c      |    9 ++++++---
 arch/um/drivers/ubd_user.c      |    2 ++
 arch/um/drivers/xterm.c         |    3 +++
 arch/um/drivers/xterm_kern.c    |    6 ++++--
 arch/um/kernel/exitcode.c       |    2 +-
 arch/um/kernel/helper.c         |    5 ++++-
 arch/um/kernel/irq_user.c       |    4 +++-
 arch/um/kernel/setup.c          |   20 --------------------
 arch/um/kernel/tempfile.c       |    3 ++-
 arch/um/kernel/tty_log.c        |    2 +-
 arch/um/os-Linux/file.c         |    4 +++-
 include/asm-um/system-generic.h |    1 +
 18 files changed, 45 insertions(+), 89 deletions(-)

ChangeSet@1.865.25.3, 2002-12-26 21:34:55-05:00, jdike@uml.karaya.com
  Fixed the calls to os_get_process in port_kern.c

ChangeSet@1.865.25.2, 2002-12-26 21:09:25-05:00, jdike@uml.karaya.com
  Forward ported a bunch of fixes from 2.4.

ChangeSet@1.797.78.1, 2002-11-18 21:53:20-05:00, jdike@uml.karaya.com
  Merged a number of bug fixes from the 2.4 pool.


