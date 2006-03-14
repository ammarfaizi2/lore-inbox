Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWCNMaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWCNMaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWCNMaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:30:01 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:7897 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751546AbWCNMaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:30:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
Date: Tue, 14 Mar 2006 23:29:30 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1142329861.9710.16.camel@homer> <200603142307.01682.kernel@kolivas.org> <1142339099.11303.12.camel@homer>
In-Reply-To: <1142339099.11303.12.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603142329.31281.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 23:24, Mike Galbraith wrote:
> On Tue, 2006-03-14 at 23:07 +1100, Con Kolivas wrote:
> > On Tuesday 14 March 2006 22:56, Mike Galbraith wrote:
> > > With my full change set, you _will_ see differences with interbench.
> > > Interbench will say you're better off without my changes in fact.  Run
> > > any of the known scheduler exploits without my changes, and then with,
> > > and you'll likely consider revising interbench a little methinks ;-)
> >
> > Not really; interbench is after interactivity, and exploit prone designs
> > don't necessarily have bad interactivity. If you can reproduce the nfs
> > case as an extra load for interbench I'd love to include it.
>
> Yes, interbench tries to assess interactivity, but it gets it totally
> wrong sometimes.  It runs it's measurement at a high priority, and calls
> the result good if it was able to get as much cpu as it wants. 

You misunderstand the code and/or my intent. There is a thread at high 
priority that does timing and signalling only, but the loads and benchmarked 
simulations are run at normal priority (nice 0) or at a nice level set by 
yourself in the options.

> The very 
> code responsible for good interbench numbers is also responsible for
> starvation problems.  It's the long sleep logic.  That logic makes my
> box suck rocks under thud and irman2.
>
> Don't forget, every one of the exploits I test with were posted by
> people who were experiencing scheduler problems in real life.  Try to
> use your box while running those exploits, and then tell me that you
> agree with interbench's assessment.

Ok you feel interbench is an irrelevant benchmark for your test case and I'm 
not going to bother arguing since it doesn't claim to test every single 
situation. 

That doesn't change the fact that your patch has only been tested by yourself. 
Don't forget I'm still agreeing with your change, I'm just suggesting the 
usual patch precautions.

Cheers,
Con
