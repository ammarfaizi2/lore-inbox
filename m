Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbRHHTHv>; Wed, 8 Aug 2001 15:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbRHHTHl>; Wed, 8 Aug 2001 15:07:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18398 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267860AbRHHTHa>;
	Wed, 8 Aug 2001 15:07:30 -0400
Importance: Normal
Subject: Re: [RFC][PATCH] Scalable Scheduling
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF731DBA23.99999991-ON85256AA2.0068A13F@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 8 Aug 2001 15:05:04 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/08/2001 03:07:27 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a project that some of our people here are involved with called
SIGMA.
They are looking at standardizing interfaces for this across all platforms.
I'll dig out an http and forward to the list.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



"David S. Miller" <davem@redhat.com> on 08/08/2001 02:53:28 PM

To:   lm@bitmover.com
cc:   torvalds@transmeta.com, Hubertus Franke/Watson/IBM@IBMUS,
      mkravetz@beaverton.ibm.com, linux-kernel@vger.kernel.org,
      wscott@bitmover.com
Subject:  Re: [RFC][PATCH] Scalable Scheduling



   Date:  Wed, 8 Aug 2001 11:18:44 -0700
   From: Larry McVoy <lm@bitmover.com>

   Someobdy really ought to take the time to make a cache miss counter
program
   that works like /bin/time.  So I could do

        $ cachemiss lat_ctx 2
        10123 instruction, 22345 data, 50432 TLB flushes

   Has anyone done that?  If so, then what would be cool is if each of
these
   wonderful new features that people propose come with cachemiss results
for
   the related part of LMbench or some other benchmark.

On some platforms, such an app can basically be written already.

The kernel support is there for sparc64 wrt. the cache
miss stuff.  It uses the cpu performance counter stuff.
Have a look at linux/include/asm-sparc64/perfctr.h to see
what I mean.

The performance counters are fancy enough that you can
ask them to do stuff like:

1) tell me D-cache misses in user and/or kernel mode
2) tell me D-cache misses that hit the E-cache
   in user and/or kernel mode
3) tell me I-cache misses, but only those which actually
   ended up stalling the pipeline
4) tell me E-cache misses, where the chip was not able
   to get granted to memory bus immediately
5) Same as #4, but how many total bus cycles were spent
   waiting for bus grant for the E-cache miss

Later,
David S. Miller
davem@redhat.com



