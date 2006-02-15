Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWBOM0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWBOM0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWBOM0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:26:17 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58503 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751138AbWBOM0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:26:16 -0500
Date: Wed, 15 Feb 2006 13:26:01 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
In-Reply-To: <20060215091959.GB1376@elte.hu>
Message-ID: <Pine.LNX.4.61.0602151259270.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
 <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
 <20060214074151.GA29426@elte.hu> <Pine.LNX.4.61.0602141113060.30994@scrub.home>
 <20060214122031.GA30983@elte.hu> <Pine.LNX.4.61.0602150033150.30994@scrub.home>
 <20060215091959.GB1376@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 15 Feb 2006, Ingo Molnar wrote:

> yeah, agreed. That will be accurately fixed via GTOD's per-hwclock 
> resolution values. It will have another advantage as well: e.g. the 
> whole of m68k wont be penalized via CONFIG_TIME_LOW_RES for having a 
> handful of sub-arches (Apollo, Sun3x, Q40) that dont have a higher 
> resolution timer - every clock can define its own resolution. You could 
> help that effort by porting m68k to use GTOD ;-)

I'll do that as soon as the perfomance is equal or better than what we 
have right now and expensive 64bit math in the fast path, where it's 
provably a waste, is not exactly encouraging. I already provided all the 
math and code to keep it cheap and (relatively) simple, but I don't have 
the time to work constantly on it, so if you'd help to integrate it into 
John's work it would go a lot faster.

bye, Roman
