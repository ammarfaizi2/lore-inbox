Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSFKOMP>; Tue, 11 Jun 2002 10:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSFKOMO>; Tue, 11 Jun 2002 10:12:14 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:63675 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S317056AbSFKOMN>; Tue, 11 Jun 2002 10:12:13 -0400
Message-ID: <3D06051C.3030305@antefacto.com>
Date: Tue, 11 Jun 2002 15:11:40 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: remedy@mirotel.net
CC: linux-kernel@vger.kernel.org
Subject: net sysctls questions
In-Reply-To: <02061117004401.01217@fortress.mirotel.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The net.ipv4.icmp_default_ttl patch
reminds me, about wierd stuff I've
seen in the net sysctls:

/proc/sys/net/unix/max_dgram_qlen is only
readable by root. Why?

Documentation/networking/ip-sysctl.txt
refers to tcp_keepalive_interval when it should
refer to tcp_keepalive_intvl

/proc/sys/net/ipv4/conf/../{arp_filter,tag}
are not documented.

/proc/sys/net/ipv4/icmp_rate_limit is jiffies.
Shouldn't this be HZ, i.e. jiffies shouldn't
be exported to userspace as it's non portable?

Any comments before I do a patch?

Padraig.

