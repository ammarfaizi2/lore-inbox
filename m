Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUIJKpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUIJKpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUIJKpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:45:12 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:17628 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267250AbUIJKpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:45:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp: kill crash when too much memory is free
Date: Fri, 10 Sep 2004 12:45:46 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409100001.28781.rjw@sisk.pl> <20040910094039.GC11281@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040910094039.GC11281@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409101245.47210.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 of September 2004 11:40, Pavel Machek wrote:
> Hi!
> 
> > > If too much memory is free, swsusp dies in quite a ugly way. Even when
> > > it is not neccessary to relocate pagedir, it is proably still
> > > neccessary to relocate individual pages. Thanks to Kurt Garloff and
> > > Stefan Seyfried...
> > > 								Pavel
> > > PS: And could I have one brown paper bag, please?
> > 
> > I applied this and it didn't fix my problems with resuming, unfortunately, 
but 
> > it changed the symptoms.  Namely, if USB modules are not unloaded before 
> > suspending, I get:
> 
> > This is 100% reproducible (ie unload USB modules and dm_mod, suspend the 
> > machine, try to wake it up, hangs solid).
> > 
> > Can you tell me, please, if there's anything I can compile out/in to debug 
it 
> > a bit more?  Or can I put some printk()s somewhere in the code to get some 
> > more info?  Any suggestions welcome.
> 
> Can you try my "bigdiff"?

It's compiling.  I can't get output from the serial console right now, so I'll 
send you a summary later on.

> Also, does it work okay in 32-bit mode? 

Well, I have a 64-bit distro installed, so I would have to reinstall to check 
this ...  It's not impossible, though.  If the big diff does not help, I'll 
try to do something about it.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
