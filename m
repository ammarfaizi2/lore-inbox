Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUEEJaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUEEJaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUEEJaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:30:05 -0400
Received: from sartre.ispvip.biz ([209.118.182.154]:6082 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S264272AbUEEJ3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:29:54 -0400
Subject: Re: [3/3] wake-one PG_locked/BH_Lock semantics
From: "Michael J. Cohen" <mjc@unre.st>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1083739343.7320.13.camel@dvdburner.uni.325i.org>
References: <20040505060612.GV1397@holomorphy.com>
	 <20040505060849.GW1397@holomorphy.com>
	 <20040505061121.GX1397@holomorphy.com>
	 <20040505061630.GY1397@holomorphy.com>
	 <1083739343.7320.13.camel@dvdburner.uni.325i.org>
Content-Type: multipart/mixed; boundary="=-+NjXYz2zt57pVlTjGXuo"
Message-Id: <1083749393.17988.9.camel@dvdburner.uni.325i.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 05 May 2004 05:29:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+NjXYz2zt57pVlTjGXuo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

here's the tiobenches, run several times. there was no significant
deviation for -mm1 so it's not considered a problem.

--=-+NjXYz2zt57pVlTjGXuo
Content-Disposition: attachment; filename=tiobench-p4m-2.6.6-rc3-mm1
Content-Type: text/plain; name=tiobench-p4m-2.6.6-rc3-mm1; charset=
Content-Transfer-Encoding: 7bit

No size specified, using 1022 MB

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
2.6.6-rc3-mm1                 1022  4096    1   27.59 8.909%     0.138      313.59   0.00000  0.00000   310
2.6.6-rc3-mm1                 1022  4096    2   26.30 8.676%     0.293      392.22   0.00000  0.00000   303
2.6.6-rc3-mm1                 1022  4096    4   24.55 8.094%     0.625      525.17   0.00000  0.00000   303
2.6.6-rc3-mm1                 1022  4096    8   24.34 7.966%     1.224     1035.81   0.00000  0.00000   306

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.52 0.429%     7.444       51.22   0.00000  0.00000   122
2.6.6-rc3-mm1                 1022  4096    2    0.54 0.255%    14.238      212.31   0.00000  0.00000   211
2.6.6-rc3-mm1                 1022  4096    4    0.59 0.332%    25.666      234.95   0.00000  0.00000   178
2.6.6-rc3-mm1                 1022  4096    8    0.60 0.334%    45.477      413.88   0.00000  0.00000   180

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1   24.51 18.11%     0.146     8561.11   0.00038  0.00000   135
2.6.6-rc3-mm1                 1022  4096    2   26.12 19.45%     0.253     5324.12   0.00038  0.00000   134
2.6.6-rc3-mm1                 1022  4096    4   20.58 15.03%     0.613    10596.65   0.00153  0.00077   137
2.6.6-rc3-mm1                 1022  4096    8   20.87 15.14%     1.143    10301.78   0.02345  0.00077   138

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.90 0.473%     0.013        0.37   0.00000  0.00000   191
2.6.6-rc3-mm1                 1022  4096    2    0.85 0.418%     0.093      175.91   0.00000  0.00000   203
2.6.6-rc3-mm1                 1022  4096    4    0.84 0.444%     0.020       25.46   0.00000  0.00000   188
2.6.6-rc3-mm1                 1022  4096    8    0.81 0.444%     0.013        0.37   0.00000  0.00000   182

--=-+NjXYz2zt57pVlTjGXuo
Content-Disposition: attachment; filename=tiobench-p4m-2.6.6-rc3-mm1-waitone
Content-Type: text/plain; name=tiobench-p4m-2.6.6-rc3-mm1-waitone; charset=
Content-Transfer-Encoding: 7bit

No size specified, using 1022 MB

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
2.6.6-rc3-mm1                 1022  4096    1   25.94 11.71%     0.146      370.36   0.00000  0.00000   221
2.6.6-rc3-mm1                 1022  4096    2   24.96 11.34%     0.304      507.07   0.00000  0.00000   220
2.6.6-rc3-mm1                 1022  4096    4   24.35 10.74%     0.626      776.48   0.00000  0.00000   227
2.6.6-rc3-mm1                 1022  4096    8   24.50 10.80%     1.225     1037.49   0.00000  0.00000   227

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.58 0.579%     6.761      108.38   0.00000  0.00000   100
2.6.6-rc3-mm1                 1022  4096    2    0.66 0.446%    11.394      134.13   0.00000  0.00000   147
2.6.6-rc3-mm1                 1022  4096    4    0.64 0.414%    23.910      267.87   0.00000  0.00000   155
2.6.6-rc3-mm1                 1022  4096    8    0.74 0.500%    39.739      379.63   0.00000  0.00000   147

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1   25.92 28.26%     0.119      789.56   0.00000  0.00000    92
2.6.6-rc3-mm1                 1022  4096    2   25.08 24.29%     0.236     7824.13   0.00076  0.00000   103
2.6.6-rc3-mm1                 1022  4096    4   23.12 24.59%     0.532     8510.70   0.00038  0.00000    94
2.6.6-rc3-mm1                 1022  4096    8   22.88 21.04%     1.018     7272.02   0.01922  0.00000   109

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.87 0.620%     0.023       19.71   0.00000  0.00000   140
2.6.6-rc3-mm1                 1022  4096    2    0.87 0.632%     0.048      118.52   0.00000  0.00000   137
2.6.6-rc3-mm1                 1022  4096    4    0.84 0.557%     0.020       11.00   0.00000  0.00000   150
2.6.6-rc3-mm1                 1022  4096    8    0.81 0.626%     0.018        0.45   0.00000  0.00000   129

--=-+NjXYz2zt57pVlTjGXuo
Content-Disposition: attachment; filename=tiobench-p4m-2.6.6-rc3-mm1-waitone-2
Content-Type: text/plain; name=tiobench-p4m-2.6.6-rc3-mm1-waitone-2; charset=
Content-Transfer-Encoding: 7bit

No size specified, using 1022 MB

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
2.6.6-rc3-mm1                 1022  4096    1   27.70 8.979%     0.138      337.13   0.00000  0.00000   309
2.6.6-rc3-mm1                 1022  4096    2   26.03 8.543%     0.295      271.51   0.00000  0.00000   305
2.6.6-rc3-mm1                 1022  4096    4   23.63 7.704%     0.643      533.84   0.00000  0.00000   307
2.6.6-rc3-mm1                 1022  4096    8   22.98 7.555%     1.295     1157.90   0.00000  0.00000   304

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.48 0.359%     8.204       58.92   0.00000  0.00000   132
2.6.6-rc3-mm1                 1022  4096    2    0.51 0.259%    14.726      208.67   0.00000  0.00000   198
2.6.6-rc3-mm1                 1022  4096    4    0.52 0.303%    29.583      256.53   0.00000  0.00000   172
2.6.6-rc3-mm1                 1022  4096    8    0.59 0.283%    49.995      347.57   0.00000  0.00000   208

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1   23.53 36.09%     0.135     8438.51   0.00038  0.00000    65
2.6.6-rc3-mm1                 1022  4096    2   26.13 19.06%     0.235     1934.21   0.00000  0.00000   137
2.6.6-rc3-mm1                 1022  4096    4   23.62 17.09%     0.539     9043.92   0.00115  0.00000   138
2.6.6-rc3-mm1                 1022  4096    8   24.08 17.34%     0.985     7376.00   0.01499  0.00000   139

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.90 0.465%     0.014        0.26   0.00000  0.00000   193
2.6.6-rc3-mm1                 1022  4096    2    0.87 0.468%     0.014        0.32   0.00000  0.00000   186
2.6.6-rc3-mm1                 1022  4096    4    0.84 0.438%     0.013        0.09   0.00000  0.00000   191
2.6.6-rc3-mm1                 1022  4096    8    0.84 0.460%     0.014        1.46   0.00000  0.00000   182

--=-+NjXYz2zt57pVlTjGXuo
Content-Description: 
Content-Disposition: attachment; filename=tiobench-p4m-2.6.6-rc3-mm1-nowaitone
Content-Type: text/plain; charset=
Content-Transfer-Encoding: 7bit

No size specified, using 1022 MB

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
2.6.6-rc3-mm1                 1022  4096    1   27.00 8.584%     0.142      346.75   0.00000  0.00000   315
2.6.6-rc3-mm1                 1022  4096    2   25.95 8.042%     0.295      413.18   0.00000  0.00000   323
2.6.6-rc3-mm1                 1022  4096    4   23.97 7.407%     0.639      701.70   0.00000  0.00000   324
2.6.6-rc3-mm1                 1022  4096    8   24.52 7.811%     1.218     1026.37   0.00000  0.00000   314

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.64 0.374%     6.134      132.43   0.00000  0.00000   170
2.6.6-rc3-mm1                 1022  4096    2    0.67 0.262%    11.186      176.23   0.00000  0.00000   256
2.6.6-rc3-mm1                 1022  4096    4    0.67 0.289%    20.849      343.38   0.00000  0.00000   230
2.6.6-rc3-mm1                 1022  4096    8    0.67 0.264%    45.265      396.09   0.00000  0.00000   252

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1   24.72 18.37%     0.149     9206.91   0.00038  0.00000   135
2.6.6-rc3-mm1                 1022  4096    2   24.82 18.16%     0.234     2451.44   0.00038  0.00000   137
2.6.6-rc3-mm1                 1022  4096    4   23.66 17.31%     0.586     8381.46   0.00153  0.00000   137
2.6.6-rc3-mm1                 1022  4096    8   23.45 16.87%     0.942     7985.45   0.01423  0.00000   139

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.6.6-rc3-mm1                 1022  4096    1    0.91 0.470%     0.013        0.27   0.00000  0.00000   193
2.6.6-rc3-mm1                 1022  4096    2    0.83 0.402%     0.013        0.27   0.00000  0.00000   206
2.6.6-rc3-mm1                 1022  4096    4    0.85 0.417%     0.013        0.29   0.00000  0.00000   203
2.6.6-rc3-mm1                 1022  4096    8    0.81 0.388%     0.013        0.27   0.00000  0.00000   208

--=-+NjXYz2zt57pVlTjGXuo--

