Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVITViA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVITViA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVITViA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:38:00 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:31724 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750772AbVITVh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:37:59 -0400
Message-ID: <43308131.5040104@nortel.com>
Date: Tue, 20 Sep 2005 15:37:53 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: help interpreting oom-killer output
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2005 21:37:54.0696 (UTC) FILETIME=[8F4C9880:01C5BE2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running a modified 2.6.10 on an x86 uniprocessor system.  I keep 
having processes killed by the oom killer at the same place while 
running LTP.  The system has gigs of memory, so I find this kind of odd.

Could someone help me interpret the oom-killer output?  The first log 
looks like this.


oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:     2473820kB (2468096kB HighMem)
Active:2831 inactive:393 dirty:2 writeback:0 unstable:0 free:618551 
slab:215125 mapped:1760 pagetables:107
DMA free:68kB min:68kB low:84kB high:100kB active:0kB inactive:0kB 
present:16384kB pages_scanned:0 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:7832kB min:3756kB low:4692kB high:5632kB active:0kB 
inactive:0kB present:901120kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:2468096kB min:512kB low:640kB high:768kB active:11324kB 
inactive:1572kB present:3276800kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 68kB
Normal: 10*4kB 8*8kB 13*16kB 1*32kB 5*64kB 1*128kB 7*256kB 3*512kB 
2*1024kB 2*2048kB 0*4096kB = 10264kB
HighMem: 376*4kB 364*8kB 292*16kB 136*32kB 96*64kB 61*128kB 30*256kB 
20*512kB 18*1024kB 16*2048kB 579*4096kB = 2468096kB
Out of Memory: Killed process 17664 (bash).



Thanks,

Chris
