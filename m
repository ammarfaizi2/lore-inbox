Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWHJAMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWHJAMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHJAMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:12:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S932285AbWHJAMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:12:45 -0400
Date: Thu, 10 Aug 2006 00:12:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Message-ID: <20060810001232.GB4249@ucw.cz>
References: <200608091426.31762.rjw@sisk.pl> <200608092201.42885.rjw@sisk.pl> <20060809131232.75a260e1.akpm@osdl.org> <200608092251.58062.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608092251.58062.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > It looks like the CMOS clock gets corrupted during the suspend to disk
> > > > > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > > > > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > > > > 
> > > > > Also, I've done some tests that indicate the corruption doesn't occur before
> > > > > saving the suspend image.  It rather happens when the box is powered off
> > > > > or rebooted (tested both cases).
> > > > > 
> > > > > Unfortunately, I have no more time to debug it further right now.
> > > > 
> > > > Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?
> > > 
> > > Well, I know nothing about that. ;-)
> > 
> > CONFIG_PM_TRACE=y will scrog your CMOS clock each time you suspend.
> 
> Oh dear.  Of course it's set in my .config.  Thanks a lot for this hint. :-)
> 
> BTW, it's a dangerous setting, because some drivers get mad if the time after
> the resume appears to be earlier than the time before the suspend.  Also the
> timer .suspend/.resume routines aren't prepared for that.

Its config option should just go away. People comfortable using *that*
should just edit some header file. Rafael, could you do patch doing
something like that?

-- 
Thanks for all the (sleeping) penguins.
