Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVHSDJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVHSDJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVHSDJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:09:50 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:1838 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750976AbVHSDJu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:09:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DqslyPUCIjj/nLnNmAY7Nf8Xs9kj2t+iMEnKcdBiiIr4fPoXbrZ6ivwrC086zoR+5oqZtueSuke6dNEl7hZDz7BKXW79TygGMLeMMRaT+6MGEl5/0ewVc9zWKiso7esXkajHWPkiFT91ahcMHdvFY12yh9vC9EbcgPTZaE1YBlU=
Message-ID: <6bffcb0e050818200936bad1d3@mail.gmail.com>
Date: Fri, 19 Aug 2005 05:09:48 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200508180945.50185.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <200508180916.08454.kernel@kolivas.org>
	 <4303CCB9.6000403@bigpond.net.au>
	 <200508180945.50185.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here are interbench v0.29 resoults:

cpusched=ingosched

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508181941

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.017 +/- 0.0267     0.458             100            100
Video      0.21 +/- 1.19        12.3             100            100
X         0.333 +/- 3.1         62.8             100           99.8
Burn      0.199 +/- 1.17          16             100            100
Write     0.048 +/- 0.209       4.08             100            100
Read      0.032 +/- 0.072      0.767             100            100
Compile   0.268 +/- 1.31          15             100            100
Memload   0.057 +/- 0.424       9.04             100            100

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.159 +/- 1.53        16.7             100           99.2
X         0.837 +/- 4.07        43.4            99.1           95.7
Burn      0.911 +/- 4.52        40.4            98.6           95.5
Write      1.08 +/- 4.43        32.7            99.2           94.2
Read      0.379 +/- 2.42        16.9            99.9           97.9
Compile     2.5 +/- 7.1          102            98.6           86.1
Memload     1.1 +/- 4.39        34.1            99.6           93.7

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.64 +/- 8.06          52            86.8           83.7
Video      17.3 +/- 31.5         110            32.9           23.2
Burn       32.9 +/- 57.8         460            20.5           11.8
Write      10.2 +/- 24.1         121            43.3           34.7
Read       4.67 +/- 15.8          75            52.1           47.3
Compile    34.5 +/- 52.9         135            20.3           11.2
Memload    4.62 +/- 15.2         126            75.2           66.9

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       6.09 +/- 14.9          91            94.3
Video      75.6 +/- 77.1         123            56.9
X          69.9 +/- 82.4         183            58.9
Burn        306 +/- 397          979            24.6
Write      43.9 +/- 68.2         468            69.5
Read       28.8 +/- 45           162            77.6
Compile     384 +/- 506         1622            20.6
Memload    25.5 +/- 37           157            79.7

-------------------------------------------------------------------------------

cpusched=staircase

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508182051

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.113 +/- 0.4         2.02             100            100
Video      1.38 +/- 2.4           12             100            100
X         0.748 +/- 1.58          11             100            100
Burn      0.518 +/- 1.95          11             100            100
Write     0.257 +/- 1.27          11             100            100
Read      0.113 +/- 0.454       7.02             100            100
Compile   0.479 +/- 1.95        16.7             100            100
Memload     0.1 +/- 0.431       5.02             100            100

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.316 +/- 2.18        18.7            99.8           98.5
X          1.41 +/- 5.04        41.7            97.9           94.3
Burn       2.33 +/- 8.22        44.3            96.5           89.8
Write      1.38 +/- 5.49        44.4            98.6           92.8
Read        1.1 +/- 4.24        19.7            99.8           93.8
Compile    3.96 +/- 18.3         409            92.4           83.1
Memload    1.14 +/- 4.43        36.6            99.5           93.8

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.57 +/- 7.36          48            85.6           82.6
Video      14.6 +/- 27.5          90            35.6           26.3
Burn       40.5 +/- 62           186            19.2           9.92
Write      10.3 +/- 22.8         108            55.9             45
Read       3.84 +/- 12.6          72            74.7           67.3
Compile    40.6 +/- 62.4         183            18.6           9.61
Memload    2.61 +/- 8.8           55            69.1           63.2

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       17.6 +/- 29.5         159              85
Video      71.8 +/- 72.7         115            58.2
X          69.5 +/- 78.8         164              59
Burn        306 +/- 470         1278            24.6
Write      47.4 +/- 61.4         209            67.8
Read       19.9 +/- 35.1         163            83.4
Compile    1012 +/- 1111        1655               9
Memload    26.7 +/- 43.3         309            78.9

