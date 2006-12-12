Return-Path: <linux-kernel-owner+w=401wt.eu-S932367AbWLLVkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWLLVkB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWLLVkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:40:01 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45905 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbWLLVkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:40:00 -0500
Subject: Re: [PATCH] hrtimer: remove unused variable
From: Steven Rostedt <rostedt@goodmis.org>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: d binderman <dcb314@hotmail.com>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64N.0611230232160.18515@attu4.cs.washington.edu>
References: <BAY107-F28F506ED79A35F4FF31CF39CE20@phx.gbl>
	 <Pine.LNX.4.64N.0611230232160.18515@attu4.cs.washington.edu>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 16:39:40 -0500
Message-Id: <1165959580.26937.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 02:33 -0800, David Rientjes wrote:
> Remove unused 'base' variable.
> 

Or just use it.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.19/kernel/hrtimer.c
===================================================================
--- linux-2.6.19.orig/kernel/hrtimer.c	2006-12-12 16:36:09.000000000 -0500
+++ linux-2.6.19/kernel/hrtimer.c	2006-12-12 16:36:36.000000000 -0500
@@ -513,7 +513,7 @@ ktime_t hrtimer_get_remaining(const stru
 	ktime_t rem;
 
 	base = lock_hrtimer_base(timer, &flags);
-	rem = ktime_sub(timer->expires, timer->base->get_time());
+	rem = ktime_sub(timer->expires, base->get_time());
 	unlock_hrtimer_base(timer, &flags);
 
 	return rem;


