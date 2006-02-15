Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422962AbWBOFWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422962AbWBOFWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422961AbWBOFWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:22:15 -0500
Received: from mail.gmx.de ([213.165.64.21]:45972 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422962AbWBOFWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:22:14 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139977373.2733.9.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131637.43335.kernel@kolivas.org> <1139810224.7935.9.camel@homer>
	 <200602131708.52342.kernel@kolivas.org>  <1139812538.7744.8.camel@homer>
	 <1139812725.2739.94.camel@mindpipe>  <1139814504.8124.6.camel@homer>
	 <1139820181.3202.2.camel@mindpipe>  <1139834106.7831.115.camel@homer>
	 <1139977373.2733.9.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 06:22:20 +0100
Message-Id: <1139980940.24148.47.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 23:22 -0500, Lee Revell wrote:
> On Mon, 2006-02-13 at 13:35 +0100, MIke Galbraith wrote:
> > On Mon, 2006-02-13 at 03:43 -0500, Lee Revell wrote:
> > > On Mon, 2006-02-13 at 08:08 +0100, MIke Galbraith wrote:
> > > > On Mon, 2006-02-13 at 01:38 -0500, Lee Revell wrote:
> > > > > Do you know which of those changes fixes the "ls" problem?
> > > > 
> > > > No, it could be either, both, or neither.  Heck, it _could_ be a
> > > > combination of all of the things in my experimental tree for that
> > > > matter.  I put this patch out there because I know they're both bugs,
> > > > and strongly suspect it'll cure the worst of the interactivity related
> > > > delays.
> > > > 
> > > > I'm hoping you'll test it and confirm that it fixes yours.
> > > 
> > > Nope, this does not fix it.  "time ls" ping-pongs back and forth between
> > > ~0.1s and ~0.9s.  Must have been something else in the first patch.
> > 
> > Hmm.  Thinking about it some more, it's probably more than this alone,
> > but it could well be the boost qualifier I'm using...
> 
> OK, with 2.6.16-rc2-mm1, "ls" bounces around between 0.15s and 0.50s.
> Better than mainline but the large seemingly random variance is still
> perceptible and annoying.  And, "ls | cat" behaves about the same as
> "ls", while on mainline it was consistently faster (!).

Ok.  That means the reduction in fluctuation had nothing to do with my
changes.  It also suggests that there may be something of a regression
in the changes that are in mm, which I also carried in my patch, since
the timing for both kernels appear to be ~identical with or without my
bits.  That seems a little odd to me considering what those changes do.

> 
> Do you have an updated patch against -mm that I can test?

I will soon if you still want to try it. I've fixed the throttle release
thing, and am fine tuning the interactivity bits.  I have it working
very well now, but want to try to squeeze some more from it.

Drop me a line if you're still interested from the interactivity side,
but I think the ls delay reduction has turned out to be a red herring.

	-Mike

