Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261752AbSI2TuT>; Sun, 29 Sep 2002 15:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSI2Tsr>; Sun, 29 Sep 2002 15:48:47 -0400
Received: from mailhost2-bcvloh.bcvloh.ameritech.net ([66.73.20.44]:64910 "EHLO
	mailhost.bcv2.ameritech.net") by vger.kernel.org with ESMTP
	id <S261760AbSI2TsO> convert rfc822-to-8bit; Sun, 29 Sep 2002 15:48:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: james <jdickens@ameritech.net>
To: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
Date: Sun, 29 Sep 2002 14:53:35 -0500
User-Agent: KMail/1.4.3
Cc: Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
References: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain> <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <20020929091539.GB1014@suse.de>
In-Reply-To: <20020929091539.GB1014@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209291453.35096.jdickens@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Upon thinking about 2.6 v3.0 argument, I think we may be  looking at this 
version comparison in the wrong light, it is not wether we have come far 
enough from 2.4.x to make it 3.0 it is wether we have change enough from 
version 2.0.x. 

When I compare running linux 2.0.x to running what will be the next version we 
are looking at a completely different system. For example in v2.0 the only 
file system choices were ext2 or DOS, with a few others that wern't in wide 
spread use.  where you created small partitions to keep fsck's fast, even if 
you had battery backup, you were still basicly limited to 8 gig file systems. 
Today we have ext2, ext3, reiserfs, JFS, XFS, in the last four,  journaling 
capabilities. it is possible and expected  have huge filesystems and patches 
exist to break the 2 terabyte file systems  exist in various stages of 
testing. Not to mention we have LVM, and raid file systems, being used on 
desktop as well server systems. 

Networking has changed as well, we went from mostly 10mbit eternet cards and a 
few 100 mbit cards, to now having 100mbit ethernet as the base of home 
networking, not to mention gigabit ethernet, and ATM gaining popularity in 
the server market, while they are just drivers, the real shift of thinking 
comes in zero copy file transfer and a mature state of the art 
firewalling/routing/bridging etc. in NAT and iptables 

For video we changed from base VGA video text and X, to acellerated video 
processors not just in X, but in framebuffers  used as consoles.

We also have support for diverse set of buses, that change the way we think 
about our system, multiple bridges on PCI, USB v1 and v2, to firewire. 

I will let others more in the know in memory management, discuss the finer 
points of this one, but it is a major change, in 2.0 we just killed random 
programs when out of memory.  today we make a slightly more educated guess as 
what to kill when we are out of memory, not to mention a just one base mix of 
address support, I think it was 2gig user and 2gig, Today we can choose, 1. 
2, or 3 gig of kernel space.  Large memory support in the Kernel , supporting  
36bit memory accessing, That support more memory than I will ever see in the 
near future. 

we have changed from a System that barely supported smp with 2 processors with 
basicly one big kernel lock to a system with finely grained locks and 
semaphores and subsystem spinlocks,  that has decent performance on 8+ cpu 
systems. Numa system surport also appeared since version 2.0.x 

In 2.0.0 we had a 15bit pid with a maximum of 1000 active ( i beleve it is 
less than this) today we have a 32+bit pid on the table with support of many 
more active processes. of couse we have numourous internal file systems that 
did not exist, tmpfs, devfs, etc.....  and changed the way we all think about 
our systems. 

A prempted kernel, need I say more. 


well that is just a small list of the globals systems that change the way we 
think of linux. 

If we continue to justify major version changes based on change in minor 
version to minor version, can we expect linux 2.98,x in the future?  In each 
minor version we rewrite one or two subsytems. And these take many months to 
plan, complete and test, so big enough change in a single minor version 
number to minor version may not be possible at the current size of this 
devolement effort, So yes we have come far enougth from v2.0.x to justify a 
version 3.0.x. If I was a marketing person I would call it linux 3.0.0 
enterprize edition, if we can get LVM2, raid and break the 2 terabyte 
filesystem limit along with what we allready have accomplised. 

Just my opionion 

James

 





