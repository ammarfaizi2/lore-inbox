Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUBISyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbUBISyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:54:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:59321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265177AbUBISyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:54:01 -0500
Date: Mon, 9 Feb 2004 10:54:02 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, sensors@stimpy.netroedge.com
Subject: Where is the world is Greg's bk trees...
Message-ID: <20040209185402.GA10123@kroah.com>
References: <20040209173232.GA9458@kroah.com> <Pine.LNX.4.44L0.0402091324070.1821-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0402091324070.1821-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added sensor, lkml, and pci hotplug lists, as people there care about
this stuff at times...

On Mon, Feb 09, 2004 at 01:30:22PM -0500, Alan Stern wrote:
> On Mon, 9 Feb 2004, Greg KH wrote:
> 
> > On Mon, Feb 09, 2004 at 11:31:16AM -0500, Alan Stern wrote:
> > > Greg:
> > > 
> > > A couple of weeks ago you said that this patch
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107530733920901&w=2
> > > 
> > > had been applied.  But it still hasn't shown up in BK.
> > 
> > It's in my local, "working" bk tree:
> > 	bk://kernel.bkbits.net/gregkh/linux/gregkh-2.6
> > 
> > and in my USB staging tree to be sent to Linus:
> > 	bk://kernel.bkbits.net/gregkh/linux/usb-2.6
> > 
> > And it's in the past few -mm releases, which pulls from the above bk
> > tree.
> 
> Actually I was asking about
> 	bk://kernel.bkbits.net//home/gregkh/linux/gregkh-2.6
> 
> That's my parent.  It isn't the same as the first one you listed above, is
> it?  Should I switch?

It is the same tree as the first one above.

Hm, oops, that patch didn't make it into that tree, sorry.  I've now
fixed that.

> How many repositories do you have to keep track of, anyway?  And where
> do you keep your ball of string to find your way back?  :-)

Heh, ok, here's all of my current bk trees, what's in them, and what
they are based off of:

bk://kernel.bkbits.net/gregkh/linux/gregkh-2.6
bk://kernel.bkbits.net/gregkh/linux/gregkh-2.4
	These are my "working" 2.6 and 2.4 kernel trees.  It's what I
	run on my boxes, and usually contain all of the different
	patches that people have sent me for the different parts of the
	kernel that I maintain.  They also contain some wierd stuff that
	I'm working on that hasn't made it into any kernel tree (or ever
	will, like that signed module stuff that used to be in my 2.6
	kernel tree, or some odd patches for one of my laptops...)

	These are _not_ based off of Linus's kernel tree, and can not be
	pulled or pushed to them.  They are based off of my own tree,
	which was started way before Linus started using bk.  They
	usually are updated to sync with Linus and Marcelo's trees every
	release (and sometimes between releases with the -bk patches.)

	Use these at your own risk, but also use these if you want to be
	able to send me a patch, and then send me another one based off
	of that one, to make sure that I got it.

	If you have any problems with these trees, don't bother any
	mailing list, just let me know.

bk://kernel.bkbits.net/gregkh/linux/clean/linux-2.4
bk://kernel.bkbits.net/gregkh/linux/clean/linux-2.6
	"Clean" parents of the above trees.  These contain _only_
	releases from kernel.org and none of my stuff.  If you want a
	tree that tracks kernel.org releases, uses these.

	These are what I use to merge the kernel.org updates into my
	gregkh-* trees.

bk://kernel.bkbits.net/gregkh/linux/usb-2.6
	Staging tree to send USB patches to Linus.  He can pull from
	this tree, and it is based off of his.  This tree also gets
	pulled from into the latest -mm release.

bk://kernel.bkbits.net/gregkh/linux/pci-2.6
	Staging tree to send PCI and PCI Hotplug patches to Linus.  He
	can pull from this tree, and it is based off of his.  This tree
	also gets pulled from into the latest -mm release.

bk://kernel.bkbits.net/gregkh/linux/i2c-2.6
	Staging tree to send I2C patches to Linus.  He can pull from
	this tree, and it is based off of his.  This tree also gets
	pulled from into the latest -mm release.

bk://kernel.bkbits.net/gregkh/linux/driver-2.6
	Staging tree to send Driver core, kobject, and sysfs patches to
	Linus.  He can pull from this tree, and it is based off of his.
	This tree also gets pulled from into the latest -mm release.

bk://kernel.bkbits.net/gregkh/linux/usb-2.4
	Staging tree to send USB patches to Marcelo.  He can pull from
	this tree, and it is based off of his.

bk://kernel.bkbits.net/gregkh/linux/pci-2.4
	Staging tree to send PCI and PCI Hotplug patches to Marcelo.  He
	can pull from this tree, and it is based off of his.



bk://kernel.bkbits.net/gregkh/udev
	Latest udev tree.  Also mirrored at
	bk://linuxusb.bkbits.net/udev


Hope that helps people figure my mess of public bk trees out.

thanks,

greg k-h
