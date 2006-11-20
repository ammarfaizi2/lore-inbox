Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933779AbWKTIFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933779AbWKTIFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 03:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933684AbWKTIFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 03:05:04 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61145 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S933779AbWKTIFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 03:05:02 -0500
Date: Mon, 20 Nov 2006 09:05:37 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 2/2] driver core: Introduce device_move(): move a
 device to a new parent.
Message-ID: <20061120090537.6d59dbc5@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061117042338.GA11131@kroah.com>
References: <20061116154210.217f2e04@gondolin.boeblingen.de.ibm.com>
	<1163695657.7900.9.camel@min.off.vrfy.org>
	<20061117042338.GA11131@kroah.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 20:23:38 -0800,
Greg KH <greg@kroah.com> wrote:

> On Thu, Nov 16, 2006 at 05:47:37PM +0100, Kay Sievers wrote:
> > On Thu, 2006-11-16 at 15:42 +0100, Cornelia Huck wrote:
> > > From: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > 
> > > Provide a function device_move() to move a device to a new parent device. Add
> > > auxilliary functions kobject_move() and sysfs_move_dir().
> > > kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> > > previous path (OLD_DEVPATH) in addition to the usual values.
> > 
> > > +	sprintf(devpath_string, "OLD_DEVPATH=%s", devpath);
> > 
> > I think it's easier to understand, if the variable starts with the same
> > string as original name. I prefer DEVPATH_OLD.
> > 
> > > +void kobject_uevent_extended(struct kobject *kobj, enum kobject_action action,
> > > +			     const char *string)
> > 
> > I think we should pass an array of env vars here instead of a single
> > string - you never know ... :) The function could probably be named
> > kobject_uevent_env() then.
> 
> I agree, care to respin these?

OK, makes sense. I'll post a new one today.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
