Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVCHUa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVCHUa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVCHUaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:30:10 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46047 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262047AbVCHU1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:27:25 -0500
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: george@mvista.com
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <4228CBFB.3000602@mvista.com>
References: <1109869828.2908.18.camel@mindpipe>
	 <20050303164520.0c0900df.akpm@osdl.org> <1109899148.3630.5.camel@mindpipe>
	 <42283857.9050007@mvista.com> <1109968985.6710.16.camel@mindpipe>
	 <4228CBFB.3000602@mvista.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 15:27:24 -0500
Message-Id: <1110313644.4600.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 12:58 -0800, George Anzinger wrote:
> Lee Revell wrote:
> > On Fri, 2005-03-04 at 02:28 -0800, George Anzinger wrote:
> > The thing that brought this code to my attention is that with PREEMPT_RT
> > this happens to be the longest non-preemptible code path in the kernel.
> > On my 1.3 Ghz machine set_rtc_mmss takes about 50 usecs, combined with
> > the rest of timer irq we end up disabling preemption for about 90 usecs.
> > Unfortunately I don't have the trace anymore.
> > 
> > Anyway the upshot is if we hung this off a timer it looks like we would
> > improve the worst case latency with PREEMPT_RT by almost 50%.  Unless
> > there is some reason it has to be done synchronously of course.
> 
> Well, it does have to be done at the right WRT the second, but I suspect we can 
> hit that as well with a timer as it is hit now.  Also, if we are _really_ off 
> the mark, this can be defered till the next second.
> 

Do you have a patch?

Andrew merged my trivial patch to clean up the logic, but a real fix
would be better.

Lee

