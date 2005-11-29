Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVK2UvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVK2UvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVK2UvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:51:13 -0500
Received: from cantor.suse.de ([195.135.220.2]:55936 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932400AbVK2UvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:51:13 -0500
Date: Tue, 29 Nov 2005 21:51:09 +0100
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       acpi-devel@lists.sourceforge.net, nando@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Message-ID: <20051129205108.GQ19515@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com> <20051129195336.GP19515@wotan.suse.de> <1133296540.4627.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133296540.4627.7.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 03:35:39PM -0500, Lee Revell wrote:
> On Tue, 2005-11-29 at 20:53 +0100, Andi Kleen wrote:
> > We're mostly addressing it - there are problems left, but
> > overall it's looking good. The remaining problem is 
> > an education issue of users to not use RDTSC directly, 
> > but use gettimeofday/clock_gettime 
> 
> No the issue is to make gettimeofday fast enough that the people who
> currently have to use the TSC can use it.  Right now it's 1500-3000 nsec
> or so, Vojtech mentioned that he has a patch that could reduce that to

It's only that slow if the hardware can't do better.

And the kernel makes it only slow when using RDTSC directly
is unsafe - so if you use it directly thinking the kernel cheats
you for your cycles you're just shoting yourself in the own foot.

> 150-300 nsec.

If you have capable hardware it can already do much better.

-Andi
