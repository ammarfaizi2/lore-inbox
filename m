Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262068AbSJEF4p>; Sat, 5 Oct 2002 01:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262069AbSJEF4p>; Sat, 5 Oct 2002 01:56:45 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:20864 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262068AbSJEF4o> convert rfc822-to-8bit; Sat, 5 Oct 2002 01:56:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] contest 0.50 results to date
Date: Sat, 5 Oct 2002 15:59:24 +1000
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>,
       Rodrigo Souza de Castro <rcastro@ime.usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210051559.38887.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are the updated contest (http://contest.kolivas.net) benchmarks with 
version 0.50

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              67.7    98      0       0       1.01
2.4.19-cc [3]           67.9    97      0       0       1.01
2.5.38 [3]              72.0    93      0       0       1.07
2.5.38-mm3 [2]          71.8    93      0       0       1.07
2.5.39 [2]              72.2    93      0       0       1.07
2.5.39-mm1 [2]          72.3    93      0       0       1.08
2.5.40 [1]              72.5    93      0       0       1.08
2.5.40-mm1 [1]          72.9    93      0       0       1.09

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              106.5   59      112     43      1.59
2.4.19-cc [3]           105.0   59      110     42      1.56
2.5.38 [3]              89.5    74      34      28      1.33
2.5.38-mm3 [1]          86.0    78      29      25      1.28
2.5.39 [2]              91.2    73      36      28      1.36
2.5.39-mm1 [2]          92.0    73      37      29      1.37
2.5.40 [2]              82.8    80      25      23      1.23
2.5.40-mm1 [2]          86.9    77      30      25      1.29

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              492.6   14      38      10      7.33
2.4.19-cc [3]           156.0   48      12      10      2.32
2.5.38 [1]              4000.0  1       500     1       59.55
2.5.38-mm3 [1]          303.5   25      23      11      4.52
2.5.39 [2]              423.9   18      30      11      6.31
2.5.39-mm1 [2]          550.7   14      44      12      8.20
2.5.40 [1]              315.7   25      22      10      4.70
2.5.40-mm1 [1]          326.2   24      23      11      4.86

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              100.0   72      33      3       1.49
2.4.19-cc [3]           92.7    76      146     21      1.38
2.5.38 [3]              107.3   70      34      3       1.60
2.5.38-mm3 [1]          100.3   72      27      2       1.49
2.5.39 [2]              103.1   72      31      3       1.53
2.5.39-mm1 [2]          103.3   72      32      3       1.54
2.5.40 [2]              102.5   72      31      3       1.53
2.5.40-mm1 [2]          107.7   68      29      2       1.60

Note the io_load value for 2.5.38 was an estimate as every time I tried to run 
it it took too long and I stopped it (the longest I waited was 4000 seconds); 
showing very clearly the write starves read problem.

Of most interest is the performance of 2.4.19 with the latest version of 
compressed cache under mem_load (2.4.19-cc). Note that although the 
performance is only slightly better timewise, the difference in actual work 
done by the background load during that time is _enormous_. This demonstrates 
most clearly the limitations in previous versions of contest.

Comments?
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9nn+8F6dfvkL3i1gRApHxAJ9CANpp1CA+chu+DxEghiNXgP0VjwCfdHsm
qf7yp7W6sBOnkNx/cmTLPQY=
=7oEd
-----END PGP SIGNATURE-----
