Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUHFV1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUHFV1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUHFV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:27:31 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266173AbUHFV1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:27:15 -0400
Date: Fri, 6 Aug 2004 23:26:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040806212651.GH30518@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston> <200408031928.08475.david-b@pacbell.net> <1091586381.3189.14.camel@laptop.cunninghams> <1091587985.5226.74.camel@gaston> <1091587929.3303.38.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091587929.3303.38.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've also done partial-tree support for suspend2 by making a new list
> > > (along side the active, off and off_irq lists) and simply moving devices
> > > I want to keep on (plus their parents) to this list prior to calling
> > > device_suspend. Works well for keeping alive the ide devices being used
> > > write the image.
> > 
> > How so ? By not calling suspend for it at all ? That's broken, the
> > driver wants suspend to match the resume it will get when the image
> > is reloaded, that's the only way the driver can guarantee a sane state
> > saved in the suspend image.
> 
> Yes, I don't call suspend for it because I can be sure the drivers are
> idle (before beginning to write the image, freeze all process, flush all
> dirty buffers and suspend all other drivers, I then wait on my own I/O
> until it is flushed too). I know it's broken to do so, but it was a good
> work around for wearing out the thing by spinning it down and then
> immediately spinning it back up, and I wasn't sure what the right state
> to try to put it in is (sound familiar?!). If you want to tell me how I
> could tell it to quiesce without spin down, I'll happily do that.
> 
> The sooner these issues get sorted, the better.

Hmm, I can't agree more... Yesterday was too late...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
