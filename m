Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263834AbTCUT20>; Fri, 21 Mar 2003 14:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263821AbTCUT1i>; Fri, 21 Mar 2003 14:27:38 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:23522 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S263820AbTCUT0h>; Fri, 21 Mar 2003 14:26:37 -0500
Date: Fri, 21 Mar 2003 11:37:12 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2 (now with deadline)
Message-ID: <20030321193711.GA31586@ca-server1.us.oracle.com>
References: <20030320204041.GO2835@ca-server1.us.oracle.com> <20030320175805.1625dbcc.akpm@digeo.com> <20030321024256.GW2835@ca-server1.us.oracle.com> <3E7ABD15.1030005@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7ABD15.1030005@cyberone.com.au>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 06:19:49PM +1100, Nick Piggin wrote:
> The smaller first runs are not due to the benchmark running for the first
> time, are they? In your mm1 tests you wrote:

	The benchmark has a ramp-up period built-in to populate the
database caches.  The first run is not always the slowest.
	The thing is, the runs can be sensitive to some things (someone
logs in and runs something, Linux decides to flush some cache, etc).
The runs take long enough without extending them to flatten this some.

> >Runs (antic):  1559.32 1025.38 1579.98
> >Runs (deadline):  1554.48 1589.89 1350.37

	If you notice, the variance always is of a fluke sort.  This is
why I do multiple runs.  The non-fluke runs are very consistent.  See
runs 1 and 3 for antic and 1 and 2 for deadline in the quote.

> So it does seem to be quite varied, but yes I'll keep working on it.
> BTW. how do these results compare with 2.4 and other operating
> systems on the same hardware, out of interest?

	I've not run other operating systems, as I don't have the
software or OSes installed.  I've not run a vanilla 2.4 recently, and
probably should do that.

Joel

-- 

 "I'm living so far beyond my income that we may almost be said
 to be living apart."
         - e e cummings

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
