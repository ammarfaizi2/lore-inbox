Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUBCXPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUBCXPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:15:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:57528 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266186AbUBCXPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:15:43 -0500
Date: Tue, 3 Feb 2004 15:13:41 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 016 release
Message-ID: <20040203231341.GA22058@kroah.com>
References: <20040203201359.GB19476@kroah.com> <1075843712.7473.60.camel@nosferatu.lan> <1075849413.11322.6.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075849413.11322.6.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 01:03:33AM +0200, Martin Schlemmer wrote:
> On Tue, 2004-02-03 at 23:28, Martin Schlemmer wrote:
> > On Tue, 2004-02-03 at 22:13, Greg KH wrote:
> > 
> > Except if I miss something major, udevsend and udevd still do not
> > work:
> > 
> 
> Skip that, it does work if SEQNUM is set :P
> 
> Anyhow, is it _really_ needed for SEQNUM to be set?  What about
> the attached patch?

Yes it is necessary, as that is what the kernel spits out.  It's also
the whole reason we need udevd :)

If you don't want to give a SEQNUM, just call udev directly.

> Then, order I have not really checked yet, but there are two things
> that bother me:
> 
> 1) latency is even higher than before (btw Greg, is there going to be
> more sysfs/whatever fixes to get udev even faster, or is this the
> limit?)

Care to measure the latency somehow?  The first event is a bit slow, but
everything after that is as fast as I ever remember it being.

> 2) events gets missing.  If you for example use udevsend in the
> initscript that populate /dev (/udev), the amount of nodes/links
> created is off with about 10-50 (once about 250) entries.

Hm, that's not good.  I'll go test that and see what's happening.

thanks,

greg k-h
