Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVCPTVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVCPTVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVCPTUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:20:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4259 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262758AbVCPTUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:20:21 -0500
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
From: Lee Revell <rlrevell@joe-job.com>
To: rostedt@goodmis.org
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	 <20050315120053.GA4686@elte.hu>
	 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	 <20050315133540.GB4686@elte.hu>
	 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	 <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org>
	 <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org>
	 <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org>
	 <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
	 <20050316031909.08e6cab7.akpm@osdl.org>
	 <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
	 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
	 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 14:20:17 -0500
Message-Id: <1111000818.21369.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 12:47 -0500, Steven Rostedt wrote:
> 
> On Wed, 16 Mar 2005, Steven Rostedt wrote:
> 
> >
> > Hi Ingo,
> >
> > I just ran this with PREEMPT_RT and it works fine.
> 
> Not quite, and I will assume that some of the other patches I sent have
> this same problem.  The jbd_trylock_bh_state really scares me. It seems
> that in fs/jbd/commit.c in journal_commit_transaction we have the
> following code:

I am a bit confused, big surprise.  Does this thread still have anything
to do with this trace from my "Latency regressions" bug report?

http://www.alsa-project.org/~rlrevell/2912us

The problem only is apparent with PREEMPT_DESKTOP and "data=ordered".

PREEMPT_RT has always worked perfectly.

Lee

