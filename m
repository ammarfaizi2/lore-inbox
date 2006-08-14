Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWHOS6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWHOS6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWHOS6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:58:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12304 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965124AbWHOS6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:58:38 -0400
Date: Mon, 14 Aug 2006 20:13:00 +0000
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andi Kleen <ak@muc.de>, Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060814201300.GA4032@ucw.cz>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz> <20060807122845.GA85602@muc.de> <20060807124855.GB21003@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807124855.GB21003@suse.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Would not preempt_disable fix that?
> > > > 
> > > > Partially, but you still have other problems. Please just get rid
> > > > of it. Why do we have timer code in the kernel if you then chose
> > > > not to use it?
> > >  
> > > The problem is that gettimeofday() is not always fast. 
> > 
> > When it is not fast that means it is not reliable and then you're
> > also not well off using it anyways.
> 
> I assume you wanted to say "When gettimeofday() is slow, it means TSC is
> not reliable", which I agree with. 
> 
> But I need, in the driver, in the no-TSC case use i/o counting, not a
> slow but reliable method. And I can't say, from outside the timing
> subsystem, whether gettimeofday() is fast or slow.

do gettimeofday(); gettimeofday(); gettimeofday();, then compare the
result with gettimeofday(); inb(); gettimeofday(); ?

						Pavel
-- 
Thanks for all the (sleeping) penguins.
