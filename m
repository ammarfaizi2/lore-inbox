Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWEZOVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWEZOVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWEZOVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:21:40 -0400
Received: from mail.gmx.de ([213.165.64.20]:63423 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750773AbWEZOVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:39 -0400
X-Authenticated: #14349625
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
In-Reply-To: <447709B3.80309@bigpond.net.au>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
	 <200605262100.22071.kernel@kolivas.org>  <447709B3.80309@bigpond.net.au>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:23:18 +0200
Message-Id: <1148653398.8321.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 23:59 +1000, Peter Williams wrote:
> Con Kolivas wrote:
> > On Friday 26 May 2006 14:20, Peter Williams wrote:
> >> This patch implements hard CPU rate caps per task as a proportion of a
> >> single CPU's capacity expressed in parts per thousand.
> > 
> > A hard cap of 1/1000 could lead to interesting starvation scenarios where a 
> > mutex or semaphore was held by a task that hardly ever got cpu. Same goes to 
> > a lesser extent to a 0 soft cap. 
> > 
> > Here is how I handle idleprio tasks in current -ck:
> > 
> > http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/patches/track_mutexes-1.patch
> > tags tasks that are holding a mutex
> > 
> > http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/patches/sched-idleprio-1.7.patch
> > is the idleprio policy for staircase.
> > 
> > What it does is runs idleprio tasks as normal tasks when they hold a mutex or 
> > are waking up after calling down() (ie holding a semaphore).
> 
> I wasn't aware that you could detect those conditions.  They could be 
> very useful.

Isn't this exactly what the PI code is there to handle?  Is something
more than PI needed?

	-Mike

