Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWCNTFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWCNTFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbWCNTFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:05:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:52127 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750766AbWCNTFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:05:48 -0500
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped
	memory exits
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com>
References: <1142352926.13256.117.camel@mindpipe>
	 <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 14:05:45 -0500
Message-Id: <1142363146.13256.145.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 18:40 +0000, Hugh Dickins wrote:
> On Tue, 14 Mar 2006, Lee Revell wrote:
> 
> > I've been testign for weeks with 2.6.16-rc1 + the latency trace patch
> > and the longest latencies measured were 10-15ms due to the well known
> > rt_run_flush issue.  Today I got one twice as long, when a Firefox
> > process with a bunch of acroreads in tabs, from a new code path.
> > 
> > It seems to trigger when a process with a large amount of memory swapped
> > out exits.
> > 
> > Can this be solved with a cond_resched?
> 
> Not that easily, I think.
> 
> Are you testing with CONFIG_PREEMPT=y, as I'd expect?  I thought
> cond_resched() adds nothing to that case (and we keep on intending
> but forgetting to make it compile away to nothing in that case).
> Or am I confused?
> 

Thanks for the explanation - I am the one confused (PREEMPT is on so
cond_resched would be pointless).

Lee

