Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWBULeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWBULeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWBULeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:34:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31980 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932253AbWBULeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:34:14 -0500
Date: Tue, 21 Feb 2006 12:33:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Matthias Hensler <matthias@wspse.de>,
       kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060221113337.GP21557@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <200602201025.01823.nigel@suspend2.net> <20060220005333.GL15608@elf.ucw.cz> <20060220094728.GD19293@kobayashi-maru.wspse.de> <43FA97D9.4070902@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA97D9.4070902@myrealbox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 20:32:25, Andy Lutomirski wrote:
> Matthias Hensler wrote:
> >Hi.
> >
> >On Mon, Feb 20, 2006 at 01:53:33AM +0100, Pavel Machek wrote:
> >
> >>Only feature I can't do is "save whole pagecache"... and 14000 lines
> >>of code for _that_ is a bit too much. I could probably patch my kernel
> >>to dump pagecache to userspace, but I do not think it is worth the
> >>effort.
> >
> >
> >I do not think that Suspend 2 needs 14000 lines for that, the core is
> >much smaller. But besides, _not_ saving the pagecache is a really _bad_
> >idea. I expect to have my system back after resume, in the same state I
> >had left it prior to suspend. I really do not like it how it is done by
> >Windows, it is just ugly to have a slowly responding system after
> >resume, because all caches and buffers are gone.
> >
> >I can only speak for myself, but I want to work with my system from the
> >moment my desktop is back.
> 
> I Am Not A VM Hacker, but:
> 
> What's the point of saving pagecache during suspend?  This seems like a 
> total waste.  Why don't we save a list of pages in pagecache to disk,
> then, after resume, prefetch them all back in.  This will slow down 
> resume (extra seeks, minimized if we sort the list, and inability
> to compress these pages), but it will speed up suspend, and it sounds
> a lot simpler.  There's already a patch to add swap prefetching, and 
> this can't be much more complicated.

I'd actually love to see this implemented. It would be useful for
suspend-to-disk (obviously), but also for benchmarks.

> While I'm at it, here's another pie-in-the-sky idea.  If we had the 

Yes, that's quite far in the sky :-).
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
