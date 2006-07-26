Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWGZAY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWGZAY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGZAY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:24:28 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:56333 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932506AbWGZAY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:24:28 -0400
Date: Tue, 25 Jul 2006 20:20:43 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060726002043.GA5192@localhost.localdomain>
References: <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org> <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C6B117.80300@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 05:02:31PM -0700, H. Peter Anvin wrote:
> Neil Horman wrote:
> >On Wed, Jul 26, 2006 at 01:29:25AM +0200, Segher Boessenkool wrote:
> >>>Yes, but if its in trade for something thats being used currently  
> >>>which hurts
> >>>more (case in point being the X server), using this solution is a  
> >>>net gain.
> >>...in the short term.
> >>
> >And for any arch that isn't able to leverage a speedup via a vdso 
> >implementation
> >of a simmilar functionality in the long term
> 
> If they can't, then they can't use your driver either.
> 
Whats your reasoning here?

> >>>I'm not arguing with you that adding a low res gettimeofday  
> >>>vsyscall is a better
> >>>long term solution, but doing that requires potentially several  
> >>>implementations
> >>>in the C library accross a range of architectures, some of which  
> >>>may not be able
> >>>to provide a time solution any better than what the gettimeofday  
> >>>syscall
> >>>provides today.  The /dev/rtc solution is easy, available right  
> >>>now, and applies
> >>>to all arches.
> >>"All"?
> >>
> >It there any arch for which the rtc driver doesn't function?
> 
> Yes, there are plenty of systems which don't have an RTC, or have an RTC 
> which can't generate interrupts.
> 
Ok, for those implementations which don't have an RTC that the rtc driver can
drive, the mmap functionality will not work, but at that point what interface
are you left with at all for obtaining periodic time?
Neil

> 	-hpa
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
