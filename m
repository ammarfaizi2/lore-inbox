Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbULLQiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbULLQiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 11:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbULLQhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 11:37:40 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:18051 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262088AbULLQgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 11:36:07 -0500
Date: Sun, 12 Dec 2004 17:35:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041212163547.GB6286@elf.ucw.cz>
References: <20041211142317.GF16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211142317.GF16322@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The below patch allows to set the HZ dynamically at boot time with
> command line parameter. HZ=1000 HZ=100 HZ=333 any other value just works
> (though certain value may cause more or less drift to the system time
> advance/decrease).
> 
> Is there any interest from the mainline developers to merge this into
> 2.6? I'm getting requests for this feature being forward ported to
> 2.6 (both for batch jobs and for the powersaved that can trim the hz
> down to 80mhz). It should be up to the user to choose the HZ like it was
> in 2.4-aa.
> 
> This patch is quite intrusive since many HZ visible to userspace have to
> be converted to USER_HZ, and most important because HZ isn't available
> at compile time anymore and every variable in function of HZ must be
> either changed to be in function of USER_HZ or it must be initialized at
> runtime. The code has debugging code (optional at compile time) so that
> I can guarantee that there cannot be any regression.
> 
> Technically this makes a lot of sense to me (well, you can guess why I
> implemented it in the first place), at least in archs where one cannot
> reprogram the timer chip in a performant way (to stop timer ticks
> completely until the next posted timer). This is in production for years
> in SLES8 btw.
> 
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa3/9999_zzz-dynamic-hz-5.gz

It certainly helps with singing capacitors... What is overhead of
this?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
