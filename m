Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbSKPDPg>; Fri, 15 Nov 2002 22:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267214AbSKPDPg>; Fri, 15 Nov 2002 22:15:36 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3456 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267213AbSKPDPe> convert rfc822-to-8bit; Fri, 15 Nov 2002 22:15:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.47-mm3 with contest
Date: Sat, 16 Nov 2002 14:22:13 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211161422.17438.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are some contest benchmarks for 2.5.47-mm3.

These include 2 experimental additions to contest. One is cacherun which is an 
unloaded kernel compile immediately following a previous compile. The second 
is dbench_load, where dbench (16*num_cpus) is run in a continuous loop. The 
number of loads in dbench_loads at the moment is which run it was up to when 
terminated (ie a run of 1 means it never got to finish).

Note the config of 2.5 kernels includes preempt.

Config of 2.5.47-mm3 includes shared 3rd level pagetables.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       1.00
2.4.19 [5]              69.0    97      0       0       0.97
2.4.20-rc1 [3]          72.2    93      0       0       1.01
2.5.47 [3]              73.5    93      0       0       1.03
2.5.47-mm1 [5]          73.6    93      0       0       1.03
2.5.47-mm3 [2]          73.7    93      0       0       1.03

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.93
2.4.19 [2]              68.0    99      0       0       0.95
2.4.20-rc1 [3]          67.2    99      0       0       0.94
2.5.47 [3]              68.3    99      0       0       0.96
2.5.47-mm1 [5]          68.4    99      0       0       0.96
2.5.47-mm3 [2]          68.3    99      0       0       0.96

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.53
2.4.19 [3]              106.5   59      112     43      1.49
2.4.20-rc1 [3]          110.7   58      119     43      1.55
2.5.47 [3]              83.4    82      22      21      1.17
2.5.47-mm1 [5]          83.0    83      21      20      1.16
2.5.47-mm3 [2]          84.2    82      22      21      1.18

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [1]              346.6   20      1       57      4.85
2.4.19 [1]              342.6   20      1       62      4.80
2.4.20-rc1 [1]          309.8   23      2       50      4.34
2.5.47 [2]              224.2   33      1       44      3.14
2.5.47-mm3 [2]          201.6   38      1       39      2.82

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.64
2.4.19 [2]              106.5   70      1       8       1.49
2.4.20-rc1 [3]          102.1   72      1       7       1.43
2.5.47 [3]              93.9    80      1       5       1.32
2.5.47-mm1 [5]          94.0    81      1       5       1.32
2.5.47-mm3 [2]          94.0    81      1       6       1.32

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.11
2.4.19 [1]              132.4   55      2       9       1.85
2.4.20-rc1 [3]          180.7   40      3       8       2.53
2.5.47 [3]              167.1   45      2       7       2.34
2.5.47-mm1 [5]          118.5   64      1       7       1.66
2.5.47-mm3 [2]          211.3   38      2       6       2.96

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.64
2.4.19 [3]              492.6   14      38      10      6.90
2.4.20-rc1 [2]          1142.2  6       90      10      16.00
2.5.47 [3]              165.9   46      9       9       2.32
2.5.47-mm1 [5]          126.3   61      5       8       1.77
2.5.47-mm3 [2]          117.1   65      4       8       1.64

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.43
2.4.19 [2]              134.1   54      14      5       1.88
2.4.20-rc1 [3]          173.2   43      20      5       2.43
2.5.47 [3]              103.4   74      6       4       1.45
2.5.47-mm1 [5]          100.6   76      7       4       1.41
2.5.47-mm3 [2]          218.5   34      10      2       3.06

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.26
2.4.19 [1]              89.8    77      1       20      1.26
2.4.20-rc1 [3]          88.8    77      0       12      1.24
2.5.47 [3]              100.2   71      1       20      1.40
2.5.47-mm1 [5]          102.4   69      1       19      1.43
2.5.47-mm3 [2]          101.2   71      1       21      1.42

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.45
2.4.19 [3]              100.0   72      33      3       1.40
2.4.20-rc1 [3]          105.9   69      32      2       1.48
2.5.47 [3]              151.1   49      35      2       2.12
2.5.47-mm1 [5]          127.0   58      29      2       1.78
2.5.47-mm3 [2]          243.8   31      39      1       3.41

Note the significant discrepancy between mm1 and mm3. This reminds me of what 
happened last time I enabled shared 3rd level pagetables - Andrew do you want 
me to do a set of numbers with this disabled?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE91bnlF6dfvkL3i1gRAlnMAKCODJZ26fA1zvTp0mcvtzydO7xk3ACfTh8A
Rxk3RlPecInc8ef7Ne8bWMg=
=+908
-----END PGP SIGNATURE-----

