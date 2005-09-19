Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVISHoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVISHoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVISHoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:44:04 -0400
Received: from [202.168.200.132] ([202.168.200.132]:14925 "EHLO
	Dynaexch.corp.dynacolor.com.tw") by vger.kernel.org with ESMTP
	id S932362AbVISHoB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:44:01 -0400
Reply-To: <responder@dynacolor.com.tw>
From: "Wei-Che, Hsu" <responder@dynacolor.com.tw>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Where do packets sent to 255.255.255.255 go?
Date: Mon, 19 Sep 2005 15:43:35 +0800
Organization: DynaColor
Message-ID: <001c01c5bced$db6d94b0$88fea8c0@acer3201>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1127108122.9696.90.camel@localhost>
X-OriginalArrivalTime: 19 Sep 2005 07:41:47.0673 (UTC) FILETIME=[9702A090:01C5BCED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sir,

I have the same question recently & found a solution on the following url.
http://www.uwsg.iu.edu/hypermail/linux/kernel/0508.3/0397.html
& trace to this mailing list.

I had added a 255.255.255.255 route to a specific interface(eth0).
But seems no luck.
The broadcast package still go out via default gateway(eth1).
(detail "route -n" will be attached on the tail of this mail.)

Does anyone have any idea about it?
Should I enable something on my kernel?

ThanX in advance.

=== Original Post ===
>>> 3. Can I set the default broadcast interface explicitly?
>>> For example, say I wanted broadcasts to go out over
>>> eth1 by default, instead of over eth0. What if I
>>> wanted them to get sent through tap0?
>>
>> Again, I'm not sure, but I think that you can force the
>> interface by adding a special route for IP 255.255.255.255
>> and with mask 255.255.255.255 to the interface you want.

> Yes, this works! It's so simple --- I can't believe I
> didn't try it before. I did mess around with iptables,
> trying to add some weird PREROUTEing DNAT that would
> redirect the packets, but I didn't know what I was doing.
=== Original Post ===

=== Detail route output ===
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
255.255.255.255 0.0.0.0         255.255.255.255 UH    0      0        0 eth0
192.168.7.0     192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.6.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
192.168.5.0     192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.4.0     192.168.6.254   255.255.255.0   UG    0      0        0 eth0
172.30.1.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
192.168.3.0     192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.2.0     192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.12.0    192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.11.0    192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.10.0    192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.9.0     192.168.6.254   255.255.255.0   UG    0      0        0 eth0
192.168.254.0   0.0.0.0         255.255.255.0   U     0      0        0 eth2
192.168.8.0     192.168.6.254   255.255.255.0   UG    0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         172.30.1.254    0.0.0.0         UG    0      0        0 eth1
=== Detail route output ===

Good day.
 
Sincerely yours,
      responder


