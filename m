Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135589AbRD1SYW>; Sat, 28 Apr 2001 14:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135590AbRD1SYU>; Sat, 28 Apr 2001 14:24:20 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:64261 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S135589AbRD1SYF>;
	Sat, 28 Apr 2001 14:24:05 -0400
Date: Sat, 28 Apr 2001 20:24:08 +0200
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: Severe trashing in 2.4.4
Message-ID: <20010428202408.A23581@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi'all,

There seems to be something amiss with 2.4.4 wrt. memory management, which
leads to severe trashing under *light* load on my SMP box (Abit BP-6 with
Maciej's IO-APIC patch). I've had my box become almost unuseable twice within a
4-hour period now. One of those times it was running a compile session, the
other time it did not run anything besides some X-terminals and xmms.

There's nothing in the log which seems to be related to this trashing. There
were no memory-intensive tasks running during the trashing (X was the biggest,
with 40 MB (including 32 MB for the video card).

When trashing, the system was running bdflush and kswapd, both of which used
between 30% and 60% CPU. System load was between 8 and 11, but the actual load
feels more like 50-60...

I have not found anything yet which triggers the problem. Coupled with the fact
that there's nothing in the logs (and nothing sensible to be seen through
sysrq). Judging from the thread on the list on the problems with the fork patch
(which seems to hit people with SMP systems), it might be related to this, but
that's only guessing.

Any ideas? Things to try?

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
