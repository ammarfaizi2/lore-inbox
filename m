Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbTC1WE1>; Fri, 28 Mar 2003 17:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbTC1WE0>; Fri, 28 Mar 2003 17:04:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263165AbTC1WEV>;
	Fri, 28 Mar 2003 17:04:21 -0500
Subject: [OSDL][BENCHMARK] DBT-2  2.5.65/mjb/osdl comparison data
From: Mary Edie Meredith <maryedie@osdl.org>
To: lse-tech <lse-tech@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Open Source Development Lab
Message-Id: <1048889724.2535.329.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Mar 2003 14:15:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have now comparison data for DBT-2 (readprofile included) from
multiple kernels. To provide a quick comparison for those not
familiar with DBT-2, we've compared the results, using 2.5.65 stock
as the baseline (bigger is better).

                        Score           Score
Kernel                  Cached          Non-Cached
2.5.65 base             100 (baseline)  100
2.5.65-mjb2 HZ=100      90.95           99.26
2.5.65-mjb2 HZ=1000     102.38          99.92
2.5.65-osdl1            101.69          99.89
2.5.64-osdl1            104.16          99.67

HZ is defined as 1000 in the base and osdl1 kernels. mjb2 kernel uses
Andrew Morton / Dave Hansen patch making HZ a config option of
100 Hz or 1000 Hz).  Also we reversed out the 400-shpte patch.

Link to .config, readprofiles, metric info, raw data:

http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/8way_2_5_65.html


Guided tour:

At the top of the screen, you will see a row that includes the .config
and the readprofile data for each kernel tested.

Next is the list of runs of each type, the average metric (Green
line) bigger numbers are better. The first set of these is the
cached workload case, second is non-cached.

Click on "Raw data" for the vmstat, iostat raw info from each run of
that kernel and workload type.


Just some things noticed looking at the vmstat plotted data:

Notible difference in processes waiting for run time, all 2.5.65
are high relative to 2.5.64(the last frame) for the cached case
(first row of frames) in these plots:
http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/r.html


Of course, interrupts are down for the HZ=100 case (second frame,
both rows):
http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/In.html

Context switches per second slightly down to for HZ=100:
http://www.osdl.org/projects/dbt2dev/results/8way/MJB65/cs.html

Moving on to 2.5.66 to escape problems with "sleep".

Mary Meredith
Mark Wong
Cliff White

Open Source Development Lab
www.osdl.org
~                                             
-- 

