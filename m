Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUIJJmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUIJJmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUIJJmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:42:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21644 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267353AbUIJJkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:40:40 -0400
Date: Fri, 10 Sep 2004 11:40:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp: kill crash when too much memory is free
Message-ID: <20040910094039.GC11281@atrey.karlin.mff.cuni.cz>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409100001.28781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409100001.28781.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If too much memory is free, swsusp dies in quite a ugly way. Even when
> > it is not neccessary to relocate pagedir, it is proably still
> > neccessary to relocate individual pages. Thanks to Kurt Garloff and
> > Stefan Seyfried...
> > 								Pavel
> > PS: And could I have one brown paper bag, please?
> 
> I applied this and it didn't fix my problems with resuming, unfortunately, but 
> it changed the symptoms.  Namely, if USB modules are not unloaded before 
> suspending, I get:

> This is 100% reproducible (ie unload USB modules and dm_mod, suspend the 
> machine, try to wake it up, hangs solid).
> 
> Can you tell me, please, if there's anything I can compile out/in to debug it 
> a bit more?  Or can I put some printk()s somewhere in the code to get some 
> more info?  Any suggestions welcome.

Can you try my "bigdiff"? Also, does it work okay in 32-bit mode?

									Pavel
