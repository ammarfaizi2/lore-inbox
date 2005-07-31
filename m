Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVGaW5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVGaW5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVGaWwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:52:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10371 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262022AbVGaWuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:50:44 -0400
Date: Mon, 1 Aug 2005 00:49:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Mark Underwood <basicmark@yahoo.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050731224959.GD27580@elf.ucw.cz>
References: <20050731221152.71074.qmail@web30303.mail.mud.yahoo.com> <1122849209.7626.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122849209.7626.16.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As this isn't the only chip of this sort (i.e. a
> > multi-function chip not on the CPU bus) maybe we
> > should store the bus driver in a common place. If
> > needed we could have a very simple bus driver
> > subsystem (this might already be in the kernel, I
> > haven't looked at the bus stuff) in which you register
> > a bus driver and client drivers register with the bus
> > driver. Just an idea :-).
> 
> This was the idea with the drivers/soc suggestion although I think that
> name is perhaps misleading.
> 
> How about drivers/mfd where mfd = Multi Functional Devices?
> 
> I think it would be acceptable (and in keeping with the other drivers
> e.g. pcmcia) to seeing the arch and platform specific modules with the
> main driver as long as the naming reflected it (like the existing mcp
> and ucb code does) i.e.:
> 
> mcp-core.c
> mcp-sa1100.c
> ucb1x00-code.c
> ucb1x00-assabet.c
> ucb1x00-collie.c
> 
> If code can be separated out into subsystems, I'm not so sure where they
> should go though. The existing policy would suggest
> drivers/input/touchscreen and sound/xxx for these...
> 
> ucb1x00-ts.c
> ucb1x00-audio.c
> 
> Opinions/Comments?

drivers/mfd sounds good, and yes, touchscreen and audio should go
where they belong.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
