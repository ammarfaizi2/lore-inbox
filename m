Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbVHFBR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbVHFBR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 21:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbVHFBRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 21:17:18 -0400
Received: from waste.org ([216.27.176.166]:4766 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263107AbVHFBRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 21:17:07 -0400
Date: Fri, 5 Aug 2005 18:16:41 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>,
       davem@davemloft.net
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050806011641.GY8074@waste.org>
References: <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <20050805212610.GA8266@wotan.suse.de> <20050805214224.GW8074@waste.org> <20050805215118.GE8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805215118.GE8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:51:18PM +0200, Andi Kleen wrote:
> > > If that was the policy it would be a quite dumb one and make netpoll
> > > totally unsuitable for production use. I hope it is not.
> > 
> > Suggest you rip __GFP_NOFAIL out of JBD before complaining about this.
> 
> So you're suggesting we should become as bad at handling networking
> errors as we are at handling IO errors?  

No, I'm suggesting that the machine will hang forever sometimes and no
amount of patching up netpoll or JBD, etc. will fix that. A hardware
watchdog is a requirement for robust failover anyway and if you think
otherwise, you're dreaming.

And for reference, both are examples of theoretical
should-never-happen memory allocation failures.
 
> > > Dave, can you please apply the timeout patch anyways?
> > 
> > Yes, let's go right over the maintainer's objections almost
> > immediately after he chimes into the thread. I'll spare the list the
> > colorful language this inspires.
> 
> Sure when the maintainer has a unreasonable position on something
> I think that's justified. Yours in this case is clearly unreasonable.

What's clear is that you didn't like my position from my very first
post in this thread and immediately went for the nuclear option
without even trying to discuss it.

Are you even aware that the patch we're discussing here is for a problem
that has yet to be observed and that Steven's initial analysis had
missed a couple things?

-- 
Mathematics is the supreme nostalgia of our time.
