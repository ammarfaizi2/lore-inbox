Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVHDOxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVHDOxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVHDOvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:51:15 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54721 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262519AbVHDOtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:49:00 -0400
Date: Thu, 4 Aug 2005 07:49:33 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, rostedt@goodmis.org,
       bhuey@lnxw.com, shemminger@osdl.org, rusty@au1.ibm.com
Subject: Re: [RFC,PATCH] RCU and CONFIG_PREEMPT_RT sane patch
Message-ID: <20050804144933.GB1297@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050801171137.GA1754@us.ibm.com> <20050804141527.GA15447@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804141527.GA15447@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 04:15:27PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > Hello!
> > 
> > The attached patch passes 20 hours of the internal-to-RCU torture test 
> > (see the code in the attached patch under CONFIG_RCU_TORTURE_TEST), 
> > which is a good improvement over last week's version, which would fail 
> > this test in less than two seconds -- this despite passing kernbench 
> > with flying colors and passing LTP 90% of the time.  Sometimes there 
> > is no substitute for a good in-kernel stress test...
> > 
> > The attached version of the patch seems to me to be ready for a larger 
> > audience.
> 
> Cool! I've merged your patch to the -52-12 version of the -RT patch. You 
> can get it from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> also, i've attached a port against 2.6.13-rc4. I have done this because 
> the PREEMPT_RCU patch in my tree is applied before the core-PREEMPT_RT 
> patch. I have fixed up the CONFIG_PREEMPT compilation branch and have 
> removed your #error define - it built and booted fine on an UP box but 
> there are no guarantees ...

Sounds great!!!  I will give it a thorough hammering in both the
CONFIG_PREEMPT and CONFIG_PREEMPT_RT environments.

							Thanx, Paul
