Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVICIHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVICIHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVICIHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:07:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35855 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751216AbVICIG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:06:59 -0400
Date: Sat, 3 Sep 2005 09:06:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050903090650.B26998@flint.arm.linux.org.uk>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509031613.10915.kernel@kolivas.org> <20050903085801.A26998@flint.arm.linux.org.uk> <200509031801.09069.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200509031801.09069.kernel@kolivas.org>; from kernel@kolivas.org on Sat, Sep 03, 2005 at 06:01:08PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 06:01:08PM +1000, Con Kolivas wrote:
> On Sat, 3 Sep 2005 17:58, Russell King wrote:
> > On Sat, Sep 03, 2005 at 04:13:10PM +1000, Con Kolivas wrote:
> > > Noone's ignoring you.
> > >
> > > What we need to do is ensure that dynamic ticks is working properly on
> > > x86 and worth including before anything else. If and when we confirm this
> > > it makes sense only then to try and merge code from the other 2
> > > architectures to as much common code as possible as no doubt we'll be
> > > modifying other architectures we're less familiar with. At that stage we
> > > will definitely want to tread even more cautiously at that stage.
> >
> > dyntick has all the hallmarks of ending up another mess just like the
> > "generic" (hahaha) irq stuff in kernel/irq - it's being developed in
> > precisely the same way - by ignore non-x86 stuff.
> >
> > I can well see that someone will say "ok, this is ready, merge it"
> > at which point we then end up with multiple differing userspace
> > methods of controlling it depending on the architecture, but
> > multiple differing kernel interfaces as well.
> >
> > Indeed, you seem to be at the point where you'd like akpm to merge
> > it.  That sets alarm bells ringing if you haven't considered these
> > issues.
> >
> > I want to avoid that.  Just because a couple of people say "we'll
> > deal with that later" it's no guarantee that it _will_ happen.  I
> > want to ensure that ARM doesn't get fscked over again like it did
> > with the generic IRQ crap.
> 
> Ok I'll make it clearer. We don't merge x86 dynticks to mainline till all are 
> consolidated in -mm.

Does this mean you're seriously going to rewrite bits of it after
you've spent what seems like months sorting out all the problems
currently being found?

Excuse me for being stupid, but I somehow don't see that happening.
Those months would be effectively wasted effort, both on the side
of the people working on the patches and those testing them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
