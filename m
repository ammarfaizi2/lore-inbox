Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314268AbSDRIT3>; Thu, 18 Apr 2002 04:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314269AbSDRIT2>; Thu, 18 Apr 2002 04:19:28 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:53670 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314268AbSDRIT2>;
	Thu, 18 Apr 2002 04:19:28 -0400
Date: Thu, 18 Apr 2002 18:18:43 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, hannal@us.ibm.com
Subject: 12 way dbench analysis: 2.5.9, dalloc and fastwalkdcache 
Message-ID: <20020418081843.GE4209@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Its about time I took to the kernel with the dbench stick. The following
results were done on a 12 way ppc64 machine with 250MHz cpus. I tested
2.5.9, 2.5.9 with Andrew Morton's dalloc work and Hanna Linder's fast
walk dcache patch. The results can be found at:

http://samba.org/~anton/linux/2.5.9/

A few things to note:

1. On 2.5.9, lru_list_lock contention starts to cut in at 4 cpus.
Andrew's dalloc work gets rid of this bottleneck completely. Its fantastic
stuff!

2. The dcache lock starts to cut in at 6 cpus, and Hanna's patch reduces
the contention a lot.

Things look pretty good right out to 12 way with these patches, I'll try
and get some runs on a larger SMP next.

Anton
