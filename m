Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWDEIRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWDEIRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 04:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWDEIRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 04:17:35 -0400
Received: from dial169-41.awalnet.net ([213.184.169.41]:38930 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751175AbWDEIRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 04:17:34 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Wed, 5 Apr 2006 11:16:05 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200604031459.51542.a1426z@gawab.com> <200604041627.25359.a1426z@gawab.com> <4432FE8C.7010900@bigpond.net.au>
In-Reply-To: <4432FE8C.7010900@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604051116.05270.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > Peter Williams wrote:
> >> Al Boldi wrote:
> >>>>>> Control parameters for the scheduler can be read/set via files in:
> >>>>>>
> >>>>>> /sys/cpusched/<scheduler>/
> >>>
> >>> The default values for spa make it really easy to lock up the system.
> >>
> >> Which one of the SPA schedulers and under what conditions?  I've been
> >> mucking around with these and may have broken something.  If so I'd
> >> like to fix it.
> >
> > spa_no_frills, with a malloc-hog less than timeslice.  Setting
> > promotion_floor to max unlocks the console.
>
> OK, you could also try increasing the promotion interval.

Seems that this will only delay the lock in spa_svr but not inhibit it.

> It should be noted that spa_no_frills isn't really expected to behave
> very well as it's a pure round robin scheduler.

It's a bare bone scheduler that allows to prioritize procs to the admins 
desire, instead of leaving the priority management to the scheduler, which 
may be undesirable for some but not all.

> It's intended purpose is as a basis for more sophisticated schedulers.

And that's why the same problem exists in the child scheds, i.e. spa_ws, 
spa_svr, zaphod, but not spa_ebs.

> I've been thinking
> about removing it as a bootable scheduler and only making its children
> available but I find it useful to compare benchmark and other test
> results from it with that from the other schedulers to get an idea of
> the extra costs involved.

Thanks!

--
Al

