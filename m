Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSLCWBc>; Tue, 3 Dec 2002 17:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSLCWBc>; Tue, 3 Dec 2002 17:01:32 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:27026 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S261518AbSLCWBa>;
	Tue, 3 Dec 2002 17:01:30 -0500
Message-ID: <1038953338.3ded2b7a5fe0d@kolivas.net>
Date: Wed,  4 Dec 2002 09:08:58 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: [BENCHMARK] 2.5.40-mm1 with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here are the latest contest (http://contest.kolivas.net) results with the osdl
hardware (http://www.osdl.org) in both UP and SMP. This is with a pre- version
of contest so includes cacherun and dbench_load and the load accounting is much
improved.

UP results

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              67.3    97      0       0       1.01
2.5.49 [5]              70.0    96      0       0       1.05
2.5.50 [5]              69.9    96      0       0       1.05
2.5.50-mm1 [5]          71.4    94      0       0       1.07

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              65.7    99      0       0       0.98
2.5.49 [5]              67.4    99      0       0       1.01
2.5.50 [5]              67.3    99      0       0       1.01
2.5.50-mm1 [5]          67.8    99      0       0       1.02

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              108.1   58      84      40      1.62
2.5.49 [5]              85.2    79      17      20      1.28
2.5.50 [5]              84.8    79      17      19      1.27
2.5.50-mm1 [5]          86.6    78      18      20      1.30

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              207.2   32      2       46      3.10
2.5.49 [5]              210.5   37      2       50      3.15
2.5.50 [5]              189.2   40      2       49      2.83
2.5.50-mm1 [5]          243.3   34      2       51      3.64

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              85.4    83      2       9       1.28
2.5.49 [5]              106.1   82      2       9       1.59
2.5.50 [5]              107.5   81      3       9       1.61
2.5.50-mm1 [5]          88.0    83      1       4       1.32

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              107.6   64      2       8       1.61
2.5.49 [5]              184.8   70      3       8       2.77
2.5.50 [5]              189.5   61      4       9       2.84
2.5.50-mm1 [5]          104.9   70      1       6       1.57

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              203.4   33      40      15      3.05
2.5.49 [5]              127.4   57      14      13      1.91
2.5.50 [5]              142.6   54      19      14      2.14
2.5.50-mm1 [5]          174.2   46      24      15      2.61

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              120.3   56      24      16      1.80
2.5.49 [5]              97.4    75      7       11      1.46
2.5.50 [5]              106.9   69      10      11      1.60
2.5.50-mm1 [5]          101.8   70      9       11      1.52

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              88.8    82      16      4       1.33
2.5.49 [5]              88.2    80      15      6       1.32
2.5.50 [5]              88.5    80      15      7       1.33
2.5.50-mm1 [5]          86.6    80      3       2       1.30

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              75.7    88      0       8       1.13
2.5.49 [5]              81.4    85      0       8       1.22
2.5.50 [5]              81.2    85      0       8       1.22
2.5.50-mm1 [5]          82.4    84      0       7       1.23

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              84.8    80      44      2       1.27
2.5.49 [5]              98.1    76      43      2       1.47
2.5.50 [5]              98.3    76      44      2       1.47
2.5.50-mm1 [5]          116.9   67      47      1       1.75


SMP Results
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              36.9    189     0       0       1.02
2.5.49 [6]              39.3    181     0       0       1.09
2.5.50 [5]              39.3    180     0       0       1.09
2.5.50-mm1 [6]          39.4    181     0       0       1.09

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              35.8    194     0       0       0.99
2.5.49 [6]              36.6    194     0       0       1.01
2.5.50 [5]              36.5    194     0       0       1.01
2.5.50-mm1 [6]          36.6    194     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              51.0    138     20      59      1.41
2.5.49 [6]              50.0    141     11      52      1.38
2.5.50 [5]              47.8    148     10      46      1.32
2.5.50-mm1 [5]          47.6    150     8       43      1.31

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              144.8   49      0       38      4.00
2.5.49 [5]              119.8   96      0       26      3.31
2.5.50 [5]              199.8   101     0       24      5.52
2.5.50-mm1 [5]          164.3   67      0       29      4.54

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              43.1    169     1       11      1.19
2.5.49 [5]              53.8    161     1       10      1.49
2.5.50 [5]              54.6    157     1       10      1.51
2.5.50-mm1 [5]          51.3    155     0       4       1.42

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              63.5    114     1       12      1.75
2.5.49 [5]              72.9    132     1       10      2.01
2.5.50 [5]              116.2   103     2       10      3.21
2.5.50-mm1 [5]          83.9    111     1       9       2.32

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              164.9   45      31      21      4.55
2.5.49 [5]              75.5    110     9       18      2.09
2.5.50 [5]              87.6    102     14      22      2.42
2.5.50-mm1 [5]          99.0    92      14      21      2.73

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              89.6    86      17      21      2.47
2.5.49 [5]              64.2    130     8       19      1.77
2.5.50 [5]              59.3    139     7       18      1.64
2.5.50-mm1 [5]          70.5    125     10      22      1.95

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              51.0    143     7       7       1.41
2.5.49 [5]              49.1    152     5       7       1.36
2.5.50 [5]              49.3    151     5       7       1.36
2.5.50-mm1 [5]          52.1    142     2       3       1.44

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              40.4    175     0       8       1.12
2.5.49 [5]              43.4    167     0       8       1.20
2.5.50 [5]              43.4    167     0       8       1.20
2.5.50-mm1 [5]          44.0    167     0       7       1.22

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              52.0    139     37      3       1.44
2.5.49 [5]              62.5    145     35      3       1.73
2.5.50 [5]              63.3    141     36      3       1.75
2.5.50-mm1 [5]          67.1    126     39      3       1.85

Further information will be available at
http://www.osdl.org/projects/ctdevel/results/ (short lag time for the web server
to catch up).

Note that some of these runs have pathological cases so looking at the full load
information (eg io_load.log) will show you these. Thats why average of 5 runs is
performed. I may move to 7 runs in the future.

Con
