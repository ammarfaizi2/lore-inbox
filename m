Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbTCJTNS>; Mon, 10 Mar 2003 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261432AbTCJTNS>; Mon, 10 Mar 2003 14:13:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261431AbTCJTNQ>;
	Mon, 10 Mar 2003 14:13:16 -0500
Date: Mon, 10 Mar 2003 12:59:26 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-Reply-To: <20030310191216.GB11310@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0303101252230.1002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Hmm, I am not sure if drivers/power is the right place for stuff like
> > > fridge.c. That might be usefull for other stuff, too.
> > 
> > That's fine. If it proves useful for other things, we can move it. 
> 
> Actually, I'd like driver model to specify that things are
> refrigerated when device_suspend() and friends are being run. That
> should make drivers a lot simpler. [And as non-bitkeeper-capable user
> I fear moves ;-)]

That's a policy decision outside of the scope of the driver model. It is 
however, inside the scope of the PM model, and by using the generic 
framework, this decision can be guaranteed to be made. 

> > > I do not think placing swsusp.h in drivers/power/swsusp is right. It
> > > should be in include/linux or include/linux/power.
> > 
> > That header is only for the shared functions between 
> > drivers/power/swsusp/*.c. There's no need to export it to everyone. 
> 
> Well, last time acpi introduced its private include/ directory, it was
> a disaster.

I don't necessarily agree. IMO, putting things in include/whatever/ makes 
it easy for other code to directly access those functions, some of which 
you never want people calling directly. And, if it's there, it's likely 
someone will use it someday. 

But, in the end it's your code, so I don't really care.


	-pat

