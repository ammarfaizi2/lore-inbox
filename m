Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSGYUXv>; Thu, 25 Jul 2002 16:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGYUXv>; Thu, 25 Jul 2002 16:23:51 -0400
Received: from 12-225-96-71.client.attbi.com ([12.225.96.71]:31361 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S316185AbSGYUXv>;
	Thu, 25 Jul 2002 16:23:51 -0400
Date: Thu, 25 Jul 2002 13:26:55 -0700
From: Jerry Cooperstein <coop@axian.com>
To: trivial@rustcorp.com.au, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Trivial Patch to sched.h for wake_up_interruptible_sync_nr
Message-ID: <20020725132655.A10660@p3.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This is gone in 2.5, but it is not right for 2.4. 
No one seems to use it, but suppose someone does.

--- linux-2.4.19-rc3/include/linux/sched.h	Mon Jul 22 08:04:48 2002
+++ sched.h	Thu Jul 25 13:10:45 2002
@@ -611,7 +611,7 @@
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define wake_up_interruptible_sync(x)	__wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
-#define wake_up_interruptible_sync_nr(x) __wake_up_sync((x),TASK_INTERRUPTIBLE,  nr)
+#define wake_up_interruptible_sync_nr(x, nr) __wake_up_sync((x),TASK_INTERRUPTIBLE,  nr)
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);


======================================================================
 Jerry Cooperstein,  <coop@axian.com>
 Axian, Inc. Software Consulting and Training
 Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================
