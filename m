Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbTEXAva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 20:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTEXAva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 20:51:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14555 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264215AbTEXAv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 20:51:27 -0400
Date: Fri, 23 May 2003 17:37:12 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs
Message-ID: <20030524003712.GA15086@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D680392F82C-100000@AUSXMPC122.aus.amer.dell.com> <20030303182553.GG16741@kroah.com> <20030523105351.2ba4f9b2.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523105351.2ba4f9b2.rusty@rustcorp.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 10:53:51AM +1000, Rusty Russell wrote:
> 
> More importantly, the modules now contain suitable aliases embedded within
> them: modules.pcimap et al will vanish before 2.6 whenever Greg (hint hint)
> updates the hotplug scripts to use them instead of modules.XXXmap.

Yeah, yeah, yeah, I'll get to it soon, sorry :)

> So the question is, how do you add PCI IDs to a module which isn't loaded?

Do we really care about this question?  I mean, if a user knows that
they want to use a specific module for their device (as they must know
this somehow), then they can just load the module today, and use the
dynamic id feature to add the new id.  At that time the device is bound
to the driver.

I don't really see this as a problem, but I might be missing something
obvious.

> You can trivially add a new alias for it, which will cause modprobe to
> find it, but the module won't know it can handle the new PCI ID, and
> will fail to load.

Not true.  The module will load just fine, just not bind to the device.
Well, old-style pci modules will not load, but I don't feel sorry about
them at all.  They have had about 3 years to convert to the "new" pci
api.

thanks,

greg k-h
