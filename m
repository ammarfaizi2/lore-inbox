Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVGKRTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVGKRTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGKRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:19:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18080 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261357AbVGKRSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:18:39 -0400
Date: Mon, 11 Jul 2005 10:19:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Attempted summary of "RT patch acceptance" thread, take 2
Message-ID: <20050711171910.GE1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050711145552.GA1489@us.ibm.com> <1121098272.7050.13.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050711164322.GD1304@us.ibm.com> <1121100589.7050.24.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121100589.7050.24.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 09:49:48AM -0700, Daniel Walker wrote:
> On Mon, 2005-07-11 at 09:43 -0700, Paul E. McKenney wrote:
> > Hello, Daniel,
> > 
> > In principle, one could inspect the Linux kernel with the PREEMPT_RT patch
> > applied, and calculate the worst-case time during which interrupts are
> > disabled, though I have not heard of anyone actually doing this.  Is this
> > what you are getting at, or are you thinking in terms of Kristian's and
> > Karim's testing?
> 
> Well with the PREEMPT_RT patch applied the interrupt off sections are
> reduced to a small number, ~100 irrespective of config options or
> drivers (although I think APM might be the one exception) .
> 
> So with the patch applied it becomes trivial to test/inspect each of the
> interrupt off sections , and thus give a hard guarantee for _all_
> PREEMPT_RT kernels. 

OK, interesting point, though this would apply only to interrupt latency,
not to scheduling latency or to latency for any other system services,
right?

Do you believe that the 50-us delay measured by Kristian and Karim was
due to APM or due to hardware (as Karim suspected)?  If the latter,
any guesses as to the cause of the holdup?  50 us is a -really- long
time for ~100 instructions on today's hardware, even if each instruction
misses the cache!

						Thanx, Paul
