Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263412AbSJCLI0>; Thu, 3 Oct 2002 07:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263413AbSJCLI0>; Thu, 3 Oct 2002 07:08:26 -0400
Received: from web13101.mail.yahoo.com ([216.136.174.146]:37746 "HELO
	web13101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263412AbSJCLIZ>; Thu, 3 Oct 2002 07:08:25 -0400
Message-ID: <20021003111356.51794.qmail@web13101.mail.yahoo.com>
Date: Thu, 3 Oct 2002 12:13:56 +0100 (BST)
From: =?iso-8859-1?q?will=20fitzgerald?= <linux_learning@yahoo.co.uk>
Subject: Re: this code does not get called in dev.c so do we need it?
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
In-Reply-To: <20021002.171042.42890215.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks David, for your speedy reply.

you say that fast routing occurs in the device driver
level. 
how does it send a packet from router eth0 to router
eth1? 
is it on the bus? (is this like zero copy jumping from
one device directly to another?)

if fast routing saves time in not having to go to the
ip layer why is it not used alll the time? 

is it buggy? 

i know you say it hasn't been implemented in the
drivers and you actually have to hack the drivers to
do it,but why have hack the drivers at all?

thanks,
will.
 
--- "David S. Miller" <davem@redhat.com> wrote: > 
> Fast routing, although not implemented in any
> in-tree drivers,
> does get used by some people who have hacked up
> drivers to support
> this.
> 
> It allows IPv4 routing to occur right at the level
> of the device
> driver, it directly pushes an input packet to the
> output routine
> of the destination device all without leaving the
> driver.
> 
> This code is used.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
