Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161598AbWAMAQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161598AbWAMAQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWAMAQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:16:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63932 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161598AbWAMAQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:16:55 -0500
Date: Fri, 13 Jan 2006 01:16:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Message-ID: <20060113001640.GD10088@elf.ucw.cz>
References: <200601122241.07363.rjw@sisk.pl> <20060112220940.GA10088@elf.ucw.cz> <200601130031.34624.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601130031.34624.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +commands defined in kernel/power/power.h.  The major and minor
> > > +numbers of the device are, respectively, 10 and 231, and they can
> > > +be read from /sys/class/misc/snapshot/dev.
> > 
> > Is this still true?
> 
> You mean the /sys/class/misc/snapshot/dev?  Yes, until sysfs gets revamped.

Ahha, but it is not your code but misc-handling code in kernel, right?

> > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> > > +	should be a pointer to an unsigned int variable that will contain
> > > +	the result if the call is successful)
> > 
> > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > available swap can be >4GB. [Or maybe it is in something else than
> > bytes, then you need to specify it.]
> 
> It returns the number of pages.  Well, it should be written explicitly,
> so I'll fix that.
> 
> [This feature is actually useful, because it allows you to check if you have
> enough swap after creating the snapshot and retry for eg. image_size = 0
> without unfreezing tasks.]

Ok. [I was asking about unsigned int, it is clear that querying
available swap is useful]. If you return swap offsets, you may want to
specify if it is #bytes/#pages, too.

> > Ouch and you have my ACK on next attempt :-).
> 
> Thanks (you are brave, though ;-)).

I... think you can call it "brave", yes. Nice euphemism ;-)))).
								Pavel
-- 
Thanks, Sharp!
