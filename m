Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262688AbREOI7l>; Tue, 15 May 2001 04:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbREOI7b>; Tue, 15 May 2001 04:59:31 -0400
Received: from CPE-61-9-184-110.vic.bigpond.net.au ([61.9.184.110]:34837 "EHLO
	surfers.oz.agile.tv") by vger.kernel.org with ESMTP
	id <S262688AbREOI7U>; Tue, 15 May 2001 04:59:20 -0400
Message-ID: <3B00F0FD.2060905@oz.agile.tv>
Date: Tue, 15 May 2001 19:03:57 +1000
From: Dave Cecil <dcecil@oz.agile.tv>
Organization: AgileTV
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Tracing a network device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I'm working on a network device that will forward some packets before 
they get to netif_rx and thus net_rx_action.  Thus, the forwarded 
packets handled by my device/protocol would not be traced by the 
existing trace utility (AF_PACKET etc.), correct?  Am I correct in 
assuming that there is no existing way to trace such fast-forwarded packets?

Mmy proposed solution to the problem is to implement a socket type for 
my (new) protocol family that will allow such packets to be traced.  
Simply open a socket eg socket(AF_MINE, SOCK_RAW, MYPROTO_TRACE) and you 
get a copy of the packets from the driver.  Is this an acceptable 
solution or are people cringing at the thought?

I came across the ethertap driver and it seems to do something along the 
lines of what I want to do, but I need to look at it more closely.

Comments?

Thanks,
Dave

