Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUC0CVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 21:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUC0CVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 21:21:39 -0500
Received: from nils.bezeqint.net ([192.115.104.5]:16347 "EHLO
	nils.bezeqint.net") by vger.kernel.org with ESMTP id S261651AbUC0CVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 21:21:36 -0500
Date: Sat, 27 Mar 2004 04:21:25 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Suspend development list <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040327022125.GA2174@luna.mooo.com>
Mail-Followup-To: Suspend development list <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th> <20040325014107.GB6094@elf.ucw.cz> <200403250857.08920.matthias.wieser@hiasl.net>
	 <1080247142.6679.3.camel@calvin.wpcb.org.au> <20040325222745.GE2179@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325222745.GE2179@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 11:27:45PM +0100, Pavel Machek wrote:
> Hi!
> 
> > By the way, here's an example where having the /proc interface is a good
> > thing: which do you use? zip compression, lzf compression or no
> > compression? Until recently I always used lzf compression. I just
> 
> We should select one, and drop the others.
> 
> gzip is useless for almost everyone -> gets little testing -> is
> probably broken.
> 
> > upgraded my laptop's hard drive, and found I wasn't getting the
> > performance improvements in suspending I expected. It turns out that the
> > CPU is now the limiting factor. Because I had the /proc interface, I
> > could easily adjust the debug settings to show me throughput and then
> > try a couple of suspend cycles with compression enabled and with it
> > disabled. Without the /proc interface, I would have had to have
> > recompiled the kernel to switch settings. (I didn't try gzip because I
> > knew it wasn't going to be a contender for me).
> 
> Kernel could automagically select the right one.. But I'd prefer for
> only "non compressed" part to reach mainline for 2.6. Feature freeze

That would mean that most people around would want to patch their
kernel considering the speed increase and the saved space (which
converts to needing less swap) considering most people get 30%-50%
compression rate, which translates to quite a bit with laptops with 1G
ram being no too uncommon these days.

You shouldn't be to extreme in you eagerness to trim things. You should
always take in mind what would be good for the user, not only the
developer.

> was few months ago, and "adding possibility to compress swsusp data"
> does not sound like a bugfix to me...
> 								Pavel
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
