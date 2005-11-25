Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVKYH6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVKYH6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 02:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVKYH6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 02:58:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11941 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751421AbVKYH6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 02:58:44 -0500
Date: Fri, 25 Nov 2005 13:34:37 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: david singleton <dsingleton@mvista.com>
Cc: "David F. Carlson" <dave@chronolytics.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: PI BUG with -rt13
Message-ID: <20051125080437.GA4844@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com> <20051124145734.GA2717@elte.hu> <20051124202637.GB9098@in.ibm.com> <20051124203250.GA9086@in.ibm.com> <C9607B8E-5D6F-11DA-90F9-000A959BB91E@mvista.com> <20051125073423.GA4825@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051125073423.GA4825@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 01:04:23PM +0530, Dinakar Guniguntala wrote:
> On Thu, Nov 24, 2005 at 08:56:06PM -0800, david singleton wrote:
> > On Nov 24, 2005, at 12:32 PM, Dinakar Guniguntala wrote:
> > 
> > >>I just noticed with the above fix, Paul's testcase completely
> > >>hangs up and when killed I hit the BUG mentioned below.
> > >>Till -rt13, this testcase just ran to completion
> > >
> > >Forgot to mention that I notice the same failure with -rt15 as well
> > 
> > Good news and bad news.
> > Good news.  This test doesn't exercise the robust futex code.
> > Pthread mutexes that want priority queuing, priority inheritance and/or 
> > robustness must have either  the robust (PTHREAD_MUTEX_ROBUST_NP) 
> > attribute set and/or the PTHREAD_PRIO_INHERIT attribute set at mutex
> > creation time.
> 
> Davi, Thank you for looking into this
> 
> Yes, this particular testcase does not exercise the robust futex code.
> However, the testcase only hangs when I apply your fix on top of
>  -rt13. A Vanilla -rt13 works fine

Just to make myself clear, this is not the same testcase where I
saw PI issues that I reported ealier in the thread. I guess since
I reported both problems in the same thread, it is sort of confusing.
Hope that clears up any confusion

	-Dinakar

