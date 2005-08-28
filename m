Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVH1IKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVH1IKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 04:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVH1IKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 04:10:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37281 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750852AbVH1IKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 04:10:13 -0400
Date: Sun, 28 Aug 2005 10:09:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Message-ID: <20050828080959.GB2039@elf.ucw.cz>
References: <1125069494.18155.27.camel@betsy> <20050827124148.GE1109@openzaurus.ucw.cz> <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508280453320.13233@artax.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>Of late I have been working on a driver for the IBM Hard Drive Active
> >>Protection System (HDAPS), which provides a two-axis accelerometer and
> >>some other misc. data.  The hardware is found on recent IBM ThinkPad
> >>laptops.
> >>
> >>The following patch adds the driver to 2.6.13-rc6-mm2.  It is
> >>self-contained and fairly simple.
> >
> >Do we really need input interface *and* sysfs interface? Input should be 
> >enough.
> 
> I think he doesn't need to export it at all and he should write code to 
> park and disable hard disk instead.
> (in userspace it's unsolvable --- i.e. you can't enable hard disk when 
> detected stable condition if the daemon is swapped out on that hard disk)

man mlockall() :-).

Accelerometer is usefull for other stuff besides parking heads, like
playing marble madness or what is the name of the game, and even
parking heads is way too complex to be put into the kernel.

Even if you don't like mlockall(), you can put timeout into
disk-freezing interface.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
