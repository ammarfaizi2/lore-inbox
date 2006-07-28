Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWG1MZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWG1MZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbWG1MZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:25:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6346 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161131AbWG1MZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:25:24 -0400
Date: Fri, 28 Jul 2006 14:25:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728122508.GC4158@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728074202.GA4757@suse.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >The applets that were doing it (yes, up to 100 times per second)
> > >corrected their ways pretty quickly, because some machines became
> > >unusable with the applet enabled.
> > 
> > Exactly -- and they've been working merrily ever since.
> > And if you don't want to trust applet developers, cache the latest
> > reads and refresh them only if X jiffies have passed.
> 
> The timer interrupt still has to happen every time their select() or
> sleep() expires, with the system having to wake up, even when nothing
> happened. Polling from userspace is bad.

I do not understand this. Any polling (in kernel or in userspace) will
wake the CPU, wasting power.

OTOH "high/low/very low" battery applet can reasonably query battery
every 5 minutes, while detailed, graphical thingie displaying the
current power consumption will probably poll every 10 seconds...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
