Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTAaURe>; Fri, 31 Jan 2003 15:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTAaURe>; Fri, 31 Jan 2003 15:17:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19169 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262208AbTAaURc>;
	Fri, 31 Jan 2003 15:17:32 -0500
Message-Id: <200301312026.h0VKQwp28398@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [OSDL][BENCHMARK] OSDL-DBT-2 - 2.4 vs 2.5 4-way/8-way with vmstat
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Jan 2003 12:26:58 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As Andrew requested, we now have posted DBT-2 results with vmstat
  data included for the 8-way workloads we reported previously.
  Runs have been included from both the cached and non-cached variants
  of the workload. The 8-way results used the same database cache
  size setting (2656M).

  In addition, we have results for DBT-2 running on STP for the cached workload
  comparing 2.4.18 versus 2.5.54dcl (the Data Center Linux kernel). In these
  runs we varied the database cache size setting (LM=2031MB, MM=2344MB,
  HH=2656M).

  Summary of results (Higher Metric is better)


  CPUs OS  Load Memory Metric (Avg)
  ---- --- ---- ------ ------------

  8way 2.4 Cached HM--- 4475.45
  8way 2.5 Cached HM--- 5063.5
  % speedup 2.5vs2.4----- 13.1 <---

  8way 2.4 NonCached HM 1414.18
  8way 2.5 NonCached HM 1659.8
  % speedup 2.5vs2.4----- 17.4 <---

  4way 2.4 Cached LM----2784.4
  4way 2.5 Cached LM----2941
  % speedup 2.5vs2.4---- 5.62 <---

  4way 2.4 Cached MM----2786.2
  4way 2.5 Cached MM----2939.8
  % speedup 2.5vs2.4----- 5.51 <---

  4way 2.4 Cached HM----2786
  4way 2.5 Cached HM----2947.2
  % speedup 2.5vs2.4----- 5.79 <---



  Here are some highlights/comments:

  Both the 4 way runs and the 8-way runs show improvement going from
  2.4 to 2.5.  The improvement is larger for the 8-way run. We believe
  the 2.5 4-way would have improved more if it had not hit a CPU wall.
  Observe the plot of vmstat percent user data  at :
  http://www.osdl.org/projects/dbt2dev/results/STP_4way/us.html

  From the data and the plots, you will notice a big change about
  every 10 minutes.  That is the time the database does a "savepoint".
  It writes dirty pages to the database files.  This happened in the
  cached runs and the non-cached runs.

  We welcome your comments on why we are seeing this improvement.
  As, always we also welcome suggestions for improvement, and random complaints.

Regards,

  Mary Edie Meredith
  Mark Wong
  Cliff White

  OSDL Database Test 2 Project
  Open Source Development Lab
  www.osdl.org



  Link information:

  The overall results page for the DBT-2 project is at:
  http://www.osdl.org/projects/dbt2dev/results

  direct link to 4 way results page:
  http://www.osdl.org/projects/dbt2dev/results/STP_4way/STP_4way_2.4v2.5.html

  direct link to 8 way results page:
  http://www.osdl.org/projects/dbt2dev/results/8way/LKML2/STP_8way_2.4v2.5.html
  direct link to 8way results page


