Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317480AbSFIANn>; Sat, 8 Jun 2002 20:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSFIANm>; Sat, 8 Jun 2002 20:13:42 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:22992 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317480AbSFIANm>;
	Sat, 8 Jun 2002 20:13:42 -0400
Message-ID: <3D029DAF.5040006@candelatech.com>
Date: Sat, 08 Jun 2002 17:13:35 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mark@mark.mielke.cc, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <20020606.202108.52904668.davem@redhat.com>	<3D01307C.4090503@candelatech.com>	<20020608170511.B26821@mark.mielke.cc> <20020608.160407.101346167.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

> You guys we have SNMP statistics for these events, there
> is no reason to have them per-socket.  You cannot convince
> me that when you are diagnosing a problem the SNMP stats
> are not enough to show you if the packets are being dropped.


So, I will not attempt to convince you that you need per-socket
counters.  I do know for absolute certain that I would like to
have them (I write a traffic-generation & testing program).

For instance, when I run 50Mbps bi-directional on a P-4 1.6Ghz machine,
using a single port of a DFE-570tx NIC, then I drop around .2% of
the packets, in bursts.  I have kernel buffers very large (2MB),
and the CPU is not maxed out.

With the current system, it is difficult for me to know exactly what
I need to change to get better performance and/or if better performance
is even possible.


> If not, this means we need to add more SNMP events, that is
> all it means.


If you're talking per-socket SNMP counters, then that could work.
General protocol-wide counters would not help much, at least
in my case.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


