Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030857AbWI0VLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030857AbWI0VLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030859AbWI0VLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:11:16 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:30848 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030857AbWI0VLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:11:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Date: Wed, 27 Sep 2006 23:13:30 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
References: <20060925071338.GD9869@suse.de> <20060927090902.GC24857@elf.ucw.cz> <20060927140808.2aece78e.akpm@osdl.org>
In-Reply-To: <20060927140808.2aece78e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609272313.31474.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 September 2006 23:08, Andrew Morton wrote:
> On Wed, 27 Sep 2006 11:09:02 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Hi!
> > 
> > > > Is "swapoff -a; echo disk > /sys/power/state" slow for you? If so, we
> > > > have something reasonably easy to debug, if not, we'll try something
> > > > else...
> > > 
> > > sony:/home/akpm# swapoff -a 
> > > sony:/home/akpm# time (echo disk > /sys/power/state) 
> > > echo: write error: no such device
> > > (; echo disk > /sys/power/state; )  0.00s user 0.08s system 1% cpu 5.259 total
> > > 
> > > It took an additional two-odd seconds to bring the X UI back into a serviceable
> > > state.
> > 
> > Console switches take long... yes it would be nice to fix X :-).
> > 
> > But we did not reproduce that 12 seconds problem. Can you try patches
> > from
> > 
> > http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw
> > 
> 
> OK, that compiles.
> 
> I think we should get this documented and merge it (or something like it) into
> mainline.  This is one area where it's worth investing in debugging tools.
> 
> If you agree, are we happy with it in its present form?

I am. ;-)
