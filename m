Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbTIAI0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 04:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbTIAI0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 04:26:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50951 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262743AbTIAI0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 04:26:50 -0400
Date: Mon, 1 Sep 2003 09:26:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901092646.B15370@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20030831232812.GA129@elf.ucw.cz> <20030901075726.A12457@flint.arm.linux.org.uk> <20030901081154.GB155@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901081154.GB155@elf.ucw.cz>; from pavel@suse.cz on Mon, Sep 01, 2003 at 10:11:54AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 10:11:54AM +0200, Pavel Machek wrote:
> Its the only way to have power managment working by 2.6.1.

Rubbish.  PM is now working here on ARM again - within a week of Pat's
change.

> Lots of
> work went into pm during 2.5 series, and Patrick invalidated all that
> with one, 140KB, untested and broken patch (and he managed to break
> about all rules about patch submission).

I agree that it needed public review _before_ hitting Linus' tree - a
change of that magnitude with only half the subsystems fixed up should
not go directly into Linus' tree without review.

> It is not possible to fix damage he done within week.

It is my understanding that the old PM in 2.5 was not suitable for
the PPC architecture and the new PM model is.  As far as the drivers
are concerned, the interface presented is a definite improvement on
what there was before (there are a few things which I'd like to see
further improvement on, but that's not a subject for discussion in
this thread.)

I don't particularly care about kernel/power/* because its not useful
for me - whereas you obviously do.  Maybe that's where your axe is
grinding.  But whatever, don't throw the baby (driver model changes)
out with the bath water.

And finally, there's longer than a week to fix it. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

