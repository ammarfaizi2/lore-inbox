Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbTEZAES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTEZAES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 20:04:18 -0400
Received: from dp.samba.org ([66.70.73.150]:32690 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263804AbTEZAER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 20:04:17 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs 
In-reply-to: Your message of "Fri, 23 May 2003 17:37:12 MST."
             <20030524003712.GA15086@kroah.com> 
Date: Sun, 25 May 2003 14:57:31 +1000
Message-Id: <20030526001728.6F50A2C0C9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030524003712.GA15086@kroah.com> you write:
> On Fri, May 23, 2003 at 10:53:51AM +1000, Rusty Russell wrote:
> > So the question is, how do you add PCI IDs to a module which isn't loaded?
> 
> Do we really care about this question?  I mean, if a user knows that
> they want to use a specific module for their device (as they must know
> this somehow), then they can just load the module today, and use the
> dynamic id feature to add the new id.  At that time the device is bound
> to the driver.

Jeff's once complained about a distro having to update modules simply
to update the PCI tables, which he indicated happened frequently.

But adding new aliases is trivial, so this covers it.

> > You can trivially add a new alias for it, which will cause modprobe to
> > find it, but the module won't know it can handle the new PCI ID, and
> > will fail to load.
> 
> Not true.  The module will load just fine, just not bind to the device.

Yes, Matt pointed this out, which makes it work fine.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
