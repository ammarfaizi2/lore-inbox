Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281775AbRKQQnE>; Sat, 17 Nov 2001 11:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281776AbRKQQmy>; Sat, 17 Nov 2001 11:42:54 -0500
Received: from quechua.inka.de ([212.227.14.2]:19768 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S281775AbRKQQms>;
	Sat, 17 Nov 2001 11:42:48 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
In-Reply-To: <20011117134127.A8041@se1.cogenit.fr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E1658YH-0008Jp-00@calista.inka.de>
Date: Sat, 17 Nov 2001 17:42:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011117134127.A8041@se1.cogenit.fr> you wrote:
>>       I have a dual Athlon w/ 512M RAM and three NICs (one gigabit
>> 3c985B running 802.1Q with 5 VLANs, two on-board 100Mbit 3c982). This box
>> has almost nothing other to do apart from routing and packet filtering.
>> Is there anything I can do to tell the VM system to use as much memory
>> for network packets as possible?

> In a sysctl fashion ? No.

You can increase the reserved free memory (not sure where to do this in
2.4.x). This is important, cause network memory requests are usually within
interrupt handlers and therefore no paging can occur. You can play a bit
with the memory settings in net/*_mem. Most important you can configure the
kernel for large window sizes and advanced routing.

> However you can increase the length of the Rx/Tx rings on the 100Mb/s side 
> and tune the pci latency timers (depends on the hardware fifo size). 

Increasing rx/rx rings is not a particular good idea cause it slows down
TCPs adaption to network congestion and router overload.

Greetings
Bernd
