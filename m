Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWJRFxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWJRFxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 01:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWJRFxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 01:53:50 -0400
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:43967 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751409AbWJRFxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 01:53:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:User-Agent;
  b=kpHxpyaJ/S9JlhdIgKbplX1MUNOvdv9iPZxOHdgqxi7pj5wuJinjE1W6688qPsbW5h8zhPBe7NWtDxOBVVFzK3BYaWiodGZldjtuBhkcvlHQ6vnRSIMqMBl3xNDMSEkOGKpk7+Jm7bhLP+G29ht/uojfyZwfbVuHiQ8EzzDD8aI=  ;
Date: Tue, 17 Oct 2006 06:46:07 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: mingo@elte.hu
Cc: lkml <linux-kernel@vger.kernel.org>, trivial@kernel.org
Subject: readjust comments of task_timeslice for kernel doc
Message-ID: <20061017044607.GA3991@zmei.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: <petkov@math.uni-muenster.de>


--- 19-rc2/kernel/sched.c	2006-10-14 08:17:59.000000000 +0200
+++ 19-rc2/kernel/sched.c.new	2006-10-17 06:34:53.000000000 +0200
@@ -160,15 +160,6 @@
 #define TASK_PREEMPTS_CURR(p, rq) \
 	((p)->prio < (rq)->curr->prio)
 
-/*
- * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
- * to time slice values: [800ms ... 100ms ... 5ms]
- *
- * The higher a thread's priority, the bigger timeslices
- * it gets during one round of execution. But even the lowest
- * priority thread gets MIN_TIMESLICE worth of execution time.
- */
-
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO / 2), MIN_TIMESLICE)
 
@@ -180,6 +171,15 @@ static unsigned int static_prio_timeslic
 		return SCALE_PRIO(DEF_TIMESLICE, static_prio);
 }
 
+/*
+ * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
+ * to time slice values: [800ms ... 100ms ... 5ms]
+ *
+ * The higher a thread's priority, the bigger timeslices
+ * it gets during one round of execution. But even the lowest
+ * priority thread gets MIN_TIMESLICE worth of execution time.
+ */
+
 static inline unsigned int task_timeslice(struct task_struct *p)
 {
 	return static_prio_timeslice(p->static_prio);

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
