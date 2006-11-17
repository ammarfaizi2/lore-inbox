Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031050AbWKQFEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031050AbWKQFEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031116AbWKQFEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:04:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:35721 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1031050AbWKQFEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:04:52 -0500
Date: Thu, 16 Nov 2006 20:23:38 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 2/2] driver core: Introduce device_move(): move a device to a new parent.
Message-ID: <20061117042338.GA11131@kroah.com>
References: <20061116154210.217f2e04@gondolin.boeblingen.de.ibm.com> <1163695657.7900.9.camel@min.off.vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163695657.7900.9.camel@min.off.vrfy.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 05:47:37PM +0100, Kay Sievers wrote:
> On Thu, 2006-11-16 at 15:42 +0100, Cornelia Huck wrote:
> > From: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > Provide a function device_move() to move a device to a new parent device. Add
> > auxilliary functions kobject_move() and sysfs_move_dir().
> > kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> > previous path (OLD_DEVPATH) in addition to the usual values.
> 
> > +	sprintf(devpath_string, "OLD_DEVPATH=%s", devpath);
> 
> I think it's easier to understand, if the variable starts with the same
> string as original name. I prefer DEVPATH_OLD.
> 
> > +void kobject_uevent_extended(struct kobject *kobj, enum kobject_action action,
> > +			     const char *string)
> 
> I think we should pass an array of env vars here instead of a single
> string - you never know ... :) The function could probably be named
> kobject_uevent_env() then.

I agree, care to respin these?

thanks,

greg k-h
