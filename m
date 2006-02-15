Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWBOTar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWBOTar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWBOTaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:30:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:50118 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932458AbWBOTaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:30:46 -0500
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602151259270.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
	 <1139827927.4932.17.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602131208050.30994@scrub.home>
	 <20060214074151.GA29426@elte.hu>
	 <Pine.LNX.4.61.0602141113060.30994@scrub.home>
	 <20060214122031.GA30983@elte.hu>
	 <Pine.LNX.4.61.0602150033150.30994@scrub.home>
	 <20060215091959.GB1376@elte.hu>
	 <Pine.LNX.4.61.0602151259270.30994@scrub.home>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 12:43:54 -0800
Message-Id: <1140036234.27720.8.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 13:26 +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 15 Feb 2006, Ingo Molnar wrote:
> 
> > yeah, agreed. That will be accurately fixed via GTOD's per-hwclock 
> > resolution values. It will have another advantage as well: e.g. the 
> > whole of m68k wont be penalized via CONFIG_TIME_LOW_RES for having a 
> > handful of sub-arches (Apollo, Sun3x, Q40) that dont have a higher 
> > resolution timer - every clock can define its own resolution. You could 
> > help that effort by porting m68k to use GTOD ;-)
> 
> I'll do that as soon as the perfomance is equal or better than what we 
> have right now and expensive 64bit math in the fast path, where it's 
> provably a waste, is not exactly encouraging. I already provided all the 
> math and code to keep it cheap and (relatively) simple, but I don't have 
> the time to work constantly on it, so if you'd help to integrate it into 
> John's work it would go a lot faster.

Hey Roman,
	I just wanted to make sure you know I'm not ignoring your suggestions.
I do appreciate the time you have spent, and I have been continuing to
work on implementing your idea. Unfortunately the code is not trivial
and very much hurts the readability. I expect thats a sacrifice that
will be necessary, but hopefully after some review cycles we'll be able
to come to something we both like.

I'm hoping to have a first pass patch I can mail this week.

thanks
-john

