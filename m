Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVHLCBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVHLCBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbVHLCBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:01:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:13758 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751051AbVHLCBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:01:20 -0400
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, rusty@au1.ibm.com, bmark@us.ibm.com,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050811095634.GA19342@elte.hu>
References: <20050810171145.GA1945@us.ibm.com>
	 <20050811095634.GA19342@elte.hu>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 22:00:56 -0400
Message-Id: <1123812057.26878.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 11:56 +0200, Ingo Molnar wrote:
> > For the record, some shortcomings of this patch:
> > 
> > o	Needs lots more testing on more architectures.
> > 
> > o	Needs performance and stress testing.
> > 
> > o	Needs testing in Ingo's PREEMPT_RT environment.
> 
> cool patch! I have integrated it into my PREEMPT_RT tree, and all it 
> needed to boot was the patch below (doesnt affect the upstream kernel).  
> Using the raw IRQ flag isnt an issue in the RCU code, all the affected 
> codepaths are small and deterministic.
> 

Ingo,

Doesn't this fix the longest latency we were seeing with
PREEMPT_DESKTOP, I don't have a trace handy but the upshot was "signal
delivery must remain atomic on !PREEMPT_RT"?

Lee

