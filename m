Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279462AbRJZWAx>; Fri, 26 Oct 2001 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279455AbRJZWAd>; Fri, 26 Oct 2001 18:00:33 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:56587 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S279443AbRJZWA3>; Fri, 26 Oct 2001 18:00:29 -0400
Date: Fri, 26 Oct 2001 23:01:04 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.13 benchmarks... (vs. previous benchmarks)
Message-ID: <Pine.LNX.4.33.0110262241120.6950-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are the 2.4.13 results, which don't mean much apart from in
comparison to previous results on the same setup. Key comparison points
highlighted below. Brief setup details: ext2 fs, 128Mb dual PII/350

dbench 8:          37Mb/sec
dbench 32:         10Mb/sec
bonnie++ write:    18.7Mb/sec
bonnie++ read:     24.2Mb/sec
bonnie++ rewrite:  4.9Mb/sec
bonnie++ seq.  create, read, del: 9800, 3600, 5700
bonnie++ rand  create, read, del: 9900, 75,   40
swaptest:  2m00s

Comparisons
===========

vs. 2.4.11pre2: dbench numbers are up from 34Mb/sec and 7.5Mb/sec
respectively. Sequential output gained 1Mb/sec. Sequential create up from
7300 and 2100.
Unfortunately, swap throughput dropped - in 2.4.11pre the test completed
in 1m30s.

vs. 2.4.10ac4: 2.4.13 has worse dbench 32 number by 4Mb/sec. Very similar
i/o throughputs (both maxed out?). 2.4.10ac4 has much much better
sequential read and delete scores at 8000 and 30000 respectively. Likewise
for random read and delete at 7000 and 300.


Cheers
Chris

