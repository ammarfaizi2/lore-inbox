Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSJQULJ>; Thu, 17 Oct 2002 16:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262095AbSJQULJ>; Thu, 17 Oct 2002 16:11:09 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:41450 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262089AbSJQULH>; Thu, 17 Oct 2002 16:11:07 -0400
Message-ID: <20021017201700.5147.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, <akpm@digeo.com>
Date: Fri, 18 Oct 2002 04:16:59 +0800
Subject: Re:Benchmark results from resp1 trivial response time test
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated results.

		Kernel version: 2.4.19
  Starting 1 CPU run with 251 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    119.653    124.207    119.786    120.644    0.002    1.000
     smallwrite    121.051    190.696    144.469    152.062    0.031    1.260
     largewrite    117.412  11871.027   1113.563   3362.302    4.870   27.870
        cpuload    119.691    313.702    178.513    190.324    0.081    1.578
      spawnload    114.624    243.985    119.747    154.604    0.057    1.281
       8ctx-mem    652.737   7564.493   1234.938   2527.273    2.904   20.948
       2ctx-mem    126.914   8428.021    620.418   2941.043    3.890   24.378


		Kernel version: 2.5.42
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.676    113.948    113.737    113.774    0.000    1.000
     smallwrite    115.352    189.983    119.500    141.645    0.036    1.245
     largewrite  19012.080  45528.170  30311.890  31472.632    9.646  276.625
        cpuload    103.328   1267.116    103.971    336.462    0.520    2.957
      spawnload    105.196    167.400    105.787    117.983    0.028    1.037
       8ctx-mem    121.166   8616.232    126.489   1824.054    3.797   16.032
       2ctx-mem    115.162  10291.470    119.560   2152.930    4.550   18.923

		Kernel version: 2.5.42-mm2
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.658    114.500    113.737    113.866    0.000    1.000
     smallwrite    117.220    245.110    119.017    144.541    0.056    1.269
     largewrite    114.841    181.420    118.746    131.568    0.028    1.155
        cpuload    104.583    159.080    104.890    115.694    0.024    1.016
      spawnload    108.790    166.141    109.655    120.698    0.025    1.060
       8ctx-mem    114.430   8484.873    784.141   2066.476    3.604   18.148
       2ctx-mem    121.388   8453.018   1414.443   2383.773    3.459   20.935

		Kernel version: 2.5.42-mm3
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.616    114.280    113.714    113.823    0.000    1.000
     smallwrite    119.452    188.512    123.024    138.799    0.029    1.219
     largewrite    117.059    177.488    119.743    131.807    0.026    1.158
        cpuload    104.678    165.664    104.837    117.055    0.027    1.028
      spawnload    108.795    162.441    108.809    119.582    0.024    1.051
       8ctx-mem   1056.455  10130.557   2031.861   3478.685    3.810   30.562
       2ctx-mem    113.234  10068.534   1518.290   2861.645    4.073   25.141


		Kernel version: 2.5.43
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.596    114.094    113.697    113.779    0.000    1.000
     smallwrite    114.992    181.439    121.280    139.729    0.032    1.228
     largewrite    113.795    262.061    121.018    158.819    0.064    1.396
        cpuload    105.404    161.821    105.760    117.027    0.025    1.029
      spawnload    107.522    166.259    107.645    119.364    0.026    1.049
       8ctx-mem   1771.175   9863.631   2593.279   4018.103    3.316   35.315
       2ctx-mem   1421.036  10475.948   1996.562   3812.757    3.785   33.510


		Kernel version: 2.5.43-mm2
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.627    114.172    113.748    113.794    0.000    1.000
     smallwrite    116.479    184.859    144.951    147.506    0.032    1.296
     largewrite    114.025    986.386    173.816    325.635    0.373    2.862
        cpuload    104.916    159.896    105.425    116.283    0.024    1.022
      spawnload    104.647    171.033    104.931    118.055    0.030    1.037
       8ctx-mem    118.156   9500.830    301.199   2132.289    4.124   18.738
       2ctx-mem    113.554  10007.751    636.093   2542.432    4.231   22.342


Paolo

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
