Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269145AbRHBUxZ>; Thu, 2 Aug 2001 16:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269146AbRHBUxQ>; Thu, 2 Aug 2001 16:53:16 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:3813 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S269144AbRHBUxL>; Thu, 2 Aug 2001 16:53:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Carlos O'Donell Jr." <carlos@baldric.uwo.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: What does "Neighbour table overflow" message indicate?
Date: Mon, 30 Jul 2001 19:28:36 -0400
X-Mailer: KMail [version 1.2]
Cc: swsnyder@home.com
In-Reply-To: <01072820231401.01125@mercury.snydernet.lan> <01072820534802.01125@mercury.snydernet.lan> <20010730083829.A7336@megatonmonkey.net>
In-Reply-To: <20010730083829.A7336@megatonmonkey.net>
MIME-Version: 1.0
Message-Id: <01073019283600.00672@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 July 2001 08:38, Carlos O'Donell Jr. wrote:
> > network module. In this case it only ensures, that the printk message is
> > not printed too often. The actual condition why the message is printed is
> > above this if.
> >
> > Greetings
> > Bernd
> > -
>
> Snyder,
>
> Just by looking at your email, @home, I can guess that your
> cable modem is connected to an HFC Cable network segment.

Random datapoint: it does this on Road Runner cable modems in Austin, too 
(2.2.17 or so did, anyway.  Haven't had a monitor physically hooked up to my 
old 486 gateway since I moved it to 2.4).  Basically any cable modem that 
acts like a hub instead of a router (letting all packets through instead of 
just the one for the mac address it's connected to).

I made it go away somehow (~6 months back).  Possibly deselecting all the ARP 
stuff when I recompiled, I honestly don't remember at this point.  2.4 never 
did it (that I saw), but I compiled that sucker myself and don't log into my 
gateway much (it's a dumb ip masquerader running no daemons) so...

> In general these segments are extremely large and due to the
> nature of the users, can cause large amounts of arp broadcast
> traffic during peak times.

Forget peak times.  It did this 24/7 for me.

Bloated the logs something fierce.  I vaguely remember looking in the source 
and finding the message and going "so why doesn't it just delete something 
out of the neighbor table then?"  Never did figure that one out.  (It 
happened when the machine wasn't actually in USE, just connected to the net 
but otherwise idle.  No connections masquerading through it, nothing...)

Rob

