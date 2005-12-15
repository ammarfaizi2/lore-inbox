Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVLOQbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVLOQbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVLOQbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:31:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:26603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750802AbVLOQbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:31:41 -0500
Date: Thu, 15 Dec 2005 08:31:22 -0800
From: Greg KH <greg@kroah.com>
To: Denny Priebe <spamtrap@siglost.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeated USB disconnect and reconnect with Wacom Intuos3 6x11 tablet
Message-ID: <20051215163122.GC14512@kroah.com>
References: <20051213184600.GA4283@nostromo.dyndns.info> <20051213193832.GA14047@kroah.com> <20051215144254.GA19794@nostromo.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215144254.GA19794@nostromo.dyndns.info>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 03:42:54PM +0100, Denny Priebe wrote:
> On Tue, Dec 13, 2005 at 11:38:32AM -0800, Greg KH wrote with possible deletions:
> 
> Hello,
> 
> > > These disconnects and reconnects disappear as soon as there's 
> > > a process reading either /dev/input/mouse0 or /dev/input/event5 
> > > (mouse0 and event5 according to my setup).
> 
> > Sounds like a hardware problem, the kernel can't cause a device to
> > electronically disconnect itself like this.
> 
> thanks for your reply, Greg.
>  
> > I suggest plugging this into a different port, using a powered hub, or
> > checking that the cable is still good.
> 
> I tried what you have suggested. Unfortunately, this doesn't change 
> anything.
> 
> What confuses me a bit is that theses USB disconnects do not appear
> as soon as I read what the tablet provides.
> 
> Could it be that the usb driver doesn't check for a connect status change
> while there's a process reading /dev/input/{mouse,event}? so that I do not
> see these disconnects while reading the tablet data? 

No, it's an electronic signal happening on the USB hub, the hub notifies
the kernel when a disconnect happens, it has nothing to do with the
driver connected to the actual device.

So I really think that this is an electronic issue, sorry.  Can you
return this device and get a replacement one?

greg k-h
