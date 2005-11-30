Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVK3Ai1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVK3Ai1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVK3Ai1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:38:27 -0500
Received: from ns2.suse.de ([195.135.220.15]:18653 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750706AbVK3Ai0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:38:26 -0500
Date: Wed, 30 Nov 2005 01:38:25 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: Andi Kleen <ak@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Stephane Eranian <eranian@hpl.hp.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051130003825.GB19515@wotan.suse.de>
References: <200511291056.32455.raybry@mpdtxmail.amd.com> <1133306966.3271.36.camel@entropy> <20051129233920.GW19515@wotan.suse.de> <200511291850.49853.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511291850.49853.raybry@mpdtxmail.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 06:50:49PM -0600, Ray Bryant wrote:
> On Tuesday 29 November 2005 17:39, Andi Kleen wrote:
> > > Well, if that's all you want them to use RDPMC 0 for, why not just make
> > > PMCs programmable from userspace?
> >
> > First we need to have a cycle counter PMC anyways for the NMI watchdog.
> > So it can as well be used for other purposes.
> >
> 
> Yes, but that assumes having the NMI watchdog around is more important to you 
> than having 4 performance counters available.    I'm perfectly willing to 

Stable kernels are important to everyone. And we can only 
get stable kernels if the bug reports are good. And that needs
the NMI watchdog.

Also see it differently - with the default ticking counter exported you
have a nice relatively reliable (you need to pin to CPUs) way to measure 
cycles of instructions now. Previously that wasn't possible or rather
required one to jump through all kinds of hops to get right. My opinion
is that RDTSC is becoming less and less usable for this kind of stuff,
but since micro measurements are important for many cases it's important
to offer a nice facility for them.

> have the NMI watchdog around by default, since it seems to be useful in most 
> cases.    But if my measurement study needs 4 PMC's to do its job and I am 
> willing to forgo use of the NMI watchdog for that period of time, why 
> shouldn't I be allowed to do that?   We have few enough PMCs anyway, I just 
> don't like the idea of giving one up forever.    I'd much prefer to make that 

You don't give it up - it's just dedicated to counting cycles, free
for everybody to use.

-Andi

