Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263516AbUJ2UeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbUJ2UeF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbUJ2U2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:28:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:50868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263443AbUJ2UXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:23:37 -0400
Date: Fri, 29 Oct 2004 15:22:49 -0500
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 2/4] Driver core: add driver_probe_device
Message-ID: <20041029202249.GB29171@kroah.com>
References: <20041029185753.53517.qmail@web81307.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029185753.53517.qmail@web81307.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:57:52AM -0700, Dmitry Torokhov wrote:
> > I really like the "driver" part in the device.  But not as a file, let's
> > make it a symlink back to the driver that is bound to the device at that
> > point in time.  This makes it just like the other symlinks in the sysfs
> > tree.
> > 
> > But if we do that, we still don't have a way to implement what you are
> > really trying to do (and it breaks your code as you already have a
> > driver file.)  I'll work on what I propose instead in my next message
> > (will be a few hours, have real work to do for a bit, sorry...)
> >
> 
> Well, we can have driver as a symlink and rename my "driver" attribute
> into something like "drvctl" (just an example, maybe somebody has better
> name in mind, I am not fixed on the name) and make it writable only.

Yes, that's exactly what I was thinking of.  But as you wanted it to do
three different things... Hm, no, I guess you only wanted it to do 2
things.  Ah, that's not bad at all.  Been traveling too long, can't
remember threads...

> I think it should work well as now device and driver objects are very
> symmetrical - they both similarly linked together via device->driver
> and driver->device).

I agree.  Hm, I guess the remaining 2 patches aren't that far away from
what I was thinking about originally. 

Ok, care to redo the "driver" patch to be a symlink instead?  I think
the last patch doesn't really need any changes, does it?

Hm, but how does this play with the current pci "add a new device id"
scheme?  Can this "bind_mode" scheme work with that?

thanks,

greg k-h
