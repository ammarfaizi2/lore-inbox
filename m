Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbSLSIQs>; Thu, 19 Dec 2002 03:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSLSIQs>; Thu, 19 Dec 2002 03:16:48 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:5018 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267566AbSLSIQr> convert rfc822-to-8bit; Thu, 19 Dec 2002 03:16:47 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench performance of mm2 patch. Latencies come down.
Date: Thu, 19 Dec 2002 13:54:33 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201E1BB@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench performance of mm2 patch. Latencies come down.
Thread-Index: AcKnOA5t4RQbTnhFT3ayxcStVTgx4g==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Dec 2002 08:24:33.0578 (UTC) FILETIME=[0F41E8A0:01C2A738]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.52 with mm2 and 2.5.52 with mm1. 
on TIObench. key findings are listed in the table. Values in the table indicate approximate percentage change with respect to previous result. 

* Maximum latency has come down for this patch. This was on rise from last 5.52 release. 

-------------------------------------------------------------
test					2.5.52-mm2 (as compared to
					2.5.52 mm1) APPRXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	5% increase
CPU % utilization			lessthan 2% increase
Average Latency			10% decrease
Maximum latency			10 % decrease 
CPU efficiency			less than 5% increase
-------------------------------------------------------------

Here are the complete results.


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
2.5.52                        252   4096   10    9.08 5.545%    11.806     1837.19   0.00000  0.00000   164

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10    0.48 0.770%   215.442     1346.07   0.00000  0.00000    62

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10   17.59 32.71%     3.810    23958.10   0.05625  0.00156    54

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10    0.77 1.067%     0.710     1113.98   0.00000  0.00000    72

Regards,
Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 extn 5092 
