Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWEEVHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWEEVHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWEEVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:07:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:167 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751780AbWEEVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:07:51 -0400
Date: Fri, 5 May 2006 14:06:14 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060505210614.GB7365@kroah.com>
References: <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com> <1146776736.27727.11.camel@localhost.localdomain> <mj+md-20060504.211425.25445.atrey@ucw.cz> <1146778197.27727.26.camel@localhost.localdomain> <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com> <1146784923.4581.3.camel@localhost.localdomain> <445BA584.40309@us.ibm.com> <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com> <20060505202603.GB6413@kroah.com> <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 04:35:17PM -0400, Jon Smirl wrote:
> On 5/5/06, Greg KH <greg@kroah.com> wrote:
> >On Fri, May 05, 2006 at 04:14:00PM -0400, Jon Smirl wrote:
> >> I would like to see other design alternatives considered on this
> >> issue. The 'enable' attribute has a clear problem in that you can't
> >> tell which user space program is trying to control the device.
> >> Multiple programs accessing the video hardware with poor coordination
> >> is already the source of many problems.
> >
> >Who cares who "enabled" the device.  Remember, the majority of PCI
> >devices in the system are not video ones.  Lots of other types of
> >devices want this ability to enable PCI devices from userspace.  I've
> >been talking with some people about how to properly write PCI drivers in
> >userspace, and this attribute is a needed part of it.
> 
> User space program enables the device.
> Next I load a device driver
> next I rmmod the device driver and it disables the device
> user space program trys to use the device
> No coordination and user space program faults

Gun.  Foot.  Shoot.

> Don't say this can't happen, it is a current source of conflict
> between X and fbdev.

Not a PCI kernel issue :)

> Should we just remove the ability to disable hardware?

Huh?  Why?

> How would that interact with hotplug?

What does hotplug have to do at all with this?

thanks,

greg "not all the world is video cards" k-h
