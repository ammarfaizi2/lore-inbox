Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbRAXIcc>; Wed, 24 Jan 2001 03:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbRAXIcW>; Wed, 24 Jan 2001 03:32:22 -0500
Received: from quechua.inka.de ([212.227.14.2]:30514 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129776AbRAXIcN>;
	Wed, 24 Jan 2001 03:32:13 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Turning off ARP in linux-2.4.0
Message-Id: <E14LLLh-0004Il-00@sites.inka.de>
Date: Wed, 24 Jan 2001 09:32:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0101240857420.1024-100000@u.domain.uli> you wrote:
> 	The problem is complex and can't be solved with ifconfig -arp

why?

> 	The needs for clusters with shared addresses include:

> 1. block ARP replies for such addresses

-arp will do that

> 2. don't announce these addresses in the ARP probes (can be achieved
> using ip addr add IP brd + dev lo scope host)

i guess -arp will disable neighbour alive probes, too?

> 3. don't autoselect such addresses (for source addresses)

This is not done if you do not use a route through that ip

So where is the problem with -arp?

Well.. another solution would be to use the ipip system instead of the arp
redirection, right?

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
