Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUIHEWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUIHEWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUIHEWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:22:42 -0400
Received: from www2.muking.org ([216.231.42.228]:16413 "HELO www2.muking.org")
	by vger.kernel.org with SMTP id S268836AbUIHEWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:22:13 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Kevin Hilman <kjh-lkml@hilman.org>
Organization: None to speak of.
Date: 07 Sep 2004 21:22:11 -0700
Message-ID: <834qm92xvw.fsf@www2.muking.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running the VP patch on a PII 400MHz to closer approximate an
embedded target.  I get a 21ms latency trace during boot which dwarfs
other latencies and prevents me from seeing any of the later latencies
when I'm running my test.  The trace (from -R5) is available here:

  http://hilman.org/kevin/VP/trace-cond_resched.txt

At first glance, it appears to be the result of an accumulation of
calls to __delay() from the 3c59x vortex driver.  Any ideas what's
going on here?

Is there a way to disable the trace by default and enable it later via
/proc?  I see that the preemption itself can be disabled via
command-line and then enable later via /proc but I don't see the same
for the latency trace.

Kevin
http://hilman.org/

