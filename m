Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbSJMLv6>; Sun, 13 Oct 2002 07:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSJMLv6>; Sun, 13 Oct 2002 07:51:58 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:56269 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261498AbSJMLv5>; Sun, 13 Oct 2002 07:51:57 -0400
Message-ID: <20021013115743.11384.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: davidsen@tmr.com
Date: Sun, 13 Oct 2002 19:57:43 +0800
Subject: Re:Benchmark results from resp1 trivial response time test
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
I think your benchmark is very intersting.
Here goes my results:

--- 2.4.19 ---
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


--- 2.5.41 ---
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
       
--- 2.5.42 ---
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
       

--- 2.5.42-mm2 ---
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


It seems that 2.5.42-mm2 is the "winner".

Comments ?

Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
