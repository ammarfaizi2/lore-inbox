Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUHJSZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUHJSZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUHJSXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:23:07 -0400
Received: from gprs214-95.eurotel.cz ([160.218.214.95]:31360 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267606AbUHJR47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:56:59 -0400
Date: Tue, 10 Aug 2004 19:56:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810175637.GB28113@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net> <20040810100751.GC9034@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408100700460.13807-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408100700460.13807-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> > Can you explain why this class-based quiescing is good idea? It seems
> > to me that "quiesce this tree" is pretty much same as "suspend this
> > tree", and can be handled in the same way.
> >
> > Nigel wanted to do class-based quiescing, but if we make quiescing
> > fast enough, it should be okay to do whole tree, always. (And I
> > believe quiescing *can* be fast enough).
> 
> It has nothing to do with speed and everything to do with domains of
> responsibility. Each device belongs to 1 device class.  That class and the
> assoicated class device represent the functional interface(s) to the
> physical device. While the physical device controls physical attributes,
> like actual I/O and power states, the class controls the logical
> interface.

I still do not see it... swsusp does not care about logical state of
device. (Actually manipulating logical state of device might make
swsusp less transparent). It cares about device not doing DMA (I also
said "no interrupts", but that is not strictly neccessary: we disable
interrupts for atomic copy. Device should do no NMIs, through).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
