Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268271AbTBMTR6>; Thu, 13 Feb 2003 14:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268270AbTBMTR6>; Thu, 13 Feb 2003 14:17:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268271AbTBMTR5>;
	Thu, 13 Feb 2003 14:17:57 -0500
Date: Thu, 13 Feb 2003 13:19:54 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Dave Jones <davej@codemonkey.org.uk>, <wingel@nano-systems.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
In-Reply-To: <1045161084.1721.30.camel@vmhack>
Message-ID: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Feb 2003, Rusty Lynch wrote:

> On Thu, 2003-02-13 at 11:07, Dave Jones wrote:
> > On Thu, Feb 13, 2003 at 07:51:45AM -0800, Rusty Lynch wrote:
> > 
> >  > > You could regard them as 'system' devices, and have them show up in 
> >  > > devices/sys/, which would make more sense than 'legacy'.
> >  > Ok, system device is the winner.
> > 
> > Why? Stop for a second and look what we have in those dirs.
> > They both contain things that are essentially motherboard resources.
> > 
> > These are add-on cards we're talking about. Surely a more sensible
> > place for them to live is somewhere under devices/pci0/ or whatever
> > bus-type said card is for.
> > 
> > Whilst there are some watchdogs which _are_ part of the motherboard
> > chipset (which is arguably 'system'), these still show up in PCI
> > space as regular PCI devices.
> > 
> > Lumping them all into the same category as things like rtc, pic,
> > fdd etc is just _wrong_.
> > 
> > 		Dave
> > 
> 
> The thing I would like to see is an easy way for a user space
> application to see the available watchdog devices without searching
> every possible bus type.  If we had that one location to find all
> watchdog devices, then each device could just be a symbolic link to the
> device in it's real bus.

Create a watchdog timer class. That will contain all watchdog timers, no 
matter what bus they are on. 

I apologize for leading you astray with suggesting you treat them as 
system devices; I was under the assumption they were more important. :)
They should always be in the most accurate place in the tree. Don't worry 
about what the user sees; consistency and accuracy are more important..

	-pat

