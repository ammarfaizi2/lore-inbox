Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWEQMrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWEQMrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWEQMrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:47:09 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:9417 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932542AbWEQMrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:47:08 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Wed, 17 May 2006 22:46:37 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, tim.c.chen@linux.intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com> <200605172025.22626.kernel@kolivas.org> <1147866161.7676.31.camel@homer>
In-Reply-To: <1147866161.7676.31.camel@homer>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2731
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200605172246.39444.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 21:42, Mike Galbraith wrote:
> Fair?  I said interactivity wise.  But what the heck, if we're talking
> fairness, I can say the same thing about I/O bound tasks.  Heck, it's
> not fair to stop any task from reaching the top, and it's certainly not
> fair to let them have (for all practical purposes) all the cpu they want
> once they sleep enough.

Toss out the I/O bound thing and we turn into a steaming dripping pile of dog 
doo whenever anything does disk I/O. And damned if there aren't a lot of pcs 
that have hard disks... 

> Shoot, the scheduler is unfair even without any 
> interactivity code.  Long term, it splits tasks into two groups... those
> that sleep for more than 50% of the time... yack yack yack... zzzzz
>
> Let's stick to the interactivity side :)

It's a deal.

> > only ever sleeps for long sleeps to prevent it getting as good priority
> > as anything else that uses only 1% cpu. I've noticed that 'top' suffers
> > this fate for example. The problem I've had all along with thud as a test
> > case is that while it causes a pause on the system for potentially a few
> > seconds, it does this by raising the load transiently to a load of 50 (or
> > whatever you set it to). I have no problem with a system having a hiccup
> > when the load is 50, provided the system eventually recovers and isn't
> > starved forever (which it isn't). There are other means to prevent one
> > user having that many running tasks if so desired.
>
> Three of the little buggers are enough to cause plenty of pain.

Spits and stutters are not starvation. Luckily it gets no worse with this 
patch.

-- 
-ck
