Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUCZWWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUCZWWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:22:52 -0500
Received: from gprs214-69.eurotel.cz ([160.218.214.69]:15745 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261375AbUCZWWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:22:49 -0500
Date: Fri, 26 Mar 2004 23:22:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Michael Frank <mhf@linuxmail.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040326222234.GE9491@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net> <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz> <opr5gf93ik4evsfm@smtp.pacific.net.th> <20040326102206.GD388@elf.ucw.cz> <1080333011.2022.9.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080333011.2022.9.camel@laptop-linux.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Good morning.

Its around midnight here :-).

> > > /proc is needed a lot
> > > 
> > > - enable escape
> > > - select reboot mode
> > > 	which is essential for multibooting. We use it all the time to
> > > 	boot various installations of Linux
> > 
> > Perhaps reboot() can have parameter for that.
> 
> Sounds feasible. Who maintains the package with reboot/shutdown and so
> on?

On my system it says:

AUTHOR
       Miquel van Smoorenburg, miquels@cistron.nl

There was even patch to do shutdown -z, or something like that... And
binary that calls it should be easy, too.

> > > - select compression none, lzw or gzip
> > > 	none is used when disk faster that cpu-limited lzf
> > > 	lzf is used when cpu is fast enough to compress to disk
> > > 		Fast CPU can do 100MB/s+ to 50MB/s drives
> > > 	gzip is used by some who care about image size eg flash users
> > 
> > If you are doing "resume=swap:<something>", why not "resume=lzw-swap:something"?
> 
> Because it's ugly? resume= is supposed to specify where the image's
> header is found, nothing more. More than that, though, doing this still
> doesn't solve the issue of how to enable/disable a compressor (or
> encryption when such a plugin appears) after booting. (Yes, I know - you
> don't want that much flexibility).

You are right, that would be ugly. How is encryption supposed to work,
kernel asks you to type in a key?

Okay, when there's more than one output plugin, some kind of file
interface is probably good.

> > > - default console level
> > > 	Controls console messages or nice display
> > > - access debug info header
> > > 	This is needed to analyze swsusp2 performance
> > > - access resume parameters
> > > 	Saves a reboot when changing parameters
> > > - activate
> > > 	swsusp2 activation independent of apci, apm
> > 
> > Should not be needed. There's reboot() syscall to do that.
> 
> That's fine once we get one implementation. For now, I've been trying to
> play nicely with swsusp and pmdisk. That's why I used resume2= and its
> also why I supported 13 headers; I needed to recognise pmdisk and swsusp
> headers so that I could know to ignore them (I tried leaving swsusp
> first in the boot order, and it paniced when I'd suspended from suspend2
> because it didn't recognise the header format).

Okay, we really should have only one implementation.
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
