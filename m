Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266639AbSKGWrm>; Thu, 7 Nov 2002 17:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266641AbSKGWrm>; Thu, 7 Nov 2002 17:47:42 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3200 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S266639AbSKGWrj> convert rfc822-to-8bit; Thu, 7 Nov 2002 17:47:39 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.46-mm1 with contest
Date: Fri, 8 Nov 2002 09:53:18 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211080953.22903.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest results showing 2.5.46-mm1 with preempt enabled. The other 
kernels have it disabled.

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          75.7    91      0       0       1.06
2.5.46 [2]              74.1    92      0       0       1.04
2.5.46-mm1 [5]          74.0    93      0       0       1.04

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          69.3    99      0       0       0.97
2.5.46 [2]              67.9    99      0       0       0.95
2.5.46-mm1 [5]          68.9    99      0       0       0.96

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          190.6   36      166     63      2.67
2.5.45 [5]              91.0    75      33      27      1.27
2.5.46 [1]              92.9    74      36      29      1.30
2.5.46-mm1 [5]          82.7    82      21      21      1.16

Much improved 

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          97.3    79      1       5       1.36
2.5.46 [1]              98.3    80      1       7       1.38
2.5.46-mm1 [5]          95.3    80      1       5       1.33

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          207.6   37      2       7       2.91
2.5.46 [1]              113.5   67      1       8       1.59
2.5.46-mm1 [5]          227.1   34      3       7       3.18

Whatever was causing this to be high in 2.5.44-mm6 is still there now.

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          284.1   28      20      10      3.98
2.5.46 [1]              600.5   13      48      12      8.41
2.5.46-mm1 [5]          134.3   58      6       8       1.88

Big change here. IO load is usually the one we feel the most.

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          104.3   73      7       4       1.46
2.5.46 [1]              103.5   75      7       4       1.45
2.5.46-mm1 [5]          103.2   74      6       4       1.45

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          95.3    75      1       20      1.33
2.5.46 [1]              96.8    74      2       22      1.36
2.5.46-mm1 [5]          101.4   70      1       22      1.42

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          226.9   33      50      2       3.18
2.5.46 [3]              148.0   51      34      2       2.07
2.5.46-mm1 [5]          180.5   41      35      1       2.53

And this remains relatively high but better than 2.5.44-mm6

Unfortunately I've only run this with preempt enabled so far and I believe 
many of the improvements are showing this effect.

Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9yu7eF6dfvkL3i1gRAqGIAJ9f6XFfwO0sQOVBn5qZPfAFY5JdlwCggOZt
WXizAEgC23W+AURXApih9xc=
=MCT0
-----END PGP SIGNATURE-----

