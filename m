Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbRCGGwY>; Wed, 7 Mar 2001 01:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130419AbRCGGwO>; Wed, 7 Mar 2001 01:52:14 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:43643 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130347AbRCGGv7>; Wed, 7 Mar 2001 01:51:59 -0500
Message-ID: <3AA5DA3D.4040708@blue-labs.org>
Date: Tue, 06 Mar 2001 22:50:37 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac4 i686; en-US; 0.8.1) Gecko/20010306
X-Accept-Language: en
MIME-Version: 1.0
To: Bryan Rittmeyer <bryan@ixiacom.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: conducting TCP sessions with non-local IPs
In-Reply-To: <3AA5B24E.D0ED2206@ixiacom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, if I configure the interface as suggested ("/sbin/ip addr add
> 10.0.0.0/24 dev eth0") can I really bind to any IP in 10.0.0.0/24 and
> conduct TCP sessions (as a client or server) using that IP--assuming all
> the ARP, etc, issues are worked out?


hostA: ip a a 10.0.0.0/24 brd + dev lo
hostB: ip r a 10.0.0.0/24 dev eth0

hostB: telnet 10.0.0.27
<connected as normal>

hostB: ssh 10.0.0.91
<connected as normal>

'tis a little magic I like.  nothing special needed anywhere.  does that 
help?

-d

