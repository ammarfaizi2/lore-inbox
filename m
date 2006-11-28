Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757426AbWK1WBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426AbWK1WBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757430AbWK1WBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:01:49 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:24699 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1757426AbWK1WBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:01:48 -0500
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20061128201444.GB26934@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
	 <1164744757.1701.58.camel@mindpipe>  <20061128201444.GB26934@elte.hu>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 14:01:22 -0800
Message-Id: <1164751282.7543.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 21:14 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Tue, 2006-11-28 at 11:58 -0800, Fernando Lopez-Lezcano wrote:
> > > Hi, I'm trying out the latest -rt patch and getting alsa xruns when
> > > using jackd and jack clients. This is a sample from the output of
> > > qjackctl / jackd (jack 0.102.25, qjackctl 0.2.21):
> > 
> > Any improvement if you disable high res timers?
> > 
> > Also, the latency tracer does not work on dual core AMD machines due 
> > to the TSC drift.  Might as well disable it.
> 
> i fixed this in -rt8: the latency tracer now uses the time of day 
> clocksource - pmtimer in this case. (that means function tracing is 
> slower than with the TSC, but latency figures are more reliable.)

I have a patch set to make the using the clocksources a little nicer..
Is there anything I should add to that interface to help enable latency
tracing, or are you satisfied with using the timekeeping clocksource?
It might get constrictive after a while.

Daniel

