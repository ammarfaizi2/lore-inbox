Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278351AbRJMSY1>; Sat, 13 Oct 2001 14:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278348AbRJMSYQ>; Sat, 13 Oct 2001 14:24:16 -0400
Received: from colorfullife.com ([216.156.138.34]:6158 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278345AbRJMSYG>;
	Sat, 13 Oct 2001 14:24:06 -0400
Message-ID: <3BC886ED.86525D2C@colorfullife.com>
Date: Sat, 13 Oct 2001 20:24:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pentium IV cacheline size.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus wrote:
> On Sat, 13 Oct 2001, Dave Jones wrote:
> >
> > Currently, we're using a L1_CACHE_SHIFT value of 7
> > for Pentium 4, which equates to 128 byte cache lines.
> 
> Well, the fact is, that from a SMP standpoint, the 128 bytes is the
> correct one: the L2 is 128 bytes wide.

The 128 bytes are split into 2 sectors - I'm not sure if 128 or 64 bytes
is appropriate.

<<<<<
The L2 cache is a 256K-byte cache that holds both instructions
that miss the Trace Cache and data that miss the L1 data cache.
The L2 cache is organized as an 8-way set-associative cache with
128 bytes per cache line. These 128-byte cache lines consist of
two 64-byte sectors. A miss in the L2 cache typically initiates
two 64-byte access requests to the system bus to fill both halves
of the cache line.
<<<<<
http://developer.intel.com/technology/itj/q12001/articles/art_2.htm

--
	Manfred
