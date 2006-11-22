Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161815AbWKVC2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161815AbWKVC2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161811AbWKVC2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:28:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161807AbWKVC2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:28:40 -0500
Date: Tue, 21 Nov 2006 18:28:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.19-rc6 6/6] rtc-omap driver
Message-Id: <20061121182828.4fc32802.akpm@osdl.org>
In-Reply-To: <200611211815.43929.david-b@pacbell.net>
References: <200611201014.41980.david-b@pacbell.net>
	<200611201028.48701.david-b@pacbell.net>
	<20061121171906.5eec32d6.akpm@osdl.org>
	<200611211815.43929.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 18:15:42 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Tuesday 21 November 2006 5:19 pm, Andrew Morton wrote:
> > On Mon, 20 Nov 2006 10:28:48 -0800
> 
> > > +		/* sometimes the alarm wraps into tomorrow */
> > > +		if (then < now) {
> > 
> > This isn't wraparound-safe.  If you have then=0xffffffff and now=0x00000001.
> > 
> > Perhaps that can't happen.
> 
> Starting in 2037 or whenever, various things will be breaking...
> 
> Probably the RTC lib routines should use a time_t, and when that gets
> changed to 64 bits then things like this will be fixed automagically.
> Right now they use "unsigned long".
> 
> I suggest Alessandro handle those issues.
> 

We could simply (ab)use timer_after() here.

> 
> > > +MODULE_AUTHOR("George G. Davis (and others)");
> > 
> > Maybe some additional signoffs would be appropirate?
> 
> I pinged the MontaVista emails from the original driver; maybe
> they'll send signoffs.
> 

OK.  Such signoffs are certainly not a DCO _requirement_.  If the MV guys
are asleep, no big deal - we trust david-b's assertion.


