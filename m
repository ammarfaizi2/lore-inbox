Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130444AbRCCKlS>; Sat, 3 Mar 2001 05:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130447AbRCCKlI>; Sat, 3 Mar 2001 05:41:08 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:26947 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130444AbRCCKkw>; Sat, 3 Mar 2001 05:40:52 -0500
Message-ID: <3AA0CA2E.70208@blue-labs.org>
Date: Sat, 03 Mar 2001 02:40:46 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac3 i686; en-US; 0.9) Gecko/20010302
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4 VM question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a particular reason why 2.4 insists on stuffing as much as 
possible into swap?

It's particularly frustrating to experience the slowdown and lag while 
the disk grinds.  I have 256M in this machine.  Right now I have 180+ 
megs free and I am 120 megs into swap.  Netscape and Mozilla are slow 
enough as it is without having to pull pages off the disk.  Running GIMP 
as well brings the system nearly to a crawl as I start opening up some 
large pictures.

Mind you however, I still have -plenty- of free memory in 
buffers/cache.  The filesystem is also reiserfs.

I would also like to point out that it's rather irritating to swapoff 
and basically everything flat out stalls until all the pages are back in 
memory.  It is also worthy of mention that it takes about 4 minutes to 
swapoff the first 64M file.  This is on a pIII 350.  The second 64M file 
took 5 minutes.

# uname -r
2.4.2-ac3

# free
            total       used       free     shared    buffers     cached
Mem:        253876     250360       3516          0      36448      86484
-/+ buffers/cache:     127428     126448
Swap:        65532      65496         36

# time swapoff /swapfile

real    5m21.080s
user    0m0.000s
sys     2m59.370s

Now that everything is forcibly paged back in, the system is once again 
responsive and quick.

Is there a particular VM quirk?  A bug?  As I see it there are two 
issues, a) the insistence of the kernel to page everything out, and b) 
the stall to page things back in, including the time frame.

-d

