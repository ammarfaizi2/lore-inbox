Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbSJBVNW>; Wed, 2 Oct 2002 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSJBVNV>; Wed, 2 Oct 2002 17:13:21 -0400
Received: from lab1.ISTS.dartmouth.edu ([129.170.248.130]:52865 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S262596AbSJBVMq>;
	Wed, 2 Oct 2002 17:12:46 -0400
Message-Id: <200210022120.g92LKqG26981@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Bring UML up to 2.5.40
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Oct 2002 17:20:52 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull http://jdike.stearns.org:5000/updates-2.5

It makes a number of small changes to make the 2.5.40 UML build and run -
	fixes a Makefile bug
	changes queue_task to schedule_task
	fixes some compilation buglets in the ubd driver
	changes sigcontext_struct to sigcontext
	changes sigmask_lock to sig->siglock

				Jeff

 arch/um/Makefile                        |    5 -----
 arch/um/drivers/chan_kern.c             |    2 +-
 arch/um/drivers/ubd_kern.c              |    7 ++++---
 arch/um/include/sysdep-ppc/sigcontext.h |    4 ++--
 arch/um/kernel/signal_kern.c            |   20 ++++++++++----------
 arch/um/kernel/trap_user.c              |    2 +-
 6 files changed, 18 insertions(+), 22 deletions(-)

ChangeSet@1.665, 2002-10-02 10:14:48-04:00, jdike@uml.karaya.com
  Small changes to bring UML up to date with 2.5.40.


