Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130416AbRBBWgv>; Fri, 2 Feb 2001 17:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbRBBWgl>; Fri, 2 Feb 2001 17:36:41 -0500
Received: from mail002.syd.optusnet.com.au ([203.2.75.245]:35283 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S130416AbRBBWgY>; Fri, 2 Feb 2001 17:36:24 -0500
Date: Sat, 3 Feb 2001 08:35:39 +1000
Message-Id: <200102022235.f12MZdi21961@borogoves.yi.org>
From: Derek Benson <derek@borogoves.yi.org>
Subject: Ethernet dies after one hour
Reply-to: derek@borogoves.yi.org
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box with: 
  a couple of analog ISA modem cards in it which have 8 modems a piece 
  the modems use devices ttyS4-19 
  a realtek 8039 pci ethernet card (100 mbit)
  486 dx

Its running redhat 6.2 and a 2.2.17 kernel with ppp ip-forwarding
ip aliasing and ip masq support. 
The kernel is patched with a rastel driver (serial.c and dummy.h from
memory)  Although this is 2.2 kernel it has support for proxy arp after
the patch. 

I am running portslave terminal server.  And I use proxy arp on dialin
connections to add an entry in the arp table (I don't like this but ppp
won't work otherwise with this particular kernel after the patch)
I am using iputils-20001010-1.6x.i386.rpm ppp-2.3.11-4.i386.rpm

When I ping I get a warning saying that time goes back and taking precautions.
I have tried changing the time on the hwclock and clock but doesn't seem to 
make any difference.  These warnings occur even when I ping the loopback 
interface.

After the box is up for an hour (in which times it functions perfectly)
it ceases to be on the network.  Its almost as if the cable has been 
unplugged.  
If I go down into single user mode and come back up it reappears
on the network for about 5 seconds and then disappears again.  
After a 'shutdown -r now' it comes up and is on the network for another hour.
The log files only contain messages like: radius server not responding etc
which you would expect if the ethernet was down.  
ifconfig shows nothing unusual, that is it is still up.
I can ping the loopback and the ip address from the box itself to itself after
it's ethernet has ceased to function.
The ethernet hub shows a slow blink for the box (corresponding to the volume
of traffic) after it has ceased to function.

Is this a kernel problem? 
A portslave problem?
An iputils-20001010-1.6x problem?
Buggey ethernet card?

thanks 
derek



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
