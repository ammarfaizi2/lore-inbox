Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUKFJkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUKFJkX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUKFJkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:40:23 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:25234 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261347AbUKFJkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:40:04 -0500
Message-ID: <418C9BE8.6060401@kolivas.org>
Date: Sat, 06 Nov 2004 20:39:52 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] sched.c whitespace mangler
References: <20041105001328.3ba97e08.akpm@osdl.org>
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBE997358F99F1AC412CBAE49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE997358F99F1AC412CBAE49
Content-Type: multipart/mixed;
 boundary="------------010405040507020007060104"

This is a multi-part message in MIME format.
--------------010405040507020007060104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attack of the whitespace mangler in sched.c. Convert spaces to tabs.



--------------010405040507020007060104
Content-Type: text/x-patch;
 name="fix_whitespace.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_whitespace.diff"

Convert whitespace in sched.c to tabs

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm3/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm3.orig/kernel/sched.c	2004-11-06 20:31:29.383223089 +1100
+++ linux-2.6.10-rc1-mm3/kernel/sched.c	2004-11-06 20:34:55.658218461 +1100
@@ -1138,7 +1138,7 @@ out:
 int fastcall wake_up_process(task_t * p)
 {
 	return try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
-		       		 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
+				 TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
 EXPORT_SYMBOL(wake_up_process);
@@ -2019,7 +2019,7 @@ static int load_balance(int this_cpu, ru
 		if (sd->balance_interval < sd->max_interval)
 			sd->balance_interval++;
 	} else {
-                sd->nr_balance_failed = 0;
+		sd->nr_balance_failed = 0;
 
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
@@ -3148,7 +3148,7 @@ EXPORT_SYMBOL(set_user_nice);
 #ifdef CONFIG_KGDB
 struct task_struct *kgdb_get_idle(int this_cpu)
 {
-        return cpu_rq(this_cpu)->idle;
+	return cpu_rq(this_cpu)->idle;
 }
 #endif
 
@@ -4992,30 +4992,30 @@ void destroy_sched_domain_sysctl()
 #ifdef CONFIG_MAGIC_SYSRQ
 void normalize_rt_tasks(void)
 {
-       struct task_struct *p;
-       prio_array_t *array;
-       unsigned long flags;
-       runqueue_t *rq;
-
-       read_lock_irq(&tasklist_lock);
-       for_each_process (p) {
-               if (!rt_task(p))
-                       continue;
-
-               rq = task_rq_lock(p, &flags);
-
-               array = p->array;
-               if (array)
-                       deactivate_task(p, task_rq(p));
-               __setscheduler(p, SCHED_NORMAL, 0);
-               if (array) {
-                       __activate_task(p, task_rq(p));
-                       resched_task(rq->curr);
-               }
-
-               task_rq_unlock(rq, &flags);
-       }
-       read_unlock_irq(&tasklist_lock);
+	struct task_struct *p;
+	prio_array_t *array;
+	unsigned long flags;
+	runqueue_t *rq;
+
+	read_lock_irq(&tasklist_lock);
+	for_each_process (p) {
+		if (!rt_task(p))
+			continue;
+
+		rq = task_rq_lock(p, &flags);
+
+		array = p->array;
+		if (array)
+			deactivate_task(p, task_rq(p));
+		__setscheduler(p, SCHED_NORMAL, 0);
+		if (array) {
+			__activate_task(p, task_rq(p));
+			resched_task(rq->curr);
+		}
+
+		task_rq_unlock(rq, &flags);
+	}
+	read_unlock_irq(&tasklist_lock);
 }
 
 EXPORT_SYMBOL(normalize_rt_tasks);


--------------010405040507020007060104--

--------------enigBE997358F99F1AC412CBAE49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFBjJvqZUg7+tp6mRURAui1AJilu+sbwXqumNXPqQ1NlUrdSnmPAJ9sKxHg
BadgYnjv9tO2JFXWbyAHBA==
=debk
-----END PGP SIGNATURE-----

--------------enigBE997358F99F1AC412CBAE49--
