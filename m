Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWEEVMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWEEVMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWEEVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:12:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:31911 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751784AbWEEVMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:12:33 -0400
Date: Fri, 5 May 2006 14:10:56 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060505211056.GC7365@kroah.com>
References: <1146776736.27727.11.camel@localhost.localdomain> <mj+md-20060504.211425.25445.atrey@ucw.cz> <1146778197.27727.26.camel@localhost.localdomain> <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com> <1146784923.4581.3.camel@localhost.localdomain> <445BA584.40309@us.ibm.com> <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com> <20060505202603.GB6413@kroah.com> <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com> <9e4733910605051343k3213d3f6ma4673ab0650272ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605051343k3213d3f6ma4673ab0650272ea@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 04:43:15PM -0400, Jon Smirl wrote:
> >On 5/5/06, Greg KH <greg@kroah.com> wrote:
> >> Who cares who "enabled" the device.  Remember, the majority of PCI
> >> devices in the system are not video ones.  Lots of other types of
> >> devices want this ability to enable PCI devices from userspace.  I've
> >> been talking with some people about how to properly write PCI drivers in
> >> userspace, and this attribute is a needed part of it.
> 
> The problem is not who 'enabled' the device. The problem is who owns
> the state that has been loaded into the device. Without a mechanism
> like open there is no way to serialize the programs trying to set
> state into the device.
> 
> fbdev and X have this fight currently. On every VT swap they each
> reload their state into the video hardware. There is no coordination
> so both systems have to assume worst case and rebuild everything. This
> is not a good environment to program in. Every time one of the systems
> starts using some new feature of hardware (like acceleration
> functions) new state recovery code needs to be written.

Yes, I agree that this is a big issue and one that needs to be worked
on.  However, this simple "enable" file has nothing to do with that
issue at all...

thanks,

greg k-h
