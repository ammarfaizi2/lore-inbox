Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268277AbUHXUcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268277AbUHXUcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbUHXUcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:32:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43681 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268280AbUHXUcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:32:36 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       manas.saksena@timesys.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <412B7E50.1030806@cybsft.com>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu>  <412B7E50.1030806@cybsft.com>
Content-Type: text/plain
Message-Id: <1093379558.817.60.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 16:32:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 13:43, K.R. Foley wrote:
> Ingo Molnar wrote:
> > * Scott Wood <scott@timesys.com> wrote:
> > 
> > 
> >>I have attached a port of the voluntary preempt patch to PPC and
> >>PPC64.  The patch is against P7, but it applies against P8 as well.
> > 
> > 
> > thanks Scott, i've applied your patch to my tree - all the changes and
> > improvements look good (except for a small compilation problem on x86,
> > asm/time.h doesnt exist there - asm/rtc.h does). The resulting code
> > booted fine on an SMP and on a UP x86 system. I've uploaded -P9:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> > 
> > (there are no other changes in -P9.)
> > 
> > 	Ingo
> > -
> 
> ~254 usec latency seen in kswapd:
> 
> http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace2.txt
> 

I am able to generate unbounded latencies in kswapd by running `make
-j12' for any C++ program that uses KDE/Qt.  The build will allocate all
available RAM, then all available swap, then the machine grinds to a
halt.

I am not sure this is solvable though.  If you fire off a bunch of
processes that try to allocate way more memory than is physically
available then you will have worse problems than latency.

Lee

