Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbTCSBhU>; Tue, 18 Mar 2003 20:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbTCSBhU>; Tue, 18 Mar 2003 20:37:20 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:41608 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262876AbTCSBhR> convert rfc822-to-8bit;
	Tue, 18 Mar 2003 20:37:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.65-mm1 with contest
Date: Wed, 19 Mar 2003 12:47:48 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200303191248.12296.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are a set of contest benchmarks for 2.5.65-mm1. A big gap in results 
prior to this because of scheduler based hangs and anticipatory scheduler 
(AS) bugs which seem to have been ironed out. These results are with the AS.

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   79      94.9    0.0     0.0     1.00
2.5.64-mm1          5   81      91.4    0.0     0.0     1.00
2.5.65              3   80      95.0    0.0     0.0     1.00
2.5.65-mm1          3   79      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   75      98.7    0.0     0.0     0.95
2.5.64-mm1          5   75      98.7    0.0     0.0     0.93
2.5.65              3   76      98.7    0.0     0.0     0.95
2.5.65-mm1          3   76      98.7    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   92      81.5    30.0    16.3    1.16
2.5.64-mm1          5   94      78.7    30.2    18.1    1.16
2.5.65              3   243     30.5    317.0   68.3    3.04
2.5.65-mm1          3   241     30.7    309.7   67.6    3.05
ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   100     79.0    0.0     0.0     1.27
2.5.64-mm1          5   114     69.3    0.8     4.4     1.41
2.5.65              3   108     72.2    0.0     0.0     1.35
2.5.65-mm1          3   113     69.9    1.0     6.2     1.43
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   103     73.8    1.0     3.9     1.30
2.5.64-mm1          5   112     67.9    1.0     4.5     1.38
2.5.65              3   106     71.7    1.0     3.8     1.32
2.5.65-mm1          3   110     70.0    1.0     4.5     1.39
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   229     33.2    58.8    14.8    2.90
2.5.64-mm1          5   97      77.3    13.6    6.2     1.20
2.5.65              3   411     19.0    137.5   20.4    5.14
2.5.65-mm1          3   139     56.1    49.4    20.9    1.76
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   100     75.0    18.4    9.0     1.27
2.5.64-mm1          5   93      80.6    13.7    7.5     1.15
2.5.65              3   164     47.6    71.7    26.2    2.05
2.5.65-mm1          3   134     58.2    60.4    27.6    1.70
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   103     76.7    6.2     4.9     1.30
2.5.64-mm1          5   115     68.7    8.2     6.1     1.42
2.5.65              3   107     72.9    6.3     4.7     1.34
2.5.65-mm1          3   124     62.9    9.5     6.5     1.57
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   96      79.2    0.0     6.2     1.22
2.5.64-mm1          5   100     76.0    0.0     7.0     1.23
2.5.65              3   98      78.6    0.0     7.1     1.23
2.5.65-mm1          3   97      79.4    0.0     7.2     1.23
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   105     74.3    58.3    1.9     1.33
2.5.64-mm1          5   111     70.3    63.2    1.8     1.37
2.5.65              3   112     70.5    67.3    2.7     1.40
2.5.65-mm1          3   103     76.7    53.3    1.9     1.30
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.64              3   222     34.2    2.3     38.7    2.81
2.5.64-mm1          5   231     32.9    2.6     42.0    2.85
2.5.65              3   542     14.2    9.0     62.5    6.78
2.5.65-mm1          3   361     21.1    6.3     55.4    4.57

The same scheduler tweak changes are evident in mm1 as 2.5.65. The AS seems to 
cause a nice drop in io based loads proportionately compared to vanilla, but 
longer than before because of the scheduler changes. Read load, which rose 
with the earlier incarnation of the AS has risen again, but not too 
dramatically. Mem load has dropped - the vm hacks?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+d8xKF6dfvkL3i1gRAsW9AJ99iDw0Wbgijxo8a0saFEcMje2wFwCdEUxw
JMaGw3HB4rAihnThEFExPrY=
=L3w7
-----END PGP SIGNATURE-----

