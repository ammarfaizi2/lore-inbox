Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262849AbTCKHaa>; Tue, 11 Mar 2003 02:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262852AbTCKHaa>; Tue, 11 Mar 2003 02:30:30 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6890 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262849AbTCKHa3>; Tue, 11 Mar 2003 02:30:29 -0500
Date: Mon, 10 Mar 2003 23:41:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dcache hash distrubition patches
Message-ID: <26350000.1047368465@[10.10.2.4]>
In-Reply-To: <20030310175221.GA20060@averell>
References: <10280000.1047318333@[10.10.2.4]> <20030310175221.GA20060@averell>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Conclusion: the hash distribution (for this simple test) looks fine
>> to me.
> 
> Yes, because of the overkill size of the hash table. With a 100K + entry
> table you can make near every hash function look good ;)
> 
> Try to reduce it to a smaller number of buckets and see what happens.

OK, after I've stopped being an idiot, and misreading the code, I have 
some numbers. They still look pretty good to me. I shrunk us from
1,048,576 buckets to 65536, and loaded 1,150,000 entries in there.



      5 3
      9 4
     44 5
    113 6
    243 7
    519 8
   1059 9
   1613 10
   2458 11
   3506 12
   4515 13
   5349 14
   6071 15
   6328 16
   6369 17
   5862 18
   5228 19
   4305 20
   3546 21
   2613 22
   1981 23
   1382 24
    928 25
    602 26
    368 27
    230 28
    115 29
     75 30
     45 31
     16 32
     14 33
      3 34
      4 35
      2 36

It's not perfect, but not bad either. Some mathematician can go calculate
just how imperfect it is over random distribution, but it looks OK to me ;-)

M

