Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTFBVwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFBVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:52:16 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:11502 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264126AbTFBVwK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:52:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.70-mm2 with contest
Date: Tue, 3 Jun 2003 08:06:42 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306030806.49885.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

no_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              1   80      93.8    0.0     0.0     1.00
2.5.69-mm3          1   79      94.9    0.0     0.0     1.00
2.5.69-mm5          1   79      94.9    0.0     0.0     1.00
2.5.69-mm6          1   78      96.2    0.0     0.0     1.00
2.5.70              1   79      94.9    0.0     0.0     1.00
2.5.70-mm2          1   78      94.9    0.0     0.0     1.00
cacherun:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              1   76      98.7    0.0     0.0     0.95
2.5.69-mm3          1   76      98.7    0.0     0.0     0.96
2.5.69-mm5          1   76      98.7    0.0     0.0     0.96
2.5.69-mm6          1   76      98.7    0.0     0.0     0.97
2.5.70              1   75      98.7    0.0     0.0     0.95
2.5.70-mm2          1   75      98.7    0.0     0.0     0.96
process_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              2   181     41.4    196.5   58.0    2.26
2.5.69-mm3          2   176     42.0    183.0   56.2    2.23
2.5.69-mm5          2   176     42.6    182.5   55.7    2.23
2.5.69-mm6          2   176     42.0    184.5   55.7    2.26
2.5.70              2   109     67.9    63.5    28.4    1.38
2.5.70-mm2          2   108     68.5    65.5    28.7    1.38
Same changes put into 2.5.70 are evident in mm2

ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              3   103     75.7    0.0     0.0     1.29
2.5.69-mm3          3   126     63.5    1.0     4.8     1.59
2.5.69-mm5          3   114     70.2    1.0     5.3     1.44
2.5.69-mm6          3   112     70.5    1.0     5.4     1.44
2.5.70              3   103     75.7    0.0     0.0     1.30
2.5.70-mm2          3   118     66.9    1.0     5.1     1.51
probably not statistically significant

xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              3   106     72.6    1.0     3.7     1.32
2.5.69-mm3          3   111     69.4    1.7     4.5     1.41
2.5.69-mm5          3   102     75.5    1.0     4.9     1.29
2.5.69-mm6          3   107     72.0    1.3     4.7     1.37
2.5.70              3   106     72.6    1.0     3.8     1.34
2.5.70-mm2          3   123     61.8    2.0     4.8     1.58
small rise in time with multiple small file extraction

io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              4   343     22.7    120.5   19.8    4.29
2.5.69-mm3          4   319     24.5    105.3   18.1    4.04
2.5.69-mm5          4   137     56.9    49.6    19.0    1.73
2.5.69-mm6          4   150     52.0    53.4    18.7    1.92
2.5.70              5   326     21.5    112.9   18.7    4.13
2.5.70-mm2          4   115     67.0    42.0    19.1    1.47
large drop in time with one large file write

io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              2   127     61.4    55.5    24.4    1.59
2.5.69-mm3          2   133     58.6    47.1    18.7    1.68
2.5.69-mm5          2   115     67.8    46.4    20.7    1.46
2.5.69-mm6          2   120     65.0    50.9    21.5    1.54
2.5.70              2   122     63.9    53.8    22.1    1.54
2.5.70-mm2          2   113     68.1    46.2    20.4    1.45
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              2   104     75.0    6.3     4.8     1.30
2.5.69-mm3          2   113     69.9    9.1     6.1     1.43
2.5.69-mm5          2   113     69.9    9.0     6.2     1.43
2.5.69-mm6          2   115     68.7    9.1     6.1     1.47
2.5.70              2   104     75.0    6.3     4.8     1.32
2.5.70-mm2          2   106     73.6    8.2     5.7     1.36
seems to correlate with .70 changes

list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              2   95      81.1    0.0     5.3     1.19
2.5.69-mm3          2   95      81.1    0.0     7.4     1.20
2.5.69-mm5          2   96      80.2    0.0     7.3     1.22
2.5.69-mm6          2   96      80.2    0.0     7.3     1.23
2.5.70              2   96      80.2    0.0     7.3     1.22
2.5.70-mm2          2   94      81.9    0.0     7.4     1.21
mem_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              2   98      79.6    60.5    2.0     1.23
2.5.69-mm3          2   135     59.3    77.0    2.2     1.71
2.5.69-mm5          2   99      79.8    53.0    2.0     1.25
2.5.69-mm6          2   100     79.0    60.0    2.0     1.28
2.5.70              2   97      80.4    53.5    2.1     1.23
2.5.70-mm2          2   99      78.8    54.5    2.0     1.27
dbench_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.69              4   374     20.3    5.0     48.1    4.67
2.5.69-mm3          4   653     11.6    6.2     34.0    8.27
2.5.69-mm5          4   316     24.1    4.0     44.6    4.00
2.5.69-mm6          4   386     19.9    5.2     48.4    4.95
2.5.70              5   321     22.1    4.0     44.5    4.06
2.5.70-mm2          4   305     24.9    4.8     55.4    3.91

I tried getting runs on 2.5.69-mm9 and 2.5.70-mm1 but ran into BUGs that have 
been reported before on lkml.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+28p4F6dfvkL3i1gRAvsgAJ4mf8syPqOXkNt+tuNaoFgdMQZ8KQCdH/Er
wWRW9HrkWqpd9UTIeR/Lzz4=
=ly6r
-----END PGP SIGNATURE-----

