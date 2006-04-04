Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWDDN3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWDDN3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWDDN2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:28:45 -0400
Received: from [212.33.180.135] ([212.33.180.135]:60432 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932183AbWDDN2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:28:42 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [RFC] sched.c : procfs tunables
Date: Tue, 4 Apr 2006 16:27:19 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200603311723.49049.a1426z@gawab.com> <200604031459.43105.a1426z@gawab.com> <200604032221.32461.kernel@kolivas.org>
In-Reply-To: <200604032221.32461.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604041627.19903.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Monday 03 April 2006 21:59, Al Boldi wrote:
> > Con Kolivas wrote:
> > > None of the current "tunables" have easily understandable heuristics.
> > > Even those that appear to be obvious, like timselice, are not. While
> > > exporting tunables is not a bad idea, exporting tunables that noone
> > > understands is not really helpful.
> >
> > Couldn't this be fixed with an autotuning module based on cpu/mem/ctxt
> > performance?
>
> You're assuming there is some meaningful relationship between changes in
> cpu/mem/ctxt performance and these tunables, which isn't the case.
> Furthermore if this was the case, noone understands it, can predict it or
> know how to tune it. Just saying "autotune it" doesn't really tell us how
> exactly the change those tunables in relation to the other variables.
> Since Mike and I understand them reasonably well I think we'd both agree
> that there is no meaningful association.

After playing w/ these tunables it occurred to me that they are really only 
deadline limits, w/ a direct relation to cpu/mem/ctxt perf.

i.e timeslice=1 on i386sx means something other than timeslice=1 on amd64

It follows that w/o autotuning, the static default values have to be selected 
to allow for a large underlying perf range w/ a preference for the high 
range.  This is also the reason why 2.6 feels really crummy on low perf 
ranges.

Autotuning the default values would allow to tighten this range specific to 
the hw used, thus allowing for a smoother desktop experience.

Thanks!

--
Al

