Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbUAJWPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUAJWPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:15:33 -0500
Received: from waste.org ([209.173.204.2]:36500 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265254AbUAJWP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:15:26 -0500
Date: Sat, 10 Jan 2004 16:14:59 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040110221459.GN18208@waste.org>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110004625.GB25089@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 01:46:25AM +0100, Adrian Bunk wrote:
> On Tue, Jan 06, 2004 at 06:08:03PM +1100, Nick Piggin wrote:
> > 
> > Matt Mackall wrote:
> > 
> > >On Tue, Jan 06, 2004 at 05:33:58PM +1100, Nick Piggin wrote:
> > >>Have you considered Adrian Bunk's CPU selection rationalisation work?
> > >>
> > >
> > >Vaguely aware of it.
> > >
> > 
> > Basically, because the types of x86 cpus are only partially ordered,
> > and a the CPU selection somehow tries to follow the rule "this CPU or
> > higher", there ends up being a bit of stuff included which doesn't
> > need to be. Not sure what the savings add up to though...
> >...
> 
> Some savings are possible as a side effect of my patch (the main goal 
> is to make the selection of multiple CPUs more user friendly).
> 
> I'll send the patch and 2 proof of concept space saving patches as 
> replies to this mail.

I like this stuff, but I think the first two bits are probably better
done in mainline proper, perhaps Andrew will consider them now that
2.6.0 is out. The -tiny approach is to make small tweaks on stuff
without diverging far from the mainline infrastructure. I'm trying to
keep most of the patches independent. I've basically already hacked my
owned version of the third bit (cpu support code selection) in an
earlier -tiny release, hadn't noticed the mtrr bits yet.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
