Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWAaVlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWAaVlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWAaVlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:41:42 -0500
Received: from tim.rpsys.net ([194.106.48.114]:27031 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751522AbWAaVlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:41:42 -0500
Subject: Re: [PATCH 2/11] LED: Add LED Class
From: Richard Purdie <rpurdie@rpsys.net>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060131205928.GA24349@kroah.com>
References: <1138714888.6869.125.camel@localhost.localdomain>
	 <20060131205928.GA24349@kroah.com>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 21:41:37 +0000
Message-Id: <1138743698.6869.273.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 12:59 -0800, Greg KH wrote:
> On Tue, Jan 31, 2006 at 01:41:28PM +0000, Richard Purdie wrote:
> > +/**
> > + * led_device_register - register a new object of led_device class.
> > + * @dev: The device to register.
> > + * @led_dev: the led_device structure for this device.
> > + */
> > +int led_device_register(struct device *dev, struct led_device *led_dev)
> 
> Shouldn't struct led_device contain a struct device within it, like the
> rest of the driver model?

The code supports more than one led per struct device. 

Perhaps the name is misleading and should be led_class_register? The
code has changed a lot through its various development stages (it did
start out as a device IIRC).

led_device should also probably be led_class by that argument...

Richard

