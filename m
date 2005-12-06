Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVLFSB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVLFSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVLFSB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:01:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:44268 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964807AbVLFSB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:01:27 -0500
Date: Tue, 6 Dec 2005 09:38:42 -0800
From: Greg KH <greg@kroah.com>
To: Luke-Jr <luke-jr@utopios.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206173842.GB3084@kroah.com>
References: <20051203152339.GK31395@stusta.de> <200512040446.32450.luke-jr@utopios.org> <20051204232205.GF8914@kroah.com> <200512050559.34464.luke-jr@utopios.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512050559.34464.luke-jr@utopios.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 05:59:33AM +0000, Luke-Jr wrote:
> On Sunday 04 December 2005 23:22, Greg KH wrote:
> > On Sun, Dec 04, 2005 at 04:46:31AM +0000, Luke-Jr wrote:
> > > Well, devfs does have some abilities udev doesn't: hotplug/udev
> > > doesn't detect everything, and can result in rarer or non-PnP devices
> > > not being automatically available;
> >
> > Are you sure about that today?
> 
> Nope, but I don't see how udev can possibly detect something that
> doesn't let the OS know it's there-- except, of course, loading the
> driver for it and seeing if it works.
> 
> > And udev wasn't created to do everything that devfs does.
> 
> Which might be a case for leaving devfs in. *shrug*

Heh, no.  Please go look up why devfs was deleted, this one broken
feature is not a good enough reason to keep it around.

> > And devfs can't do everything that udev can (by far...)
> 
> Didn't say it could...
> 
> > > Interesting effects of switching my desktop from devfs to udev:
> > > 1. my DVD burners are left uninitialized until I manually modprobe ide-cd
> > > or (more recently) ide-scsi
> >
> > Sounds like a broken distro configuration :)
> 
> Well, I was assuming you kept Gentoo's udev packages up to date. ;)
> [ebuild   R   ] sys-fs/udev-070-r1  (-selinux) -static 429 kB

That's the latest stable udev release in Gentoo, yes.  Do you have
problems with that one?  If so, please file them in the proper Gentoo
bugzilla.

And yes, Gentoo is lagging a bit on the latest udev support (073 is in
the tree, but 076 has been released.)  That's totally my fault, and you
can blame my lack of free time to do what is needed to fully intregrate
it (due to some very good snow in our local mountains...)

> > > devfs also has the advantage of keeping the module info all in one
> > > place-- the kernel or the module.
> > > In particular, with udev the detection and /dev info is scattered into
> > > different locations of the filesystem. This can probably be fixed
> > > easily simply by having udev read such info from modules or via a /sys
> > > entry, though.
> >
> > What information are you talking about here?
> 
> I'm assuming everything in /etc/udev/rules.d/50-udev.rules used to be
> in the kernel for devfs-- perhaps it was PAM though, I'm not sure.

That is not true, it was not.

> Other than that, I don't expect that simply installing a new kernel
> module will allow the device to be detected automatically, but that
> some hotplug or udev configurations will need to be updated also.

Have you tried this?  What "new kernel module" are you speaking of?

thanks,

greg k-h
