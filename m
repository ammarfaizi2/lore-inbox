Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVC0WXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVC0WXW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVC0WXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:23:22 -0500
Received: from peabody.ximian.com ([130.57.169.10]:57510 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261609AbVC0WXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:23:17 -0500
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
From: Adam Belay <abelay@novell.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
In-Reply-To: <20050327214309.GA18745@isilmar.linta.de>
References: <1111951499.3503.87.camel@localhost.localdomain>
	 <20050327210853.GA18358@isilmar.linta.de>
	 <1111958844.3503.100.camel@localhost.localdomain>
	 <20050327214309.GA18745@isilmar.linta.de>
Content-Type: text/plain
Date: Sun, 27 Mar 2005 17:18:10 -0500
Message-Id: <1111961891.3503.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 23:43 +0200, Dominik Brodowski wrote:
> On Sun, Mar 27, 2005 at 04:27:24PM -0500, Adam Belay wrote:
> > > extern int device_create_file(struct device *device, struct device_attribute
> > > * entry);
> > > and delete them (e.g. in ->remove) using
> > > extern void device_remove_file(struct device * dev, struct device_attribute
> > > * attr);
> > > 
> > > and there's also 
> > > 
> > > extern int driver_create_file(struct device_driver *, struct
> > > driver_attribute *);
> > > extern void driver_remove_file(struct device_driver *, struct
> > > driver_attribute *);
> > > 
> > > 
> > > 	Dominik
> > 
> > Yes, I'm aware of these functions but they pollute the bus level
> > namespace.  I'm interested in reactions to this alternative approach.  I
> > wanted to explore the possibility of making a device driver instance a
> > separate component with its own individual state and relationships.
> 
> To be honest, I don't consider this to be a pollution of the "bus"
> namespace, but I fear that having two different places for somewhat similar,
> or even equal, data adds unneeded complexity to the driver model. In what
> specific instances has the current design limited or obstructed your
> intentions?
> 

Fair enough.  I just wanted to float this possibility.  I appreciate
your comments.  The original intention for this design was to begin
working on a framework for driver layering.  (ex. snd-intel8x0m -> ac97,
or the pci express bus abstraction)  I was considering the possibility
of having driver devices with parent and child relationships that
reflect the internal layering of Linux drivers.  I haven't really had a
chance to fully develop this idea, so at this point, driver layering and
my original email are just abstract concepts.

Adam


