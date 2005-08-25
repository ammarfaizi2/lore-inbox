Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVHYEwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVHYEwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVHYEwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:52:05 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:23962 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S964793AbVHYEwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:52:04 -0400
Message-ID: <430D4E6D.1090200@candelatech.com>
Date: Wed, 24 Aug 2005 21:51:57 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050824172631.11829.qmail@web33309.mail.mud.yahoo.com>
In-Reply-To: <20050824172631.11829.qmail@web33309.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:

> I think the concensus is that 2.6 has made trade
> offs that lower raw throughput, which is what a
> networking device needs. So as a router or
> network appliance, 2.6 seems less suitable. A raw
> bridging test on a 2.0Ghz operton system:
> 
> FreeBSD 4.9: Drops no packets at 900K pps
> Linux 2.4.24: Starts dropping packets at 350K pps
> Linux 2.6.12: Starts dropping packets at 100K pps

I ran some quick tests using kernel 2.6.11, 1ms tick (HZ=1000), SMP kernel.
Hardware is P-IV 3.0Ghz + HT on a new SuperMicro motherboard with 64/133Mhz
PCI-X bus.  NIC is dual Intel pro/1000.  Kernel is close to stock 2.6.11.

I used brctl to create a bridge with the two GigE adapters in it and
used pktgen to stream traffic through it (250kpps in one direction, 1kpps in
the other.)

I see a reasonable amount of drops at 250kpps (60 byte packets):
about 60,000,000 packets received, 20,700 dropped.

Interestingly, the system is about 60% idle according to top,
and still dropping pkts, so it would seem that the system could
be better utilized!

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

