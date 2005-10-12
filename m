Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVJLXjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVJLXjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVJLXje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:39:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3297 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932477AbVJLXjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:39:33 -0400
Date: Thu, 13 Oct 2005 01:39:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spitz (zaurus sl-c3000) support
Message-ID: <20051012233917.GA2890@elf.ucw.cz>
References: <20051012223036.GA3610@elf.ucw.cz> <1129158864.8340.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129158864.8340.20.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I got spitz machine today. I thought oz3.5.3 for spitz would be
> > 2.6-based, but found out that I'm not _that_ fortunate.
> 
> oz 3.5.4 is due for release soon and will hopefully have a 2.6 option
> for spitz.

Is there chance to get preview version somewhere? 2.6-capable userland
would be very nice (and zImage would help, too, just for a demo :-).

> > Is there simple way to tell spitz and tosa apart (like without opening
> > the machine)?
> 
> At what level? machine_is_spitz() and machine_is_tosa()? There are some
> checks in the sharpsl head file to auto detect all the Zaurus machines
> and set the machine numbers. For those two machines the difference is
> the presence of the tc6393 chip in tosa. See head-sharpsl.S

I was thinking about "huh, is this machine tosa or spitz", but it is
labeled SL-C3000, so it should be spitz.

> > Aha, I realized that spitz support came into 2.6.14-rc2, so something
> > definitely _is_ happening. Are there newer patches than orca.cx
> > somewhere?
> 
> I got a spitz recently which moved 2.6 for it forwards a lot. Have a
> look at:
> 
> http://www.rpsys.net/openzaurus/

Wildly offtopic... I got poweradapter with spitz (with funny design)
that says 100V (and lot of japanese letters).. I guess it would be
very bad idea to try it at 240V?

> This file should give you an idea of which patches to apply in what
> order:
> http://www.rpsys.net/openzaurus/temp/linux-openzaurus_2.6.14-rc1.bb

Quite a long list; what is $RPSRC -- that is where are those patches
really placed? Is there some way I can help you (besides obviously
testing)?

> With my patch series applied, we're missing usb client (usb host works)
> and sound support.
> 
> Mainline is missing power management and currently fails to compile
> without my patch series but I'm working on that.

Yes, asm/arch/ohci.h seems to be missing... But I should probably do
update, I'm at rc2 with my zaurus hacks now.

								Pavel
-- 
Thanks, Sharp!
