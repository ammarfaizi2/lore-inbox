Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbVJ1TLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbVJ1TLi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbVJ1TLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:11:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:40634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751658AbVJ1TLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:11:37 -0400
Date: Fri, 28 Oct 2005 12:09:37 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core: document struct class_device properly
Message-ID: <20051028190937.GA16822@kroah.com>
References: <11304810242041@kroah.com> <200510280154.59943.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510280154.59943.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 01:54:59AM -0500, Dmitry Torokhov wrote:
> On Friday 28 October 2005 01:30, Greg KH wrote:
> > [PATCH] Driver Core: document struct class_device properly
> ...
> 
> > + * @release: pointer to a release function for this struct class_device.  If
> > + * set, this will be called instead of the class specific release function.
> > + * Only use this if you want to override the default release function, like
> > + * when you are nesting class_device structures.
> > + * @hotplug: pointer to a hotplug function for this struct class_device.  If
> > + * set, this will be called instead of the class specific hotplug function.
> > + * Only use this if you want to override the default hotplug function, like
> > + * when you are nesting class_device structures.
> 
> Greg, 
> 
> Is this solution for nesting class devices considered permanent or is it
> a stop-gap measure?

As I detalied a while ago, a stop-gap for now.

> I hope it is latter as these 2 new methods allow one
> class device walk all over class's intended interface and semantics and
> you can no longer rely that objects of the same class have similar
> characteristics/attributes and similar behavior. You already had to
> abandon using class's default attributes when dealing with nested devices,
> I think it is wrong long-term solution.
> 
> What about Kay's proposal about moving (as far as userspace concerned)
> everything into /sys/devices?

That's exactly what I am now working on.  But it will take much longer
than 2.6.15 to get there for that.  More like the next 6 months or so at
the least...

For a good description of the latest summary, see:
	http://www.kroah.com/log/linux/driver_model_changes.html
thanks,

greg k-h
