Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWDAUOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWDAUOi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 15:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWDAUOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 15:14:38 -0500
Received: from mx1.rowland.org ([192.131.102.7]:12306 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751622AbWDAUOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 15:14:37 -0500
Date: Sat, 1 Apr 2006 15:14:36 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Handling devices that don't have a bus
In-Reply-To: <200604010932.55104.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0604011507470.26230-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2006, David Brownell wrote:

> On Saturday 01 April 2006 8:46 am, Alan Stern wrote:
> 
> > I think you have misunderstood my point.  Yes, devices are part of the
> > platform bus only if they explicitly want to be.  My point was that even
> > though they _do_ want to be on the platform bus, 
> 
> I'm not clear on why it would want to be on the platform bus;
> what would its inner platform-ness consist of?
> 
> There really isn't a "bus" that makes much sense for such a
> singleton device to sit on.  

I suppose you could argue that the "platform-ness" is related to the fact
that a gadget is a sort-of synthetic device, made up entirely of software.  
Not very convincing, I admit.

The real reason for wanting to use the platform bus is because USB gadgets
don't really belong anywhere else, and the platform bus is supposed to be
(among other things) the bus for devices that don't have a home of their
own.  It took over that role from the old "misc" bus, or whatever it used
to be called.

Of course, there's always the possibility of creating a "usb-gadget" bus
-- but that really would be going over the top!

Alan Stern

