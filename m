Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVHLU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVHLU5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVHLU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:57:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:29623 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932083AbVHLU5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:57:12 -0400
Date: Fri, 12 Aug 2005 13:57:44 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, rusty@au1.ibm.com, bmark@us.ibm.com,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050812205744.GE1297@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050810171145.GA1945@us.ibm.com> <20050811095634.GA19342@elte.hu> <1123812057.26878.9.camel@mindpipe> <20050812063600.GC13397@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812063600.GC13397@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 08:36:00AM +0200, Ingo Molnar wrote:
> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Doesn't this fix the longest latency we were seeing with 
> > PREEMPT_DESKTOP, I don't have a trace handy but the upshot was "signal 
> > delivery must remain atomic on !PREEMPT_RT"?
> 
> yes - although Paul's patch converts only a portion of the signal code 
> to RCU-read-lock, so i'd expect there to be other latencies too. Might 
> be worth a test (once we've sorted out the HRT build bugs).

And there remains the question of how much of the benefit remains after
I handle the corner cases...  :-/

						Thanx, Paul
