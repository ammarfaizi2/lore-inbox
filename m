Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVAHNT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVAHNT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVAHNT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:19:26 -0500
Received: from gprs215-164.eurotel.cz ([160.218.215.164]:60544 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261155AbVAHNTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:19:23 -0500
Date: Sat, 8 Jan 2005 14:19:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Message-ID: <20050108131909.GA7363@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <1105135940.2488.39.camel@desktop.cunninghams> <200501080156.06145.rjw@sisk.pl> <200501081049.02862.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501081049.02862.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thanks for pointing it out.  I have adapted this patch to -mm2, but 
> > unfortunately it does not fix the issue.  Still searching. ;-)
> 
> The regression is caused by the timer driver.  Obviously, turning 
> timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it go away.
> 
> It looks like a locking problem to me.  I'll try to find a fix, although 
> someone who knows more about these things would probably do it faster. :-)

(I do not have time right now, but...)

...you might want to look at i386 time code, they have common
ancestor, and i386 one seems to work.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