---

cpusched=staircase+patch

---patch---
Index: linux-2.6.13-rc6-plugsched/kernel/staircase.c
===================================================================
--- linux-2.6.13-rc6-plugsched.orig/kernel/staircase.c  2005-08-18
07:32:34.000000000 +1000
+++ linux-2.6.13-rc6-plugsched/kernel/staircase.c       2005-08-18
07:33:10.000000000 +1000
@@ -64,8 +64,8 @@ int sched_compute = 0;
  *compute setting is reserved for dedicated computational scheduling
  *and has ten times larger intervals.
  */
-#define _RR_INTERVAL           ((10 * HZ / 1000) ? : 1)
-#define RR_INTERVAL()          (_RR_INTERVAL * (1 + 9 * sched_compute))
+#define _RR_INTERVAL           ((5 * HZ / 1000) ? : 1)
+#define RR_INTERVAL()          (_RR_INTERVAL * (1 + 19 * sched_compute))

 #define TASK_PREEMPTS_CURR(p, rq) \
        ((p)->prio < (rq)->curr->prio)
---patch---

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-4 at datestamp 200508182129

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.087 +/- 0.331       2.02             100            100
Video      1.56 +/- 1.77        6.03             100            100
X         0.759 +/- 1.29        6.05             100            100
Burn      0.466 +/- 1.4         6.01             100            100
Write     0.138 +/- 0.556       5.03             100            100
Read      0.084 +/- 0.29        2.03             100            100
Compile   0.378 +/- 1.23        6.02             100            100
Memload   0.109 +/- 0.378       4.02             100            100

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.266 +/- 1.95        18.7            99.8           98.8
X          1.54 +/- 5.03        39.4            98.2             94
Burn       2.02 +/- 6.37        23.4             100           90.1
Write      1.42 +/- 5.01        39.4            99.5           92.2
Read      0.359 +/- 2.32        18.7            99.8           98.2
Compile    5.02 +/- 20.3         275            90.7           80.8
Memload   0.517 +/- 3.08        39.4            99.6           97.4

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.38 +/- 7.54          75            85.1           82.6
Video      15.3 +/- 28.7          90            35.2           25.5
Burn       38.6 +/- 60.1         180            19.3           10.2
Write      10.1 +/- 22.8         105            52.6           42.1
Read       5.84 +/- 16.8         119            63.6             57
Compile    43.3 +/- 66.4         195            17.8           9.19
Memload    3.81 +/- 12.2          72            66.8           60.2

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       9.51 +/- 19.9          80            91.3
Video        73 +/- 74.1         116            57.8
X            69 +/- 80.5         173            59.2
Burn        336 +/- 468          982            22.9
Write      45.2 +/- 59.1         183            68.9
Read       40.8 +/- 60.9         165              71
Compile     584 +/- 810         1481            14.6
Memload    32.5 +/- 52.1         285            75.4

---

cpusched=staircase

