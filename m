Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbTCJTBk>; Mon, 10 Mar 2003 14:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbTCJTBk>; Mon, 10 Mar 2003 14:01:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59917 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261404AbTCJTBj>; Mon, 10 Mar 2003 14:01:39 -0500
Date: Mon, 10 Mar 2003 20:12:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030310191216.GB11310@atrey.karlin.mff.cuni.cz>
References: <20030307203650.GB2447@elf.ucw.cz> <Pine.LNX.4.33.0303101049290.1002-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303101049290.1002-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The cumulative patch is here:
> > > 
> > > http://kernel.org/pub/linux/kernel/people/mochel/power/pm-2.5.64.diff.gz
> > 
> > Hmm, I am not sure if drivers/power is the right place for stuff like
> > fridge.c. That might be usefull for other stuff, too.
> 
> That's fine. If it proves useful for other things, we can move it. 

Actually, I'd like driver model to specify that things are
refrigerated when device_suspend() and friends are being run. That
should make drivers a lot simpler. [And as non-bitkeeper-capable user
I fear moves ;-)]

> > I do not think placing swsusp.h in drivers/power/swsusp is right. It
> > should be in include/linux or include/linux/power.
> 
> That header is only for the shared functions between 
> drivers/power/swsusp/*.c. There's no need to export it to everyone. 

Well, last time acpi introduced its private include/ directory, it was
a disaster.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
