Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261465AbSJDEOI>; Fri, 4 Oct 2002 00:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261466AbSJDEOI>; Fri, 4 Oct 2002 00:14:08 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:20202 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S261465AbSJDEOH>;
	Fri, 4 Oct 2002 00:14:07 -0400
Message-ID: <3D9D16D9.7040008@candelatech.com>
Date: Thu, 03 Oct 2002 21:19:37 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: tg3 and Netgear GA302T  x 2 locks machine
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got my two new Netgear GA302t nics today.  They seem to use the
tg3 driver....

I put them into the 64/66 slots on my Tyan dual amd motherboard..
Running kernel 2.4.20-pre8

eth2 is plugged into eth3 over cross-over cable.

The tg3 found and used them, mostly:

tg3.c:v1.1 (Aug 30, 2002)
eth2: Tigon3 [partno(AC91002A1) rev 0105 PHY(5701)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:40:f4:47:20:56
eth3: Tigon3 [partno(AC91002A1) rev 0105 PHY(5701)] (PCI:66MHz:32-bit) 10/100/1000BaseT Ethernet 00:40:f4:47:22:fd
tg3: eth3: Link is up at 1000 Mbps, full duplex.
tg3: eth3: Flow control is off for TX and off for RX.
...
tg3: eth3: Link is up at 1000 Mbps, full duplex.
tg3: eth3: Flow control is off for TX and off for RX.
tg3: eth3: Link is down.
tg3: eth3: Link is up at 1000 Mbps, full duplex.
tg3: eth3: Flow control is on for TX and on for RX.

I tried to start traffic with pktgen, and the machine hangs solid.
The last thing I see is:

[root@localhost root]# tg3: eth2: transmit timed out, resetting


Any ideas?  Is this NIC supposed to work with tg3?

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


