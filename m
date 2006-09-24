Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWIXVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWIXVFm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWIXVFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:05:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932093AbWIXVFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:05:42 -0400
Date: Sun, 24 Sep 2006 23:05:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] usb still sucks battery in -rc7-mm1
Message-ID: <20060924210527.GG1873@elf.ucw.cz>
References: <20060924090858.GA1852@elf.ucw.cz> <Pine.LNX.4.44L0.0609241647230.14008-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609241647230.14008-100000@netrider.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I made some quick experiments, and usb still eats 4W of battery
> > power. (With whole machine eating 9W, that's kind of a big deal)...
> > 
> > This particular machine has usb bluetooth, but it can be disabled by
> > firmware, and appears unplugged. (I did that). It also has fingerprint
> > scanner, that can't be disabled, but that does not have driver (only
> > driven by useland, and was unused in this experiment).
> > 
> > Any ideas?
> 
> The USB autosuspend patches are still not entirely in -mm.  They contain a
> couple of bugs that have to get fixed first.  When they do get merged you
> should see considerable improvement.  Note that although they will reduce
> the amount of power being used by the USB controllers and will stop the
> DMA activity (thus allowing your CPU to enter C2), they won't put the
> controllers into D3.  For that you'll have to get PCI autosuspend...
> :-)

I have not measured that, but I _hope_ drain by controller itself will
not be big enough.

> In the meantime, if all you care about is power consumption there are 
> some things you can do.  The easiest is simply to rmmod ehci-hcd, 
> ohci-hcd, and uhci-hcd.  After all, if you're not using USB there's no 
> reason to let the drivers eat up memory, CPU time, and power.

Are autosuspend patches available somewhere? (Relative to -mm, or
relative to 2.6.18?) I'd like to play with them...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
