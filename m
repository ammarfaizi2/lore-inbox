Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVAOS7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVAOS7a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVAOS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 13:59:30 -0500
Received: from mproxy.gmail.com ([216.239.56.246]:27922 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262306AbVAOS7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 13:59:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CmWPxNmQlpMtaFEjIWVYLxozYNj/BJ9bwNGKeh5FXOTFBTX9irnKRsah4G1isFHqQVQmLha3WtgY+BjOV+6zk3kVKapHKTC23ITRRtqfPDPTKAesF+YnI/vVLyhI0ximFRPrNODSQoJuQHf4+lBfVma8jsqpB+Mz1JMA+3zi8oM=
Message-ID: <7f45d93905011510597f27ca00@mail.gmail.com>
Date: Sat, 15 Jan 2005 10:59:18 -0800
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Poor responsiveness during disk I/O
In-Reply-To: <200501151653.27921.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7f45d9390501141121269b42b2@mail.gmail.com>
	 <1105732650.6042.50.camel@laptopd505.fenrus.org>
	 <7f45d939050114135752a00033@mail.gmail.com>
	 <200501151653.27921.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005 16:53:26 +0200, Jan Knutar <jk-lkml@sci.fi> wrote:
> On Friday 14 January 2005 23:57, Shaun Jackman wrote:
> > Linux 2.6.8.1
> 
> A "vmstat 1" output during high load would be nice...

Here I'm running updatedb and opening firefox, which takes about 45
seconds to open. It's running on an Athlon 2400+ XP (2.0 GHz) with 256
MB RAM (PC2100) and 256 MB swap (ATA100).

Thanks,
Shaun


$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2  95216  44148  30752  20720  180    0  2176     0 1774  2384 89 11  0  0
 1  2  95356  45380  28460  20844  560  180  1576   544 1576  2252 69 31  0  0
 1  3  95356  44076  28520  21480  192    0  2296    72 1665  3937 90 10  0  0
 1  2  95548  45292  26472  22392    0  200  1752  1536 1466  2571 91  9  0  0
 2  1  95548  44340  26368  23788    0    0  2524     0 1566  3019 67 33  0  0
 4  1  95648  45068  24116  24292    0  424  2232   624 1722  3502 75 25  0  0
 1  2  95672  43924  23172  26696    0   36  3876   168 1651  3322 91  9  0  0
 1  2  95904  45420  22360  26464  116  296  1572   532 1519  2342 94  6  0  0
 1  2  96012  44412  23776  26804   48  112  2784   756 1884  3789 67 33  0  0
 2  2  96216  45756  21616  26964    0  232  1180   416 1535  2823 92  8  0  0
 1  2  96216  45596  22284  27588  156    0  1444     0 1471  8843 87 13  0  0
 1  2  96344  44196  21392  30276    0  220  3356   440 1437  2290 94  6  0  0
 1  2  97092  45148  20336  31524  184  824  2428  1436 1382  2312 68 32  0  0
 1  2  97268  45540  20224  32124  260  196  2092   580 1479  2424 91  9  0  0
 3  1  97452  45540  19804  32104    0  192  2372   324 1525  2766 92  8  0  0
 1  3  97752  44140  18468  35512    0  320  4848   360 1494  2746 70 30  0  0
 1  2  98228  45476  17712  35524    0  504  1428   888 1447  2364 90 10  0  0
 1  2  98228  44412  18164  35252    0    0  1392   448 1495  2852 91  9  0  0
 1  2  99076  45084  17864  35488    4 1052  2452  1532 1497  2424 91  9  0  0
 2  2  99624  45364  18336  35812   16  908  1992  1016 1559  2646 65 35  0  0
 1  2 100132  45420  17736  36960    4  664  2600   736 1486  2142 83 17  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  5 100132  44836  18256  37744   88    0  1392     0 1469  2475 80  5  0 15
 1  3 100576  43940  18144  37588  676  488  1076  2252 1452  2241 88  7  0  5
 1  4 100612  45284  18372  37088    0   52   836   128 1494  2381 73 27  0  0
 1  2 100928  46012  19008  36296    0  380  1272   468 1561  2927 85 15  0  0
 1  2 101112  46172  19108  36244   36  212  1468   276 1492  2122 93  7  0  0
 1  3 101224  45668  18924  36384   56  120  1544   196 1457  2479 95  5  0  0
 0  5 101484  44492  18656  35980  476  300  1408  2208 1455  2372 37 31  0 33
 1  3 101484  44044  19184  36280   64    0   888   468 1482  2360 32  5  0 63
 2  3 101716  44380  18476  35944    0  236  1312   484 1457  2256 93  7  0  0
 1  2 101884  45692  18280  35880   32  216  1096   292 1431  2330 93  7  0  0
 1  2 102276  45356  18204  35356  336  444  1208   452 1440  2191 93  7  0  0
 1  2 102372  45948  18028  35320  176   96  1092   604 1377  1887 66 29  0  5
 1  3 102384  44492  18124  35376   28   52  1784    64 1470  1874 77  4  0 19
 2  2 102856  45556  17196  35644   80  568  1644  1640 1507  1774 93  7  0  0
 1  3 103108  45164  17704  36132   44  252  1980   268 1632  2248 65 35  0  0
 1  3 103228  44428  17352  36532   92  120  1668   128 1585  2236 87 13  0  0
 1  3 103452  44092  17596  36440  112  228  1672  1696 1598  2256 92  8  0  0
 1  6 103660  45540  16664  35644 1076  216  2536   244 1502  2689 71 29  0  0
 1  2 103776  44028  16088  36244  560  128  2044   296 1461  1643 93  7  0  0
 1  2 104264  45204  14808  35596  112  616  1652   876 1450  1985 91  9  0  0
 1  2 104472  44196  14508  35632   32  496   640   496 1536  1663 90 10  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  2 104600  46492  13396  34876  432  200  1664   668 1461  2093 70 30  0  0
 1  3 104664  46044  14652  34780  184  104  2608   140 1793  3130 90 10  0  0
 1  2 104852  44140  14576  35284  524  244  2352   332 1529  2197 92  8  0  0
 1  1 105372  46660  13256  34792  732  612  1304  2372 1544  1842 71 29  0  0
 1  2 105372  44924  14568  35152  104    0  1776     0 1654  2364 94  6  0  0
 1  2 105540  44476  15504  34696  100  172  1728   880 1698  2911 89 11  0  0
 1  3 105520  44460  16144  34244  220    4  1840    92 1617  2390 63 37  0  0
 1 11 105828  45300  14668  33528 2260  388  3416   416 1473  1859 74 20  0  6
 1  7 106180  45156  13012  33976  788  604  2824   632 1520  1452 48  5  0 46
 1  8 106824  45516  12460  33920 1208  776  2760   776 1504  1826 92  8  0  0
