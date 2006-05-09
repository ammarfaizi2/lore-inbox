Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWEIWDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWEIWDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWEIWDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:03:36 -0400
Received: from ns.suse.de ([195.135.220.2]:51406 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751206AbWEIWDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:03:36 -0400
Date: Tue, 9 May 2006 15:01:58 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Message-ID: <20060509220158.GA20564@kroah.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.826853000@sous-sol.org> <20060509194044.GA374@kroah.com> <20060509215314.GU24291@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509215314.GU24291@moss.sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 02:53:14PM -0700, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > And what are you doing with the different "levels"?  Is there some
> > description of how you are using sysfs for this?  Busses should not be
> > "nested", devices should.  How does sysfs look with this code in it?
> > What is the /sys/bus/ structure?  What is the /sys/devices/ structure?
> 
> e.g.
> 
> /sys/bus/xen
> |-- devices
> |   |-- vbd-51713 -> ../../../devices/xen/vbd-51713
> |   `-- vif-0 -> ../../../devices/xen/vif-0
> `-- drivers
>     `-- vbd
>         |-- bind
>         |-- unbind
>         `-- vbd-51713 -> ../../../../devices/xen/vbd-51713
> 
> /sys/devices/xen
> |-- uevent
> |-- vbd-51713
> |   |-- block:xvda1 -> ../../../block/xvda1
> |   |-- bus -> ../../../bus/xen
> |   |-- devtype
> |   |-- driver -> ../../../bus/xen/drivers/vbd
> |   |-- nodename
> |   `-- uevent
> `-- vif-0
>     |-- bus -> ../../../bus/xen
>     |-- devtype
>     |-- nodename
>     `-- uevent

<snip>

> > What is the "frontend/backend" relationship here?
> 
> do you mean in sysfs?  or more in general?

Either.  You seem to mention a lot of nested depths in sysfs or "files",
yet your above tree doesn't show that.  And I don't understand what you
mean by frontend/backend here either?  Is it a sysfs thing?  Or a Xen
thing?

thanks,

greg k-h
