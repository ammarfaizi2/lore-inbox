Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWCNWN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWCNWN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWCNWN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:13:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17873 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932525AbWCNWN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:13:28 -0500
Date: Tue, 14 Mar 2006 23:11:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
Message-ID: <20060314221111.GA7118@elte.hu>
References: <20060314101811.GA10450@elte.hu> <Pine.LNX.4.44L0.0603142256050.1291-100000@lifa01.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603142256050.1291-100000@lifa01.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> On Tue, 14 Mar 2006, Ingo Molnar wrote:
> 
> >
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> >
> > [...]
> > no. We have to run deadlock detection to avoid things like circular lock
> > dependencies causing an infinite schedule+wakeup 'storm' during priority
> > boosting. (like possible with your wakeup based method i think)
> No, all tasks would just settle on the highest priority and then the
> wakeups would stop.

you are right, that shouldnt be possible. But how about other, SMP 
artifacts? What if the woken up task runs on another CPU, and the whole 
chain of boosting is thus delayed?

	Ingo
