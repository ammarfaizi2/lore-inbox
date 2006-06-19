Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWFSUU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWFSUU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWFSUUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:20:06 -0400
Received: from xenotime.net ([66.160.160.81]:39107 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750756AbWFSUUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:20:02 -0400
Date: Mon, 19 Jun 2006 13:09:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tglx@linutronix.de, mingo@elte.hr
Subject: [PATCH] ktime/hrtimer: fix kernel-doc comments
Message-Id: <20060619130948.6ea3998c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc formatting in ktime.h and hrtimer.[ch] files.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/hrtimer.h |    3 ---
 include/linux/ktime.h   |    8 --------
 kernel/hrtimer.c        |   11 +----------
 3 files changed, 1 insertion(+), 21 deletions(-)

--- linux-2617-pv.orig/include/linux/ktime.h
+++ linux-2617-pv/include/linux/ktime.h
@@ -66,7 +66,6 @@ typedef union {
 
 /**
  * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
- *
  * @secs:	seconds to set
  * @nsecs:	nanoseconds to set
  *
@@ -138,7 +137,6 @@ static inline ktime_t ktime_set(const lo
 
 /**
  * ktime_sub - subtract two ktime_t variables
- *
  * @lhs:	minuend
  * @rhs:	subtrahend
  *
@@ -157,7 +155,6 @@ static inline ktime_t ktime_sub(const kt
 
 /**
  * ktime_add - add two ktime_t variables
- *
  * @add1:	addend1
  * @add2:	addend2
  *
@@ -184,7 +181,6 @@ static inline ktime_t ktime_add(const kt
 
 /**
  * ktime_add_ns - Add a scalar nanoseconds value to a ktime_t variable
- *
  * @kt:		addend
  * @nsec:	the scalar nsec value to add
  *
@@ -194,7 +190,6 @@ extern ktime_t ktime_add_ns(const ktime_
 
 /**
  * timespec_to_ktime - convert a timespec to ktime_t format
- *
  * @ts:		the timespec variable to convert
  *
  * Returns a ktime_t variable with the converted timespec value
@@ -207,7 +202,6 @@ static inline ktime_t timespec_to_ktime(
 
 /**
  * timeval_to_ktime - convert a timeval to ktime_t format
- *
  * @tv:		the timeval variable to convert
  *
  * Returns a ktime_t variable with the converted timeval value
@@ -220,7 +214,6 @@ static inline ktime_t timeval_to_ktime(c
 
 /**
  * ktime_to_timespec - convert a ktime_t variable to timespec format
- *
  * @kt:		the ktime_t variable to convert
  *
  * Returns the timespec representation of the ktime value
@@ -233,7 +226,6 @@ static inline struct timespec ktime_to_t
 
 /**
  * ktime_to_timeval - convert a ktime_t variable to timeval format
- *
  * @kt:		the ktime_t variable to convert
  *
  * Returns the timeval representation of the ktime value
--- linux-2617-pv.orig/include/linux/hrtimer.h
+++ linux-2617-pv/include/linux/hrtimer.h
@@ -40,7 +40,6 @@ struct hrtimer_base;
 
 /**
  * struct hrtimer - the basic hrtimer structure
- *
  * @node:	red black tree node for time ordered insertion
  * @expires:	the absolute expiry time in the hrtimers internal
  *		representation. The time is related to the clock on
@@ -59,7 +58,6 @@ struct hrtimer {
 
 /**
  * struct hrtimer_sleeper - simple sleeper structure
- *
  * @timer:	embedded timer structure
  * @task:	task to wake up
  *
@@ -72,7 +70,6 @@ struct hrtimer_sleeper {
 
 /**
  * struct hrtimer_base - the timer base for a specific clock
- *
  * @index:		clock type index for per_cpu support when moving a timer
  *			to a base on another cpu.
  * @lock:		lock protecting the base and associated timers
--- linux-2617-pv.orig/kernel/hrtimer.c
+++ linux-2617-pv/kernel/hrtimer.c
@@ -98,7 +98,6 @@ static DEFINE_PER_CPU(struct hrtimer_bas
 
 /**
  * ktime_get_ts - get the monotonic clock in timespec format
- *
  * @ts:		pointer to timespec variable
  *
  * The function calculates the monotonic clock from the realtime
@@ -238,7 +237,6 @@ lock_hrtimer_base(const struct hrtimer *
 # ifndef CONFIG_KTIME_SCALAR
 /**
  * ktime_add_ns - Add a scalar nanoseconds value to a ktime_t variable
- *
  * @kt:		addend
  * @nsec:	the scalar nsec value to add
  *
@@ -299,7 +297,6 @@ void unlock_hrtimer_base(const struct hr
 
 /**
  * hrtimer_forward - forward the timer expiry
- *
  * @timer:	hrtimer to forward
  * @now:	forward past this time
  * @interval:	the interval to forward
@@ -411,7 +408,6 @@ remove_hrtimer(struct hrtimer *timer, st
 
 /**
  * hrtimer_start - (re)start an relative timer on the current CPU
- *
  * @timer:	the timer to be added
  * @tim:	expiry time
  * @mode:	expiry mode: absolute (HRTIMER_ABS) or relative (HRTIMER_REL)
@@ -460,14 +456,13 @@ EXPORT_SYMBOL_GPL(hrtimer_start);
 
 /**
  * hrtimer_try_to_cancel - try to deactivate a timer
- *
  * @timer:	hrtimer to stop
  *
  * Returns:
  *  0 when the timer was not active
  *  1 when the timer was active
  * -1 when the timer is currently excuting the callback function and
- *    can not be stopped
+ *    cannot be stopped
  */
 int hrtimer_try_to_cancel(struct hrtimer *timer)
 {
@@ -489,7 +484,6 @@ EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel)
 
 /**
  * hrtimer_cancel - cancel a timer and wait for the handler to finish.
- *
  * @timer:	the timer to be cancelled
  *
  * Returns:
@@ -510,7 +504,6 @@ EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
 /**
  * hrtimer_get_remaining - get remaining time for the timer
- *
  * @timer:	the timer to read
  */
 ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
@@ -564,7 +557,6 @@ ktime_t hrtimer_get_next_event(void)
 
 /**
  * hrtimer_init - initialize a timer to the given clock
- *
  * @timer:	the timer to be initialized
  * @clock_id:	the clock to be used
  * @mode:	timer mode abs/rel
@@ -588,7 +580,6 @@ EXPORT_SYMBOL_GPL(hrtimer_init);
 
 /**
  * hrtimer_get_res - get the timer resolution for a clock
- *
  * @which_clock: which clock to query
  * @tp:		 pointer to timespec variable to store the resolution
  *


---
