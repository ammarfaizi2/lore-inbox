Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVBOUcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVBOUcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVBOUaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:30:13 -0500
Received: from gprs214-212.eurotel.cz ([160.218.214.212]:36238 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261855AbVBOUW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:22:26 -0500
Date: Tue, 15 Feb 2005 21:22:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, mhf@berlios.de,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.11-rc[234] setfont fails on i810 after resume from ACPI-S3
Message-ID: <20050215202212.GK7338@elf.ucw.cz>
References: <20050215122233.22605728.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215122233.22605728.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Any thoughts on this one?  We should come back from resume in 30-row mode,
> shouldn't we?

Well, current state of video resume is "we are happy to see anything
at all". 

> HW info
> 
> Using vga=0xf07, default8x16 font, display has 30 lines
> 
> On powerup from S3 console has only 25 lines but still scrolls 
> at 30 lines. Setfont historically fixes it. 
> 
> Tested with 2.6.10, 2.6.11-rc1: OK
> 
> Tested with 2.6.11-rc2-Vanilla and 2.6.11-rc[234]+swsusp2.
> When using setfont, screen goes blank. Power up after S3
> returns console in 25 lines mode with 30 lines scroll. 
> Several attempts - same result.

So... screen goes blank even when suspend is not involved, right?
Sounds like a bug to me ;-).

> Another bug I see only on this HW and only with 2.6 is that
> when - and only when - using gentoo emerge --usepackage in
> text console, scroll area resets to _25_ when portage 
> "dumps" the (binary) package contents which scrolls pretty
> fast. I was unable to reproduce this in any other way. 
> Tried also echo loop in bash but perhaps it is too slow
> or not random enough. Note that 2.4.2[789] no problem.

Well, dumping random stuff to console can produce funny results. I'd
call that normal. Try cat /dev/urandom, that should be "enough
random".

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
