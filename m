Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSLADFT>; Sat, 30 Nov 2002 22:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSLADFS>; Sat, 30 Nov 2002 22:05:18 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:50819 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S261426AbSLADFQ> convert rfc822-to-8bit; Sat, 30 Nov 2002 22:05:16 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.50 with contest
Date: Sun, 1 Dec 2002 14:14:43 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212011415.05264.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are UP and SMP contest benchmarks for 2.5.50:

UP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              67.2    97      0       0       1.01
2.4.20 [5]              67.3    97      0       0       1.01
2.5.49 [5]              70.0    96      0       0       1.05
2.5.50 [5]              69.9    96      0       0       1.05

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              65.9    99      0       0       0.99
2.4.20 [5]              65.7    99      0       0       0.98
2.5.49 [5]              67.4    99      0       0       1.01
2.5.50 [5]              67.3    99      0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              106.2   58      82      40      1.59
2.4.20 [5]              108.1   58      84      40      1.62
2.5.49 [5]              85.2    79      17      20      1.28
2.5.50 [5]              84.8    79      17      19      1.27

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              215.9   31      2       45      3.23
2.4.20 [5]              207.2   32      2       46      3.10
2.5.49 [5]              210.5   37      2       50      3.15
2.5.50 [5]              189.2   40      2       49      2.83
Improvement here.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              85.6    81      2       8       1.28
2.4.20 [5]              85.4    83      2       9       1.28
2.5.49 [5]              106.1   82      2       9       1.59
2.5.50 [5]              107.5   81      3       9       1.61

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              104.5   65      2       7       1.57
2.4.20 [5]              107.6   64      2       8       1.61
2.5.49 [5]              184.8   70      3       8       2.77
2.5.50 [5]              189.5   61      4       9       2.84

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              182.3   37      36      14      2.73
2.4.20 [5]              203.4   33      40      15      3.05
2.5.49 [5]              127.4   57      14      13      1.91
2.5.50 [5]              142.6   54      19      14      2.14
Slight slowdown here.

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              111.9   60      21      15      1.68
2.4.20 [5]              120.3   56      24      16      1.80
2.5.49 [5]              97.4    75      7       11      1.46
2.5.50 [5]              106.9   69      10      11      1.60
This is an io_load on another hard disk, slight slowdown here.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              95.8    76      16      4       1.43
2.4.20 [5]              88.8    82      16      4       1.33
2.5.49 [5]              88.2    80      15      6       1.32
2.5.50 [5]              88.5    80      15      7       1.33

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              76.8    87      0       7       1.15
2.4.20 [5]              75.7    88      0       8       1.13
2.5.49 [5]              81.4    85      0       8       1.22
2.5.50 [5]              81.2    85      0       8       1.22

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              87.3    78      43      2       1.31
2.4.20 [5]              84.8    80      44      2       1.27
2.5.49 [5]              98.1    76      43      2       1.47
2.5.50 [5]              98.3    76      44      2       1.47


SMP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              38.0    183     0       0       1.05
2.4.20 [5]              36.9    189     0       0       1.02
2.5.49 [6]              39.3    181     0       0       1.09
2.5.50 [5]              39.3    180     0       0       1.09

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              35.9    193     0       0       0.99
2.4.20 [5]              35.8    194     0       0       0.99
2.5.49 [6]              36.6    194     0       0       1.01
2.5.50 [5]              36.5    194     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              49.8    140     20      57      1.38
2.4.20 [5]              51.0    138     20      59      1.41
2.5.49 [6]              50.0    141     11      52      1.38
2.5.50 [5]              47.8    148     10      46      1.32

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              159.4   45      0       40      4.40
2.4.20 [5]              144.8   49      0       38      4.00
2.5.49 [5]              119.8   96      0       26      3.31
2.5.50 [5]              199.8   101     0       24      5.52
Interesting, UP sped up here but SMP dropped off.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              43.7    165     1       10      1.21
2.4.20 [5]              43.1    169     1       11      1.19
2.5.49 [5]              53.8    161     1       10      1.49
2.5.50 [5]              54.6    157     1       10      1.51

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              49.2    144     1       10      1.36
2.4.20 [5]              63.5    114     1       12      1.75
2.5.49 [5]              72.9    132     1       10      2.01
2.5.50 [5]              116.2   103     2       10      3.21
Slowdown in SMP.

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              162.3   45      28      19      4.48
2.4.20 [5]              164.9   45      31      21      4.55
2.5.49 [5]              75.5    110     9       18      2.09
2.5.50 [5]              87.6    102     14      22      2.42
Correlates with slowdown in UP

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              62.3    117     11      20      1.72
2.4.20 [5]              89.6    86      17      21      2.47
2.5.49 [5]              64.2    130     8       19      1.77
2.5.50 [5]              59.3    139     7       18      1.64
Speedup here probably not statistically significant.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              60.2    123     9       7       1.66
2.4.20 [5]              51.0    143     7       7       1.41
2.5.49 [5]              49.1    152     5       7       1.36
2.5.50 [5]              49.3    151     5       7       1.36

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              40.3    174     0       8       1.11
2.4.20 [5]              40.4    175     0       8       1.12
2.5.49 [5]              43.4    167     0       8       1.20
2.5.50 [5]              43.4    167     0       8       1.20

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              53.7    133     36      3       1.48
2.4.20 [5]              52.0    139     37      3       1.44
2.5.49 [5]              62.5    145     35      3       1.73
2.5.50 [5]              63.3    141     36      3       1.75

Interesting. There is a divergence under SMP versus UP. The hardware is the 
same for both SMP and UP with the second cpu offline for UP. Maybe these will 
start to make more sense with continued testing of newer kernels.

Further details can be found here:
http://www.osdl.org/projects/ctdevel/results/

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE96X6jF6dfvkL3i1gRAoqHAJ9k3n/2drqSmN1pp+o/LGAVYQn5gwCfU3p+
AfyFNU16W2MKVMFBLMkkgLs=
=yEoN
-----END PGP SIGNATURE-----
