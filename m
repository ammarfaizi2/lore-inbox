Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbTAEMYt>; Sun, 5 Jan 2003 07:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTAEMYt>; Sun, 5 Jan 2003 07:24:49 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:16009 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S264672AbTAEMYr> convert rfc822-to-8bit;
	Sun, 5 Jan 2003 07:24:47 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.54-mm3 with contest
Date: Sun, 5 Jan 2003 23:33:04 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301052333.20853.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest benchmarks for the -mm* series (offline for holidays and with 
a mem leak so no results for mm1/2)

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              70.1    96      0       0       1.05
2.5.53-mm1 [7]          71.0    96      0       0       1.06
2.5.54 [5]              70.0    96      0       0       1.05
2.5.54-mm3 [5]          70.1    96      0       0       1.05

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              67.6    99      0       0       1.01
2.5.53-mm1 [7]          68.5    99      0       0       1.03
2.5.54 [5]              67.6    99      0       0       1.01
2.5.54-mm3 [5]          67.5    99      0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              86.9    77      18      21      1.30
2.5.53-mm1 [7]          117.1   58      47      40      1.75
2.5.54 [5]              85.5    78      17      19      1.28
2.5.54-mm3 [5]          87.2    77      18      21      1.31
Whatever that change was in .53-mm1 has reverted back to previous results


dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.54 [5]              216.8   37      2       52      3.25
2.5.54-mm3 [5]          195.7   39      2       48      2.93

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              107.4   81      3       9       1.61
2.5.53-mm1 [7]          103.1   79      3       10      1.54
2.5.54 [4]              102.7   82      3       9       1.54
2.5.54-mm3 [5]          103.8   81      3       9       1.55

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              151.0   69      3       8       2.26
2.5.53-mm1 [7]          150.2   66      2       7       2.25
2.5.54 [4]              159.3   71      3       8       2.39
2.5.54-mm3 [5]          124.1   69      2       7       1.86
speedup here


io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              113.9   63      12      12      1.71
2.5.53-mm1 [7]          133.1   57      23      17      1.99
2.5.54 [4]              121.0   61      13      12      1.81
2.5.54-mm3 [5]          128.6   57      15      13      1.93

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              99.5    73      8       10      1.49
2.5.53-mm1 [7]          107.7   70      18      17      1.61
2.5.54 [4]              96.0    74      8       9       1.44
2.5.54-mm3 [5]          99.8    71      9       11      1.49

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              88.2    80      15      6       1.32
2.5.53-mm1 [7]          89.6    80      12      6       1.34
2.5.54 [4]              87.7    81      14      6       1.31
2.5.54-mm3 [5]          91.5    77      13      6       1.37

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              81.5    85      0       9       1.22
2.5.53-mm1 [7]          82.1    85      0       9       1.23
2.5.54 [4]              81.3    85      0       9       1.22
2.5.54-mm3 [5]          81.4    85      0       9       1.22

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.53 [7]              98.7    80      44      2       1.48
2.5.53-mm1 [7]          110.9   67      41      1       1.66
2.5.54 [4]              98.2    80      45      2       1.47
2.5.54-mm3 [5]          108.7   70      46      2       1.63

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+GCYAF6dfvkL3i1gRAsCIAJ92Fdq4L/KouJ+KCmxn68lSXw7jXACgojkb
xFpknpj5NhTKYFpG07w818M=
=SD7Z
-----END PGP SIGNATURE-----
