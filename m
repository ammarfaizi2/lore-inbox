Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267755AbSLTJM3>; Fri, 20 Dec 2002 04:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267757AbSLTJM3>; Fri, 20 Dec 2002 04:12:29 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:10113 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267755AbSLTJM0> convert rfc822-to-8bit; Fri, 20 Dec 2002 04:12:26 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.52-mm2 with contest
Date: Fri, 20 Dec 2002 20:22:25 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212202022.30960.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest (http://contest.kolivas.net) benchmarks using the osdl 
(http://www.osdl.org) hardware for 2.5.52-mm2 in both UniProcessor and SMP 
mode:

For the uniprocessor results you need your filter glasses on to compare 2.5.52 
with the -mm results as the baseline changed for compicated reasons. So apart 
from the trend, you can only compare the absolute results between mm1 and 
mm2.

UP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              70.2    96      0       0       1.05
2.5.52-mm1 [7]          74.7    96      0       0       1.12
2.5.52-mm2 [7]          74.6    96      0       0       1.12

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              67.5    99      0       0       1.01
2.5.52-mm1 [7]          71.9    99      0       0       1.08
2.5.52-mm2 [7]          72.0    99      0       0       1.08

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              84.4    79      17      19      1.26
2.5.52-mm1 [7]          91.0    79      18      19      1.36
2.5.52-mm2 [7]          90.3    79      18      19      1.35

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              222.3   36      2       53      3.33
2.5.52-mm1 [7]          226.4   37      2       51      3.39
2.5.52-mm2 [7]          229.6   36      2       50      3.44

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              109.8   81      2       8       1.64
2.5.52-mm1 [7]          112.2   81      3       9       1.68
2.5.52-mm2 [7]          109.6   81      2       9       1.64

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              161.4   69      3       8       2.42
2.5.52-mm1 [7]          127.9   70      2       7       1.92
2.5.52-mm2 [7]          125.0   70      2       7       1.87

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              120.9   60      13      12      1.81
2.5.52-mm1 [7]          143.9   55      18      13      2.16
2.5.52-mm2 [7]          129.3   61      14      12      1.94

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              94.9    76      7       10      1.42
2.5.52-mm1 [7]          115.5   67      11      11      1.73
2.5.52-mm2 [7]          93.3    79      7       9       1.40

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              88.1    80      15      7       1.32
2.5.52-mm1 [7]          97.0    78      15      6       1.45
2.5.52-mm2 [7]          93.6    80      15      6       1.40

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              81.0    86      0       9       1.21
2.5.52-mm1 [7]          86.8    85      0       9       1.30
2.5.52-mm2 [7]          86.3    85      0       9       1.29

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [3]              100.0   78      45      2       1.50
2.5.52-mm1 [7]          117.5   69      45      1       1.76
2.5.52-mm2 [7]          108.0   77      46      2       1.62


SMP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              39.3    181     0       0       1.09
2.5.52-mm1 [8]          39.7    180     0       0       1.10
2.5.52-mm2 [7]          39.2    181     0       0       1.08

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              36.5    194     0       0       1.01
2.5.52-mm1 [7]          36.9    194     0       0       1.02
2.5.52-mm2 [7]          36.5    194     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              48.7    144     10      49      1.34
2.5.52-mm1 [7]          49.0    144     10      50      1.35
2.5.52-mm2 [7]          46.5    152     8       41      1.28

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              56.1    161     1       10      1.55
2.5.52-mm1 [7]          55.5    156     1       10      1.53
2.5.52-mm2 [7]          52.8    154     1       10      1.46

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              83.1    138     1       9       2.29
2.5.52-mm1 [7]          77.4    122     1       8       2.14
2.5.52-mm2 [7]          76.1    124     1       8       2.10

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              73.1    111     10      19      2.02
2.5.52-mm1 [7]          80.5    108     10      19      2.22
2.5.52-mm2 [7]          74.5    112     11      20      2.06

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              75.1    120     10      21      2.07
2.5.52-mm1 [7]          60.1    131     7       18      1.66
2.5.52-mm2 [7]          59.9    134     6       18      1.65

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              49.4    151     5       7       1.36
2.5.52-mm1 [7]          49.9    149     5       6       1.38
2.5.52-mm2 [7]          50.5    147     5       6       1.39

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              43.2    167     0       9       1.19
2.5.52-mm1 [7]          43.8    167     0       9       1.21
2.5.52-mm2 [7]          43.7    167     0       9       1.21

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52 [7]              63.5    148     38      3       1.75
2.5.52-mm1 [7]          71.1    123     36      2       1.96
2.5.52-mm2 [7]          66.0    141     39      3       1.82

Slight shift in the balance in both SMP and UP results towards lower times for 
io_load, io_other and mem_load. Note also the interesting rise in mem_loads 
done despite the shorter time (a marked improvement therefore).

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+AuFSF6dfvkL3i1gRAosVAJ0VgSaPJurexvoCR7wRnA1+wJtWLwCgqu9u
OKFw2P3E8MHYPMfAhWyKEyQ=
=6+VY
-----END PGP SIGNATURE-----
