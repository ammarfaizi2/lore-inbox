Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbTACGba>; Fri, 3 Jan 2003 01:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbTACGb3>; Fri, 3 Jan 2003 01:31:29 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:16821 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267442AbTACGb1> convert rfc822-to-8bit; Fri, 3 Jan 2003 01:31:27 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] Lmbench results for 2.5.54
Date: Fri, 3 Jan 2003 12:09:32 +0530
Message-ID: <94F20261551DC141B6B559DC491086720448D4@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] Lmbench results for 2.5.54
Thread-Index: AcKy8t97dNvXaMAVTaGptvEq7vqfEg==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Jan 2003 06:39:32.0802 (UTC) FILETIME=[DFE60A20:01C2B2F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a comparison of results of 2.5.52 and 2.5.53. The figures in the table below indicate median of 5 repetitions of tests. This result doesn't have many 
Differences than the previous one.


						2.5.54	2.5.53
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. Null call				0.44		0.46
2. stat					29		27
3. exec proc				1600		1528
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/0K ctxsw				1.560		1.430
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1.AF UNIX					19		21
2.UDP						30		33
3.TCP						75		125 
4.RPC TCP					106		156
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. PIPE					554		386
2. AF UNIX					109		136
3.
==============================================================================


*****************************************************************************
				Lmbench result
				kernel 2.5.54
****************************************************************************

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.54       i686-pc-linux-gnu  790
benchtest  Linux 2.5.54       i686-pc-linux-gnu  790
benchtest  Linux 2.5.54       i686-pc-linux-gnu  790
benchtest  Linux 2.5.54       i686-pc-linux-gnu  790
benchtest  Linux 2.5.54       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.54  790 0.44 0.80   29   30       1.30 5.38  385 1541 7903
benchtest  Linux 2.5.54  790 0.44 0.83   29   30    38 1.28 5.16  322 1528 7872
benchtest  Linux 2.5.54  790 0.44 0.82   29   30    34 1.29 5.39  365 1534 7852
benchtest  Linux 2.5.54  790 0.46 0.80   29   30    35 1.29 5.16  312 1491 7862
benchtest  Linux 2.5.54  790 0.46 0.84   29   30    34 1.33 5.38  426 1511 7948

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.54 1.450 4.8900     14 8.9400    164      43     177
benchtest  Linux 2.5.54 1.570 5.2200     14 6.1100    181      39     179
benchtest  Linux 2.5.54 1.620 5.2600     26 6.2900    181      41     179
benchtest  Linux 2.5.54 1.560 4.9000     14 8.5100    176      42     179
benchtest  Linux 2.5.54 1.520 5.2000     15 7.0300    174      39     179

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.54 1.450 8.649   19    30    54    76   106  146
benchtest  Linux 2.5.54 1.570 8.426   19    30    55    77   106  147
benchtest  Linux 2.5.54 1.620 8.668   19    30    55    76   108  146
benchtest  Linux 2.5.54 1.560 8.522   19    30    54    76   106  146
benchtest  Linux 2.5.54 1.520 8.630   19    30    55    76   108  147

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.54    118     55    381    128      594 1.015 4.00000
benchtest  Linux 2.5.54    118     55    378    126      606 1.003 4.00000
benchtest  Linux 2.5.54    118     56    374    119      598 1.017 4.00000
benchtest  Linux 2.5.54    118     56    374    127      599 1.005 4.00000
benchtest  Linux 2.5.54    118     56    375    126      626 1.022 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.54  559  110   25    296    354    124    112  353   170
benchtest  Linux 2.5.54  356   98   25    296    353    124    112  352   169
benchtest  Linux 2.5.54  580  105   25    294    353    124    113  352   169
benchtest  Linux 2.5.54  554  109   24    295    353    124    112  354   170
benchtest  Linux 2.5.54  544  114   25    287    354    124    114  354   170

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.54   790 3.799 8.8820    175
benchtest  Linux 2.5.54   790 3.806     60    175
benchtest  Linux 2.5.54   790 3.799 8.8950    175
benchtest  Linux 2.5.54   790 3.807 8.8820    175
benchtest  Linux 2.5.54   790 3.807 8.8820    175

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 

