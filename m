Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbSJZHgf>; Sat, 26 Oct 2002 03:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJZHgf>; Sat, 26 Oct 2002 03:36:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16394 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S261911AbSJZHge>;
	Sat, 26 Oct 2002 03:36:34 -0400
Date: Sat, 26 Oct 2002 09:42:35 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Adrian Pop <adrpo@ida.liu.se>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: The pain with the Net Drivers (ne*, xirc2ps_c, etc)
Message-ID: <20021026074235.GA29184@alpha.home.local>
References: <20021026044500.GA11483@www.kroptech.com> <Pine.GSO.4.44.0210260712300.11632-100000@mir20.ida.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0210260712300.11632-100000@mir20.ida.liu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sat, Oct 26, 2002 at 07:58:36AM +0200, Adrian Pop wrote:
>  NETDEV WATCHDOG: eth0: transmit timed out
>  eth0: transmit timed out
> And after this the card resets, and it
> takes quite a while for that.
> 
> My workaround for NE2000 cards: in 8390.h replaced
>   #define TX_TIMEOUT (20*HZ/100)
>   with
>   #define TX_TIMEOUT (100*HZ/100)

you understand that this means that your card often needds more than 0.2s to
send a frame ? Are all your cards connected to a defective hub, or a network
with lots of collisions ? Is the yellow led on your hub constantly lit ?

I have several ISA cards here (3c509, hp, ...) on a 386sx and a 486DX2-66 and
I have used NE2K for years on these machines under 2.2 and 2.4 kernels
without even one problem. The 486 is a firewall which generates lots of
collisions on the hub when uploading files to the local web server, but I
never had the problem you mention on these machines.

In fact, the only PC on which I see it is my laptop. When I send lots of
traffic to a 3c575 (cardbus), I get lots of these. This is not because of
the card (it works well in other notebooks, and other cards do the same),
but the notebook itself. When it's getting hot, I think it looses interrupts!

And please, give us an example of kernel version you use. >2.2 is not an
answer. How do you want people to read the code if they don't know *exactly*
which one certainly induces the problem ? We don't even know if it's a vanilla
kernel or a patched one.

Cheers,
Willy

