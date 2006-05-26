Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWEZV0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWEZV0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWEZV0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:26:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751582AbWEZV0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:26:37 -0400
Date: Fri, 26 May 2006 14:26:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] hrtimer: export symbols
Message-ID: <20060526142631.38d5309e@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use the hrtimer's in the netem (Network Emulator) qdisc.
But the necessary symbols aren't exported for module use.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
--- linux-2.6.orig/kernel/hrtimer.c	2006-04-27 11:12:53.000000000 -0700
+++ linux-2.6/kernel/hrtimer.c	2006-05-26 14:21:37.000000000 -0700
@@ -456,6 +456,7 @@
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hrtimer_start);
 
 /**
  * hrtimer_try_to_cancel - try to deactivate a timer
@@ -484,6 +485,7 @@
 	return ret;
 
 }
+EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel);
 
 /**
  * hrtimer_cancel - cancel a timer and wait for the handler to finish.
@@ -504,6 +506,7 @@
 		cpu_relax();
 	}
 }
+EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
 /**
  * hrtimer_get_remaining - get remaining time for the timer
@@ -522,6 +525,7 @@
 
 	return rem;
 }
+EXPORT_SYMBOL_GPL(hrtimer_get_remaining);
 
 #ifdef CONFIG_NO_IDLE_HZ
 /**
@@ -580,6 +584,7 @@
 	timer->base = &bases[clock_id];
 	timer->node.rb_parent = HRTIMER_INACTIVE;
 }
+EXPORT_SYMBOL_GPL(hrtimer_init);
 
 /**
  * hrtimer_get_res - get the timer resolution for a clock
@@ -599,6 +604,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hrtimer_get_res);
 
 /*
  * Expire the per base hrtimer-queue:
