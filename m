Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752337AbWCPKuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbWCPKuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbWCPKuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:50:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64408 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752168AbWCPKuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:50:54 -0500
Date: Thu, 16 Mar 2006 11:50:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Stefan Seyfried <seife@suse.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: does swsusp suck after resume for you?
Message-ID: <20060316105054.GB9399@atrey.karlin.mff.cuni.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603162133.26771.kernel@kolivas.org> <20060316104630.GA9399@atrey.karlin.mff.cuni.cz> <200603162147.56725.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603162147.56725.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thursday 16 March 2006 21:46, Pavel Machek wrote:
> > > On Thursday 16 March 2006 04:59, Pavel Machek wrote:
> > > The tunable in /proc/sys/vm/swap_prefetch is now bitwise ORed:
> > > 1	= Normal background swap prefetching when load is light
> > > 2	= Aggressively swap prefetch as much as possible
> > >
> > > And once the "aggressive" bit is set it will prefetch as much as it can
> > > and then disable the aggressive bit. Thus if you set this value to 3 it
> > > will prefetch aggressively and then drop back to the default of 1. This
> > > makes it easy to simply set the aggressive flag once and forget about it.
> > > I've booted and tested this feature and it's working nicely. Where
> > > exactly you'd set this in your resume scripts I'm not sure. A rolled up
> > > patch against 2.6.16-rc6-mm1 is here for simplicity:
> > > http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_
> > >suspend_test.patch
> > >
> > > and the incremental on top of the 4 patches pending for the next -mm is
> > > below.
> > >
> > > Comments and testers most welcome.
> >
> > Looks okay, but... what happens if I set /proc/sys/vm/swap_prefetch to
> > "2"? Do nothing but do it agresively?
> >
> > Maybe having 0 = off, 1 = normal, 2 = aggressive would be less error
> > prone for the users.
> 
> 2 means aggressively prefetch as much as possible and then disable swap 
> prefetching from that point on. Too confusing?

Ahha... oops, yes, clever; no, I guess keep it.
								Pavel
-- 
Thanks, Sharp!
