Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265771AbTGDEKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 00:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTGDEKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 00:10:47 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:64458 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265771AbTGDEKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 00:10:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Tom Sightler <ttsig@tuxyturvy.com>
Subject: Re: 2.5.74-mm1 and Con Kolivas' CPU scheduler work
Date: Fri, 4 Jul 2003 14:25:29 +1000
User-Agent: KMail/1.5.2
Cc: "ismail (cartman) donmez" <kde@myrealbox.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <200307031936.34458.kde@myrealbox.com> <200307041229.06238.kernel@kolivas.org> <1057291914.5681.11.camel@iso-8590-lx.zeusinc.com>
In-Reply-To: <1057291914.5681.11.camel@iso-8590-lx.zeusinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307041425.29828.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003 14:11, Tom Sightler wrote:
> On Thu, 2003-07-03 at 22:29, Con Kolivas wrote:
> > Ah yes I believe I know this issue. The problem is the parent spinning
> > madly waiting for the child and it is the parent that starves the child.
> > While this is not a fix, if you can reproduce the problem can you try
> > changing CHILD_PENALTY in kernel/sched.c from 50 to 100 and see if that
> > makes the problem go away? I mentioned this hidden in a thread a while
> > ago, and am trying to get a reasonable fix.
>
> Well, perhaps I spoke too soon about this particular issues.  I have
> just compiled 2.5.74-mm1 and it seems to be much better behaved that my
> previous kernel (2.5.72-mm2).  I can no longer reproduce the issue with
> this new kernel but the problem is easily reproducible with my older
> kernel.  Does 2.5.74-mm1 have a recent version of your patches (I know
> it has some variation of your patches but you've been cracking them out
> pretty quick lately).  I've run testing with my horror cases of
> Crossover Plugin and multiple Crossover Office applications running
> simultaneously and all programs seem responsive, these cases caused all
> kinds of audio skipping and pauses on the system before.
>
> I'm still running some other tests that seem to be showing some
> strangeness but I need to do some more test on both kernels before I
> really reports them.
>
> Thanks for your hard work on these issues, for my workload things seem
> to be getting quite a bit better.

Heh well that's nice. The last patch posted on my site ( 
kernel.kolivas.org/2.5 ) is the same as in -mm1. There is no newer patch yet, 
but I've got some changes coming to apply on top pretty soon. Hopefully these 
will address your "strangeness". :)

Con

