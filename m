Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWAFCuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWAFCuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWAFCuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:50:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:7862 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932606AbWAFCuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:50:20 -0500
Date: Thu, 5 Jan 2006 16:44:33 -0800
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [CFT 1/29] Add bus_type probe, remove, shutdown methods.
Message-ID: <20060106004433.GA29218@kroah.com>
References: <20060105142951.13.01@flint.arm.linux.org.uk> <20060105230739.GA27466@kroah.com> <20060105232410.GA5399@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105232410.GA5399@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:24:10PM +0000, Russell King wrote:
> On Thu, Jan 05, 2006 at 03:07:39PM -0800, Greg KH wrote:
> > On Thu, Jan 05, 2006 at 02:29:51PM +0000, Russell King wrote:
> > > Add bus_type probe, remove and shutdown methods to replace the
> > > corresponding methods in struct device_driver.  This matches
> > > the way we handle the suspend/resume methods.
> > > 
> > > Since the bus methods override the device_driver methods, warn
> > > if a device driver is registered whose methods will not be
> > > called.
> > > 
> > > The long-term idea is to remove the device_driver methods entirely.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > All of this looks good to me, want me to add them to my tree and forward
> > it on to Linus?
> 
> As far as forwarding to Linus, not sure about that yet - I suspect
> these patches may cause akpm some reject grief since they're fairly
> wide-spread over the kernel.  If akpm prefers the small patches
> instead of one large one, it may make sense for it to go via akpm.

Bah, rejects are something that akpm eats for lunch, we have good tools
to handle this now :)

> I don't have a preference myself - it's whatever's easiest for others.

I'll add this to my tree, which will end up in -mm and forward to Linus
in a bit, after some sanity build tests.

> > thanks for doing this work, I really appreciate it.
> 
> Obviously, there's still more to come when I get a round tuit, but
> this should provide sufficient infrastructure to allow folk to
> move over the remaining areas if I don't get there first.  ISTR
> SCSI requires a bit of work.

I'll poke at the remainders when I get a chance, the kernel log messages
should cause others to perk up and notice and possibly help out too :)

thanks,

greg k-h
