Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSJGQfO>; Mon, 7 Oct 2002 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSJGQfN>; Mon, 7 Oct 2002 12:35:13 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:8368 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S261297AbSJGQfM>;
	Mon, 7 Oct 2002 12:35:12 -0400
Message-ID: <3DA1B8ED.2000309@candelatech.com>
Date: Mon, 07 Oct 2002 09:40:13 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Andre Hedrick <andre@pyxtechnologies.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
References: <Pine.GSO.4.30.0210070749430.1861-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Sun, 6 Oct 2002, Ben Greear wrote:
> 
> 
>>I can reproduce my crash using mtu sized pkts running only 50Mbps
>>send + receive on 2 nics.  It took over-night to do it though.  Running
>>as hard as I can with MTU packets will crash it as well, and much
>>quicker.
>>
> 
> 
> So is there a correlation with packet count then?

No, running at slower speeds (50Mbps), the packet count was well over
4 billion (ie it successfully wrapped 32-bits).  At higher speeds, it
crashes before the 32-bit wrap, generally.  It also does not coorelate
to bytes-sent/received, or anything else that I could think of to look at.

> 
> 
> 
>>Interestingly enough, the tg3 NIC (netgear 302t), registered 57 deg C between
>>the fins of it's heat sink in the 32-bit slots.  Makes me wonder if my PCI bus
>>is running too hot :P
> 
> 
> Does the problem happen with the tg3?

As Dave mentioned, tg3 locks up almost immediately (like within 30 seconds),
and in the meantime, it's spitting out errors that are 'impossible'.  The
messages I sent a day or two ago.

I may have cooked my cards, or something like that, because one of
the tg3's do not work in my other machine now.  Still trouble-shooting that one.

Ben


> 
> cheers,
> jamal
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


