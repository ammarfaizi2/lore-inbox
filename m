Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbSKWMVw>; Sat, 23 Nov 2002 07:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbSKWMVw>; Sat, 23 Nov 2002 07:21:52 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:6017 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S266989AbSKWMVv> convert rfc822-to-8bit; Sat, 23 Nov 2002 07:21:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
Date: Sat, 23 Nov 2002 23:30:27 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>
Subject: [BENCHMARK] 2.4.19-rmap15 with contest
Message-Id: <200211232330.38419.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a set of contest (http://contest.kolivas.net) benchmarks for 
2.4.19-rmap15

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [5]              71.7    93      0       0       0.99
2.4.19 [5]              69.0    97      0       0       0.95
2.4.19-rmap15 [3]       73.1    92      0       0       1.01

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [2]              66.6    99      0       0       0.92
2.4.19 [2]              68.0    99      0       0       0.94
2.4.19-rmap15 [3]       67.7    99      0       0       0.94

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              109.5   57      119     44      1.51
2.4.19 [3]              106.5   59      112     43      1.47
2.4.19-rmap15 [3]       112.7   56      123     44      1.56

Marginally slower here.


ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              117.4   63      1       7       1.62
2.4.19 [2]              106.5   70      1       8       1.47
2.4.19-rmap15 [3]       98.4    77      1       6       1.36

First significant difference. Notably faster while creating tars.


xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              150.8   49      2       8       2.09
2.4.19 [1]              132.4   55      2       9       1.83
2.4.19-rmap15 [3]       130.2   55      1       19      1.80

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              474.1   15      36      10      6.56
2.4.19 [3]              492.6   14      38      10      6.81
2.4.19-rmap15 [3]       222.9   33      13      9       3.08

Well this is nice. io_load is the most felt of the slowdowns and rmap manages 
to blunt the effect io load has (note io load uses quite a bit of ram to do 
the io load).


read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              102.3   70      6       3       1.41
2.4.19 [2]              134.1   54      14      5       1.85
2.4.19-rmap15 [3]       129.5   56      20      5       1.79

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              90.2    76      1       17      1.25
2.4.19 [1]              89.8    77      1       20      1.24
2.4.19-rmap15 [3]       90.4    76      0       12      1.25

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.18 [3]              103.3   70      32      3       1.43
2.4.19 [3]              100.0   72      33      3       1.38
2.4.19-rmap15 [3]       105.3   72      37      5       1.46

Note that while mem_load is marginally slower with rmap, the machine was in a 
much more usable state after running the mem_load. Much less was coming back 
from swap upon using it after the benchmark, and contest cant show this 
effect.


Looking good Rik.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE933TmF6dfvkL3i1gRAsPGAJsGcgRoKaMUtIVebjIHlFeyuzBgeACePG7N
GUhW6kzYg7amphsfe4W5GQ4=
=+NY1
-----END PGP SIGNATURE-----
