Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVAGV2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVAGV2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVAGVNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:13:48 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:12957 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261622AbVAGVMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:12:31 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200501071620.j07GKrIa018718@localhost.localdomain>
References: <200501071620.j07GKrIa018718@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 16:12:28 -0500
Message-Id: <1105132348.20278.88.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 11:20 -0500, Paul Davis wrote:
> >On Fri, Jan 07, 2005 at 10:41:40AM -0500, Paul Davis wrote:
> >> 
> >> fine, so the mlock situation may have improved enough post-2.6.9 that
> >> it can be considered fixed. that leaves the scheduler issue. but
> >> apparently, a uid/gid solution is OK for mlock, and not for the
> >> scheduler. am i missing something?
> >
> >I think you skipped a step. You don't have a scheduler requirement, you have
> >a latency requirement. You currently *solve* that latency requirement via a
> >scheduler "hack", yet is quite clear that the "hard" realtime solution is
> >most likely not the right approach. Note that I'm not saying that you
> 
> Why is that clear? In just about every respect, realtime audio has the
> same characteristics as hard realtime, except that nobody gets hurt
> when a deadline is missed :) We have an IRQ source, and a deadline
> (sometimes on the sub-msec range, but more typically 1-5msec) for the
> work that has to be done. This deadline is tight enough that the task
> essentially *has* to run with SCHED_FIFO scheduling, because doing
> almost anything else instead will cause the deadline to be missed. 
> 

It's not like hard realtime, it is.  All that makes a hard RT system is
that missing a deadline means the system has utterly failed.  How is
this any different than an xrun causing a loud pop or click in a live
performance?

Really, I think Linux has owned the server space for so long that some
folks on this list are getting hubristic.  Just because you have the
best server OS does not mean it's the best at everything.

Lee

