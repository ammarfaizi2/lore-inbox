Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWCNVYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWCNVYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWCNVYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:24:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2485 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751009AbWCNVYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:24:24 -0500
Date: Tue, 14 Mar 2006 22:22:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped memory exits
Message-ID: <20060314212207.GC23458@elte.hu>
References: <1142352926.13256.117.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142352926.13256.117.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> I've been testign for weeks with 2.6.16-rc1 + the latency trace patch 
> and the longest latencies measured were 10-15ms due to the well known 
> rt_run_flush issue.  Today I got one twice as long, when a Firefox 
> process with a bunch of acroreads in tabs, from a new code path.
> 
> It seems to trigger when a process with a large amount of memory 
> swapped out exits.

btw., one good way to get such things fixed is to code up a testcase: a 
.c file that just has to be run to reproduce the latency. It might be 
less trivial to code that up in some cases (like this one - e.g. you 
might have to first get a large chunk of memory swapped out which isnt 
easy), but i think it's still worth the effort, as that way you can 
gently pressure us lazy upstream maintainers to act quicker, and we can 
also easily verify whether the fix does the trick :-)

	Ingo
