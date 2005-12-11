Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVLKIiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVLKIiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 03:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVLKIiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 03:38:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751343AbVLKIiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 03:38:04 -0500
Date: Sun, 11 Dec 2005 09:37:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Message-ID: <20051211083737.GF5187@elf.ucw.cz>
References: <20051203135608.GJ31395@stusta.de> <200512071214.26574.rob@landley.net> <20051210083503.GA2833@ucw.cz> <200512102330.31572.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512102330.31572.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 10-12-05 23:30:30, Rob Landley wrote:
> On Saturday 10 December 2005 02:35, Pavel Machek wrote:
> > On Wed 07-12-05 12:14:25, Rob Landley wrote:
> > > On Tuesday 06 December 2005 12:51, Bill Davidsen wrote:
> > > > Just so we're all on the same page, I think there are two sets of
> > > > unhappy people here... one is the group who want new stuff fast and
> > > > stable. For the most part that's not me, although I was in the "if
> > > > you're going to add ipw2200 support, why not something that works?"
> > > > group. But new stuff is going in faster than most people can assimilate
> > > > it if they have a real job, so I don't see too much problem there.
> > >
> > > My laptop has an ipw2200 but I can't get it to work in any kernel I built
> > > because the kernels I build aren't modular.  I hope to be able to work
> > > around this someday with a clever enough initramfs (if necessary, moving
> > > the initramfs initialization earlier in the boot sequence), but it hasn't
> > > made it far enough up my todo list yet.
> >
> > Well, building modular kernel for a test is not *that* much work.
> > Anyway, if you are going to fix it, fix it properly (by
> > delayed firmware loading) -- initrd hacks are good for you
> > but unusable for anyone else.
> 
> I don't see why that's any less usable than using udev from initramfs to find 
> your root partition.

Why use udev from initramfs? Just teach ipw2200 to load firmware
late. Don't load firmware when ipw2200 is initialized, load it only
when someone attempts to talk to your ipw2200. At that time, you
should have userland already.
								Pavel
-- 
Thanks, Sharp!
