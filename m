Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUIJWm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUIJWm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUIJWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:37:50 -0400
Received: from gprs40-132.eurotel.cz ([160.218.40.132]:43597 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268008AbUIJW33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:29:29 -0400
Date: Sat, 11 Sep 2004 00:29:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp: kill crash when too much memory is free
Message-ID: <20040910222915.GC1347@elf.ucw.cz>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409100001.28781.rjw@sisk.pl> <20040910094039.GC11281@atrey.karlin.mff.cuni.cz> <200409101926.30902.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409101926.30902.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you try my "bigdiff"? Also, does it work okay in 32-bit mode?
> 
> Well, the good news is that it sort of works.  Still, there are some bad news, 
> as usual. ;-)

So it sort-of-works, 32-bit and 64-bit mode? Good.

> First, to make the box wake up, I have to unload ohci_hcd and everything that 
> sits on IRQ11 before suspending (on my system that is sk98lin, yenta_socked, 
> and ohci1394).  If you want me to show what happens if I don't unload these 
> modules, I'll be able to grab some traces in a couple of hours. ;-)  Also, I 
> have to compile out the frequency scaling, because otherwise it hangs solid 
> at some time after wake-up.
> 
> Second, after it's woken up, it seems to be very, _very_ slow, and the reason 
> is indicated by this:

Hmm, I do not know what nForce3 is (it should use better name at the
minimum), but that driver probably needs some work.


>   5:    6656316          XT-PIC  NVidia nForce3
....
>   5:    6680145          XT-PIC  NVidia nForce3

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
