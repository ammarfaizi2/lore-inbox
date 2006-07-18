Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWGRB7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWGRB7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 21:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWGRB7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 21:59:55 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:3783 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750809AbWGRB7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 21:59:54 -0400
Subject: Re: [PATCH] fix bad macro param in timer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       keir@xensource.com, Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
In-Reply-To: <1153187268.9932.6.camel@localhost.localdomain>
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
	 <1153187268.9932.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 21:59:46 -0400
Message-Id: <1153187986.9932.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches suggested another set of parans.  And I believe he's right.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc2/kernel/timer.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/timer.c	2006-07-17 21:42:01.000000000 -0400
+++ linux-2.6.18-rc2/kernel/timer.c	2006-07-17 21:56:49.000000000 -0400
@@ -408,7 +408,7 @@ static int cascade(tvec_base_t *base, tv
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
-#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+#define INDEX(N) ((base->timer_jiffies >> (TVR_BITS + (N) * TVN_BITS)) & TVN_MASK)
 
 static inline void __run_timers(tvec_base_t *base)
 {


