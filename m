Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262825AbSJJBEs>; Wed, 9 Oct 2002 21:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSJJBEr>; Wed, 9 Oct 2002 21:04:47 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:4055 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262825AbSJJBEp>;
	Wed, 9 Oct 2002 21:04:45 -0400
Message-ID: <3DA4D383.1010006@candelatech.com>
Date: Wed, 09 Oct 2002 18:10:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: tg3 (netgear 302t) performance numbers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After placing my Netgear 302t NICs into my SS50 P-IV (1.8Ghz)
machine, they seem to work fine.  (They had various problems in
my AMD machines, but that could all just be coincidence and other,
non-related, problems)

My test-bed has two of these NICs connected to each other via
a cross-over cable.  Both NICs are in the same machine...

Here are some performance numbers I see:

tcp/ip send + receive in user-space:
   112Mbps on each port (does not count any packet over-head,
     and my generator/receiver is not the fastest thing around)

pktgen (kernel pkt generator module):
   60-byte packets, sending 1kpps in one direction, and maximum possible
   in the other.  Was able to generate 122,000 packets-per-second.
   (A tulip 10/100 NIC can do 140kpps in this configuration)
   Average Latency: 22 micro-seconds.
   0 dropped packets over 10+ minute run.

   1514-byte packets, sending 1kpps in one direction, max possible in
   the other.  25.8kpps (310Mbps) in the fast direction.
   Average Latency:  17 miliseconds (127 micro-seconds for the 1kpps direction)
   2000 dropped pkts, 5.8 million sent during this test.


So, not too bad, probably the 32/33 PCI bus is most of the bottle-neck.
The good part is, no errors or other strangnesses were seen with the driver.

Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


