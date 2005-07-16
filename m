Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVGPKJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVGPKJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 06:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGPKJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 06:09:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5766 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261348AbVGPKI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 06:08:58 -0400
Subject: Re: [ANNOUNCE] Interbench v0.21
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200507151401.49854.kernel@kolivas.org>
References: <200507151401.49854.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 04:41:07 -0400
Message-Id: <1121503267.5070.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 14:01 +1000, Con Kolivas wrote:
> Interbech is a an application is designed to benchmark interactivity in Linux.
> 
> Version 0.21 update
> 
> http://ck.kolivas.org/apps/interbench/interbench-0.21.tar.bz2
> 

I would suggest using microseconds for both the RT and non RT tests.  It
would allow easier comparison of results.  I have a pretty slow machine
and the max result would only be ~44000 usecs.

Also, if it's run with -r and sched_setscheduler fails, rather than
saying "you must be root for SCHED_FIFO" the error message should
encourage the user to try a 2.6.12+ kernel and add themselves to the
"audio" or "realtime" group, and to file a feature request if their
distro does not support the new realtime rlimit feature.

We should encourage more applications to take advantage of, and distros
to support, the non-root RT scheduling available in 2.6.12+.  I really
think the kernel is good enough at this point that we could achieve
OSX-like multimedia performance on the desktop if more apps like xmms,
xine, and mplayer were to adopt a multithreaded model with the
time-critical rendering threads running RT.  XMMS recently adopted such
a model, but I don't think the audio thread runs SCHED_FIFO yet.  These
benchmarks imply that it would be a massive improvement.

Lee

