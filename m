Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTH0XXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 19:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbTH0XXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 19:23:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:61879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262441AbTH0XXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 19:23:31 -0400
Date: Wed, 27 Aug 2003 16:29:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI PM & compatibility
In-Reply-To: <1061988185.1293.57.camel@gaston>
Message-ID: <Pine.LNX.4.44.0308271628060.4140-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > - When a device is suspended, the pm_users count of its pm_parent is 
> >   decremented, and incremented when the device is resumed. 
> > 
> > - device_suspend() makes multiple passes over the device list, in case
> >   power dependencies cause some devices to be deferred. It fails with an 
> >   error (and resumes all suspended devices) if a pass was made in which 
> >   no devicse were suspended, but there are still devices with a positive
> >   pm_users count. 
> 
> How do you intend to deal with the childs of the device that has
> pm_users non null ?
> 
> If you don't suspend it, you must also postpone all of it's childs.
> That makes the list walking slightly more tricky, or you finally go
> to a real tree structure ? (Which you may have to do to implement
> the set_parent() thing too, no ?

I don't understand. We suspend the children before we suspend the device, 
so as long as all the children go done, so will the parent device.


	Pat