sched_compute=1

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508182323

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.016 +/- 0.0285     0.528             100            100
Video     0.218 +/- 0.666       3.21             100            100
X         0.451 +/- 4.07        90.6            99.8           99.8
Burn       72.4 +/- 384         2910            57.1           56.6
Write      1.03 +/- 17.1         408            99.3           99.2
Read      0.095 +/- 0.406          4             100            100
Compile    68.2 +/- 334         3298            58.6           57.4
Memload   0.216 +/- 1.56        34.6             100            100

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.264 +/- 2.03        19.7            99.9           98.7
X          4.88 +/- 14.3         148            95.4           79.6
Burn        149 +/- 867         6300            10.2            8.7
Write      2.33 +/- 9.54         202            97.9           88.8
Read      0.811 +/- 3.61        20.7            99.8           95.8
Compile    97.6 +/- 987        18012              23             19
Memload    1.15 +/- 4.85        79.7            99.4           94.1

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.91 +/- 9.08          74            89.4           85.9
Video        10 +/- 20.8          84            42.7           33.7
Burn        393 +/- 1510        8106             9.9           7.28
Write      12.2 +/- 28.9         134            54.1           43.6
Read       8.35 +/- 23.4         147            58.3           50.2
Compile     122 +/- 432         3608            14.6           7.55
Memload    9.96 +/- 27.9         140            57.3           48.3

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       6.96 +/- 15.6        64.1            93.5
Video        68 +/- 69.7         111            59.5
X          68.7 +/- 78.9         173            59.3
Burn        105 +/- 109          401            48.9
Write      45.8 +/- 60           140            68.6
Read       28.2 +/- 48.2         165              78
Compile     671 +/- 1668        7256              13
Memload    27.6 +/- 48.6         166            78.3

-------------------------------------------------------------------------------

cpusched=spa_no_frills

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508182154

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.021 +/- 0.0602     0.752             100            100
Video     0.508 +/- 2.2         13.6             100            100
X           1.9 +/- 11.9         112            98.6           98.6
Burn       1561 +/- 5890       45545            0.412         0.412
Write      3.33 +/- 19           191            97.6           97.3
Read      0.057 +/- 0.651       15.9             100            100
Compile    1399 +/- 3774       17236            0.57           0.57
Memload   0.243 +/- 3.57        85.8            99.8           99.8

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.116 +/- 1.26        17.7             100           99.4
X          1.67 +/- 12.1         146            95.6           94.5
Burn        716 +/- 2159       15909            0.0602       0.0602
Write      3.17 +/- 18.6         374            94.4           88.3
Read      0.949 +/- 5.33         132            99.5           94.9
Compile     948 +/- 1355        3281            0.294         0.118
Memload    1.32 +/- 7.24         203            99.1             93

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None        1.9 +/- 8.58          56            85.3           81.8
Video      15.7 +/- 28.8          85            33.6           24.1
Burn        648 +/- 813         3325            2.48              1
Write      11.9 +/- 35.4         336            57.8           48.1
Read        3.8 +/- 14.6         140            77.5           70.7
Compile     928 +/- 1177        3480            3.27           1.79
Memload    4.29 +/- 13.3         119            70.9           64.2

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None         11 +/- 24.4         151            90.1
Video      69.9 +/- 70.3        87.7            58.9
X          67.2 +/- 76.4         137            59.8
Burn        644 +/- 1049        3393            13.4
Write      39.9 +/- 57.7         278            71.5
Read       17.5 +/- 30.3         156            85.1
Compile     476 +/- 697         2290            17.4
Memload    20.3 +/- 30.5         125            83.1

-------------------------------------------------------------------------------

cpusched=zaphod

max_ia_bonus=default
max_tpt_bonus=default

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508190006

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       0.02 +/- 0.0495     0.791             100            100
Video      0.28 +/- 2.16          35             100            100
X         0.584 +/- 5.88         113            99.8           99.7
Burn      0.994 +/- 5.62          96             100           99.8
Write     0.877 +/- 5.86        89.9             100           99.5
Read      0.501 +/- 4.53          94             100           99.8
Compile    1.22 +/- 7.29         104            99.8           99.5
Memload   0.508 +/- 3.61        51.1             100           99.8

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.02 +/- 7.25        79.4            95.4           94.9
X          1.28 +/- 8.11         117              95           94.2
Burn       1.61 +/- 10.1         134            95.5           94.6
Write      4.63 +/- 17.9         314            84.6           79.6
Read       1.45 +/- 8.6          100            94.9           93.4
Compile    2.38 +/- 10           136            94.8           89.9
Memload    2.09 +/- 9.54         124            94.9             90

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       2.36 +/- 10.9          68            86.5           83.8
Video        21 +/- 38           148            30.1           20.6
Burn       4.55 +/- 15.3          76            70.4           63.8
Write      26.1 +/- 73.1         504            37.2           27.5
Read       6.22 +/- 27.2         360            62.3           56.2
Compile    7.18 +/- 19.4          96            59.4           50.1
Memload    5.85 +/- 17.7          99              63           56.9

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       7.86 +/- 20.9        79.2            92.7
Video        82 +/- 86.7         165            54.9
X           128 +/- 213          847            43.9
Burn       26.6 +/- 38.5         197              79
Write      55.1 +/- 132          965            64.5
Read         22 +/- 33.6         227              82
Compile    46.8 +/- 60.5         225            68.1
Memload    29.8 +/- 48           396            77.1

