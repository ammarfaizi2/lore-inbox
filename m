Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTKSXa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbTKSXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:30:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:49320 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264190AbTKSXa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:30:26 -0500
Date: Wed, 19 Nov 2003 15:26:51 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] document that udev isn't yet ready (fwd)
Message-ID: <20031119232651.GA22676@kroah.com>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069283566.5032.21.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 01:12:46AM +0200, Martin Schlemmer wrote:
> On Thu, 2003-11-20 at 00:14, Greg KH wrote:
> > On Wed, Nov 19, 2003 at 10:32:38PM +0100, Adrian Bunk wrote:
> > > The trivial documentation patch forwarded below still applies (with a 
> > > few lines offset) against 2.6.0-test9-mm4.
> > 
> > Hm, with the 006 release, what do you find lacking in udev?
> > 
> 
> I am guessing its more driver support, etc.  Input devices for
> instance do not seem to have any sysfs support yet,

Yes, we do need better driver support.  But that's nothing that udev
itself can do :)

I have a number of patches pending for 2.6.1 that will add more driver
support for sysfs.

> and full initramfs support with udev in there,

The people keeping the klibc kernel bk tree have enough support in it to
place udev into initramfs.  Again, nothing that udev needs to do for
this.

> and udev.permissions setup to get general permissions, etc right,

We now support wildcards in udev.permissions, forgot to mention that in
the 006 release.  So it's just a matter of distros building up a
permissions file that matches their needs.

> might make it more advertisable for the masses (no need to maintain
> /dev or the initial costs for users not so interested in the workings
> of things).

Mostly it's a implementation issue with a distro to get everything tied
together properly.  Much like devfs had issues when it was added to the
kernel and people had to tweak userspace a bunch to get it to work
properly.

> Lets just say from what I have seen from users talking/asking, the
> initial setup and seeming 'lack of functionality' is the biggest
> blocker.

Initial setup will be done by distros when they implement it into their
system.  What do you mean by "lack of functionality"?  What users are
telling you this, and what functions are they?  Please feel free to
forward them on to me, otherwise I will not know...

Now yes, I do know that udev still has a way to go to be solid and
mature, but it is usable for the most part :)

thanks,

greg k-h
