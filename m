Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267139AbSK2T5v>; Fri, 29 Nov 2002 14:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267141AbSK2T5v>; Fri, 29 Nov 2002 14:57:51 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:27776 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267139AbSK2T5t> convert rfc822-to-8bit; Fri, 29 Nov 2002 14:57:49 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.4.20 with contest
Date: Sat, 30 Nov 2002 07:07:05 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211300707.37590.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks to the resources of the OSDL (http://www.osdl.org) I now can generate 
benchmarks for the same hardware in UP and SMP modes. Here are the current 
stable kernel benchmarks with contest (http://contest.kolivas.net):

UNIPROCESSOR:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              67.2    97      0       0       1.01
2.4.20 [5]              67.3    97      0       0       1.01

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              65.9    99      0       0       0.99
2.4.20 [5]              65.7    99      0       0       0.98

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              106.2   58      82      40      1.59
2.4.20 [5]              108.1   58      84      40      1.62

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              215.9   31      2       45      3.23
2.4.20 [5]              207.2   32      2       46      3.10

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              85.6    81      2       8       1.28
2.4.20 [5]              85.4    83      2       9       1.28

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              104.5   65      2       7       1.57
2.4.20 [5]              107.6   64      2       8       1.61

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              182.3   37      36      14      2.73
2.4.20 [5]              203.4   33      40      15      3.05

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              111.9   60      21      15      1.68
2.4.20 [5]              120.3   56      24      16      1.80

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              95.8    76      16      4       1.43
2.4.20 [5]              88.8    82      16      4       1.33

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              76.8    87      0       7       1.15
2.4.20 [5]              75.7    88      0       8       1.13

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              87.3    78      43      2       1.31
2.4.20 [5]              84.8    80      44      2       1.27

io_other is a custom addition which performs an io_load on a different hard 
disk from where the kernel compilation is.


SMP:
noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              38.0    183     0       0       1.05
2.4.20 [5]              36.9    189     0       0       1.02

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              35.9    193     0       0       0.99
2.4.20 [5]              35.8    194     0       0       0.99

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              49.8    140     20      57      1.38
2.4.20 [5]              51.0    138     20      59      1.41

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              159.4   45      0       40      4.40
2.4.20 [5]              144.8   49      0       38      4.00

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              44.4    163     1       11      1.23
2.4.20 [5]              43.1    169     1       11      1.19

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              49.2    144     1       10      1.36
2.4.20 [5]              63.5    114     1       12      1.75

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              162.3   45      28      19      4.48
2.4.20 [5]              164.9   45      31      21      4.55

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              62.3    117     11      20      1.72
2.4.20 [5]              89.6    86      17      21      2.47

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              60.2    123     9       7       1.66
2.4.20 [5]              51.0    143     7       7       1.41

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              40.3    174     0       8       1.11
2.4.20 [5]              40.4    175     0       8       1.12

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              53.7    133     36      3       1.48
2.4.20 [5]              52.0    139     37      3       1.44

Slowdown under IO load on same and other disks, and xtar load. Speedup with 
dbench load and read loads.


Hardware info and more detailed results can be found at:
http://www.osdl.org/projects/ctdevel/results/

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE958jtF6dfvkL3i1gRAugpAJ0c2yvtK/BZQCw2NDUkC9qQKE6X4wCaA6uY
6ZJk0TnX3j6tb2cDz0ZwK9g=
=T8S/
-----END PGP SIGNATURE-----