---

max_ia_bonus=0
max_tpt_bonus=default

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508190109

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.021 +/- 0.058       1.01             100            100
Video     0.334 +/- 1.74        13.8             100            100
X          1.32 +/- 9.31         110            99.3           99.2
Burn       8198 +/- 16905      35815            0.348         0.174
Write      2.53 +/- 20.7         424            98.5           98.1
Read      0.171 +/- 3.48        85.2            99.8           99.8
Compile    1647 +/- 5681       24402            2.01           1.84
Memload   0.305 +/- 3.77        88.4            99.8           99.8

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.038 +/- 0.56        16.7             100           99.9
X          1.37 +/- 9.19         128              97           95.4
Burn       2701 +/- 6623       20512            0.224         0.168
Write      2.81 +/- 14.4         234            95.4           89.1
Read      0.852 +/- 4.12        60.5            99.7           95.4
Compile    3538 +/- 10559      38340            0.222        0.0554
Memload    1.46 +/- 7.19         109            98.4           93.2

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.31 +/- 6.7           60            86.6           83.5
Video      15.3 +/- 28.3          78            34.5           25.2
Burn       1786 +/- 6779       28716            4.79           4.26
Write      9.43 +/- 23.6         164              64           52.4
Read        3.2 +/- 11.8          76              69           64.4
Compile    1178 +/- 4079       26841            4.97           2.49
Memload    3.94 +/- 11.2          78              72           63.7

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       10.4 +/- 22.6         164            90.5
Video        70 +/- 70.5        88.2            58.8
X            67 +/- 76.8         176            59.9
Burn        277 +/- 385         1128            26.5
Write      39.2 +/- 57.2         242            71.8
Read       17.4 +/- 27.3         170            85.2
Compile     627 +/- 1401        5978            13.8
Memload    22.3 +/- 33.7         200            81.8

---

max_ia_bonus=default
max_tpt_bonus=0

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508190151

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.204 +/- 3.95          96             100           99.8
Video     0.327 +/- 2.38        34.1             100            100
X         0.815 +/- 6.12        93.3             100           99.5
Burn      0.577 +/- 2.88        29.2             100            100
Write     0.781 +/- 4.55          50             100           99.7
Read       0.68 +/- 6.77        98.3            99.8           99.5
Compile    1.18 +/- 7.93         113            99.7           99.5
Memload   0.539 +/- 6.02         125            99.8           99.5

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.06 +/- 7.19        76.4            95.1           94.3
X          1.43 +/- 8.72         122              95           93.9
Burn       1.34 +/- 7.84        79.3              96           94.7
Write      4.62 +/- 16.7         198            84.5           79.4
Read       1.48 +/- 9.35         154            94.3           93.1
Compile    2.81 +/- 10.6         135            94.8             88
Memload    1.89 +/- 8.88        79.3            94.8           90.9

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       2.92 +/- 12.4          81            88.8           84.2
Video      22.5 +/- 39.6         132            30.1           19.8
Burn       4.66 +/- 15.3          84            60.2           52.5
Write      10.3 +/- 26           184            61.6           50.1
Read       4.25 +/- 16.9         174            73.8           67.9
Compile    8.38 +/- 21.4         140            54.6           44.9
Memload    6.03 +/- 17.5          90            59.3           51.8

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None        7.8 +/- 21.2        77.2            92.8
Video      80.5 +/- 84.8         163            55.4
X           129 +/- 212          828            43.6
Burn       24.3 +/- 33.3         146            80.4
Write      48.7 +/- 107          820            67.3
Read         21 +/- 30.8         124            82.7
Compile    43.1 +/- 50.9         171            69.9
Memload    32.2 +/- 49.2         328            75.6

