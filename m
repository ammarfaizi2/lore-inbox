Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWBMDD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWBMDD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 22:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWBMDD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 22:03:56 -0500
Received: from mail.gmx.net ([213.165.64.21]:22757 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751098AbWBMDDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 22:03:55 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Con Kolivas <kernel@kolivas.org>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139787578.2739.13.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
	 <1139515605.30058.94.camel@mindpipe>  <1139553319.8850.79.camel@homer>
	 <1139752033.27408.20.camel@homer>  <1139771016.19342.253.camel@mindpipe>
	 <1139780193.7837.7.camel@homer>  <1139787578.2739.13.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 04:09:29 +0100
Message-Id: <1139800169.7595.24.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 18:39 -0500, Lee Revell wrote:
> On Sun, 2006-02-12 at 22:36 +0100, MIke Galbraith wrote:
> > On Sun, 2006-02-12 at 14:03 -0500, Lee Revell wrote:
> > > On Sun, 2006-02-12 at 14:47 +0100, MIke Galbraith wrote:
> > > > If you think it's the scheduler, how about try the patch below.  It's
> > > > against 2.6.16-rc2-mm1, and should tell you if it is the interactivity
> > > > logic in the scheduler or not.  I don't see other candidates in there,
> > > > not that that means there aren't any of course. 
> > > 
> > > I'll try, but it's a serious pain for me to build an -mm kernel.  A
> > > patch against 2.6.16-rc1 would be much easier.
> > 
> > Ok, here she comes.  It's a bit too reluctant to release a task so it
> > can reach interactive status at the moment, but for this test, that's a
> > feature. In fact, for this test, it's probably best to jump straight to
> > setting both g1 and g2 to zero.
> 
> Not only does this fix my "time ls" test case, it seems to drastically
> improve interactivity for my desktop apps.  I was really being plagued
> by weird stalls, it's much smoother now.

Yeah, but under load, that reluctance to release is fairly annoying...

> 
> Now to regression test it...

...and may cause test applications to not reach their proper priority
before measurement begins.

	-Mike

