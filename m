Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVK3Cdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVK3Cdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVK3Cdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:33:54 -0500
Received: from fsmlabs.com ([168.103.115.128]:60105 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750783AbVK3Cdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:33:53 -0500
X-ASG-Debug-ID: 1133318031-28783-51-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 29 Nov 2005 18:39:32 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: Enabling RDPMC in user space by default
Subject: Re: Enabling RDPMC in user space by default
In-Reply-To: <20051129151515.GG19515@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0511291837050.17356@montezuma.fsmlabs.com>
References: <20051129151515.GG19515@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5711
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Tue, 29 Nov 2005, Andi Kleen wrote:

> I'm considering to enable CR4.PCE by default on x86-64/i386. Currently it's 0
> which means RDPMC doesn't work. On x86-64 PMC 0 is always programmed
> to be a cycle counter, so it would be useful to be able to access
> this for measuring instructions. That's especially useful because RDTSC 
> does not necessarily count cycles in the current P state (already
> the case on Intel CPUs and AMD's future direction seems to also
> to decouple it from cycles) Drawback is that it stops during idle, but 
> that shouldn't be a big issue for normal measuring. It's not useful
> as a real timer anyways.

Some processor implementations don't have a performance counter which 
ticks during the idle thread either.

> Any comments on this? 

I think that this should be best left to a profiling tool to configure and 
not a general kernel facility. I also have very little faith in processor 
vendors not doing to performance counters what was done to the TSC.

	Zwane

