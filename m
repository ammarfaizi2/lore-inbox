Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265733AbSJTCAD>; Sat, 19 Oct 2002 22:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265734AbSJTCAD>; Sat, 19 Oct 2002 22:00:03 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:55944 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S265733AbSJTCAA>;
	Sat, 19 Oct 2002 22:00:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.44 with contest
Date: Sun, 20 Oct 2002 12:05:53 +1000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210201206.00121.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the latest contest benchmark results including 2.5.44:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              71.8    93      0       0       1.01
2.5.38 [3]              72.0    93      0       0       1.01
2.5.39 [2]              72.2    93      0       0       1.01
2.5.40 [1]              72.5    93      0       0       1.02
2.5.41 [1]              73.8    93      0       0       1.03
2.5.42 [2]              72.5    93      0       0       1.02
2.5.43 [2]              74.6    92      0       0       1.04
2.5.43-mm2 [2]          73.4    93      0       0       1.03
2.5.44 [3]              74.6    93      0       0       1.04

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              106.5   59      112     43      1.49
2.5.38 [3]              89.5    74      34      28      1.25
2.5.39 [2]              91.2    73      36      28      1.28
2.5.40 [2]              82.8    80      25      23      1.16
2.5.41 [1]              91.1    73      38      30      1.28
2.5.42 [1]              98.0    69      44      33      1.37
2.5.43 [2]              99.7    71      44      31      1.40
2.5.43-mm2 [2]          105.8   71      44      31      1.48
2.5.44 [3]              90.9    76      32      26      1.27

This does appear to be significant. It does not appear to have returned to the 
performance of 2.5.40 though.

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              106.5   70      1       8       1.49
2.5.38 [1]              97.2    79      1       6       1.36
2.5.39 [1]              91.8    83      1       6       1.29
2.5.40 [1]              96.9    80      1       6       1.36
2.5.41 [1]              93.3    81      1       6       1.31
2.5.42 [1]              96.7    80      1       7       1.35
2.5.43 [1]              97.6    79      1       7       1.37
2.5.43-mm2 [1]          92.3    82      1       5       1.29
2.5.44 [3]              97.7    80      1       6       1.37

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              132.4   55      2       9       1.85
2.5.38 [1]              120.5   63      2       8       1.69
2.5.39 [1]              108.3   69      1       6       1.52
2.5.40 [1]              110.7   68      1       6       1.55
2.5.41 [2]              138.8   53      2       8       1.94
2.5.42 [1]              112.7   66      1       7       1.58
2.5.43 [1]              114.9   67      1       7       1.61
2.5.43-mm2 [2]          171.0   45      2       8       2.39
2.5.44 [3]              117.0   65      1       7       1.64

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              492.6   14      38      10      6.90
2.5.38 [1]              4000.0  1       500     1       56.02
2.5.39 [2]              423.9   18      30      11      5.94
2.5.40 [1]              315.7   25      22      10      4.42
2.5.41 [2]              607.5   13      47      12      8.51
2.5.42 [1]              849.1   9       69      12      11.89
2.5.43 [1]              578.9   13      45      12      8.11
2.5.43-mm2 [2]          301.1   26      21      11      4.22
2.5.44 [3]              873.8   9       69      12      12.24

This remains bad. IO writing is still choking the kernel.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              134.1   54      14      5       1.88
2.5.38 [2]              100.5   76      9       5       1.41
2.5.39 [2]              101.3   74      14      6       1.42
2.5.40 [1]              101.5   73      13      5       1.42
2.5.41 [1]              101.1   75      7       4       1.42
2.5.42 [1]              102.0   75      8       5       1.43
2.5.43 [3]              117.3   64      6       3       1.64
2.5.43-mm2 [1]          105.7   73      6       4       1.48
2.5.44 [3]              110.8   68      6       3       1.55

Coming back down after the rise at 2.5.43 but not to the levels of 2.5.42-

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              89.8    77      1       20      1.26
2.5.38 [1]              99.1    71      1       20      1.39
2.5.39 [1]              101.3   70      2       24      1.42
2.5.40 [1]              97.0    72      1       21      1.36
2.5.41 [1]              93.6    75      1       18      1.31
2.5.42 [1]              97.5    71      1       20      1.37
2.5.43 [2]              93.0    76      1       18      1.30
2.5.43-mm2 [1]          98.9    72      1       23      1.39
2.5.44 [3]              99.1    71      1       21      1.39

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              100.0   72      33      3       1.40
2.5.38 [3]              107.3   70      34      3       1.50
2.5.39 [2]              103.1   72      31      3       1.44
2.5.40 [2]              102.5   72      31      3       1.44
2.5.41 [1]              101.6   73      30      3       1.42
2.5.42 [1]              104.0   72      30      3       1.46
2.5.43 [1]              102.0   75      28      2       1.43
2.5.43-mm2 [2]          106.5   69      27      2       1.49
2.5.44 [3]              114.3   67      30      2       1.60

Slowed down here as well.


Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9sg+BF6dfvkL3i1gRArDsAJ9EmLDtLYj77n3G/JvmBwMp7SOfTACdFcC3
DUlvm2cpb6euJM5mFRUhZ10=
=vbkY
-----END PGP SIGNATURE-----
