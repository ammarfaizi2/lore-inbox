Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSHYQz4>; Sun, 25 Aug 2002 12:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSHYQz4>; Sun, 25 Aug 2002 12:55:56 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:31715 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317415AbSHYQzz>;
	Sun, 25 Aug 2002 12:55:55 -0400
Message-ID: <3D690D10.5040601@candelatech.com>
Date: Sun, 25 Aug 2002 10:00:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: packet re-ordering on SMP machines.
References: <3D6884BC.5090004@candelatech.com> <1030286473.16651.7.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sun, 2002-08-25 at 08:18, Ben Greear wrote:
> 
>>By re-ordered, I mean that a method called from process_backlog in dev.c
>>is being handed packets in a different order than they are being poked into
>>the driver with hard_start_xmit on the other interface.  If each CPU can be running the
>>process_backlog, then I can see how this could be happening.
>>
>>
>>1)  Is this expected behaviour?
> 
> Yes
> 
> 
>>2)  Is there any standard (ie configurable) way to enforce strict ordering on an
>>     SMP system?
> 
> No
> 
> 
>>3)  If answer to 2 is no, would you all be interested in a patch that
>>     did allow strict ordering (if indeed I can figure out how to write one)?
> 
> 
> You should never need it. Ethernet, hubs, switches, routers, internet
> backbones etc will all cause packet re-ordering. You should also expect
> the percentage of re-ordered frames on the net to rise and rise. 

I would like to detect the number of pkts that such backbone hardware does
re-order, so if my end machine is also re-ordering, I cannot get valid
numbers.

Thanks,
Ben

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


