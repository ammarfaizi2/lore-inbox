Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSKSEJD>; Mon, 18 Nov 2002 23:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbSKSEJD>; Mon, 18 Nov 2002 23:09:03 -0500
Received: from mnh-1-10.mv.com ([207.22.10.42]:27653 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267038AbSKSEJB>;
	Mon, 18 Nov 2002 23:09:01 -0500
Message-Id: <200211190420.XAA06477@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Miscellaneous UML bug fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Nov 2002 23:20:19 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fixes-2.5

This update fixes a number of small bugs:
	strtoul calls are checked such that an empty string doesn't look like
zero
	fixed some ubd driver error checking
	a host helper is searched for if it's not in its usual location
	fixed a check for an irq being disabled

				Jeff

 arch/um/drivers/fd.c            |    2 +-
 arch/um/drivers/mcast_kern.c    |    4 ++--
 arch/um/drivers/port_user.c     |    2 +-
 arch/um/drivers/ubd_kern.c      |    9 ++++++---
 arch/um/drivers/xterm.c         |    3 +++
 arch/um/kernel/exitcode.c       |    2 +-
 arch/um/kernel/helper.c         |    5 ++++-
 arch/um/kernel/irq_user.c       |    3 ++-
 arch/um/kernel/tty_log.c        |    2 +-
 arch/um/os-Linux/file.c         |    3 ++-
 include/asm-um/system-generic.h |    1 +
 11 files changed, 24 insertions(+), 12 deletions(-)

ChangeSet@1.843, 2002-11-18 21:53:20-05:00, jdike@uml.karaya.com
  Merged a number of bug fixes from the 2.4 pool.


