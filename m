Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTARNmY>; Sat, 18 Jan 2003 08:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTARNmY>; Sat, 18 Jan 2003 08:42:24 -0500
Received: from mail020.syd.optusnet.com.au ([210.49.20.135]:9451 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S264739AbTARNmW> convert rfc822-to-8bit; Sat, 18 Jan 2003 08:42:22 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.59{-mm2} with contest
Date: Sun, 19 Jan 2003 00:50:49 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301190051.13781.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest (http://contest.kolivas.net) benchmarks with the osdl 
(http://www.osdl.org) hardware on 2.5.59 and mm2:

no_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       74      95.9    0       0.0     1.00
2.5.58-mm1      3       74      94.6    0       0.0     1.00
2.5.59          3       74      94.6    0       0.0     1.00
2.5.59-mm2      4       74      95.9    0       0.0     1.00
cacherun:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       73      97.3    0       0.0     0.99
2.5.58-mm1      3       72      97.2    0       0.0     0.97
2.5.59          3       72      97.2    0       0.0     0.97
2.5.59-mm2      3       72      98.6    0       0.0     0.97
process_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       89      79.8    28      16.9    1.20
2.5.58-mm1      3       87      80.5    26      16.1    1.18
2.5.59          3       88      80.7    27      15.9    1.19
2.5.59-mm2      3       89      79.8    29      18.0    1.20
ctar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       107     82.2    2       6.5     1.45
2.5.58-mm1      3       102     80.4    2       7.8     1.38
2.5.59          3       106     81.1    2       7.5     1.43
2.5.59-mm2      3       97      77.3    1       4.1     1.31
xtar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       119     78.2    1       5.9     1.61
2.5.58-mm1      3       107     79.4    1       5.6     1.45
2.5.59          3       118     78.0    1       5.9     1.59
2.5.59-mm2      3       99      73.7    1       6.1     1.34
io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       136     58.8    6       12.4    1.84
2.5.58-mm1      3       138     55.8    7       13.0    1.86
2.5.59          4       113     68.1    4       9.7     1.53
2.5.59-mm2      3       563     12.8    38      17.4    7.61
read_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       96      81.2    6       6.2     1.30
2.5.58-mm1      3       97      79.4    6       6.2     1.31
2.5.59          3       96      79.2    6       6.2     1.30
2.5.59-mm2      3       137     54.7    9       6.6     1.85
list_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       87      83.9    0       8.0     1.18
2.5.58-mm1      3       87      83.9    0       8.0     1.18
2.5.59          3       87      83.9    0       8.0     1.18
2.5.59-mm2      2       87      83.9    0       8.0     1.18
mem_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       97      77.3    46      1.0     1.31
2.5.58-mm1      3       100     73.0    50      1.0     1.35
2.5.59          3       99      74.7    48      1.0     1.34
2.5.59-mm2      3       95      76.8    48      1.0     1.28
dbench_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.58          3       120     63.3    3       21.7    1.62
2.5.58-mm1      3       122     60.7    3       23.8    1.65
2.5.59          3       108     69.4    2       15.7    1.46
2.5.59-mm2      3       120     60.0    3       26.7    1.62

HELLO! Something going on here. Went back and repeated results and looked 
carefully - can't see any funny business going on at my end. Modest changes 
from 2.5.58-59 and big changes with -mm2.

Full details and archived results available at:
http://www.osdl.org/projects/ctdevel/results/
Only results with current version of contest and hardware setup are kept 
there.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+KVu7F6dfvkL3i1gRAkiXAJsHQYc1QWioZRGiap9+6STXcywVtwCdFmOW
oZ/gfmCZTA4C6WZPGYcPToQ=
=vV66
-----END PGP SIGNATURE-----
