Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275708AbRIZXw0>; Wed, 26 Sep 2001 19:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275707AbRIZXwR>; Wed, 26 Sep 2001 19:52:17 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:64010 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S275705AbRIZXwB>; Wed, 26 Sep 2001 19:52:01 -0400
Message-ID: <3BB26983.29B37F4E@osdlab.org>
Date: Wed, 26 Sep 2001 16:49:23 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Peter Sandstrom <peter@zaphod.nu>, Robert Cantu <robert@tux.cs.ou.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Question: Etherenet Link Detection
In-Reply-To: <20010926174116.A7544@tux.cs.ou.edu> <CIEJKOKMAIAHDBBLFGFFEEOPCGAA.peter@zaphod.nu> <20010926163928.A3678@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

It's traditionally been defined as MII information, but that's
awfully slow, so some Ethernet controllers make it available
in a quicker manner.

ethtool might do this (http://sourceforge.net/projects/gkernel/);
I don't know for sure.

or mii-diag (http://www.scyld.com/diag/).

~Randy


Matthew Dharm wrote:
> 
> You can get that information from the PHY too, so if you can get to the MII
> control registers, you can query the phy for link status.
> 
> Again, tho, the problem is getting that data to userland.
> 
> Matt
> 
> On Fri, Sep 28, 2001 at 01:36:07AM +0200, Peter Sandstrom wrote:
> > I know for sure that the Intel 82559 Fast Ethernet embedded controller
> > has a register where it's possible to read out if the link led is active
> > or not. It seems quite likely that this would be available on other
> > controllers as well.
> >
> > Is there any functionality in the current kernel that enables a userland
> > program to read this? I mostly turn my machines on and and let them do
> > their thing until the hardware fails :)
> >
> > /Peter
> >
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Robert Cantu
> > Sent: den 26 september 2001 23:41
> > To: linux-kernel@vger.kernel.org
> > Subject: Question: Etherenet Link Detection
> >
> >
> > Is there a method of detecting the link status of an ethernet NIC? If not,
> > is it feasible? And if it is, then would it be something in each driver,
> > or on a level above the driver, thereby available to all drivers? I figure
> > the list is the best place to ask this, although it might be a moot point.
> >
> > Example: Have a cable modem hooked into a computer's NIC. Cable service
> > goes out, link light on back of NIC goes out. A hypothetical program says
> > that the link is gone via some hook in /proc somewhere.
> >
> > Is this a worthwhile endeavor, if possible?
