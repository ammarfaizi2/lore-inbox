Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVCQXIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVCQXIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCQXIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:08:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:11670 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261349AbVCQXIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:08:15 -0500
Date: Thu, 17 Mar 2005 14:55:59 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] add TIMEOUT to firmware_class hotplug event
Message-ID: <20050317225559.GD6620@kroah.com>
References: <20050317023431.GA27777@vrfy.org> <20050317054602.GA14459@kroah.com> <1111057675.6675.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111057675.6675.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 12:07:55PM +0100, Kay Sievers wrote:
> On Wed, 2005-03-16 at 21:46 -0800, Greg KH wrote:
> > On Thu, Mar 17, 2005 at 03:34:31AM +0100, Kay Sievers wrote:
> > > On Tue, 2005-03-15 at 09:25 +0100, Hannes Reinecke wrote:
> > > > The current implementation of the firmware class breaks a fundamental
> > > > assumption in udevd: that the physical device can be initialised fully
> > > > prior to executing the next event for that device.
> > > 
> > > Here we add a TIMEOUT value to the hotplug environment of the firmware
> > > requesting event. I will adapt udevd not to wait for anything else, if
> > > it finds a TIMEOUT key.
> > 
> > Can't you just trigger off of the FIRMWARE variable instead?
> 
> Sure, that will work too. I just thought it would be nice to give
> userspace a hint about the event behavior the kernel expects, instead of
> adding an exception to the udevd event management?

Hm, so by adding the TIMEOUT value, we are telling userspace that we
better act on this operation soon, right?  That's a special case too :)

Anyway, sure, this is fine, I'll go add this to the driver-bk tree.

thanks,

greg k-h
