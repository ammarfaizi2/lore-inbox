Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUHFVcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUHFVcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268311AbUHFVcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:32:45 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:6529 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268304AbUHFV3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:29:30 -0400
Date: Fri, 6 Aug 2004 23:29:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@linuxmail.org, David Brownell <david-b@pacbell.net>,
       Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040806212909.GI30518@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston> <200408031928.08475.david-b@pacbell.net> <1091586381.3189.14.camel@laptop.cunninghams> <1091587985.5226.74.camel@gaston> <1091587929.3303.38.camel@laptop.cunninghams> <1091592870.5226.80.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091592870.5226.80.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, I don't call suspend for it because I can be sure the drivers are
> > idle (before beginning to write the image, freeze all process, flush all
> > dirty buffers and suspend all other drivers, I then wait on my own I/O
> > until it is flushed too). I know it's broken to do so, but it was a good
> > work around for wearing out the thing by spinning it down and then
> > immediately spinning it back up, and I wasn't sure what the right state
> > to try to put it in is (sound familiar?!). If you want to tell me how I
> > could tell it to quiesce without spin down, I'll happily do that.
> 
> Very easy... with the current code, just use state 4 for the round
> of suspend callbacks, ide-disk will then avoid spinning down.

There are some network drivers that test for "4" and fails suspend
with something like "invalid suspend state" :-(.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
