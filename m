Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTBBH2d>; Sun, 2 Feb 2003 02:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTBBH2d>; Sun, 2 Feb 2003 02:28:33 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:44432 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265135AbTBBH2b>;
	Sun, 2 Feb 2003 02:28:31 -0500
Message-ID: <3E3CCADA.6080308@candelatech.com>
Date: Sat, 01 Feb 2003 23:38:02 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: problems achieving decent throughput with latency.
Content-Type: multipart/mixed;
 boundary="------------070604080407070409070209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604080407070409070209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I am testing my latency-insertion tool, and I notice that tcp will not use
all of the available bandwidth if there is any significant amount of latency
on the wire.

For example, with 25ms latency in both directions, I see about 8Mbps
bi-directional throughput.

If I lower that to 15ms, I see 12Mbps bi-directional throughput.

I see 27Mbps at 5ms.

Here is the /proc/net/tcp output at 5ms latency.

machine demo2
   13: 050302AC:80EB 070302AC:80EB 01 0005900C:0002012E 01:00000016 00000000     0        0 578943 3 c6628a80 22 4 1 45 -1

machine demo1
   11: 070302AC:80EB 050302AC:80EB 01 00010DDB:00000000 01:00000014 00000000     0        0 513094 3 c62c5080 21 4 1 45 -1


Any ideas why it is so slow at the higher latencies?  Any other info
I can gather to help determine the cause?

(UDP does not experience this slowdown, so I believe my latency
insertion tool is working as designed, but it's always possible it is
to blame...)


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


--------------070604080407070409070209
Content-Type: message/rfc822;
 name="problems achieving decent throughput with latency."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="problems achieving decent throughput with latency."

Message-ID: <3E3C466D.7030602@candelatech.com>
Date: Sat, 01 Feb 2003 14:13:01 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: problems achieving decent throughput with latency.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

<div class="moz-text-flowed" style="font-family: -moz-fixed">I am testing my latency-insertion tool, and I notice that tcp will not use
all of the available bandwidth if there is any significant amount of latency
on the wire.

For example, with 25ms latency in both directions, I see about 8Mbps
bi-directional throughput.

If I lower that to 15ms, I see 12Mbps bi-directional throughput.

I see 27Mbps at 5ms.

Here is the /proc/net/tcp output at 5ms latency.

machine demo2
   13: 050302AC:80EB 070302AC:80EB 01 0005900C:0002012E 01:00000016 00000000     0        0 578943 3 c6628a80 22 4 1 45 -1

machine demo1
   11: 070302AC:80EB 050302AC:80EB 01 00010DDB:00000000 01:00000014 00000000     0        0 513094 3 c62c5080 21 4 1 45 -1


Any ideas why it is so slow at the higher latencies?  Any other info
I can gather to help determine the cause?

(UDP does not experience this slowdown, so I believe my latency
insertion tool is working as designed, but it's always possible it is
to blame...)


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


</div>
--------------070604080407070409070209--

