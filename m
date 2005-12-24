Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVLXXUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVLXXUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 18:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVLXXUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 18:20:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49348 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750712AbVLXXUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 18:20:02 -0500
Date: Sun, 25 Dec 2005 00:19:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>,
       Stelian Pop <stelian@popies.net>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
Subject: Re: PowerBook5,8 - TrackPad update
Message-ID: <20051224231928.GC2183@elf.ucw.cz>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net> <20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch> <20051130234653.GB15102@hansmi.ch> <1133533712.23129.25.camel@localhost.localdomain> <20051204224221.GA28218@hansmi.ch> <1135382385.4542.8.camel@gaston> <20051224201753.GA26801@elf.ucw.cz> <1135463271.5611.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135463271.5611.3.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 25-12-05 09:27:51, Benjamin Herrenschmidt wrote:
> On Sat, 2005-12-24 at 21:17 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > Ok, I finally received my new laptop (PowerBook5,8 15"). I tried the
> > > latest patch you posted, and while the kernel driver seem to work ok
> > > (though you can feel the lack of a proper acceleration curve), the
> > > synaptics driver in X doesn't work in any useable way. I updated the one
> > > that comes with breezy to whatever was the latest on the author web site
> > > (.44 I think) and while it detected the tracpkad, the result was soooooo
> > > slooooow that it was totally unseable. I've tried the config tool that
> > > comes with KDE for it but couldn't "boost" it to anything useful. Is
> > > that expected or is there still issues to be resolved in the driver ?
> > > I'm tempted to add some minimum support for a proper acceleration curve
> > > in the kernel driver in fact...
> > 
> > I do not think you should add it inside *kernel*. Proper acceleration
> > support really belongs to X...
> 
> X, fbdev apps, gpm ... acceleration curves are typically done in HW,
> thus it makes sense in this case to have it in the kernel driver
> (besides, it should be fairly simple anyway) when it's in normal
> mode.

It should be doable once in gpm, all other apps can use gpm's repeater
mode...

> When it's in raw mode for use by the synaptics X driver, if course, it's
> expected that those things are to be done by that driver.

...but you are right, doing it in /dev/input/mice emulation layer
makes some sense. OTOH I thought we were moving away from
/dev/input/mice... Its Dmitry's call I guess.
								Pavel
-- 
Thanks, Sharp!
