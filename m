Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVJBXfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVJBXfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJBXfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:35:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8911 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751124AbVJBXfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:35:40 -0400
Date: Mon, 3 Oct 2005 01:35:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jan Spitalnik <lkml@spitalnik.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: thinkpad suspend to ram and backlight
Message-ID: <20051002233516.GB6035@elf.ucw.cz>
References: <20051002175703.GA3141@elf.ucw.cz> <200510022007.29660.lkml@spitalnik.net> <20051002182354.GA2031@elf.ucw.cz> <1128294674.8267.65.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128294674.8267.65.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> > > > video chips is not turned off, too). Unfortunately, backlight is not
> > > > turned even when lid is closed. I know some patches were floating
> > > > around to solve that... but I can't find them now. Any ideas?
> > > 
> > > if your thinkpad has ati radeon, you can use this:
> > > 
> > > http://www.thinkwiki.org/wiki/Radeontool
> > 
> > radeontool light off before suspend indeed works, but I'd like to
> > solve it properly.
> 
> Well, it depends what you call "properly". 

I'd like it to work as well as it does for PPC :-).

> There are indeed some patches
> floating around that put the radeon chip in D2 state, that seem to
> help.

I found that patch with a little help from the list. Unfortunately, it
makes things worse (not better) on my X32. [There was another
regression here. With 2.6.8 or so, backlight was off during S3 sleep
(but chip still running and eating power). With 2.6.14-rc3, not only
chip is running, but backlight is forced to max to add an insult to
the injury].
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
