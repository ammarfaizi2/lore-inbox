Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTJZKfx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 05:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTJZKfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 05:35:53 -0500
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:24971 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262836AbTJZKfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 05:35:47 -0500
Date: Sun, 26 Oct 2003 05:38:29 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031026103829.GA6549@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test8-mm1 doesn't have the AIM7 database regression
that 2.6.0-test8 has.  The AIM7 fileserver and shared 
workloads regression between test5-mm2 and test8-mm1 is
about 18%.  Mainline regression was about 38% between test5
and test8 on AIM7 fileserver and shared workloads.

AIM7 dbase workload
kernel                   Tasks   Jobs/Min        Real    CPU
2.6.0-test5-mm2          32	609.3		311.9	139.5
2.6.0-test8-mm1          32	608.2		312.6	133.5
2.6.0-test5              32	590.2		322.0	131.9
2.6.0-test8              32	299.8		634.0	128.6

2.6.0-test5-mm2          64	786.2		483.5	253.2
2.6.0-test8-mm1          64	784.3		484.7	256.6
2.6.0-test5              64	774.3		490.9	256.6
2.6.0-test8              64	450.5		843.9	246.5

2.6.0-test8-mm1          96	876.2		650.8	384.0
2.6.0-test5-mm2          96	869.2		656.0	382.2
2.6.0-test5              96	859.0		663.9	389.5
2.6.0-test8              96	549.7		1037.4	366.0

2.6.0-test5-mm2          128	929.4		818.0	526.1
2.6.0-test8-mm1          128	924.7		822.2	523.3
2.6.0-test5              128	910.3		835.2	528.6
2.6.0-test8              128	558.7		1360.8	497.6

2.6.0-test5-mm2          160	962.5		987.4	674.6
2.6.0-test8-mm1          160	959.8		990.2	664.5
2.6.0-test5              160	741.5		1281.7	644.8
2.6.0-test8              160	522.1		1820.2	612.2

2.6.0-test5-mm2          192	993.9		1147.5	810.0
2.6.0-test8-mm1          192	983.7		1159.3	806.0
2.6.0-test5              192	840.0		1357.8	776.0
2.6.0-test8              192	515.5		2212.4	742.7

2.6.0-test5-mm2          224	1011.2		1315.8	943.5
2.6.0-test8-mm1          224	1011.1		1315.9	918.0
2.6.0-test5              224	986.9		1348.2	911.8
2.6.0-test8              224	529.9		2510.8	859.5

2.6.0-test5-mm2          256	1030.9		1475.1	1076.5
2.6.0-test8-mm1          256	1023.2		1486.2	1078.5
2.6.0-test5              256	999.5		1521.3	1029.3
2.6.0-test8              256	552.4		2753.0	980.4


-mm regressed about 20% going from test5 to test8 in AIM7
fileserver workload.  Linus tree regressed about 38%.

AIM7 fserver workload
kernel                   Tasks   Jobs/Min        Real    CPU
2.6.0-test5              4	79.7		304.0	38.3
2.6.0-test5-mm2          4	77.4		313.4	38.3
2.6.0-test8-mm1          4	66.5		364.5	34.1
2.6.0-test8              4	42.3		573.6	40.9

2.6.0-test5              8	129.8		373.5	66.3
2.6.0-test5-mm2          8	103.1		470.4	62.0
2.6.0-test8-mm1          8	85.1		569.6	63.9
2.6.0-test8              8	63.3		765.7	71.6

2.6.0-test5              12	164.1		443.0	93.1
2.6.0-test5-mm2          12	112.4		646.8	98.4
2.6.0-test8-mm1          12	92.3		788.0	101.8
2.6.0-test8              12	83.2		874.2	95.0

2.6.0-test5              16	173.4		559.0	116.5
2.6.0-test5-mm2          16	128.8		752.9	119.9
2.6.0-test8-mm1          16	104.4		928.5	124.1
2.6.0-test8              16	87.5		1108.4	102.5

2.6.0-test5              20	180.5		671.5	143.0
2.6.0-test5-mm2          20	141.7		855.3	144.1
2.6.0-test8-mm1          20	116.6		1039.9	143.9
2.6.0-test8              20	105.0		1154.6	136.7

2.6.0-test5              24	189.1		769.0	176.0
2.6.0-test5-mm2          24	156.2		930.9	180.2
2.6.0-test8-mm1          24	127.1		1144.1	174.4
2.6.0-test8              24	111.2		1308.1	162.2

