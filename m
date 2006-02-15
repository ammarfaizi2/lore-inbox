Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423007AbWBOHRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423007AbWBOHRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423008AbWBOHRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:17:45 -0500
Received: from mail.gmx.de ([213.165.64.21]:60801 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423007AbWBOHRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:17:44 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139983865.2733.20.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131637.43335.kernel@kolivas.org> <1139810224.7935.9.camel@homer>
	 <200602131708.52342.kernel@kolivas.org>  <1139812538.7744.8.camel@homer>
	 <1139812725.2739.94.camel@mindpipe>  <1139814504.8124.6.camel@homer>
	 <1139820181.3202.2.camel@mindpipe>  <1139834106.7831.115.camel@homer>
	 <1139977373.2733.9.camel@mindpipe>  <1139980940.24148.47.camel@homer>
	 <1139983865.2733.20.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 08:17:59 +0100
Message-Id: <1139987879.12598.20.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 01:11 -0500, Lee Revell wrote:
> On Wed, 2006-02-15 at 06:22 +0100, MIke Galbraith wrote:
> > > OK, with 2.6.16-rc2-mm1, "ls" bounces around between 0.15s and
> > 0.50s.
> > > Better than mainline but the large seemingly random variance is
> > still
> > > perceptible and annoying.  And, "ls | cat" behaves about the same as
> > > "ls", while on mainline it was consistently faster (!).
> > 
> > Ok.  That means the reduction in fluctuation had nothing to do with my
> > changes.  It also suggests that there may be something of a regression
> > in the changes that are in mm, which I also carried in my patch, since
> > the timing for both kernels appear to be ~identical with or without my
> > bits.  That seems a little odd to me considering what those changes
> > do.
> > 
> > > 
> > > Do you have an updated patch against -mm that I can test?
> > 
> > I will soon if you still want to try it. I've fixed the throttle
> > release
> > thing, and am fine tuning the interactivity bits.  I have it working
> > very well now, but want to try to squeeze some more from it.
> > 
> > Drop me a line if you're still interested from the interactivity side,
> > but I think the ls delay reduction has turned out to be a red
> > herring. 
> 
> Just to be clear - this is 2.6.16-rc2-mm1 *without* your patch that I am
> talking about.

Exactly.  2.6.16-rc2-mm1 without my patch has a delay of .15 to .50s.
2.6.16-rc1 with my patch had a reported delay of from .19 to .45s.
That's identical in my book.  My patch to rc1 also contained Con's
changes that are in mm, that's constant.  Subtracting the variable, my
patch, made no difference.  Con's changes may be responsible for the
behavior change, but mine are certainly not.

	-Mike

