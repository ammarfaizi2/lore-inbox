Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbSLSJEL>; Thu, 19 Dec 2002 04:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbSLSJEL>; Thu, 19 Dec 2002 04:04:11 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:2176 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267575AbSLSJEI> convert rfc822-to-8bit; Thu, 19 Dec 2002 04:04:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] scheduler tunables with contest - max_sleep_average
Date: Thu, 19 Dec 2002 20:14:17 +1100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212192014.25201.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are a set of contest results for 2.5.52-mm1 with max_sleep_average 
scheduler settings (default is 2000) using the osdl hardware 
(http://www.osdl.org)

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [8]          39.7    180     0       0       1.10
max_sle1000 [3]         40.0    179     0       0       1.10
max_sle4000 [4]         39.7    180     0       0       1.10
max_sle500 [3]          39.6    180     0       0       1.09

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          36.9    194     0       0       1.02
max_sle1000 [3]         36.8    194     0       0       1.02
max_sle4000 [4]         36.6    194     0       0       1.01
max_sle500 [3]          36.7    194     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          49.0    144     10      50      1.35
max_sle1000 [3]         52.8    133     14      61      1.46
max_sle4000 [4]         46.5    154     8       39      1.28
max_sle500 [3]          48.1    150     9       44      1.33

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          55.5    156     1       10      1.53
max_sle1000 [3]         53.2    161     1       10      1.47
max_sle4000 [4]         51.7    159     1       9       1.43
max_sle500 [3]          54.7    161     1       10      1.51

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          77.4    122     1       8       2.14
max_sle1000 [3]         82.6    117     1       9       2.28
max_sle4000 [3]         66.0    127     1       8       1.82
max_sle500 [3]          67.0    131     1       8       1.85

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          80.5    108     10      19      2.22
max_sle1000 [3]         89.9    94      14      21      2.48
max_sle4000 [3]         65.2    121     8       18      1.80
max_sle500 [3]          77.4    110     11      21      2.14

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          60.1    131     7       18      1.66
max_sle1000 [3]         66.3    127     9       20      1.83
max_sle4000 [3]         80.0    111     10      20      2.21
max_sle500 [3]          106.6   101     19      25      2.94

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          49.9    149     5       6       1.38
max_sle1000 [3]         50.2    148     5       6       1.39
max_sle4000 [3]         50.4    149     5       6       1.39
max_sle500 [3]          50.1    148     5       6       1.38

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          43.8    167     0       9       1.21
max_sle1000 [3]         43.7    167     0       9       1.21
max_sle4000 [3]         43.6    167     0       9       1.20
max_sle500 [3]          44.1    167     0       9       1.22

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm1 [7]          71.1    123     36      2       1.96
max_sle1000 [3]         103.3   81      36      2       2.85
max_sle4000 [3]         104.4   79      36      2       2.88
max_sle500 [3]          101.3   76      35      2       2.80

Pretty weird. No clear relationship with changes here except perhaps a 
proportional (small) change in ctar_load.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+AY3qF6dfvkL3i1gRAj1sAKCf80vYSSfEjl9SI3WFSOZE1HV6cgCggFgj
tivVtTQa/1wiytrsNyNAjow=
=rd8R
-----END PGP SIGNATURE-----
