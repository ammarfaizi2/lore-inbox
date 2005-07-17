Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVGQUQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVGQUQG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVGQUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:16:06 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:32153 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261367AbVGQUQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:16:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ANNOUNCE] Interbench v0.21
Date: Mon, 18 Jul 2005 06:18:27 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200507151401.49854.kernel@kolivas.org> <1121503267.5070.21.camel@mindpipe>
In-Reply-To: <1121503267.5070.21.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507180618.27121.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2005 06:41 pm, Lee Revell wrote:
> On Fri, 2005-07-15 at 14:01 +1000, Con Kolivas wrote:
> > Interbech is a an application is designed to benchmark interactivity in
> > Linux.
> >
> > Version 0.21 update
> >
> > http://ck.kolivas.org/apps/interbench/interbench-0.21.tar.bz2
>
> I would suggest using microseconds for both the RT and non RT tests.  It
> would allow easier comparison of results.  I have a pretty slow machine
> and the max result would only be ~44000 usecs.

I think the significance of usec values from the non-rt tests makes this an 
inappropriate thing to do. The variation in results will be greater than usec 
resolution.

> Also, if it's run with -r and sched_setscheduler fails, rather than
> saying "you must be root for SCHED_FIFO" the error message should
> encourage the user to try a 2.6.12+ kernel and add themselves to the
> "audio" or "realtime" group, and to file a feature request if their
> distro does not support the new realtime rlimit feature.
>
> We should encourage more applications to take advantage of, and distros
> to support, the non-root RT scheduling available in 2.6.12+.  I really
> think the kernel is good enough at this point that we could achieve
> OSX-like multimedia performance on the desktop if more apps like xmms,
> xine, and mplayer were to adopt a multithreaded model with the
> time-critical rendering threads running RT.  XMMS recently adopted such
> a model, but I don't think the audio thread runs SCHED_FIFO yet.  These
> benchmarks imply that it would be a massive improvement.

While I agree with you in principal on getting the rlimit feature working and 
supported, this benchmark is meant to be run in single user mode for most 
reproducible and valid results. However, clearly there will be people using 
it cautiously as a normal user first. I originally did not include the 
information that you need to be root in v.20 and said in the documentation 
"need rt privileges" but within about 5 minutes of posting it I had someone 
not understanding what "unable to get SCHED_FIFO" meant. I guess a more 
verbose message will be required explaining non-root RT as well.

Cheers,
Con
