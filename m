Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTIPAwg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTIPAwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:52:36 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:41100
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261732AbTIPAwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:52:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]O20.3int
Date: Tue, 16 Sep 2003 11:00:44 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8CmZ/Be3ZG9BQv1"
Message-Id: <200309161100.44312.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_8CmZ/Be3ZG9BQv1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yep I really hate doing this, sorry. This is what I was supposed to do in 
O20.2int.

applies to O20.2int

Con

--Boundary-00=_8CmZ/Be3ZG9BQv1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O20.2-O20.3int"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="patch-O20.2-O20.3int"

--- linux-2.6.0-test5-mm2-O20.2/kernel/sched.c	2003-09-16 09:27:57.000000000 +1000
+++ linux-2.6.0-test5-mm2-O20.3/kernel/sched.c	2003-09-16 10:50:49.000000000 +1000
@@ -1426,11 +1426,11 @@ void scheduler_tick(int user_ticks, int 
 		 * equal priority.
 		 *
 		 * This only applies to tasks in the interactive
-		 * delta range with at least MIN_TIMESLICE to requeue.
+		 * delta range with at least TIMESLICE_GRANULARITY to requeue.
 		 */
 		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
 			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
-			(p->time_slice >= MIN_TIMESLICE) &&
+			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
 			(p->array == rq->active)) {
 
 			dequeue_task(p, rq->active);

--Boundary-00=_8CmZ/Be3ZG9BQv1--

