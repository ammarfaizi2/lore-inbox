Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTBDIco>; Tue, 4 Feb 2003 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTBDIco>; Tue, 4 Feb 2003 03:32:44 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:38058 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267153AbTBDIcn>;
	Tue, 4 Feb 2003 03:32:43 -0500
Message-ID: <3E3F7CDA.9020701@candelatech.com>
Date: Tue, 04 Feb 2003 00:42:02 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: john@grabjohn.com, cfriesen@nortelnetworks.com, ahu@ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: Re: problems achieving decent throughput with latency.
References: <3E3EAF04.9010308@candelatech.com>	<20030203.211933.27826107.davem@redhat.com>	<3E3F70AD.7060901@candelatech.com> <20030203.233948.53493107.davem@redhat.com>
In-Reply-To: <20030203.233948.53493107.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Mon, 03 Feb 2003 23:50:05 -0800
>    
>    Why would it use the maximum socket for a connection with low to
>    no acks, ie low to no throughput?
> 
> You open up the congestion window by ACK'ing a few windows
> worth of data, then you stop ACK'ing.

I think I understand, but on my system it seem to take 5-8 seconds for
the bandwidth to get up to ~20Mbps (with my larger buffer settings mentioned
earlier).  This is with 25ms latency. With the default settings I can run about
8Mbps, so it would appear to me that only 3x the current default buffer settings
should get a window size enough to go ~20Mbps at 25ms latency.

Am I correct that if I have 10k clients doing their worst tricks, and
3 * (80k, my default according to the kernel) == 240k, then I have at most
2.4MB denial of service?  Assuming 60k clients, that is only about 15MB
of DoS?  If true, that is a fairly small time DoS considering the RAM available
on today's machines.

You claim for a very large N that the denial of service can happen.  I
am just trying to understand the upper bound of N, and thus the upperbound
of the memory consumption assuming each connection is using it's maximum
buffer size.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


