Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSFOKla>; Sat, 15 Jun 2002 06:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSFOKl3>; Sat, 15 Jun 2002 06:41:29 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:5099 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315257AbSFOKl3>; Sat, 15 Jun 2002 06:41:29 -0400
Date: Sat, 15 Jun 2002 06:42:39 -0400
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020615104239.GA30698@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > test the crap out of a kernel :).

>> Linux Test Project's runalltests.sh has occasionally triggered a bug.

> Is this still happening?  What was the bug?

That's just a general suggestion with regard to kernel testing.
Recent 2.5.x hasn't had a problem completing LTP runalltests.sh.  
I've used LTP to narrow down a couple early 2.4.x reiserfs bugs to
a specific test case.  LTP has occasionally triggered oops and
livelocks too.  It's a useful regression test. 

>> 2.5 took a drop in dbench throughput recently.
>>
>> dbench ext2 128 processes       Average         High            Low(MB/sec)

> Is this still with 384 megs of memory?

Yes. 

> 2.5.19                           18.60           21.69           14.58
> 2.5.20                           12.89           13.15           12.79

> One possibile culprit here is the doubling of the request queue size
> in 2.5.20.  A long time ago it was 1024 slots.  Then it went to
> 128.  That's where it is in Marcelo kernels.  Then -ac kernels
> went up to 1024 because they have read-latency2.  Somehow 2.5 found
> itself at 256 slots.  In 2.5.20 it slealthily snuck up to 512
> slots.  I didn't squeak about this because I was interested to see what
> effect it would have.

Interesting.  I've seen read-latency2 drop dbench throughput in -aa
kernels (but I use it anyway).  I'd like to capture the request
queue size.  Is there a command or file in /proc that displays 
it, or should I just grep drivers/block/ll_rw_blk.c?

> Does this patch get the throughput back?

I will try that next.

-- 
Randy Hron

