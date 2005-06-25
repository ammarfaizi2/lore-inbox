Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVFYXnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVFYXnd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 19:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVFYXnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 19:43:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:3273 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261378AbVFYXnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 19:43:18 -0400
Date: Sat, 25 Jun 2005 16:43:05 -0700
From: Greg KH <greg@kroah.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050625234305.GA11282@kroah.com>
References: <20050624081808.GA26174@kroah.com> <20050625221516.GD14426@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625221516.GD14426@waste.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 03:15:16PM -0700, Matt Mackall wrote:
> On Fri, Jun 24, 2005 at 01:18:08AM -0700, Greg KH wrote:
> > Now I just know I'm going to regret this somehow...
> > 
> > Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
> > tiny:
> > $ size fs/ndevfs/inode.o 
> >    text    data     bss     dec     hex filename
> >    1571     200       8    1779     6f3 fs/ndevfs/inode.o
> > replacement for devfs for those embedded users who just can't live
> > without the damm thing.  It doesn't allow subdirectories, and only uses
> > LSB compliant names.  But it works, and should be enough for people to
> > use, if they just can't wean themselves off of the idea of an in-kernel
> > fs to provide device nodes.
> > 
> > Now, with this, is there still anyone out there who just can't live
> > without devfs in their kernel?
> > 
> > Damm, the depths I've sunk to these days, I'm such a people pleaser...
> 
> Hmm. I'm not pleased. Perhaps you're pleasing the wrong people?

You are so right, I am.  I need to be pleasing me, and devfs in the
kernel is not the correct solution.  I knew this 4 years ago when Pat
and I started working on the driver core (my main goal was to do it to
support a udev-like solution), and I still know this today.

So no, I'm not going to be submitting this.  But what it is, is a nice
proof-of-concept for people who "just can't live without a in-kernel
devfs" to show that it can be done in less than 300 lines of code, and
only 6 hooks (2 functions in 3 different places) in the main kernel
tree.  That is managable outside of the main kernel for years, with
almost little to no effort.

> What we really need is a short HOWTO that covers:
> 
> - Do you really need a dynamic /dev?
> - How to embed a static /dev in your embedded kernel with initramfs
> - How to add a dynamic /dev to your kernel with udev

Yes, I'm going to start working with some of the people who really know
this stuff (the distro developers who make the whole dynamic boot and
early boot process work correctly) and we will hash out a coheirant
future together, and document it all really well.

But I'm going to wait to do that till next week, the sun is shining, the
beer is cold, and I'm going to relax now...

Thanks for calling me on this, I appreciate it.  You weren't the only
one either, which is a good thing.

greg k-h
