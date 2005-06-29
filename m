Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVF2CXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVF2CXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVF2CTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:19:25 -0400
Received: from [218.94.38.158] ([218.94.38.158]:6034 "EHLO xianan.com.cn")
	by vger.kernel.org with ESMTP id S262178AbVF2CRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 22:17:49 -0400
X-AuthUser: chengq@xianan.com.cn
Message-ID: <42C204B6.1040806@gmail.com>
Date: Wed, 29 Jun 2005 10:17:26 +0800
From: Benbenshi <benbenshi@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com, linux-kernel@vger.kernel.org,
       zhuangyy@xianan.com.cn
Subject: Re: route trouble with kernel
References: <dc849d8505062805573a73ec99@mail.gmail.com> <Pine.LNX.4.61.0506280942330.12415@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0506280942330.12415@chaos.analogic.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>
> It could be argued that if `iptables` retains its
> parameters after its only interface has been shut
> down it's a bug.
>
> The fact that no routes remain after a network
> interface has been shut down is both logical
> and in conformance with de facto Unix standards.
> This is partially as a result of route's manipulating
> flags (the UP flag would be wrong if the interface
> was down).
>
> I can't imagine that you have so many routes
> that it takes a significant amount of time to
> reset them using a script. If so, you probably
> have a configuration error where you are
> not properly using netmasks. Certainly, you
> shouldn't have to establish a host-route for
> every host on your network. You only need a
> network route (out the interface) and a
> default route that goes to some router to get
> out of your LAN. Even if you __are__ a router,
> the network setup remains about the same,
> only the user-mode software changes, which
> may dynamically alter the routing tables.
>
> On Tue, 28 Jun 2005, cigarette Chan wrote:
>
>> i add a route to the kernel
>> eg: # route add -net XXX.XXX.XXX.XXX/24 gw XXX.XXX.XXX.XXX dev eth1
>>
>> but after i restart eth1
>>
>> #ifdown eth1
>> #ifup eth1
>>
>> the route disappear,this make me a lot of troubles.i have several
>> interfaces,and i have to
>> re-add all of these routes...
>>
>> Is there any way or patches to make route work like iptables,after i
>> restart the interface,
>> rules are still there.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
> Notice : All mail here is now cached for review by Dictator Bush.
> 98.36% of all statistics are fiction.
>
my host is a vpn gateway, and i have several virtual interface to run
vpn. ie tap0, tap1....
I have to add routes to these TAPs to make vpn work. but after i restart
the tapX, i have
to re-add routes relate to this interface~

If i have to maintain several vpn and lots of TAPs , So i need a simple
way to maintian route tables.
sometimes it's quite diffcult to do this with shell scipts ,especially
when it's quite complex.


thanks~
