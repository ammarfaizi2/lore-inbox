Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWDTSmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWDTSmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDTSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:42:31 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:59339 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1751229AbWDTSma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:42:30 -0400
From: Wolfgang Hoffmann <woho@woho.de>
Reply-To: woho@woho.de
To: linux-kernel@vger.kernel.org
Subject: Re: [-rt] time-related problems with CPU frequency scaling
Date: Thu, 20 Apr 2006 20:39:30 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Lee Revell <rlrevell@joe-job.com>
References: <200604162041.10844.woho@woho.de>
In-Reply-To: <200604162041.10844.woho@woho.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604202039.31008.woho@woho.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 April 2006 20:41, Wolfgang Hoffmann wrote:
> Now with speedstep enabled and CONFIG_HIGH_RES_TIMERS=y, I see some
> anomalies:
> - time-of-day lags gradually behind wallclock time

It turns out that this is a non-issue. I can't quite explain how I came to the 
impression that there is a clock lag, but current status is that the clock 
runs correctly. So sorry for the noise.

On Tuesday 18 April 2006 00:35, Lee Revell wrote:
> On Sun, 2006-04-16 at 20:41 +0200, Wolfgang Hoffmann wrote:
> > - if CPU frequency is low when jackd is started, it complains:
> >     "delay of 2915.000 usecs exceeds estimated spare
> >     time of 2847.000; restart ..."
> >   as soon as frequency is scaled up. Seems that jackd gets confused by
> > some influence of CPU frequency on timekeeping? No problems as long as
> > CPU frequency isn't scaled up, though.
>
> JACK still uses the TSC for timing and thus is incompatible with CPU
> frequency scaling.  You must use the -clockfix branch from CVS.

Thanks for the pointer, Lee. I'm now running the clockfix CVS branch and the 
problems are solved. So the -rt kernel is fine.

Thanks for the help,
Wolfgang
