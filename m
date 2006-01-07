Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWAGKYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWAGKYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 05:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWAGKYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 05:24:08 -0500
Received: from mail.gmx.de ([213.165.64.21]:49543 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030400AbWAGKYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 05:24:06 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060107112152.00c26298@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 07 Jan 2006 11:23:50 +0100
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client   
  on	interactive response
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200601072030.59445.kernel@kolivas.org>
References: <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
 <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net>
 <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:30 PM 1/7/2006 +1100, Con Kolivas wrote:
>On Saturday 07 January 2006 16:27, Mike Galbraith wrote:
> > >   Personally, I think that all TASK_UNINTERRUPTIBLE sleeps should be
> > > treated as non interactive rather than just be heavily discounted (and
> > > that TASK_NONINTERACTIVE shouldn't be needed in conjunction with it) BUT
> > > I may be wrong especially w.r.t. media streamers such as audio and video
> > > players and the mechanisms they use to do sleeps between cpu bursts.
> >
> > Try it, you won't like it.  When I first examined sleep_avg woes, my
> > reaction was to nuke uninterruptible sleep too... boy did that ever _suck_
> > :)
>
>Glad you've seen why I put the uninterruptible sleep logic in there.

Yeah, if there's one thing worse than too much preemption, it's too little 
preemption.

         -Mike

