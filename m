Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUG2T14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUG2T14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUG2T1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:27:12 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:30991 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S264973AbUG2TZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:25:26 -0400
Date: Thu, 29 Jul 2004 12:25:10 -0700
To: Scott Wood <scott@timesys.com>
Cc: Bill Huey <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040729192510.GA11917@nietzsche.lynx.com>
References: <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040722185308.GC4774@yoda.timesys> <20040722194513.GA32377@nietzsche.lynx.com> <20040728064547.GA16176@elte.hu> <20040728205211.GC6685@yoda.timesys> <20040729182110.GA16419@elte.hu> <20040729183626.GA11652@nietzsche.lynx.com> <20040729191752.GB27701@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729191752.GB27701@yoda.timesys>
User-Agent: Mutt/1.5.6+20040722i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:17:52PM -0400, Scott Wood wrote:
> On Thu, Jul 29, 2004 at 11:36:26AM -0700, Bill Huey wrote:
> There are legitimate reasons to use smp_processor_id() outside of a
> non-preemptible region, though.  These include debugging
> printks/logging, and situations where the awareness of CPU is for
> optimization rather than correctness (for example, using per-cpu data
> with per-cpu locks, which are only contended if preemption occurs, or
> per-cpu counters incremented with atomic operations (or where counter
> accuracy is not critical)).
> 
> The detection mechanism we used in 2.4 was simply to grep for
> smp_processor_id and check/fix everything manually (which is somewhat
> tedious, but there aren't *too* many instances in core code, and many
> uses are similar to one another).

That's a better method. But if there's a need for a kind of runtime
detector, I guess you could do that. The use of smp_processor_id() should
be seldom enough that manually fixing all of the points really should
be the solution.

bill

