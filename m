Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSLLMWJ>; Thu, 12 Dec 2002 07:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSLLMWJ>; Thu, 12 Dec 2002 07:22:09 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:52223 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S262808AbSLLMWH> convert rfc822-to-8bit; Thu, 12 Dec 2002 07:22:07 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIO bench mm2 patch better than mm1 patch
Date: Thu, 12 Dec 2002 17:59:34 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DECD@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIO bench mm2 patch better than mm1 patch
Thread-Index: AcKh2iBX0uqxfl5HSvinLGh2+VQy6A==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Dec 2002 12:29:35.0156 (UTC) FILETIME=[21306F40:01C2A1DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of Kernel 2.5.51 with mm2 patch and 2.5.51 with mm1 patch.  
Please see the mail in full size window to avoid text wrap problem. 
Key findings of the comparison:
1. Great reduction in maximum latency.
2. better throughput of CPU mainly because less usage for same work.
3. mega-bytes transfered per second have also improved.

many optimizations done in the pathces. they must perform :)

*******************************************************************************
                             TIO BENCH PERFORMANCE RESULT
             		     LINUX KERNEL 2.5.51 with mm2
			     Date: December 12TH 2002
*******************************************************************************
No size specified, using 252 MB

Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10    8.81 5.345%    12.244     1894.78   0.00000  0.00000   165

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10    0.51 0.750%   206.139     1306.27   0.00000  0.00000    68

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10   17.56 32.68%     3.841    28833.24   0.05625  0.00156    54

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10    0.72 1.013%     3.694     4066.20   0.07500  0.00000    71

*******************************************************************************
                             TIO BENCH PERFORMANCE RESULT
             		     LINUX KERNEL 2.5.51 with mm1
			     Date: December 11TH 2002
*******************************************************************************
Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10    8.57 5.375%    12.720     1712.91   0.00000  0.00000   159

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10    0.50 1.073%   205.984     1278.60   0.00000  0.00000    47

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10   17.86 33.77%     3.850    21603.95   0.06406  0.00000    53

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.51                        252   4096   10    0.77 1.091%     0.736     1551.03   0.00000  0.00000    70

========================================================================================================================


Regards,
---------------------------------------------------------------
Aniruddha Marathe
Systems Engineer,
4th floor, WIPRO technologies,
53/1, Hosur road,
Madivala,
Bangalore - 560068
Karnataka, India
Phone: +91-80-5502001 extension 5092
E-mail: aniruddha.marathe@wipro.com
---------------------------------------------------------------
