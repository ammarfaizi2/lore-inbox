Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVDCW5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVDCW5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVDCW5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 18:57:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19679 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261938AbVDCW5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 18:57:41 -0400
Date: Mon, 4 Apr 2005 00:57:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re(2): fix u32 vs. pm message t in usb
Message-ID: <20050403225729.GD13466@elf.ucw.cz>
References: <20050403193216.961D5194084@smtp.etmail.cz> <200504031301.02179.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504031301.02179.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, you obviously have easy access to usb development trees...
> > Do you think you could just take this patch as a basis and fix
> > remaining u32 vs pm-message-t in usb? --p  
> 
> Fixing the "sparse -Wbitwise" messages, and addressing some other
> behavior changes/bugs that crept in, was the idea.  That's already
> done, but _without_ taking this as a basis (or breaking the sysfs
> support etc).

Okay, if you fixed -Wbitwise, it should be all fixed...

> The patches I sent fix everything I had time to test (just a subset
> of the dozens of cases previously tested, probably covering the main
> stuff that got broken) except the non-PCI platform_bus drivers where
> pm_message_t has discarded essential functionality.  (Notably, info
> about whether device clocks and/or power must be turned off.)

At what places is essential functionality lost? I thought that u32
state is pretty much always 3 ;-). Is there platform where it is not
the case?

Could you push also trivial bits that you could not test? I'd like to
get rid of all "u32 state"s...

> p.s. PCI-express patches don't belong with USB patches.  :)

Oops, sorry. Same maintainer, though ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