---

max_ia_bonus=0
max_tpt_bonus=0

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508190325

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.024 +/- 0.103       2.06             100            100
Video     0.399 +/- 1.88        12.7             100            100
X          1.31 +/- 9.34         112            99.3           99.2
Burn        172 +/- 278          503              20             20
Write      1.67 +/- 12.4         131            98.8           98.8
Read      0.035 +/- 0.0722     0.833             100            100
Compile     520 +/- 770         2943            3.45           3.45
Memload   0.669 +/- 6.24          99            99.7           99.7

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.178 +/- 1.64        17.7            99.9             99
X          1.53 +/- 10.3         137            96.4           94.6
Burn        465 +/- 873         8110            0.12         0.0601
Write      2.44 +/- 13.3         342            96.2           90.4
Read       1.82 +/- 5.47          18            99.9           89.3
Compile     916 +/- 3017       22968            0.118         0.059
Memload    1.11 +/- 5.09         107            99.6             94

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None       1.44 +/- 6.96          45              90           87.2
Video      16.6 +/- 30            80            33.7           23.9
Burn      12076 +/- 37271     105484            0.508         0.508
Write      10.4 +/- 25.4         175            53.6           43.5
Read       6.62 +/- 20.9         126              68           59.8
Compile     407 +/- 508          884            14.9           10.6
Memload    4.12 +/- 13.6          84            79.9           73.5

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       11.3 +/- 24.4         108            89.9
Video      72.7 +/- 73.2        87.1            57.9
X          67.8 +/- 77.4         162            59.6
Burn        211 +/- 225          978            32.1
Write      41.6 +/- 62.7         314            70.6
Read       18.8 +/- 30.2         138            84.2
Compile     210 +/- 216          461            32.2
Memload    19.9 +/- 36           254            83.4

-------------------------------------------------------------------------------

cpusched=nicksched

Using 1844991 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.13-rc6-2 at datestamp 200508190404

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.015 +/- 0.0496     0.707             100            100
Video     0.061 +/- 0.536       10.6             100            100
X          0.15 +/- 1.24          14             100            100
Burn      0.067 +/- 0.996       19.9             100            100
Write     0.314 +/- 4.01        95.3             100           99.8
Read      0.024 +/- 0.0544      1.04             100            100
Compile   0.145 +/- 1.43          24             100            100
Memload   0.046 +/- 0.226       3.79             100            100

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None      0.185 +/- 1.68        16.7            99.8             99
X         0.883 +/- 5.42        83.3            98.2           95.4
Burn      0.181 +/- 1.7         19.9            99.9             99
Write      2.22 +/- 13.4         344            95.6           89.4
Read      0.864 +/- 4.46         100            99.4             95
Compile    3.31 +/- 10.2         169            96.3           81.6
Memload    1.22 +/- 4.57        34.2            99.6             93

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None        1.4 +/- 6.82          48            90.3           86.6
Video        19 +/- 35.7         144            30.2           21.3
Burn       67.1 +/- 195         1500            12.4           7.06
Write      11.3 +/- 27.5         189            54.8           43.9
Read       7.67 +/- 24.2         143            52.6           46.6
Compile      74 +/- 223         1800            11.3           6.36
Memload       6 +/- 17.5         120            66.2           57.3

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load    Latency +/- SD (ms)  Max Latency   % Desired CPU
None       6.81 +/- 16          84.9            93.6
Video      80.5 +/- 83.8         159            55.4
X            72 +/- 84.1         196            58.1
Burn        342 +/- 580         2777            22.6
Write      44.9 +/- 69.9         423              69
Read       24.6 +/- 41.5         165            80.3
Compile     457 +/- 590         1435              18
Memload    26.3 +/- 38.4         153            79.2

Regards,
Michal Piotrowski
