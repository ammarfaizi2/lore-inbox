Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSK0VkO>; Wed, 27 Nov 2002 16:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSK0VkN>; Wed, 27 Nov 2002 16:40:13 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:9126 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S264857AbSK0VkM>;
	Wed, 27 Nov 2002 16:40:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.4.19-rmap15a with contest
Date: Thu, 28 Nov 2002 08:47:24 +1100
User-Agent: KMail/1.4.3
Cc: Rik van Riel <riel@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211280847.29690.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a set of contest benchmarks and related results for rmap15a

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [5]              69.0    97      0       0       0.95
2.4.19-rmap15 [3]       73.1    92      0       0       1.01
2.4.19-rmap15a [5]      73.9    92      0       0       1.02

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              68.0    99      0       0       0.94
2.4.19-rmap15 [3]       67.7    99      0       0       0.94
2.4.19-rmap15a [5]      67.8    99      0       0       0.94

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              106.5   59      112     43      1.47
2.4.19-rmap15 [3]       112.7   56      123     44      1.56
2.4.19-rmap15a [5]      113.9   56      126     45      1.58

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              342.6   20      1       62      4.74
2.4.19-rmap15 [3]       358.0   20      1       50      4.95
2.4.19-rmap15a [5]      318.1   22      1       35      4.40

slightly faster than rmap15 here


ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              106.5   70      1       8       1.47
2.4.19-rmap15 [3]       98.4    77      1       6       1.36
2.4.19-rmap15a [5]      99.5    75      1       5       1.38

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              132.4   55      2       9       1.83
2.4.19-rmap15 [3]       130.2   55      1       19      1.80
2.4.19-rmap15a [5]      143.7   51      2       6       1.99

slightly slower than rmap15 here


io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              492.6   14      38      10      6.81
2.4.19-rmap15 [3]       222.9   33      13      9       3.08
2.4.19-rmap15a [5]      209.9   35      12      9       2.90

a little faster than rmap15 here (and a lot faster than vanilla)


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [2]              134.1   54      14      5       1.85
2.4.19-rmap15 [3]       129.5   56      20      5       1.79
2.4.19-rmap15a [5]      119.0   61      9       4       1.65

a little faster during large reads


list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [1]              89.8    77      1       20      1.24
2.4.19-rmap15 [3]       90.4    76      0       12      1.25
2.4.19-rmap15a [5]      90.8    76      0       12      1.26

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              100.0   72      33      3       1.38
2.4.19-rmap15 [3]       105.3   72      37      5       1.46
2.4.19-rmap15a [5]      111.4   66      31      3       1.54

Seems a little slower here. I wonder if it's just because of the artificial 
nature of the actual memory load used in the test, or if it's a true slowdown 
during periods of memory stress?


These contest benchmarks for rmap15a show only small differences between 
rmap15 and rmap15a with more speedups than slowdowns.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE95T1tF6dfvkL3i1gRAvOeAJ4xB9rrlZfBbqLC9MeP3+Uwg/OQbACfZCNy
hxR1hdeR9+4E7JTiAJ7R3vo=
=2H4s
-----END PGP SIGNATURE-----
