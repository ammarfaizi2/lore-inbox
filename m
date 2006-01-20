Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161421AbWATC4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWATC4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWATCzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:46 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:40685
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161428AbWATCzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:14 -0500
Message-Id: <20060120021343.135710000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:51 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/7] [hrtimers] Add back lost credit lines
Content-Disposition: inline;
	filename=0006-hrtimers-Add-back-lost-credit-lines.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At some point we added credits to people who actively helped
to bring k/hr-timers along. This was lost in the big code
revamp. Add it back.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

---

 include/linux/ktime.h |    6 ++++++
 kernel/hrtimer.c      |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

4b2719dcb1143a18de16162f2562045e40487e49
diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 1bd6552..6aca67a 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -10,6 +10,12 @@
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
  *
+ *  Credits:
+ *
+ *  	Roman Zippel provided the ideas and primary code snippets of
+ *  	the ktime_t union and further simplifications of the original
+ *  	code.
+ *
  *  For licencing details see kernel-base/COPYING
  */
 #ifndef _LINUX_KTIME_H
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index efff949..2b6e175 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -21,6 +21,12 @@
  *  Credits:
  *	based on kernel/timer.c
  *
+ *	Help, testing, suggestions, bugfixes, improvements were
+ *	provided by:
+ *
+ *	George Anzinger, Andrew Morton, Steven Rostedt, Roman Zippel
+ *	et. al.
+ *
  *  For licencing details see kernel-base/COPYING
  */
 
-- 
1.0.8

--

