Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267760AbTBELMa>; Wed, 5 Feb 2003 06:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267916AbTBELMa>; Wed, 5 Feb 2003 06:12:30 -0500
Received: from mail015.syd.optusnet.com.au ([210.49.20.173]:55756 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S267760AbTBELM2> convert rfc822-to-8bit; Wed, 5 Feb 2003 06:12:28 -0500
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.59-mm8 with contest
Date: Wed, 5 Feb 2003 22:21:49 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302052221.55663.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest benchmarks using osdl hardware. More resolution has been 
added to the io loads and read load (thanks Aggelos)

no_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       79      94.9    0.0     0.0     1.00
2.5.59-mm7      5       78      96.2    0.0     0.0     1.00
2.5.59-mm8      3       79      93.7    0.0     0.0     1.00
cacherun:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       76      98.7    0.0     0.0     0.96
2.5.59-mm7      5       75      98.7    0.0     0.0     0.96
2.5.59-mm8      3       76      97.4    0.0     0.0     0.96
process_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       92      81.5    28.3    16.3    1.16
2.5.59-mm7      3       95      77.9    33.7    18.9    1.22
2.5.59-mm8      3       195     37.9    205.3   60.5    2.47

seems the scheduler changes have changed the balance of what work is done with 
this process load. No cpu cycles are wasted so it is not necessarily a bad 
result.


ctar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       98      80.6    2.0     5.1     1.24
2.5.59-mm7      5       96      80.2    1.4     3.4     1.23
2.5.59-mm8      3       99      78.8    2.0     5.1     1.25
xtar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       101     75.2    1.0     4.0     1.28
2.5.59-mm7      5       96      79.2    0.8     3.3     1.23
2.5.59-mm8      3       100     77.0    1.0     4.0     1.27
io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       154     48.7    32.6    12.3    1.95
2.5.59-mm7      3       112     67.0    15.9    7.1     1.44
2.5.59-mm8      3       152     50.0    35.4    13.1    1.92

This seems to be creeping up to the same as 2.5.59


read_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       101     77.2    6.3     5.0     1.28
2.5.59-mm7      3       94      80.9    2.8     2.1     1.21
2.5.59-mm8      3       93      81.7    2.8     2.2     1.18
list_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       95      80.0    0.0     6.3     1.20
2.5.59-mm7      4       94      80.9    0.0     6.4     1.21
2.5.59-mm8      3       98      78.6    0.0     6.1     1.24
mem_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       97      80.4    56.7    2.1     1.23
2.5.59-mm7      4       92      82.6    45.5    1.4     1.18
2.5.59-mm8      3       97      80.4    53.3    2.1     1.23
dbench_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       126     60.3    3.3     22.2    1.59
2.5.59-mm7      4       121     62.0    2.8     24.8    1.55
2.5.59-mm8      3       212     35.8    11.0    47.2    2.68

and this seems to be taking significantly longer


io_other:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       89      84.3    11.2    5.4     1.13
2.5.59-mm7      3       92      81.5    12.6    6.5     1.18
2.5.59-mm8      3       115     67.8    35.2    18.3    1.46

And this load which normally changes little has significantly different 
results.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+QPPNF6dfvkL3i1gRAjh9AJ0VrUQBD9SbKX8jQNOtnYlwv0Ud2QCfdU+Q
k6hvNs0RWwIBc4PLSrc5eSo=
=ujgV
-----END PGP SIGNATURE-----
