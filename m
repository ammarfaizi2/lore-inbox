Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275421AbRIZSRb>; Wed, 26 Sep 2001 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275425AbRIZSRW>; Wed, 26 Sep 2001 14:17:22 -0400
Received: from smtp6.us.dell.com ([143.166.83.101]:24591 "EHLO
	smtp6.us.dell.com") by vger.kernel.org with ESMTP
	id <S275421AbRIZSRJ>; Wed, 26 Sep 2001 14:17:09 -0400
Date: Wed, 26 Sep 2001 13:17:29 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)
In-Reply-To: <20010926164935.J27945@athlon.random>
Message-ID: <Pine.LNX.4.33.0109261310340.23259-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've tried the 2.4.10 with vmtweaks2 on out machine with 8GB RAM. It was 
looking good for a while, until it just stopped. Here is what was 
happening on the machine.

I was ftping files into the box at a rate of about 8MB/sec. This continued 
until all the RAM was in the  cache column. This was earlier in the 
included vmstat output. The I started a dd if=/dev/sde of=/dev/null in a 
new window.

All was looking good until it just stopped. I captured the vmstat below. 
vmstat continued running for about 1 minute, then it died too. What other 
info can I provide?

 2  0  0   4148   3612  36088 7946652   0   0 15488    64 10216 23346   0  
11  88
 2  0  1   4148   6424  36100 7944288   0   0 11526    40 7107 15848   0  
18  82
 1  1  1   4132   5452  36112 7945444   0   0 11642  6208 7531 16983   0  
17  83
 2  1  1   4132   4972  36128 7946100   0   0 14272 11904 10651 24330   0  
13  87
 3  0  0   4132   4480  36144 7946588   0   0 13120  6760 11007 25144   0  
12  88
 0  1  0   4132   5312  36160 7944964   0   0 15616     0 9935 22793   0  
10  89
 0  3  1   4132   2924  36168 7947052   0   0  6727 11010 5049 11226   0  
26  74
 0  2  2   4132   2668  36168 7946396   0   0  1666  8598 2230  4598   0  
11  89
 0  2  2   4132   3776  36168 7946396   0   0     0     0  159     5   0   
0 100
 0  2  2   4132   3768  36168 7946396   0   0     0     0  121     5   0   
0 100
 0  2  2   4132   3760  36168 7946396   0   0     0     0  126     4   0   
0 100
 0  2  2   4132   3756  36168 7946396   0   0     0     0  139     4   0   
0 100
 0  2  2   4132   3756  36168 7946396   0   0     0     0  148     5   0   
0 100


