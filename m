Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbULKCGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbULKCGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 21:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbULKCGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 21:06:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:16026 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261907AbULKCGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 21:06:12 -0500
Date: Fri, 10 Dec 2004 18:05:42 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041211020542.GA18315@kroah.com>
References: <20041210005055.GA17822@kroah.com> <200412101729.01155.david-b@pacbell.net> <20041211013930.GB12846@kroah.com> <200412101802.00197.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412101802.00197.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 06:02:00PM -0800, David Brownell wrote:
> On Friday 10 December 2004 5:39 pm, Greg KH wrote:
> > > What I'd really want out of a debug file API is to resolve
> > > the naming issues, work with seq_file, and "softly and
> > > silently vanish away".  I think this patch has the last
> > > two, but not the first one!
> > 
> > I considered adding a kobject as a paramater to the debugfs interface.
> > The file created would be equal to the path that the kobject has.  Would
> > that work for you?
> 
> If I could pass device->kobj or driver->kobj, that'd be good.

Ok, I'll work on adding that.

> Will there be a /debug/devices tree parallel to /sys/devices?

If the kobject name is devices/foo/whatever, then  yes, it would then
match up the same, if you create a debugfs file with the kobject.  If
you don't do that, then no, I'm not going to maintain a mirror directory
image of sysfs in debugfs just for the fun of it :)

thanks,

greg k-h
