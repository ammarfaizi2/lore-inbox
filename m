Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbTCJSqI>; Mon, 10 Mar 2003 13:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbTCJSqI>; Mon, 10 Mar 2003 13:46:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54280 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261397AbTCJSqH>; Mon, 10 Mar 2003 13:46:07 -0500
Date: Mon, 10 Mar 2003 19:56:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: ioctl32 cleanup -- rest of architectures
Message-ID: <20030310185647.GA11310@atrey.karlin.mff.cuni.cz>
References: <20030310172832.GG5278@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310172832.GG5278@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Could you cc myself or parisc-linux@parisc-linux.org in future
> please?

Yes, I'll try to cc you.


> first, you've called it `compact_sys_ioctl' -- it should be `compat_sys_ioctl'.
> it's compatible, not really small ;-)

Ouch, stupid typo. Sorry

> second, you've not changed the definition in arch/parisc/kernel/syscall.S:
> 
> -	ENTRY_DIFF(ioctl)
> +	ENTRY_COMP(ioctl)

So I should take arch/parisc/kernel/syscall.S and change
ENTRY_DIFF(ioctl) into ENTRY_COMP(ioctl)? Great, thanx.

[BTW have you actually tested it or are these just first obvious
mistakes?]

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
