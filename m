Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTHYIqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTHYIqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:46:20 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:62853 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261613AbTHYIqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:46:13 -0400
Date: Mon, 25 Aug 2003 10:46:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: paul.devriendt@amd.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       richard.brunner@amd.com, mark.langsdorf@amd.com
Subject: Re: Cpufreq for opteron
Message-ID: <20030825084616.GC403@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C080EF006@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF006@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > There's a *lot* of this in this driver. Does it really need 
> > that much
> > > debugging info ? Additionally, the combination of dprintk, tprintk,
> > > printk (KERN_DEBUG  is really messy, and kind of defeats the point
> > > of having these macros. If they're not going to be consistent, don't
> > > use them at all.
> > 
> > Yep, I do not like those ?printk's too. Anyway, I killed most #ifdef
> > DEBUG, and converted it to BUG_ON(). That makes driver shorter and
> > easier to read. Hopefully not much new hardware will be buggy.
> 
> I am not really expecting to see a lot of buggy hardware. Hopefully !
> 
> I am, however, expecting to see BIOS problems. This code has been tested
> internally on a few machines, and every single one of the had some form
> or error in the BIOS. Even the AMD internal only development platforms
> had problems Some of this stuff was defined kind of late, and went through
> several revisions.

Okay, but hopefully machines being sold in retail will have bug-free
BIOSes?

> There are many debug prints in the code, plus additional code that is
> enabled when DEBUG/TRACE are defined. This is all there, based on the
> experience of debugging these early machines in house.

You are welcome to keep the debugging version of your driver for
debugging early machines; it is even possible that 2.4.X version
distributed with SuSE is going to be "debugging" one. But I do not
think Linus/Dave Jones is going to accept debugging version into
mainline kernel.

[And I hope those BUG_ON()'s should be enough to do some debugging,
too. You will not get a nice error message but ugly backtrack, but it
should be enough].

> Without the debug/trace code there, I have to fall back to "please put
> the machine in a box and mail it to me" instead of "email me the log
> file".

Well, if your users will use SuSE 2.4 kernel, they will have logfile,
anyway. By the time 2.6 is widely used, I *hope* bios problems are
already fixed.

> I know the debug code is ugly ... but, I am expecting to need it. In the
> next rev of the driver, when hardware is publicly for sale, we have some
> degree of stability, etc ... then great. But, for now, releasing a driver
> that has only been tested on prototype hardware ... and removing the
> debug code. Ouch.

If we want the code to be in 2.6.X final, it is good to start pushing
it _now_. And we can't reasonably expect linus to eat patch with
_that_ much debugging.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
