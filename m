Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbTCMOXk>; Thu, 13 Mar 2003 09:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbTCMOXk>; Thu, 13 Mar 2003 09:23:40 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:60055 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S262335AbTCMOXh>; Thu, 13 Mar 2003 09:23:37 -0500
Date: Thu, 13 Mar 2003 09:34:09 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>,
       linux-ns83820@kvack.org
Subject: Re: problem w/ auto negotiate & ns83820 & netgear fsm726s switch
In-Reply-To: <20030312131531.F16642@redhat.com>
Message-ID: <Pine.LNX.4.53.0303121319370.21265@filesrv1.baby-dragons.com>
References: <Pine.LNX.4.53.0303120908470.21265@filesrv1.baby-dragons.com>
 <20030312131531.F16642@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Ben ,

On Wed, 12 Mar 2003, Benjamin LaHaise wrote:
> On Wed, Mar 12, 2003 at 09:11:02AM -0500, Mr. James W. Laferriere wrote:
> > 	The switch reports negotiating ...
> > 	Port Name        Link On/Off State      Rate/Duplex Flow Ctrl
> > 	26GB Not Defined Up   On     Forwarding (10   Full) (Disabled)
> >
> > 	ns83820 reports ,  eth0: link now 1000F mbps, full duplex and up.
> ...
> > 	I am quite aware that this could well be a difficulty in the
> > 	switch still .  So I am looking for pointers on where to look ?
> >  	I already tried the netgear suport site ;-} .  That is why I am
> > 	running the lastest code for the switch (1.0.4) .

> It's entirely possible the card has a different polarity for the phy bits
> as compared to the fibre card (Netgear) that the driver is already tested
> on.  Also, I've only managed to test on a cisco switch -- is there any
> other hardware you can test against (ie using the fibre cable for cross
> over) to narrow things down?  Enabling debug and dumping the status bits
> might hint as to what has to be changed.  Thankfully Trendnet seems to
> have programmed the subsystem id, so I'll be able to include the change
> automatically.
	I have access to another one of those cards at work it reports
	the same items in the dmesg ,  I just looked at the switch it is
	attached to & it shows fine(*) .  That switch manufacturer is an
	old Cabletron SSR4000 .  But the thruput there is even worse (**).
	THO the ssr4k network isn't idle .  And I am unable to aportion a
	time to make it idle .  The previous emails test network was idle .
	After I get back from a road trip next week I'll try a back to
	back test .  At least I hope I can when I get back .  Twyl ,  JimL

(*)
 # port show port-status gi.4.2
Flags: M - Mirroring enabled  S - SmartTRUNK port
                                                              Link  Admin
Port     Port Type              Duplex Speed      Negotiation State State
Flags
----     ---------              ------ -----      ----------- ----- ----- -----
gi.4.2   1 Gigabit Ethernet     Full   1 Gbits    Auto        Up    Up

(**)
 $ tftp hostname
tftp> mode binary
tftp> get getme
Received 675315712 bytes in 1169.8 seconds
tftp> quit

 $ bc
scale=10
675315712/1169.8
577291.5985638570	<< bytes/sec
last*8
4618332.7885108560	<< bits/sec
quit

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
