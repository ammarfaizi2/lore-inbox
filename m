Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUIDVlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUIDVlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUIDVlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:41:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54406 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262085AbUIDVlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:41:12 -0400
Date: Sat, 4 Sep 2004 23:41:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       linux-kernel@vger.kernel.org, Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040904214111.GA19601@atrey.karlin.mff.cuni.cz>
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org> <20040903120634.GK6985@lug-owl.de> <1094237243l.7429l.1l@hydra> <20040903232507.A8810@flint.arm.linux.org.uk> <20040904111202.GB28074@atrey.karlin.mff.cuni.cz> <20040904215333.B29410@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904215333.B29410@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > sysfs is one-file-one-value. We do not want to end up with /proc-like
> > mess.
> 
> In which case I protest in the strongest terms that having one device
> node plus attributes _PER_ _LED_ is just fscking stupid.  What if you
> have an embedded machine with 32 LEDs?  Do you _really_ need all that
> extra data just to support sysfs so that maybe you can control them
> from userspace?

If you do not need that 32 files on that embedded system, do not
enable that in config... I do not see what is wrong with two or three
files per led.

> What next?  One sysfs node plus attributes per GPIO line?  How about
> we do one sysfs node per virtual memory bit so people can control
> anything in their system on a bit granularity without needing mmap
> or any other interfaces?  When does this madness stop?

GPIO lines are obviously system specific, I guess they could go to
/proc or be controlled via ioctl()... But that was attempt at
universal LED interface, right?
								Pavel
