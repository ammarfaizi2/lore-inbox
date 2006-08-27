Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWH0KRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWH0KRk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 06:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWH0KRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 06:17:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5087 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750722AbWH0KRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 06:17:38 -0400
Date: Sun, 27 Aug 2006 12:17:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: waking system up using RTC (was Re: rtcwakeup.c)
Message-ID: <20060827101725.GB9953@elf.ucw.cz>
References: <20060725124941.GD5034@ucw.cz> <200608261415.33353.david-b@pacbell.net> <20060826214342.GB3784@elf.ucw.cz> <200608261704.05017.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608261704.05017.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Your new RTC driver seems to work for me (thinkpad x60), but no, I
> > > > can't get wakeup using RTC to work:
> > > 
> > > Does it work using /proc/acpi/alarm?  In my experience, ACPI wakeup
> > > doesn't work on Linux ... hence my pleasant surprise to see it work
> > 
> > No, I could not get it working using /proc/acpi/alarm.
> 
> Then I suspect that's the root cause of your problem ... ACPI code,
> in either Linux or your BIOS, is not sufficiently cooperative.  All
> that the rtc-acpi driver does is move the wakeup code, it doesn't
> actually change what the /proc/acpi/alarm stuff does.

I searched the bios; timer wakeup is enabled, but I can't set timer
wakeup from the bios.

> > rtc-acpi 00:07: AT compatible RTC (S4wake) (y3k), 1 month alarm
> 
> Seems like Intel's chips won't do one year alarms ... so sad.  :)

:-).

(BTW... if STR still does not work on your notebook, let me know, and
we can try to fix that...)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
