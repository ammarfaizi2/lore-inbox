Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279333AbRJWJpX>; Tue, 23 Oct 2001 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279334AbRJWJpN>; Tue, 23 Oct 2001 05:45:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5643 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279333AbRJWJo7>; Tue, 23 Oct 2001 05:44:59 -0400
Date: Tue, 23 Oct 2001 11:44:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011023114407.B2639@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E15vpU0-00045L-00@the-village.bc.nu> <Pine.LNX.4.33.0110221726140.25103-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110221726140.25103-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 	/* Now tell them to stop I/O and save their state */
> > > 	device_suspend(3, SUSPEND_SAVE_STATE);
> >
> > I'd very much like this one to be two pass, with the second pass occuring
> > after interrupts are disabled. There are some horrible cases to try and
> > handle otherwise (like devices that like to jam the irq line high).
> 
> I forgot to mention to disable interrupts after the SUSPEND_NOTIFY call.
> The idea is to allocate all memory in the first pass, disable interrupts,
> then save state. Would that work? Or, should some of the state saving take
> place with interrupts enabled?

That looks ugly, because you'd need to add DONT_SUSPEND_NOTIFY, called
when SUSPEND_NOTIFY fails.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
