Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWGGXIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWGGXIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWGGXIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:08:41 -0400
Received: from tornado.reub.net ([202.89.145.182]:56530 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932306AbWGGXIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:08:40 -0400
Message-ID: <44AEE978.8090703@reub.net>
Date: Sat, 08 Jul 2006 11:08:40 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060707)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<44AE268F.7080409@reub.net>	<20060707023518.f621bcf2.akpm@osdl.org>	<44AECEDD.201@reub.net> <20060707143854.4a8fd106.akpm@osdl.org>
In-Reply-To: <20060707143854.4a8fd106.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/07/2006 9:38 a.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>
>>> The core slab data structures were wrecked.  For kmalloc(), no less. 
>>> Something secretly destroyed your kernel, and it could be anything.  Nice.
>> Having now turned on slab debugging, is it possibly related to this message 
>> which appeared in my log when I booting up earlier?
>>
>> Jul  8 02:49:39 tornado kernel: EXT3-fs: mounted filesystem with ordered data mode.
>> Jul  8 02:49:39 tornado kernel: Adding 497972k swap on /dev/sdc9.  Priority:-1 
>> extents:1 across:497972k
>> Jul  8 02:49:40 tornado kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
>> Jul  8 02:49:40 tornado kernel: Netfilter messages via NETLINK v0.30.
>> Jul  8 02:49:40 tornado kernel: ip_conntrack version 2.4 (4060 buckets, 32480 
>> max) - 288 bytes per conntrack
>> Jul  8 02:49:40 tornado kernel: Slab corruption: start=ffff81003efd7000, len=4096
>> Jul  8 02:49:40 tornado kernel: 170: ff ff ff ff 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b
>> Jul  8 02:49:40 tornado kernel: e1000: eth0: e1000_watchdog: NIC Link is Up 1000 
>> Mbps Full Duplex
>> Jul  8 02:49:40 tornado kernel: GRE over IPv4 tunneling driver
>>
> 
> Yikes!  Until we fix that there's no point in looking at anything else.
> 
> CONFIG_DEBUG_PAGEALLOC would nail this bug in a flash, but x86_64 doesn't
> implement the damn thing :(
> 
> So if this is repeatable it would be of some value if you can work out what
> causes it - start by disabling netfilter.

It hasn't come back after a quick reboot, but I'll be more vigilant than usual 
for it.  With that warning above and the nasty crash before that which maybe 
related, I'm thinking that it's not just a one-off thing.

reuben
