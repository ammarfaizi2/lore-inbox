Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWGZLo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWGZLo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGZLo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:44:26 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:5797
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932527AbWGZLo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:44:26 -0400
Date: Wed, 26 Jul 2006 13:45:34 +0200
From: andrea@cpushare.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "bruce@andrew.cmu.edu" <bruce@andrew.cmu.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] TIF_NOTSC and SECCOMP prctl
Message-ID: <20060726114534.GG32243@opteron.random>
References: <200607180623_MC3-1-C54F-3802@compuserve.com> <20060718132941.GG5726@opteron.random> <20060725214441.GC32243@opteron.random> <20060726080739.GA10574@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726080739.GA10574@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 10:07:39AM +0200, Ingo Molnar wrote:
> 
> * andrea@cpushare.com <andrea@cpushare.com> wrote:
> 
> > Here a repost of the last seccomp patch against current mainline 
> > including the preempt fix. This changes the seccomp API from 
> > /proc/<pid>/seccomp to a prctl (this will produce a smaller kernel) 
> > and it adds a TIF_NOTSC that seccomp sets. Only the current task can 
> > call disable_TSC (obviously because it hasn't a task_t param). This 
> > includes Chuck's patch to give zero runtime cost to the notsc feature.
> 
> please send a patch-queue that is properly split-up: the bugfix, the API 
> change and the TIF_NOTSC improvement.

Which bugfix do you mean? If you mean the preempt fix for the NOTSC
improvement it makes no sense to split it up from the NOTSC
part. There are no other bugfixes (the reduction of the notsc window
isn't strictly a bugfix, since the feature already helped).

I can split the API change from the NOTSC feature, I'll wait some more
days in the hope this one goes in. If it doesn't go in I'll follow
your suggestion and I'll try again later with the split up in the hope
to increase my chances.

>From my point of view it's not urgent to merge it, it's just the
anti-seccomp advocates that should want this patch being merged
urgently.
