Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSJXP61>; Thu, 24 Oct 2002 11:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265518AbSJXP61>; Thu, 24 Oct 2002 11:58:27 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:37287 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265517AbSJXP60>;
	Thu, 24 Oct 2002 11:58:26 -0400
Message-ID: <3DB81A0E.7040000@colorfullife.com>
Date: Thu, 24 Oct 2002 18:04:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       "Richard B. Johnson" <root@chaos.analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: "Richard B. Johnson" <root@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>A 400 MHz ix86 CPU will checksum/copy at 685 megabytes per second.
>It will copy at 1,549 megabytes per second. Those are megaBYTES!
>  
>
Interesting. You copy data with 1,549 megabytes per second over a 800 
megabytes per second frond side bus, into (probably) PC100 memory, i.e. 
theoretical bandwidth of 800 megabytes/sec.
You probably operate within the L2 cache.

Roy, which type of memory and which chipset do you use?
The csum/copy speed is 210 MByte/sec: 13% cpu time needed for 225 
mbit/sec. That could be correct, if you use SDRAM and everything is 
cache-cold (source dma from disk, dest previously used as a network 
buffer, dma from nic)

--
    Manfred


