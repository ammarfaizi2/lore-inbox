Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbRADTHy>; Thu, 4 Jan 2001 14:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbRADTHe>; Thu, 4 Jan 2001 14:07:34 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:36361 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130024AbRADTHZ>; Thu, 4 Jan 2001 14:07:25 -0500
Date: Thu, 4 Jan 2001 11:07:15 -0800
To: Christian Loth <chris@gidayu.max.uni-duisburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
Message-ID: <20010104110715.A32323@ferret.phonewave.net>
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de>; from chris@gidayu.max.uni-duisburg.de on Thu, Jan 04, 2001 at 12:31:39PM +0100
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 12:31:39PM +0100, Christian Loth wrote:
> Hello all,
> 
>   I recently installed a system with the 3c905C
> NIC on RedHat 6.2. In our network, IP adresses
> are granted via DHCP, although every host has
> a fixed IP instead of a dynamic IP pool. The IP
> is statically coupled with the MAC adresses of
> our network.
> 
>   The freshly installed RedHat 6.2 worked nice
> and flawlessly, and the IP was handed out correctly
> to the new machine. However after upgrading
> to the 2.2.16 RedHat Kernel RPMS, the DHCP negotiation
> no longer worked! Okay, I said, maybe it is a RedHat
> thing (they included modules both for the 90x and for the 59x
> cards, and I tried both), so I downloaded 2.2.18 proper.
> I compiled in the support for the card, but also: same
> result. The old 2.2.14 RedHat kernel worked, but the
> newer kernels did not.
> 
>   Unfortunately the machine had to go on the net, so I had
> to switch the NIC for a DEC Tulip one, which worked flawlessly
> under 2.2.18 again. Therfore I unfortunately can't volunteer
> for testing :(, all I can say is that something happened
> between 2.2.14 and 2.2.16/2.2.18 which made DHCP inoperable
> for the 3c905C.


I think I have a similar problem with a 3c905B. I'm using Debian/GNU
Linux (Potato) with the 2.2.18-pre kernel to do the install. DHCP
configuration from the installer does not work, but DHCP configuration
from the installed system (configuring the network manually, then
changing to DHCP afterward) works.

What I noticed, was during the install my DHCP server wasn't seeing the
broatcasts from the client.

Also, I notice that with the kernel driver, the NIC switches to 10baseT
half-duplex when the interface is brought up, yet the MII autonegotiates
with the other end to 100baseTX half-duplex. I haven't tried 3com's
driver yet. Oh.. and 3com's windows driver was doing the same thing (as
of about ten months ago) when I had the NIC in a windows machine last.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
