Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbTHaTkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTHaTkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:40:55 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:53512
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261926AbTHaTky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:40:54 -0400
Subject: Re: [SHED] Questions.
From: Robert Love <rml@tech9.net>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1062358285.5171.101.camel@big.pomac.com>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062355996.1313.4.camel@boobies.awol.org>
	 <1062358285.5171.101.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1062359478.1313.9.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 15:51:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-31 at 15:31, Ian Kumlien wrote:

> Since they would have a high pri still, and preempt is there... it
> should be back on the cpu pretty quick.

Ah, but no!  You assume we do not have an expired list and round robin
scheduling.

Once a task exhausts its timeslice, it cannot run until all other tasks
exhaust their timeslice.  If this were not the case, high priority tasks
could monopolize the system.

> But, it also creates problems for when a interactive process becomes a
> cpu hog. Like this the detection should be faster, but should be slowed
> down somewhat.

I agree, although I do think it responds fairly quick.  But, regardless,
this is why I am interested in Nick's work.  The interactivity estimator
can never be perfect.

> But, hogs would instead cause a context switch hell and lessen the
> throughput on server loads...

Hm, why?

> I don't see how priorities would be questioned... Since, all i say is
> that a task that gets preempted should have a guaranteed time on the cpu
> so that we don't waste cycles doing context switches all the time. 

But latency is important.

	Robert Love


