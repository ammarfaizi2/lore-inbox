Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSJOU7S>; Tue, 15 Oct 2002 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264821AbSJOU6j>; Tue, 15 Oct 2002 16:58:39 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:14569 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264822AbSJOU6D>; Tue, 15 Oct 2002 16:58:03 -0400
Message-ID: <20021015210352.26833.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 16 Oct 2002 05:03:52 +0800
Subject: Re:Benchmark results from resp1 trivial response time test
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
updated results:
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

		Kernel version: 2.5.41-mm2
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.676    114.413    113.713    113.856    0.000    1.000
     smallwrite    117.001    228.536    119.025    141.028    0.049    1.239
     largewrite    116.102   1681.086    216.776    499.422    0.667    4.386
        cpuload    105.461    160.513    105.834    116.661    0.025    1.025
      spawnload    108.506    166.367    108.863    120.305    0.026    1.057
       8ctx-mem   1789.834   9155.800   3790.198   4547.118    2.831   39.938
       2ctx-mem   2290.391  10661.156   4810.641   5040.725    3.358   44.273

		Kernel version: 2.5.41-mm2C
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.648    114.508    113.707    113.861    0.000    1.000
     smallwrite    116.054    180.420    117.924    130.525    0.028    1.146
     largewrite    114.019    179.770    120.451    134.021    0.028    1.177
        cpuload    106.590    162.893    107.075    118.080    0.025    1.037
      spawnload    106.574    164.898    107.490    118.671    0.026    1.042
       8ctx-mem   7767.843  16917.625   8994.265  10906.788    3.844   95.790
       2ctx-mem   6515.450  18273.101  10344.575  11217.755    4.822   98.521

		Kernel version: 2.5.41-mm2C@128MiB
  Starting 1 CPU run with 123 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.550    114.451    113.763    113.857    0.000    1.000
     smallwrite    118.926    182.074    123.044    139.160    0.028    1.222
     largewrite    119.864    186.550    139.593    148.957    0.027    1.308
        cpuload    105.468    165.026    105.922    117.648    0.026    1.033
      spawnload    106.408    162.414    106.778    117.861    0.025    1.035
       8ctx-mem   7264.508  12232.155   8106.800   8836.428    1.965   77.610
       2ctx-mem   7447.326  23237.534  11601.912  13325.664    6.527  117.038

		Kernel version: 2.5.41
  Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.607    114.030    113.774    113.783    0.000    1.000
     smallwrite    117.882    526.275    121.038    208.868    0.178    1.836
     largewrite   1674.216  88428.871  14794.752  27750.852   34.851  243.892
        cpuload    104.225    158.400    104.478    115.269    0.024    1.013
      spawnload    105.933    166.818    106.682    118.452    0.027    1.041
       8ctx-mem    116.458   8893.645    120.670   1875.275    3.923   16.481
       2ctx-mem    116.847  10174.152    121.309   2130.303    4.497   18.722

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


Ciao,
        Paolo

P.S Andrew, do you like test and results ?
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
