Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423259AbWANCGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423259AbWANCGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423261AbWANCGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:06:13 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:23460 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1423259AbWANCGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:06:13 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Sat, 14 Jan 2006 13:05:49 +1100
User-Agent: KMail/1.9
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>
References: <5.2.1.1.2.20060113124751.00bf2660@pop.gmx.net> <5.2.1.1.2.20060113165958.00beb8e0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060113165958.00beb8e0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141305.49925.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 03:15, Mike Galbraith wrote:
> At 01:34 AM 1/14/2006 +1100, Con Kolivas wrote:
> >On Saturday 14 January 2006 00:01, Mike Galbraith wrote:
> > > At 09:51 PM 1/13/2006 +1100, Con Kolivas wrote:
> > > >See my followup patches that I have posted following "[PATCH 0/5]
> > > > sched - interactivity updates". The first 3 patches are what you
> > > > tested. These patches are being put up for testing hopefully in -mm.
> > >
> > > Then the (buggy) version of my simple throttling patch will need to
> > > come out.  (which is OK, I have a debugged potent++ version)
> >
> >Your code need not be mutually exclusive with mine. I've simply damped the
> >current behaviour. Your sanity throttling is a good idea.
>
> I didn't mean to imply that they're mutually exclusive, and after doing
> some testing, I concluded that it (or something like it) is definitely
> still needed.  The version that's in mm2 _is_ buggy however, so ripping it
> back out wouldn't hurt my delicate little feelings one bit.  In fact, it
> would give me some more time to instrument and test integration with your
> changes.  

Ok I've communicated this to Andrew (cc'ed here too) so he should remove your 
patch pending a new version from you.

> (Which I think are good btw because they remove what I considered 
> to be warts; the pipe and uninterruptible sleep barriers.  

Yes I felt your abuse wrt to these in an earlier email...

> Um... try irman2 
> now... pure evilness)

Hrm I've been using staircase which is immune for so long I'd all but 
forgotten about this test case. Looking at your code I assume your changes 
should help this?

Con
