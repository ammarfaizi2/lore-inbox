Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUGUSiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUGUSiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUGUSiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:38:05 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:59097 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266582AbUGUSiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:38:03 -0400
Date: Wed, 21 Jul 2004 14:34:15 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721183415.GC2206@yoda.timesys>
References: <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FE545E.3050300@yahoo.com.au>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 09:32:46PM +1000, Nick Piggin wrote:
> What do you think about deferring softirqs just while in critical
> sections?
> 
> I'm not sure how well this works, and it is CONFIG_PREEMPT only
> but in theory it should prevent unbounded softirqs while under
> locks without taking the performance hit of doing the context
> switch.

You're still running do_softirq() with preemption disabled, which is
almost as bad as doing it under a lock.

-Scott