2.6.0-test5              28	204.6		829.2	197.5
2.6.0-test5-mm2          28	158.7		1069.2	209.8
2.6.0-test8-mm1          28	127.8		1327.5	203.8
2.6.0-test8              28	130.7		1297.9	185.8

2.6.0-test5              32	213.7		907.4	228.9
2.6.0-test5-mm2          32	151.9		1276.7	239.7
2.6.0-test8-mm1          32	123.2		1573.5	243.7
2.6.0-test8              32	134.2		1444.5	212.9

On the shared workload, Linus tree regressed about 38% between
test5 and test8.  The -mm tree only regressed about 16%.

AIM7 shared workload
kernel                   Tasks   Jobs/Min        Real    CPU
2.6.0-test5              64	1888.8		197.2	168.3
2.6.0-test5-mm2          64	1517.6		245.4	177.0
2.6.0-test8-mm1          64	1265.2		294.4	174.8
2.6.0-test8              64	829.1		449.3	167.8

2.6.0-test5              128	2094.9		355.6	338.1
2.6.0-test5-mm2          128	1837.4		405.4	352.4
2.6.0-test8-mm1          128	1558.3		478.1	348.9
2.6.0-test8              128	1105.2		674.1	330.5

2.6.0-test5              192	2256.0		495.3	507.8
2.6.0-test5-mm2          192	2074.9		538.5	530.9
2.6.0-test8-mm1          192	1755.2		636.6	526.9
2.6.0-test8              192	1320.0		846.6	504.7

2.6.0-test5              256	2389.0		623.7	683.8
2.6.0-test5-mm2          256	2207.2		675.0	720.6
2.6.0-test8-mm1          256	1855.2		803.1	708.4
2.6.0-test8              256	1462.1		1019.0	672.7

2.6.0-test5              320	2457.9		757.7	856.6
2.6.0-test5-mm2          320	2327.9		800.0	919.4
2.6.0-test8-mm1          320	1958.4		951.0	894.6
2.6.0-test8              320	1573.0		1184.0	845.2

2.6.0-test5              384	2480.4		901.0	1036.5
2.6.0-test5-mm2          384	2440.2		915.9	1111.6
2.6.0-test8-mm1          384	1997.9		1118.6	1087.2
2.6.0-test8              384	1601.1		1395.9	1028.7

2.6.0-test5              448	2529.8		1030.7	1209.2
2.6.0-test5-mm2          448	2510.0		1038.8	1306.1
2.6.0-test8-mm1          448	2030.0		1284.4	1279.6
2.6.0-test8              448	1659.7		1571.0	1205.2

2.6.0-test5              512	2566.2		1161.2	1386.2
2.6.0-test5-mm2          512	2579.1		1155.4	1504.0
2.6.0-test8-mm1          512	2046.4		1456.1	1481.3
2.6.0-test8              512	1614.4		1845.8	1381.5


The big increase in max latency on tiobench sequential reads at
256 threads affects both test8 and test8-mm1.

tiobench-0.3.3
File size = 8192 megabytes
Blk Size  = 4096 bytes

Sequential Reads ext2
                    Num                    Avg       Maximum     Lat%
Kernel              Thr   Rate  (CPU%)   Latency     Latency      >2s
------------------  ---  --------------------------------------------
2.6.0-test5           1   28.55 13.89%     0.408      754.59  0.00000
2.6.0-test5-mm2       1   28.66 13.98%     0.406      742.76  0.00000
2.6.0-test8           1   28.66 13.57%     0.406     1010.39  0.00000
2.6.0-test8-mm1       1   28.53 13.79%     0.408      977.75  0.00000

2.6.0-test5           8   34.01 17.09%     2.620      834.85  0.00000
2.6.0-test5-mm2       8   32.44 16.44%     2.765      844.99  0.00000
2.6.0-test8           8   20.83  9.82%     4.437     1626.42  0.00000
2.6.0-test8-mm1       8   21.31 10.27%     4.334     1669.82  0.00000

2.6.0-test5          16   30.13 15.04%     5.980     1337.69  0.00000
2.6.0-test5-mm2      16   29.71 14.97%     6.024     1115.95  0.00000
2.6.0-test8          16   15.88  7.53%    11.604     2888.67  0.00000
2.6.0-test8-mm1      16   16.40  7.93%    11.203     2954.75  0.00000

