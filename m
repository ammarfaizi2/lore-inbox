Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVBXHEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVBXHEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVBXHEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:04:41 -0500
Received: from peabody.ximian.com ([130.57.169.10]:39602 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261873AbVBXHEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:04:39 -0500
Subject: Re: [RFC] PCI bridge driver rewrite
From: Adam Belay <abelay@novell.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <9e473391050223224532239c9d@mail.gmail.com>
References: <1109226122.28403.44.camel@localhost.localdomain>
	 <9e473391050223224532239c9d@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 02:03:58 -0500
Message-Id: <1109228638.28403.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 01:45 -0500, Jon Smirl wrote:
> On Thu, 24 Feb 2005 01:22:01 -0500, Adam Belay <abelay@novell.com> wrote:
> > For the past couple weeks I have been reorganizing the PCI subsystem to
> > better utilize the driver model.  Specifically, the bus detection code
> > is now using a standard PCI driver.  It turns out to be a major
> 
> What about VGA routing? Most PCI buses do it with the normal VGA bit
> but big hardware supports multiple legacy IO spaces via the bridge
> chips.
> 
> Are you going to make sysfs entries for the bridges? If so I'd like a
> VGA attribute that directly reads the VGA bit from the hardware and
> display it instead of using the shadow copy.

Yeah, actually I've been thinking about this issue a lot.  I think it
would make a lot of sense to export this sort of thing under the
"pci_bus" class in sysfs.  The ISA enable bit should probably also be
exported.  Furthermore, we should be verifying the BIOS's configuration
of VGA and ISA.  I'll try to integrate this in my future releases.  I
appreciate the code.

I also have a number of resource management plans for the VGA enable bit
that I'll get into in my next set of patches.

> 
> Jesse can comment on the specific support needed for multiple legacy IO spaces.
> 

That would be great.  Most of my experience has been with only a couple
legacy IO port ranges passing through the bridge.

Thanks,
Adam


