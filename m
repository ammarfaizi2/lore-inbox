Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbSLLXBT>; Thu, 12 Dec 2002 18:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbSLLXBT>; Thu, 12 Dec 2002 18:01:19 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:34443 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267559AbSLLXBQ>;
	Thu, 12 Dec 2002 18:01:16 -0500
Message-ID: <3DF916EA.10504@candelatech.com>
Date: Thu, 12 Dec 2002 15:08:26 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Roger Luethi <rl@hellgate.ch>,
       netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pci-skeleton duplex check
References: <Pine.LNX.4.44.0212121539110.10674-100000@beohost.scyld.com>
In-Reply-To: <Pine.LNX.4.44.0212121539110.10674-100000@beohost.scyld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:

> I've been actively developing Linux drivers for over a decade, and run
> about two dozen mailing lists for specific drivers.  I write diagnostic
> routines for every released driver.  I thoroughly test and frequently
> update the driver set I maintain.  And since about 2000, my patches were
> ignored while the first notice I've have gotten to changes in my drivers
> is the bug reports.  And the response: "submit a patch to fix those
> newly introduced bugs".  I've even had patches ignore in favor of people
> that wrote "I don't have the NIC, but here is a change".
> 
> A good example is the tulip driver.  You repeatedly restructured my
> driver in the kernel, splitting into different files.  It was still 90+%
> my code, but the changes made it impossible to track the modification
> history.  The kernel driver was long-broken with 21143-SYM cards, but no
> one took the responsibility for fixing it.

For what it's worth, I have yet to find a tulip driver that works with
all of my 4-port NICs.  Becker's fails with the Phobos 4-port NIC,
a very recent kernel driver fails to negotiate correctly (sometimes)
with the DFE-570tx NIC.  Both of them failed a while back when I tried
to put 3 DFE-570tx's into a single machine.

On average, I've had better luck with the kernel driver than with
Becker's, and since it is quite a pain to compile and test it, I
have been ignoring it more and more.

Mr Becker:  Perhaps you could rename your tulip driver becker_tulip and have
it separately buildable and configurable in the kernel config options?  If
it was back into the kernel proper it would be much easier to experiment with.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


