Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTAXXMm>; Fri, 24 Jan 2003 18:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTAXXMm>; Fri, 24 Jan 2003 18:12:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:40102 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265843AbTAXXMb>; Fri, 24 Jan 2003 18:12:31 -0500
Date: Fri, 24 Jan 2003 15:30:42 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: lse-tech@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: LSE Minutes for 24 Jan 2003
Message-ID: <71820000.1043451042@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LSE Con Call 24 Jan 2003

Michael Hohnbaum -  NUMA Update

Last call mbligh mentioned his mini numa schedular.
By late friday night Erich Focht had generated the last
piece of code needed (node rebalancing). He debugged it 
and Linus picked it all up by Thursday! 
Congrats to Martin, Erich, Michael, Andrew and everyone
else for getting it in.

As an added bonus Ingo Molnar responded to the 
patches being accepted.  He made some additional 
changes which has been debugged and it should all
work together well. 

Andrew Theurer added code to help the numa scheduler
dispatch hyperthreaded processes. It was more of a
proof of concept than final solution for hyperthreading.
Ingo then made additional changes to the O(1) sched. and 
he took some fixes that Andrea Arcangeli made to the O(1)
sceduler.

Michael did some basic runs and it appears there are some
nice performance boosts according to sched bench (on numaq).

There are still some issues that hbaum is looking at related 
to poor load balancing.

Dave Hanson asked about lock contention on shared runqueues for 
hyperthreading? Michael isnt using any hardware with hyperthreading
now.  Andrew is the one looking at that now.

If you are trying to support Hyperthreading then 
Martin Bligh mentioned you should use ingo's patch 
called D7 which provides one runqueue per pair of 
hyperthreaded processors. You can use D7 without CONFIG_NUMA.

Could someone please write a list of patches or hacks that might be 
helpful for working with hyperthreading? (Andrew? Martin?) 

Pat Gaughen was interested in talking to Erich about
support for topology stuff. Hanna has figured out how to
call out to international numbers so Erich, I will really
be able to call you next time! 

Hanna Linder- Move lse project of of sf?
	
	- leave lse-tech mailing list where it is. 
	- sourceforge has no money to support any special requests
	- Consider Tigris, Savanagh.nongnu, OSDL umbrella project for scalability.
	- Discussed moving to osdl. Should talk to nathan and bryce.
	- Hanna will walk across the street and talk to them in person.
	- Hanna did talk to them and it is looking like a promising
	  option. 
	- Does anyone see any issue with moving lse to osdl?

The plan for now is just a place to easily put patches.
The osdl has other tools to enable automatic testing
of patches which we hope to utilize in the future.

	- Hanna will add offset from GMT for future announcements of lse calls.`
