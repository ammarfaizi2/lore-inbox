Return-Path: <linux-kernel-owner+w=401wt.eu-S932206AbXADA3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbXADA3S (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbXADA3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:29:18 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:37877
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbXADA3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:29:17 -0500
Date: Wed, 3 Jan 2007 16:29:10 -0800
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Message-ID: <20070104002909.GA31682@gnuppy.monkey.org>
References: <20070104001225.GA31434@gnuppy.monkey.org> <9D2C22909C6E774EBFB8B5583AE5291C01A4FB7D@fmsmsx414.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C01A4FB7D@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 04:25:46PM -0800, Chen, Tim C wrote:
> Earlier I used latency_trace and figured that there was read contention
> on mm->mmap_sem during call to _rt_down_read by java threads
> when I was running volanomark.  That caused the slowdown of the rt
> kernel
> compared to non-rt kernel.  The output from lock_stat confirm
> that mm->map_sem was indeed the most heavily contended lock.

Can you sort the output ("sort -n" what ever..) and post it without the
zeroed entries ?

I'm curious about how that statistical spike compares to the rest of the
system activity. I'm sure that'll get the attention of Peter as well and
maybe he'll do something about it ? :)

bill

