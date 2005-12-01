Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbVLAECb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbVLAECb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 23:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbVLAECb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 23:02:31 -0500
Received: from fsmlabs.com ([168.103.115.128]:25731 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751428AbVLAECa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 23:02:30 -0500
X-ASG-Debug-ID: 1133409747-15934-65-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 30 Nov 2005 20:08:08 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: Enabling RDPMC in user space by default
Subject: Re: Enabling RDPMC in user space by default
In-Reply-To: <20051130033808.GJ19515@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0511292030580.17356@montezuma.fsmlabs.com>
References: <20051129151515.GG19515@wotan.suse.de>
 <Pine.LNX.4.61.0511291837050.17356@montezuma.fsmlabs.com>
 <20051130033808.GJ19515@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5747
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005, Andi Kleen wrote:

> The performance counters definitely share some properties with TSC already -
> they definitely won't be synced (because they don't tick in C states etc.)
> so if you change CPUs they won't be monotone.
> 
> But I doubt we'll ever see them running at a different frequency than
> the current P state, which is the big problem RDTSC has now and that's
> why I'm looking for a replacement. That it's faster on P4 is just
> a bonus.
> 
> However it looks like everybody except me hates the idea :/ Or perhaps
> a lot of the opposition was just against the reasonable position
> that profiling should not disturb the NMI watchdogs. I guess not
> everybody values debuggable kernel dumps.

I agree that the NMI watchdog is very important, but my main objection is 
trying to provide a stable interface for this, i would rather see a 
seperate tool do it (as cumbersome as it may be) even if it meant that 
the external tool simply did what you intend on doing in the kernel.

	Zwane

