Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290858AbSBFWsV>; Wed, 6 Feb 2002 17:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290875AbSBFWsE>; Wed, 6 Feb 2002 17:48:04 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:28686 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290858AbSBFWrH>;
	Wed, 6 Feb 2002 17:47:07 -0500
Date: Wed, 6 Feb 2002 13:22:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020206122253.GB446@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202051445400.6350-100000@master.linux-ide.org> <Pine.LNX.4.33.0202051500510.25114-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202051500510.25114-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > On Tue, Feb 05, 2002 at 10:43:14AM -0800, Patrick Mochel wrote:
> > > > I think that ide should get its own bus, as a child of the ide controller. 
> > > > I haven't looked at ide yet at all. But, on most modern systems, the ide 
> > > > controller is a function of the southbridge, so ide devices should go 
> > > > under that. Like what the usb stuff does now...
> > > 
> > > What about, say, a Promise PCI IDE card?  You really need to reference
> > > the parent PCI device when the is one.
> > 
> > LOL, how about ones that are quad-channel with a DEC-Bridge to slip the
> > local BUSS?
> 
> LOL? I don't understand...
> 
> I don't see how any of those cases are necessarily hard to visualize. 
> 
> Case 1: Typical PC with IDE as function of southbridge.
> 
> pci0
>  |
>   -- 07.2 (IDE controller)
>      |
>       --- disk0
>      |
>       --- disk1
> 
> Case 2: Promise IDE Controller with 2 channels
> 
> 
> pci0
>  |
>   --- 03.0 (Promise IDE Controller)
>       |
>        --- channel0
>            |
>             ---- disk0
>            |
>             ---- disk1
> 

These are easy ones, but what about

Case 4: 386 with no PCI

and what's worse

Case 5: 486 with both PCI and VLB, where ide is on the VLB?

cases 4 and 5 are IMO hard, because it is difficult to know where it
really is... and I'm not sure current kernel knows it.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
