Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVC0VnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVC0VnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVC0VnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:43:14 -0500
Received: from isilmar.linta.de ([213.239.214.66]:38335 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261593AbVC0VnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:43:10 -0500
Date: Sun, 27 Mar 2005 23:43:09 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Message-ID: <20050327214309.GA18745@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Adam Belay <abelay@novell.com>, Greg KH <greg@kroah.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
References: <1111951499.3503.87.camel@localhost.localdomain> <20050327210853.GA18358@isilmar.linta.de> <1111958844.3503.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111958844.3503.100.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 04:27:24PM -0500, Adam Belay wrote:
> > extern int device_create_file(struct device *device, struct device_attribute
> > * entry);
> > and delete them (e.g. in ->remove) using
> > extern void device_remove_file(struct device * dev, struct device_attribute
> > * attr);
> > 
> > and there's also 
> > 
> > extern int driver_create_file(struct device_driver *, struct
> > driver_attribute *);
> > extern void driver_remove_file(struct device_driver *, struct
> > driver_attribute *);
> > 
> > 
> > 	Dominik
> 
> Yes, I'm aware of these functions but they pollute the bus level
> namespace.  I'm interested in reactions to this alternative approach.  I
> wanted to explore the possibility of making a device driver instance a
> separate component with its own individual state and relationships.

To be honest, I don't consider this to be a pollution of the "bus"
namespace, but I fear that having two different places for somewhat similar,
or even equal, data adds unneeded complexity to the driver model. In what
specific instances has the current design limited or obstructed your
intentions?

	Dominik
