Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTILSm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTILSly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:41:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:56550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261841AbTILSjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:39:48 -0400
Message-Id: <200309121839.h8CIdao22695@mail.osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Nick's scheduler policy v15 
In-Reply-To: Your message of "Fri, 12 Sep 2003 00:34:47 +1000."
             <3F608807.9090705@cyberone.com.au> 
Date: Fri, 12 Sep 2003 11:39:36 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> http://www.kerneltrap.org/~npiggin/v15/
> 

Here are results for several recent kernels for comparison.
the sched-rollup-nopolicy tests are still running. 
Performance of v15 suffers as number of CPU's increase.
At 8 cpu's, delta is noticeable vs stock -test5
cliffw

stp2 CPU machine
Database workload

STP id PLM# Kernel Name                    Workfile   MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change
279766 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  1317.56   22  0.00 stp2-000  profile=2 elevator=cfq
279764 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  1333.37   22  1.20 stp2-002  profile=2 elevator=deadline
279762 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  1311.99   22 -0.42 stp2-000  profile=2
279714 2124 2.6.0-test5-O1int20.1          new_dbase  1351.91   24  2.61 stp2-003  
279588 2112 2.6.0-test5-mm1-fix11.0        new_dbase  1316.95   22 -0.05 stp2-000  profile=2
279474 2110 linux-2.6.0-test5              new_dbase  1337.11   22  1.48 stp2-000  profile=2

Compute workload
STP id PLM# Kernel Name                    Workfile   MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change
279765 2132 2.6.0-test5-sched-roll-v15-3   compute    1553.34   26  0.00 stp2-003  profile=2 elevator=deadline
279763 2132 2.6.0-test5-sched-roll-v15-3   compute    1488.25   26 -4.19 stp2-001  profile=2
279589 2112 2.6.0-test5-mm1-fix11.0        compute    1503.12   26 -3.23 stp2-001  profile=2
279475 2110 linux-2.6.0-test5              compute    1545.03   26 -0.53 stp2-002  profile=2


stp4 CPU machine
Database workload

STP id PLM# Kernel Name                    Workfile   MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change
279772 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  4986.82   60  0.00 stp4-000  profile=2 elevator=cfq
279770 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  4935.10   60 -1.04 stp4-002  profile=2 elevator=deadline
279768 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  4974.13   60 -0.25 stp4-000  profile=2
279606 2112 2.6.0-test5-mm1-fix11.0        new_dbase  5347.06   92  7.22 stp4-002  profile=2

Compute workload
STP id PLM# Kernel Name                    Workfile   MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change
279769 2132 2.6.0-test5-sched-roll-v15-3   compute    5248.08   76  0.00 stp4-001  profile=2
279650 2117 2.6.0-test5-sched-rollup       compute    5134.75   88 -2.16 stp4-003  profile=2
279607 2112 2.6.0-test5-mm1-fix11.0        compute    5380.18   92  2.52 stp4-001  profile=2
279493 2110 linux-2.6.0-test5              compute    5175.28   88 -1.39 stp4-000  profile=2


stp8 CPU machine
Database workload

STP id PLM# Kernel Name                    Workfile   MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change
279760 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  7440.33   88  0.00 stp8-003  profile=2 elevator=cfq
279758 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  7445.05   88  0.06 stp8-003  profile=2 elevator=deadline
279756 2132 2.6.0-test5-sched-roll-v15-3   new_dbase  7574.35   88  1.80 stp8-001  profile=2
279706 2124 2.6.0-test5-O1int20.1          new_dbase  8441.09  136 13.45 stp8-001  
279717 2120 2.6.0-test5.ck.O20.1int        new_dbase  8408.47  136 13.01 stp8-001  
279562 2112 2.6.0-test5-mm1-fix11.0        new_dbase  8478.10  136 13.95 stp8-001  profile=2 elevator=cfq
279560 2112 2.6.0-test5-mm1-fix11.0        new_dbase  8303.30  136 11.60 stp8-001  profile=2 elevator=deadline
279558 2112 2.6.0-test5-mm1-fix11.0        new_dbase  8401.98  136 12.92 stp8-001  profile=2
279448 2110 linux-2.6.0-test5              new_dbase  8812.21  144 18.44 stp8-000  profile=2 elevator=cfq
279446 2110 linux-2.6.0-test5              new_dbase  8950.07  144 20.29 stp8-002  profile=2 elevator=deadline
279444 2110 linux-2.6.0-test5              new_dbase  8785.24  144 18.08 stp8-002  profile=2

Compute workload

STP id PLM# Kernel Name                    Workfile   MaxJPM  MaxU Change Host    Options
Newest Kernel - Baseline for % change
279759 2132 2.6.0-test5-sched-roll-v15-3   compute    9111.87  120  0.00 stp8-001  profile=2 elevator=deadline
279757 2132 2.6.0-test5-sched-roll-v15-3   compute    9124.72  120  0.14 stp8-002  profile=2
279563 2112 2.6.0-test5-mm1-fix11.0        compute    9743.27  160  6.93 stp8-003  profile=2 elevator=cfq
279561 2112 2.6.0-test5-mm1-fix11.0        compute    9719.15  160  6.66 stp8-003  profile=2 elevator=deadline
279559 2112 2.6.0-test5-mm1-fix11.0        compute    9687.67  160  6.32 stp8-003  profile=2
279449 2110 linux-2.6.0-test5              compute    9666.02  160  6.08 stp8-003  profile=2 elevator=cfq
279445 2110 linux-2.6.0-test5              compute    9758.11  160  7.09 stp8-002  profile=2
> 
