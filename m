Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261716AbTCLCS0>; Tue, 11 Mar 2003 21:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263004AbTCLCS0>; Tue, 11 Mar 2003 21:18:26 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:30220 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261716AbTCLCSZ>; Tue, 11 Mar 2003 21:18:25 -0500
Date: Wed, 12 Mar 2003 03:28:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
In-Reply-To: <Pine.LNX.4.33.0303111314010.1015-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303120317240.5042-100000@serv>
References: <Pine.LNX.4.33.0303111314010.1015-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Mar 2003, Patrick Mochel wrote:

> > > Greg, and Rusty, are right. Dealing with this is a PITA, and I think will 
> > > always be. I'm willing to take the Nancy Reagan platform, too. 
> > 
> > Right with what? 
> 
> With the idea that unloading modules is a bad idea. 

With the current module refcount model I can only agree.
OTOH I need a sufficiently complex example, which gets the module locking 
right (file systems are just too simple), then I can actually produce a 
patch, which shows the advantages of a different model and the driver 
model/sysfs looks like an interesting victim. :)

> > What is the "Nancy Reagan platform"?
> 
> "Just say no". It was a big anti-drug campaign in the US targeted at
> schoolchildren, spearheaded in the mid-80's by Nancy Reagan.

Well, this always look simple, but it hardly ever solves the real problem.

bye, Roman

