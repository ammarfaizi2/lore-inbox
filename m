Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130132AbRBML15>; Tue, 13 Feb 2001 06:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbRBML1v>; Tue, 13 Feb 2001 06:27:51 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:52160 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129445AbRBML1c>; Tue, 13 Feb 2001 06:27:32 -0500
Message-ID: <3A891B97.4F9805A6@uow.edu.au>
Date: Tue, 13 Feb 2001 22:33:43 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: al goldstein <gold@sense-gold-134.oz.net>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 swaps hardware addresses for ethernet cards
In-Reply-To: <Pine.LNX.4.21.0102122250180.848-100000@sense-gold-134.oz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

al goldstein wrote:
> 
> I have 2 ether cards 59x (eth0) and 509 (eth1). I have been adding 509
> at boot in lilo.conf. Using this same config in 2.4.1 results in
> the hardware addresses for the cards to be swapped. If I remove 509 from
> Lilo I get the same result. Suggestions would be appreciated

If both drivers are statically linked into the kernel then
I guess this is entirely dependent upon the linkage order of
net/core/dev.o and drivers/net/3c59x.o.

If you make the drivers modular then you can force the order
within your boot scripts.

If you make just one driver modular then that one will be
"eth1".

You can grab Andi's "nameif" app which allows you to rename
interfaces based on their MAC address, which will certainly
put and end to the issue.  I'm not sure whether this
app is in net-tools yet.

Finally, you can wait until the Linux hotplug architecture
is fully implemented, after which the naming order will
be nicely randomised each time you boot :)

It's fun, isn't it?

-
