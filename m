Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUJUPAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUJUPAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270745AbUJUO6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:58:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:39147 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270752AbUJUOx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:53:56 -0400
Date: Thu, 21 Oct 2004 07:50:51 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: Driver core change request
Message-ID: <20041021145051.GB5718@kroah.com>
References: <200410062354.18885.dtor_core@ameritech.net> <20041008214820.GA1096@kroah.com> <200410120129.59221.dtor_core@ameritech.net> <200410210205.43399.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410210205.43399.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:05:40AM -0500, Dmitry Torokhov wrote:
> On Tuesday 12 October 2004 01:29 am, Dmitry Torokhov wrote:
> > For now I added:
> > 
> > - "driver" default device attribute that produces name of currently bound
> >   driver uppon read.
> > - bus->rebind_handler method that is called when someone writes to "driver"
> >   attribute and allows to perform bunctions like disconnecting device or
> >   rebinding it to alternative driver in bus-specific way.
> > - "bind_mode" default device and driver attributes that can be "auto" or
> >   "manual". When device or driver marked as manual bind device_attach()
> >   and driver_attach() will ignore them. They are expected to be bound by
> >   bus->rebind_handler (via driver_probe_device()).
> > 
> > I also renamed bus_match to driver_probe_device() and exported it, along
> > with device_attach and driver_attach.
> > 
> > Please let me know if its acceptable.
> > 
> 
> Greg,
> 
> Sorry for bothering you but cold you tell me if you are staisfied with the
> patches or I need to look for some alternative. As an example of usage
> please find my working copy of serio.c below.

I like part of them :)

But I'm still swamped with syncing up with Linus's tree, but should be
able to get to these later this afternoon.  I haven't forgotten about
these, they are still in my todo queue.

thanks,

greg k-h
