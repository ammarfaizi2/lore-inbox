Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSLZGXs>; Thu, 26 Dec 2002 01:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSLZGXs>; Thu, 26 Dec 2002 01:23:48 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:41351 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262446AbSLZGXq> convert rfc822-to-8bit; Thu, 26 Dec 2002 01:23:46 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] lmbench results for 5.53 mm1
Date: Thu, 26 Dec 2002 12:01:46 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044279@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] lmbench results for 5.53 mm1
Thread-Index: AcKsqHZoubwmKeY6RNeJCpo5y6LRdg==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Larry McVoy" <lm@bitmover.com>
X-OriginalArrivalTime: 26 Dec 2002 06:31:47.0550 (UTC) FILETIME=[774837E0:01C2ACA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Benchmark didn't produce any result for local communication latency for UDP. Larry, any clue?

Here is a comparison of results of 2.5.53-mm1 and 2.5.53. The figures in the table below indicate median of 5 repetitions of tests. 

						2.5.53-mm1	2.5.53	
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. increase in time for fork proc 	415		382
2. increase in time for sh proc 	8190		8088
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/64K ctxsw				6.49		7.44
2. 16p/16K ctxsw				38		44
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. RPC / UDP				61		58
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. mmap latency				630		610
==============================================================================


*****************************************************************************
				Lmbench result
				kernel 2.5.53 with mm1
*****************************************************************************
             L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.53       i686-pc-linux-gnu  790
benchtest  Linux 2.5.53       i686-pc-linux-gnu  790
benchtest  Linux 2.5.53       i686-pc-linux-gnu  790
benchtest  Linux 2.5.53       i686-pc-linux-gnu  790
benchtest  Linux 2.5.53       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.53  790 0.44 0.80   28   30    32 1.28 5.47  446 1647 8100
benchtest  Linux 2.5.53  790 0.44 0.82   28   30    35 1.29 5.24  373 1616 8190
benchtest  Linux 2.5.53  790 0.44 0.80   28   30    32 1.29 5.47  387 1604 8190
benchtest  Linux 2.5.53  790 0.44 0.82   28   30    37 1.31 5.47  430 1629 8130
benchtest  Linux 2.5.53  790 0.44 0.82   28   30    35 1.29 5.46  415 1619 8231

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.53 1.190 4.9100     14 6.7200    174      39     177
benchtest  Linux 2.5.53 1.470 5.1100     14 7.6800    178      42     180
benchtest  Linux 2.5.53 1.380 5.0600     15 6.4900    178      37     179
benchtest  Linux 2.5.53 1.420 5.1000     15 6.2400    179      38     180
benchtest  Linux 2.5.53 1.490 5.1000     14 6.1200    186      38     181

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.53 1.190 8.170   21          61   127   156  178
benchtest  Linux 2.5.53 1.470 8.122   21          61   125   135  185
benchtest  Linux 2.5.53 1.380 8.284   19          62   127   155  183
benchtest  Linux 2.5.53 1.420 8.273   21          61   125   155  182
benchtest  Linux 2.5.53 1.490 8.319   21          61   125   158  175

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.53    119     59    383    128      653 1.033 4.00000
benchtest  Linux 2.5.53    122     59    384    125      631 1.014 4.00000
benchtest  Linux 2.5.53    122     60    388    131      634 0.868 4.00000
benchtest  Linux 2.5.53    121     59    387    128      630 0.946 4.00000
benchtest  Linux 2.5.53    122     59    385    126      632 0.938 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.53  296  134   23    298    355    124    114  356   171
benchtest  Linux 2.5.53  393  134   22    290    353    123    113  354   170
benchtest  Linux 2.5.53  412  136   23    294    352    123    112  354   169
benchtest  Linux 2.5.53  293  134   22    285    352    123    112  353   169
benchtest  Linux 2.5.53  406  137   23    293    352    123    112  353   169

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.53   790 3.807 8.8740    174
benchtest  Linux 2.5.53   790 3.798 8.8720    175
benchtest  Linux 2.5.53   790 3.800 8.8840    176
benchtest  Linux 2.5.53   790 3.808 8.8830    176
benchtest  Linux 2.5.53   790 3.798 8.8830    176

Rest of the results are not much different.
Regards,
Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092
