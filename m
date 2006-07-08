Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWGHJaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWGHJaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 05:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWGHJaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 05:30:24 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:57516 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932104AbWGHJaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 05:30:23 -0400
Subject: Re: Implement class_device_update_dev() function
From: Marcel Holtmann <marcel@holtmann.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1152318397.3266.130.camel@pim.off.vrfy.org>
References: <1152226792.29643.8.camel@localhost>
	 <20060706235745.GA13548@kroah.com>  <1152258152.3693.8.camel@localhost>
	 <1152318397.3266.130.camel@pim.off.vrfy.org>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 11:27:20 +0200
Message-Id: <1152350840.29506.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kay,

> > > But userspace should also find out about this change, and this patch
> > > prevents that from happening.  What about just tearing down the class
> > > device and creating a new one?  That way userspace knows about the new
> > > linkage properly, and any device naming and permission issues can be
> > > handled anew?
> > 
> > This won't work for Bluetooth. We create the TTY and its class device
> > with tty_register_device() and then the device node is present. Then at
> > some point later we open that device and the Bluetooth connection gets
> > established. Only when the connection has been established we know the
> > device that represents it. So tearing down the class device and creating
> > a new one will screw up the application that is using this device node.
> > 
> > Would reissuing the uevent of the class device help here?
> 
> How about KOBJ_ONLINE/OFFLINE?

I am not that familiar with the internals of kobject. Can you give me an
example on how to do that?

Regards

Marcel


