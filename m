Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSLPKMl>; Mon, 16 Dec 2002 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLPKLs>; Mon, 16 Dec 2002 05:11:48 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:18143 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S266755AbSLPKLO> convert rfc822-to-8bit; Mon, 16 Dec 2002 05:11:14 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] LM bench results summary for 52-mm1 patch
Date: Mon, 16 Dec 2002 15:48:49 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DFF2@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] LM bench results summary for 52-mm1 patch
Thread-Index: AcKk7IXW5qy1qEeBQtelvFweKv5Mjg==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Dec 2002 10:18:49.0395 (UTC) FILETIME=[86675030:01C2A4EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a brief summary of results of LM bench on kernel 2.5.52

								2.5.52-mm1	 	2.5.51
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. Null call						0.44			0.46
2. open close			 			30			28
3. single handle						5.13			5.22
4. fork proc						400			363
5. sh proc							8279			7967
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. TCP connection						174		161
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. 0K file delete						60		57
2. mmap latency						615		640
------------------------------------------------------------------------------
==============================================================================

Rest of the results are not much different.
	

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.52       i686-pc-linux-gnu  790
benchtest  Linux 2.5.52       i686-pc-linux-gnu  790
benchtest  Linux 2.5.52       i686-pc-linux-gnu  790
benchtest  Linux 2.5.52       i686-pc-linux-gnu  790
benchtest  Linux 2.5.52       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.52  790 0.44 0.81   28   30       1.30 5.13  355 1581 8185
benchtest  Linux 2.5.52  790 0.44 0.83   28   30    36 1.31 5.13  400 1570 8247
benchtest  Linux 2.5.52  790 0.44 0.81   28   30    32 1.29 5.35  401 1584 8336
benchtest  Linux 2.5.52  790 0.46 0.83   28   30    37 1.28 5.13  404 1591 8277
benchtest  Linux 2.5.52  790 0.44 0.80   28   30    32 1.28 5.12  370 1572 8279

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.52 1.350 4.9900     14 9.6200    176      46     177
benchtest  Linux 2.5.52 1.290 4.6000     15 8.0900    179      42     179
benchtest  Linux 2.5.52 1.190 4.8300     14 7.3500    177      44     179
benchtest  Linux 2.5.52 1.190 4.5800     17 7.4400    184      42     180
benchtest  Linux 2.5.52 1.340 4.6200     16 9.1900    181      39     180

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.52 1.350 7.875   21    34    59   128   158  174
benchtest  Linux 2.5.52 1.290 7.961   21    35    59   126   159  174
benchtest  Linux 2.5.52 1.190 7.982   21    34    60   127   160  175
benchtest  Linux 2.5.52 1.190 8.239   21    34    60   125   159  176
benchtest  Linux 2.5.52 1.340 7.952   21    34    60   125   158  175

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.52    120     60    384    130      640 1.124 5.00000
benchtest  Linux 2.5.52    120     60    396    130      646 1.095 4.00000
benchtest  Linux 2.5.52    120     60    384    126      637 0.803 4.00000
benchtest  Linux 2.5.52    121     60    385    130      644 1.090 4.00000
benchtest  Linux 2.5.52    120     60    385    122      635 1.032 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.52  337  135   22    298    355    124    113  355   171
benchtest  Linux 2.5.52  447  134   22    293    353    123    112  354   169
benchtest  Linux 2.5.52  422  136   22    293    353    123    112  354   169
benchtest  Linux 2.5.52  445  135   22    295    353    123    113  354   169
benchtest  Linux 2.5.52  450  134   22    294    352    123    112  353   169

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.52   790 3.807 8.8730    174
benchtest  Linux 2.5.52   790 3.799 8.8760    175
benchtest  Linux 2.5.52   790 3.808 8.8840    175
benchtest  Linux 2.5.52   790 3.801 8.8730    176
benchtest  Linux 2.5.52   790 3.809 8.8720    176

Regards,
Aniruddha Marathe
WIPRO Technologies, India
Aniruddha.marathe@wipro.com
