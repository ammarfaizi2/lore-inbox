Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319094AbSHFOjp>; Tue, 6 Aug 2002 10:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319096AbSHFOjo>; Tue, 6 Aug 2002 10:39:44 -0400
Received: from [213.69.213.4] ([213.69.213.4]:8093 "EHLO i-t-c-s.de")
	by vger.kernel.org with ESMTP id <S319094AbSHFOjo> convert rfc822-to-8bit;
	Tue, 6 Aug 2002 10:39:44 -0400
X-AuthUser: tmi@wikon.de
Content-Type: text/plain; charset=US-ASCII
From: Thomas Mierau <tmi@wikon.de>
Organization: WIKON Kommunikationstechnik GmbH
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: 2.4.19-ac4 IRQ messup?
Date: Tue, 6 Aug 2002 16:44:03 +0200
X-Mailer: KMail [version 1.4]
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de> <200208061139.35323.tmi@wikon.de> <20020806100101.GA20758@alpha.home.local>
In-Reply-To: <20020806100101.GA20758@alpha.home.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061643.56773.tmi@wikon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I switched cables, checked the switch etc....
nothing helps.
I installed an extra PCI card which came up as eth0, making the internal ones 
eth1 and eth2. No I started pinging with eth0, which was giving me strange 
effects again.
eth0 = 192.168.47.11
eth1 = 192.168.47.12
eth2 = 192.168.47.13
I took a tcpdump on the receiving box. It was kind of interesting.
There were arp packages askin who is 192.168.47.11 and answers coming back 
with two dofferent MAC-Id's One from the eth0 and the other one from the eth2 
which was actually configured on  IP .13
 After I shut down etho1 and 2 and ran the box with "noapic" it preforms 
perfect with the external card.
Either the NIC's are broken, or the driver  or whatever. I hate that !!


> On Tue, Aug 06, 2002 at 11:39:43AM +0200, Thomas Mierau wrote:
> > Thanks,
> > I looked it up its called watchdog (what else). It was set to 5000ms and
> > I changed it to 300ms. But the result is : no change!
>
> by "no change", you mean "still loss of 5s" ?
> If this is the case, are you sure the switch port you are connected to is
> in full duplex too ? does it detect receive errors or carrier lost ? I
> believe that cisco switches in "spanning tree portfast" mode block the port
> during 5s after a renegociation. It's easy to detect because the port's led
> becomes orange.
>
> perhaps you can switch the 2 NIC's cables to check if the problem follows
> the cable or the NIC.
>
> else I have no other clue ...
>
> Regards,
> Willy

