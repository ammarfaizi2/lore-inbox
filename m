Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289481AbSA2KrG>; Tue, 29 Jan 2002 05:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289492AbSA2Kq5>; Tue, 29 Jan 2002 05:46:57 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:9486 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S289481AbSA2Kqv>;
	Tue, 29 Jan 2002 05:46:51 -0500
Message-ID: <3C567D93.7030602@namesys.com>
Date: Tue, 29 Jan 2002 13:46:43 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>
>On Tue, 29 Jan 2002, Hans Reiser wrote:
>
>>This fails to recover an object (e.g. dcache entry) which is used once, 
>>and then spends a year in cache on the same page as an object which is 
>>hot all the time.  This means that the hot set of objects becomes 
>>diffused over an order of magnitude more pages than if garbage 
>>collection squeezes them all together.  That makes for very poor caching.
>>
>
>Any GC that is going to move active dentries around is out of question.
>It would need a locking of such strength that you would be the first
>to cry bloody murder - about 5 seconds after you look at the scalability
>benchmarks.
>
>

I don't mean to suggest that the dentry cache locking is an easy problem 
to solve, but the problem discussed is a real one, and it is sufficient 
to illustrate that the unified cache is fundamentally flawed as an 
algorithm compared to using subcache plugins.

Hans

