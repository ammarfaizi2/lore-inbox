Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWAZJuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWAZJuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 04:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAZJuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 04:50:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2830 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932210AbWAZJuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 04:50:03 -0500
Date: Thu, 26 Jan 2006 10:50:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: george@mvista.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/posix-timers.c: remove do_posix_clock_notimer_create()
Message-ID: <20060126095002.GX3590@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function is neither used nor has any real contents.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Jan 2006
- 7 Jan 2006

 include/linux/posix-timers.h |    1 -
 kernel/posix-timers.c        |    6 ------
 2 files changed, 7 deletions(-)

--- linux-2.6.15-mm2-full/include/linux/posix-timers.h.old	2006-01-07 23:13:08.000000000 +0100
+++ linux-2.6.15-mm2-full/include/linux/posix-timers.h	2006-01-07 23:13:17.000000000 +0100
@@ -84,7 +84,6 @@
 void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock);
 
 /* error handlers for timer_create, nanosleep and settime */
-int do_posix_clock_notimer_create(struct k_itimer *timer);
 int do_posix_clock_nonanosleep(const clockid_t, int flags, struct timespec *,
 			       struct timespec __user *);
 int do_posix_clock_nosettime(const clockid_t, struct timespec *tp);
--- linux-2.6.15-mm2-full/kernel/posix-timers.c.old	2006-01-07 23:13:25.000000000 +0100
+++ linux-2.6.15-mm2-full/kernel/posix-timers.c	2006-01-07 23:13:30.000000000 +0100
@@ -875,12 +875,6 @@
 }
 EXPORT_SYMBOL_GPL(do_posix_clock_nosettime);
 
-int do_posix_clock_notimer_create(struct k_itimer *timer)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(do_posix_clock_notimer_create);
-
 int do_posix_clock_nonanosleep(const clockid_t clock, int flags,
 			       struct timespec *t, struct timespec __user *r)
 {

