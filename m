Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWCULVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWCULVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWCULU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:20:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8163 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030291AbWCULU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:20:58 -0500
Date: Tue, 21 Mar 2006 12:18:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Willy Tarreau <willy@w.ods.org>
Cc: Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321111850.GA2776@elte.hu>
References: <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu> <1142592375.7895.43.camel@homer> <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer> <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer> <20060321091353.GA25248@w.ods.org> <20060321091422.GA9207@elte.hu> <20060321111552.GA25651@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321111552.GA25651@w.ods.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Willy Tarreau <willy@w.ods.org> wrote:

> On Tue, Mar 21, 2006 at 10:14:22AM +0100, Ingo Molnar wrote:
> > 
> > * Willy Tarreau <willy@w.ods.org> wrote:
> > 
> > > 
> > > On Tue, Mar 21, 2006 at 08:51:38AM +0100, Mike Galbraith wrote:
> > > > On Tue, 2006-03-21 at 07:47 +0100, Willy Tarreau wrote:
> > > > > Hi Mike,
> > > > 
> > > > Greetings!
> > > 
> > > Thanks for the details,
> > > I'll try to find some time to test your code quickly. If this fixes this
> > > long standing problem, we should definitely try to get it into 2.6.17 !
> > 
> > the time window is quickly closing for that to happen though.
> 
> Ingo, Mike,
> 
> it's a great day :-)
> 
> Right now, I'm typing this mail from my notebook which has 8 instances 
> of my exploit running in background. Previously, 4 of them were enough 
> on this machine to create pauses of up to 31 seconds. Right now, I can 
> type normally, and I simply can say that my exploit has no effect 
> anymore ! It's just consuming CPU and nothing else. I also tried to 
> write 0 to grace_g[12] and I find it even more responsive with 0 in 
> those values. I've not had time to do more extensive tests, but I can 
> assure you that the problem is clearly solved for me. I'd like Grant 
> to test ssh on his firewall with it too.

great work by Mike! One detail: i'd like there to be just one default 
throttling value, i.e. no grace_g tunables [so that we have just one 
default scheduler behavior]. Is the default grace_g[12] setting good 
enough for your workload?

	Ingo
