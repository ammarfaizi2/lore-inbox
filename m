Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbULMLXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbULMLXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbULMLXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:23:16 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:51333 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262225AbULMLWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:22:42 -0500
Date: Mon, 13 Dec 2004 12:22:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Hans Kristian Rosbach <hk@isphuset.no>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213112229.GS6272@elf.ucw.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <1102936790.17227.24.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102936790.17227.24.camel@linux.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The performance benefit, if any, is often lost in noise during 
> > >  benchmarks and when there, is less than 1%. So I was wondering if you 
> > >  had some specific advantage in mind for this patch? Is there some 
> > >  arch-specific advantage? I can certainly envision disadvantages to lower Hz.
> > 
> > There are apparently some laptops which exhibit appreciable latency between
> > the start of ACPI sleep and actually consuming less power.  The 1ms wakeup
> > frequency will shorten battery life on these machines significantly.  (I
> > forget the exact numbers - Len will know).
> 
> Is there any recommended lower bound setting?
> Would there be a point in recommending lower settings for desktops
> running only text consoles opposed to X desktops?

I tried defining HZ to 10 once, and there are some #if arrays in the
kernel that prevented me from doing that.

Some drivers do timeouts based on jiffies; having HZ=1 may turn 20msec
timeout into 1sec, that could hurt a lot in the error case...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
