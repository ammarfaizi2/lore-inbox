Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTIAUiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTIAUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:38:15 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:6633 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262148AbTIAUiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:38:13 -0400
Date: Mon, 1 Sep 2003 11:33:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901093344.GC155@elf.ucw.cz>
References: <20030831232812.GA129@elf.ucw.cz> <20030901075726.A12457@flint.arm.linux.org.uk> <20030901081154.GB155@elf.ucw.cz> <20030901092646.B15370@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901092646.B15370@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Its the only way to have power managment working by 2.6.1.
> 
> Rubbish.  PM is now working here on ARM again - within a week of Pat's
> change.

As you said, you are not using kernel/power.

> > Lots of
> > work went into pm during 2.5 series, and Patrick invalidated all that
> > with one, 140KB, untested and broken patch (and he managed to break
> > about all rules about patch submission).
> 
> I agree that it needed public review _before_ hitting Linus' tree - a
> change of that magnitude with only half the subsystems fixed up should
> not go directly into Linus' tree without review.

Good. [I believe it was big enough to require testing on separate tree
(-mm? -ac?) before going mainline].

> > It is not possible to fix damage he done within week.
> 
> It is my understanding that the old PM in 2.5 was not suitable for
> the PPC architecture and the new PM model is.  As far as the drivers
> are concerned, the interface presented is a definite improvement on
> what there was before (there are a few things which I'd like to see
> further improvement on, but that's not a subject for discussion in
> this thread.)

I only see dm getting more and more complicated :-(.

> I don't particularly care about kernel/power/* because its not useful
> for me - whereas you obviously do.  Maybe that's where your axe is
> grinding.  But whatever, don't throw the baby (driver model changes)
> out with the bath water.

kernel/power/* changes are worst, because that's subsystem I should be
maintainer of. Driver model changes are quite bad, too, because they
mean we should go over all drivers and fix them. And driver failures
are often pretty subtle.

> And finally, there's longer than a week to fix it. 8)

I'm not looking forward to another half-a-year before kernel gets into
state where it was in -test3.

I still want that crap killed, at least because of the way *how* it
was merged. Altrough killing kernel/power/* would be good start, and
maybe it would lead us to a state where dm changes can be debugged. 

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