2.6.0-test5          32   29.46 14.62%    11.954     1560.02  0.00000
2.6.0-test5-mm2      32   28.01 14.26%    12.808     1627.00  0.00000
2.6.0-test8          32   16.17  7.55%    22.170     5119.98  0.00000
2.6.0-test8-mm1      32   15.78  7.74%    23.080     4826.59  0.00000

2.6.0-test5          64   25.24 13.57%    26.901     1743.05  0.00000
2.6.0-test5-mm2      64   24.01 13.27%    27.922     1849.82  0.00000
2.6.0-test8          64    8.71  4.78%    82.514    11744.03  3.04523
2.6.0-test8-mm1      64    9.06  5.13%    79.839     9458.66  2.92964

2.6.0-test5         128   10.41  9.76%   129.662     1820.78  0.00000
2.6.0-test5-mm2     128   11.00 10.44%   120.118     1742.44  0.00000
2.6.0-test8         128    3.04  2.64%   466.928    26583.72  8.12159
2.6.0-test8-mm1     128    3.00  2.78%   476.711    22323.98  8.28352

2.6.0-test5         256    9.13 13.30%   305.097     1446.43  0.00000
2.6.0-test5-mm2     256    9.09 13.60%   304.019     1648.80  0.00000
2.6.0-test8         256    2.66  2.41%   960.563   679406.45  9.02886
2.6.0-test8-mm1     256    2.80  2.61%   916.388   678138.20  8.60138


test8 and test8-mm1 have an increase in requests taking more than 2 
seconds on tiobench random reads at 256 threads.  -mm1 regressed less
than mainline between test5 and test8.

Random Reads ext2
                    Num                    Avg       Maximum     Lat%
Kernel              Thr   Rate  (CPU%)   Latency     Latency      >2s
------------------  ---  --------------------------------------------
2.6.0-test5           1    0.95  0.94%    12.373      114.89  0.00000
2.6.0-test5-mm2       1    0.90  0.88%    13.061      113.19  0.00000
2.6.0-test8           1    0.95  0.85%    12.360      113.96  0.00000
2.6.0-test8-mm1       1    0.89  0.88%    13.222      107.35  0.00000

2.6.0-test5           8    4.11  4.58%    19.433      137.74  0.00000
2.6.0-test5-mm2       8    3.94  4.03%    20.931      144.16  0.00000
2.6.0-test8           8    3.52  3.59%    25.298      477.80  0.00000
2.6.0-test8-mm1       8    4.51  4.80%    19.777      299.43  0.00000

2.6.0-test5          16    4.05  3.90%    42.424      236.49  0.00000
2.6.0-test5-mm2      16    4.09  4.31%    41.651      255.17  0.00000
2.6.0-test8          16    3.92  3.56%    45.278      843.31  0.00000
2.6.0-test8-mm1      16    4.11  3.46%    42.043      608.63  0.00000

2.6.0-test5          32    4.41  3.58%    70.910      516.28  0.00000
2.6.0-test5-mm2      32    4.23  4.17%    78.492      372.63  0.00000
2.6.0-test8          32    4.25  3.45%    77.345     1324.85  0.00000
2.6.0-test8-mm1      32    3.70  3.69%    91.986     1270.38  0.00000

2.6.0-test5          64    4.47  4.00%   137.277     1077.53  0.00000
2.6.0-test5-mm2      64    4.79  4.53%   124.035     1144.38  0.00000
2.6.0-test8          64    3.57  3.32%   181.257     3029.47  0.00000
2.6.0-test8-mm1      64    3.66  3.24%   175.724     2493.85  0.00000

2.6.0-test5         128    4.86  4.83%   243.704     2287.09  0.00000
2.6.0-test5-mm2     128    5.08  4.85%   228.102     2391.21  0.00000
2.6.0-test8         128    3.28  3.08%   379.081     5007.00  0.00000
2.6.0-test8-mm1     128    3.40  3.52%   372.210     4671.71  0.00000

2.6.0-test5         256    5.51  7.00%   427.503     2511.79  0.00000
2.6.0-test5-mm2     256    5.23  7.39%   449.007     3169.28  0.00000
2.6.0-test8         256    2.07  2.40%  1162.555    13971.08 16.95313
2.6.0-test8-mm1     256    2.36  2.99%  1019.360    10935.31 10.65104

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

