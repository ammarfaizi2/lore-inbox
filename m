Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVHTVuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVHTVuF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 17:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVHTVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 17:50:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56745 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751247AbVHTVuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 17:50:04 -0400
Subject: Re: sched_yield() makes OpenLDAP slow
From: Lee Revell <rlrevell@joe-job.com>
To: Howard Chu <hyc@symas.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4307788E.1040209@symas.com>
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca>
	 <4306AF26.3030106@yahoo.com.au>  <4307788E.1040209@symas.com>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 17:50:01 -0400
Message-Id: <1124574601.2628.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 11:38 -0700, Howard Chu wrote:
> Nick Piggin wrote:
> >  Robert Hancock wrote:
> > > I fail to see how sched_yield is going to be very helpful in this
> > > situation. Since that call can sleep from a range of time ranging
> > > from zero to a long time, it's going to give unpredictable results.
> 
> >  Well, not sleep technically, but yield the CPU for some undefined
> >  amount of time.
> 
> Since the slapd server was not written to run in realtime, nor is it 
> commonly run on realtime operating systems, I don't believe predictable 
> timing here is a criteria we care about. One could say the same of 
> sigsuspend() by the way - it can pause a process for a range of time 
> ranging from zero to a long time. Should we tell application writers not 
> to use this function either, regardless of whether the developer thinks 
> they have a good reason to use it?

Of course not.  We should tell them that if they use sigsuspend() they
cannot assume that the process will not wake up immediately.

Lee


