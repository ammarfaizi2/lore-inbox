Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTDKTon (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTDKTon (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:44:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:16297 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261675AbTDKTol (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:44:41 -0400
Date: Fri, 11 Apr 2003 12:58:43 -0700
From: Greg KH <greg@kroah.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411195843.GO1821@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411192827.GC31739@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411192827.GC31739@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 12:28:27PM -0700, Joel Becker wrote:
> On Fri, Apr 11, 2003 at 11:31:28AM -0700, Kevin P. Fleming wrote:
> > - if any partitions are found, they are registered with the kernel using 
> > device-mapper ioctls
> > - because these new "mapped sections" of the drive are _also_ usable block 
> > devices in their own right, they generate hotplug events
> 
> 	In reality, we need /dev/disk0 for disks, and /dev/part0 for
> partitions, and /dev/lv0 for logical volumes from the LVM.

Well, that's maybe what _you_ want to call your disks and partitions,
but not what I want to call them :)

> There's going to be a war over this naming, and that's why this is
> hard.

No, there isn't.  That's what I am trying to completely avoid with udev.
It will allow you to plug in whatever device naming scheme that you
want.  This will keep all of the disc vs. disk flamewars from every
happening in the kernel community (well, I can hope...)

I'll be providing a small default name scheme that happens to match the
current Documentation/devices.txt names, and possibly a devfs naming
scheme for those people who like that scheme.  After that, it will be
quite easy for you to create a Oracle naming scheme where you give
different prefixes to your partitions vs. disks.

This scheme allows you to use databases, flat files, or even send a
message across the network to a admin console to get the name of a new
device.  Much more flexible than setting a kernel naming scheme, and
moves this whole argument and policy out of the kernel.

thanks,

greg k-h
