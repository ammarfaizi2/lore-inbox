Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbUD2WkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbUD2WkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbUD2WkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:40:17 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31677 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S265008AbUD2WkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:40:09 -0400
Date: Thu, 29 Apr 2004 15:40:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ian Campbell <icampbell@arcom.com>, stefan.eletzhofer@eletztrick.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
Message-ID: <20040429224007.GA15265@smtp.west.cox.net>
References: <20040429120250.GD10867@gonzo.local> <1083242482.26762.30.camel@icampbell-debian> <20040429135408.G16407@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429135408.G16407@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:54:08PM +0100, Russell King wrote:
> On Thu, Apr 29, 2004 at 01:41:23PM +0100, Ian Campbell wrote:
> > Hi Stefan,
> > 
> > > This driver only does the low-level I2C stuff, the rtc misc device
> > > driver is a separate driver module which I will send a patch for soon.
> > 
> > I have a patch (attached, it could do with cleaning up) for the Dallas
> > DS1307 I2C RTC which I ported from the 2.4 rmk patch, originally written
> > by Intrinsyc. Currently it includes both the I2C and the RTC bits in the
> > same driver.
> 
> Have a look at drivers/acorn/char/{i2c,pcf8583}.[ch]
> 
> > Do you think it is realistic/possible to have the same generic RTC
> > driver speak to multiple I2C devices, from what I can see in your driver
> > the two chips seem pretty similar and the differences could probably be
> > abstracted away. Perhaps that is your intention from the start?
> > 
> > I guess I will wait until you post the RTC misc driver and try and make
> > the DS1307 one work with that before I submit it.
> 
> If you look at the last 2.6-rmk patch, you'll notice that it contains
> an abstracted RTC driver - I got peed off with writing the same code
> to support the user interfaces to the variety of RTCs over and over
> again.  (Ones which are simple 32-bit second counters with alarms
> through to ones which return D/M/Y H:M:S.C format.)

A generic one for i2c rtcs or another generic rtc driver?  There's
already drivers/char/genrtc.c...

-- 
Tom Rini
http://gate.crashing.org/~trini/
