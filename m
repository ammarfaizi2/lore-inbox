Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTBPJgx>; Sun, 16 Feb 2003 04:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTBPJgx>; Sun, 16 Feb 2003 04:36:53 -0500
Received: from c16639.thoms1.vic.optusnet.com.au ([210.49.244.5]:59533 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S266100AbTBPJgw>;
	Sun, 16 Feb 2003 04:36:52 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 2.5.61-mm1 +/- as or cfq with contest
Date: Sun, 16 Feb 2003 20:46:42 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302162046.42103.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are contest (http://contest.kolivas.org) results with osdl 
(http://www.osdl.org) hardware for 2.5.61-mm1 with either the as i/o 
scheduler or the cfq scheduler.

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   79      94.9    0.0     0.0     1.00
2.5.61              1   79      94.9    0.0     0.0     1.00
2.5.61-mm1          3   81      91.4    0.0     0.0     1.00
2.5.61-mm1cfq       3   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   75      100.0   0.0     0.0     0.95
2.5.61              1   76      97.4    0.0     0.0     0.96
2.5.61-mm1          3   76      97.4    0.0     0.0     0.94
2.5.61-mm1cfq       3   76      97.4    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   91      78.0    32.3    18.7    1.15
2.5.61              1   93      80.6    29.0    16.1    1.18
2.5.61-mm1          3   179     41.9    178.0   57.0    2.21
2.5.61-mm1cfq       3   188     39.9    196.7   59.0    2.38
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   98      79.6    1.0     4.1     1.24
2.5.61              2   100     79.0    1.0     4.0     1.27
2.5.61-mm1          2   137     58.4    2.0     5.8     1.69
2.5.61-mm1cfq       3   104     76.0    1.0     3.8     1.32
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   108     70.4    1.0     3.7     1.37
2.5.61              2   102     75.5    1.0     4.9     1.29
2.5.61-mm1          2   158     48.7    2.0     4.4     1.95
2.5.61-mm1cfq       3   104     74.0    1.0     3.8     1.32
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   112     67.0    15.7    7.1     1.42
2.5.61              2   143     52.4    32.9    13.3    1.81
2.5.61-mm1          2   634     12.5    257.3   24.6    7.83
2.5.61-mm1cfq       3   397     19.6    123.3   18.1    5.03
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   89      84.3    10.5    5.6     1.13
2.5.61              2   91      82.4    11.1    5.5     1.15
2.5.61-mm1          2   187     41.7    84.7    27.3    2.31
2.5.61-mm1cfq       3   199     39.2    77.2    23.5    2.52
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   93      81.7    2.8     2.2     1.18
2.5.61              2   102     77.5    6.3     4.9     1.29
2.5.61-mm1          2   120     65.8    8.9     5.8     1.48
2.5.61-mm1cfq       3   109     72.5    7.1     5.5     1.38
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   96      79.2    0.0     6.2     1.22
2.5.61              2   95      81.1    0.0     6.3     1.20
2.5.61-mm1          2   97      79.4    0.0     6.2     1.20
2.5.61-mm1cfq       3   97      79.4    0.0     6.2     1.23
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60-mm1          3   95      82.1    51.7    2.1     1.20
2.5.61              1   96      81.2    54.0    2.1     1.22
2.5.61-mm1          2   128     61.7    72.0    2.3     1.58
2.5.61-mm1cfq       3   117     66.7    61.0    1.7     1.48
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.61              2   237     32.5    3.0     47.3    3.00
2.5.61-mm1          2   716     10.8    11.0    50.4    8.84
2.5.61-mm1cfq       3   426     18.1    5.7     50.7    5.39

So we're getting into a situation where 2.6 will have either server or desktop 
tuning? I guess if one can't fit all (ideal) then this is a good compromise. 
What I don't understand is why the anticipatory scheduler takes longer to 
compile a kernel without any load running? This happened with previous tests 
of the as scheduler too.

Con
