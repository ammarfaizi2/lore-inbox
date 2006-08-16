Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWHPLhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWHPLhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 07:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWHPLhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 07:37:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4315 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751111AbWHPLhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 07:37:47 -0400
Date: Wed, 16 Aug 2006 13:37:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH] PM: Use suspend_console in swsusp and make it configureable
Message-ID: <20060816113722.GD9497@elf.ucw.cz>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608161304.51758.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The appended patch does the following:
> > > 
> > > 1) Adds suspend_console() and resume_console() to the suspend-to-disk code
> > > paths so that people using netconsole are safe with swsusp.
> 
> So I assume this one is OK.
> 
> > > 2) Adds a Kconfig option allowing us to disable suspend_/resume_console()
> > > if need be.
> > 
> > Slightly ugly, but I guess that is the way to go.
> 
> It also seems to be needed to add a 2 sec. dealy in suspend_console() so
> that eg. the network console can send the messages before we try to suspend
> the device.
> 
> > > 3) Marks CONFIG_PM_TRACE as dangerous.
> > 
> > I do not think that is enough. "(WILL TRASH YOUR CMOS)" would be more
> > suitable. Dangerous is "may cause problems to you". This is "will
> > cause problems to you". And for this to be useful, people have to edit
> > sources, anyway.
> > 
> > 								Pavel
> > 
> > Can we just delete the config option?
> 
> OK, I'll do that.
> 
> I have divided the changes into three individual patches that will follow as
> replies to this message.

Ack on all three... and thanks.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
