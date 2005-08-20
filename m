Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbVHTAcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbVHTAcU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbVHTAcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:32:20 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:40841 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932760AbVHTAcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:32:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Sat, 20 Aug 2005 10:31:59 +1000
User-Agent: KMail/1.8.2
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <200508191436.42881.kernel@kolivas.org> <1124482411.25424.49.camel@mindpipe>
In-Reply-To: <1124482411.25424.49.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508201031.59981.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2005 06:13, Lee Revell wrote:
> On Fri, 2005-08-19 at 14:36 +1000, Con Kolivas wrote:
> > On Fri, 19 Aug 2005 02:41 pm, Peter Williams wrote:
> > > Maybe we could use interbench to find a nice value for X that doesn't
> > > destroy Audio and Video?  The results that I just posted for
> > > spa_no_frills with X reniced to -10 suggest that the other schedulers
> > > could cope with something closer to zero.
> >
> > I don't see the point. X works fine as is without renicing not
> > withstanding these extreme loads in interbench. Furthermore, reworking of
> > xorg code to not spin the cpu unnecessarily when the gpu is busy is
> > underway and tuning the cpu scheduler unfairly for an X server that will
> > no longer behave so badly is inappropriate.
>
> See, that's where we disagree, I certainly don't believe X "works fine".
> Compared to MacOS and (especially) Windows the Linux desktop is WAY
> sluggish.
>
> For example when I cycle through windows with alt-tab in X, it can take
> 5-10 seconds for each to render.  I can see the application's widgets
> being drawn one at a time, then finally the border.  Repeated
> alt-tabbing between the same two windows seems to cause a CPU intensive
> redraw of the entire window.  It's as if X just discards the rendered
> contents of a window as soon as it's obscured.
>
> On Windows this works as expected - cycling through windows whose
> contents have already been rendered is *instantaneous*.
>
> I agree that tweaking the scheduler is probably pointless, as long as X
> is burning gazillions of CPU cycles redrawing things that don't need to
> be redrawn.
>
> Then again even the OSX scheduler has hooks for the GUI.  Presumably
> they concluded that the desktop responsiveness problem could not be
> adequately solved within the framework of a general purpose UNIX
> scheduler.

It's an X problem and it's being fixed. Get over it, we're not tuning the 
scheduler for a broken app.

Con
