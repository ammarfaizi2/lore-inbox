Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWBABlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWBABlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 20:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWBABlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 20:41:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:27102
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964813AbWBABlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 20:41:15 -0500
Date: Tue, 31 Jan 2006 17:41:09 -0800
From: Greg KH <greg@kroah.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/11] LED: Add LED Class
Message-ID: <20060201014109.GA3827@kroah.com>
References: <1138714888.6869.125.camel@localhost.localdomain> <20060131205928.GA24349@kroah.com> <1138743698.6869.273.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138743698.6869.273.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 09:41:37PM +0000, Richard Purdie wrote:
> On Tue, 2006-01-31 at 12:59 -0800, Greg KH wrote:
> > On Tue, Jan 31, 2006 at 01:41:28PM +0000, Richard Purdie wrote:
> > > +/**
> > > + * led_device_register - register a new object of led_device class.
> > > + * @dev: The device to register.
> > > + * @led_dev: the led_device structure for this device.
> > > + */
> > > +int led_device_register(struct device *dev, struct led_device *led_dev)
> > 
> > Shouldn't struct led_device contain a struct device within it, like the
> > rest of the driver model?
> 
> The code supports more than one led per struct device. 
> 
> Perhaps the name is misleading and should be led_class_register?

Yes, that would make more sense, and have the struct device * be called
"parent".

> The code has changed a lot through its various development stages (it
> did start out as a device IIRC).
> 
> led_device should also probably be led_class by that argument...

Yes.

thanks,

greg k-h
