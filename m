Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbSLPJeA>; Mon, 16 Dec 2002 04:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbSLPJeA>; Mon, 16 Dec 2002 04:34:00 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:3288 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S266310AbSLPJd7> convert rfc822-to-8bit; Mon, 16 Dec 2002 04:33:59 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 52-mm1 patch-TIO bench- maximum I/O latency on rise.
Date: Mon, 16 Dec 2002 15:11:40 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DFE6@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 52-mm1 patch-TIO bench- maximum I/O latency on rise.
Thread-Index: AcKkzpiGwMh7xY5dT4qE6ckHItSyOQAAEAaAAAW4KUA=
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Dec 2002 09:41:40.0243 (UTC) FILETIME=[55B9B630:01C2A4E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.52 with mm1 and 2.5.52 on TIObench. key findings. 

-------------------------------------------------------------
test					2.5.52-mm1 (as compared to
					2.5.52) APPRXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	less than 2% increase
CPU % utilization			less than 2% increase
Average Latency			3 to 4% increase
Maximum latency			20 % increase ( from 51 to 52 there was 15% increase)		
CPU efficiency			less than 5% increase
-------------------------------------------------------------

-------------------------------------------------------------
			Linux kernel 2.5.52-mm1
			TIO bench results
			Date 16th december 2002
-------------------------------------------------------------
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
2.5.52                        252   4096   10    8.75 5.008%    12.424     1947.51   0.00000  0.00000   175

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10    0.50 0.781%   212.562     1357.99   0.00000  0.00000    65

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10   16.79 31.59%     4.111    25844.57   0.06562  0.00156    53

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10    0.73 0.979%     1.375     1629.45   0.00000  0.00000    75
regards,
Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
