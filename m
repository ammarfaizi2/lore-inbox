Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289844AbSBEXID>; Tue, 5 Feb 2002 18:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBEXHy>; Tue, 5 Feb 2002 18:07:54 -0500
Received: from air-2.osdl.org ([65.201.151.6]:32686 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289844AbSBEXHh>;
	Tue, 5 Feb 2002 18:07:37 -0500
Date: Tue, 5 Feb 2002 15:08:15 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <Pine.LNX.4.10.10202051445400.6350-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0202051500510.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Andre Hedrick wrote:

> On Tue, 5 Feb 2002, Russell King wrote:
> 
> > On Tue, Feb 05, 2002 at 10:43:14AM -0800, Patrick Mochel wrote:
> > > I think that ide should get its own bus, as a child of the ide controller. 
> > > I haven't looked at ide yet at all. But, on most modern systems, the ide 
> > > controller is a function of the southbridge, so ide devices should go 
> > > under that. Like what the usb stuff does now...
> > 
> > What about, say, a Promise PCI IDE card?  You really need to reference
> > the parent PCI device when the is one.
> 
> LOL, how about ones that are quad-channel with a DEC-Bridge to slip the
> local BUSS?

LOL? I don't understand...

I don't see how any of those cases are necessarily hard to visualize. 

Case 1: Typical PC with IDE as function of southbridge.

pci0
 |
  -- 07.2 (IDE controller)
     |
      --- disk0
     |
      --- disk1

Case 2: Promise IDE Controller with 2 channels


pci0
 |
  --- 03.0 (Promise IDE Controller)
      |
       --- channel0
           |
            ---- disk0
           |
            ---- disk1


Case 3: Quad channel DEC Bridge

Ok, maybe I don't understand completely what you're talking about, Andre. 
That's just a 4 channel IDE controller, that happens to be on the board? 
So, it's looks the same as the last example.

Unless, I'm missing something, which is always likely.

	-pat

