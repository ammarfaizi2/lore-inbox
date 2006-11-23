Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757347AbWKWKdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347AbWKWKdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757349AbWKWKdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:33:18 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:8399 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1757347AbWKWKdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:33:17 -0500
Date: Thu, 23 Nov 2006 02:33:13 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: d binderman <dcb314@hotmail.com>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] hrtimer: remove unused variable
In-Reply-To: <BAY107-F28F506ED79A35F4FF31CF39CE20@phx.gbl>
Message-ID: <Pine.LNX.4.64N.0611230232160.18515@attu4.cs.washington.edu>
References: <BAY107-F28F506ED79A35F4FF31CF39CE20@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'base' variable.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 kernel/hrtimer.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index d0ba190..b55532f 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -508,11 +508,10 @@ EXPORT_SYMBOL_GPL(hrtimer_cancel);
  */
 ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
 {
-	struct hrtimer_base *base;
 	unsigned long flags;
 	ktime_t rem;
 
-	base = lock_hrtimer_base(timer, &flags);
+	lock_hrtimer_base(timer, &flags);
 	rem = ktime_sub(timer->expires, timer->base->get_time());
 	unlock_hrtimer_base(timer, &flags);
 
