Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWBLXXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWBLXXt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWBLXXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:23:49 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8322 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751015AbWBLXXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:23:49 -0500
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: Lee Revell <rlrevell@joe-job.com>
To: MIke Galbraith <efault@gmx.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Con Kolivas <kernel@kolivas.org>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139780193.7837.7.camel@homer>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
	 <1139515605.30058.94.camel@mindpipe>  <1139553319.8850.79.camel@homer>
	 <1139752033.27408.20.camel@homer>  <1139771016.19342.253.camel@mindpipe>
	 <1139780193.7837.7.camel@homer>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 18:23:47 -0500
Message-Id: <1139786627.2739.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 22:36 +0100, MIke Galbraith wrote:
> On Sun, 2006-02-12 at 14:03 -0500, Lee Revell wrote:
> > On Sun, 2006-02-12 at 14:47 +0100, MIke Galbraith wrote:
> > > If you think it's the scheduler, how about try the patch below.  It's
> > > against 2.6.16-rc2-mm1, and should tell you if it is the interactivity
> > > logic in the scheduler or not.  I don't see other candidates in there,
> > > not that that means there aren't any of course. 
> > 
> > I'll try, but it's a serious pain for me to build an -mm kernel.  A
> > patch against 2.6.16-rc1 would be much easier.
> 
> Ok, here she comes.  It's a bit too reluctant to release a task so it
> can reach interactive status at the moment, but for this test, that's a
> feature. In fact, for this test, it's probably best to jump straight to
> setting both g1 and g2 to zero.

Thanks, this solves the "ls" problem I was having!  The strange
"oscillating" behavior is gone, now it consistently takes 0.19-0.45s.

It's still not as consistent as "time ls | cat", which takes 0.19-0.26s,
but MUCH better.

Lee

