Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265564AbSLPHBV>; Mon, 16 Dec 2002 02:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSLPHBV>; Mon, 16 Dec 2002 02:01:21 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:17853 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S265564AbSLPHBT> convert rfc822-to-8bit; Mon, 16 Dec 2002 02:01:19 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] no much change in performance of 2.5.52 as tested on LM bench
Date: Mon, 16 Dec 2002 12:38:59 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DFBE@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] no much change in performance of 2.5.52 as tested on LM bench
Thread-Index: AcKk0gFdpGky5q6dTQmt4bAAdGGi+A==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Dec 2002 07:09:00.0337 (UTC) FILETIME=[01FEFA10:01C2A4D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a brief summary of results of LM bench on kernel 2.5.52

								2.5.52 	2.5.51
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1.single handle						5.22		5.08
2. increase in time for fork proc 			362		403
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/16K ctxsw						4.84		5.01
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. pipe							8.005		8.26
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. 10K file delete					57		59
2. mmap latency						615		651
------------------------------------------------------------------------------
*Local* Communication bandwidths in MB/s - bigger is better
1. pipe							404		335
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
benchtest  Linux 2.5.52  790 0.46 0.83   27   28    37 1.30 5.22  363 1582 7961
benchtest  Linux 2.5.52  790 0.46 0.83   27   28    32 1.28 5.23  389 1575 7967
benchtest  Linux 2.5.52  790 0.44 0.80   27   28    34 1.30 5.21  353 1579 8109
benchtest  Linux 2.5.52  790 0.46 0.83   27   28    36 1.30 5.21  349 1581 7979
benchtest  Linux 2.5.52  790 0.46 0.83   27   28    37 1.30 5.23  403 1563 8033

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.52 1.170 4.7900     14 7.2100    175      40     178
benchtest  Linux 2.5.52 1.170 4.8300     14 6.4700    179      39     179
benchtest  Linux 2.5.52 1.190 4.8500     14 5.5800    177      41     178
benchtest  Linux 2.5.52 1.260 4.8800     14 5.5200    182      41     180
benchtest  Linux 2.5.52 1.230 4.9400     14 8.0500    181      39     179

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.52 1.170 8.075   21    34    59   125   153  161
benchtest  Linux 2.5.52 1.170 8.005   21    34    59   123   154  159
benchtest  Linux 2.5.52 1.190 7.952   21    34    59   123   156  161
benchtest  Linux 2.5.52 1.260 8.093   21    35    59   123   133  159
benchtest  Linux 2.5.52 1.230 8.068   21    34    59   124   154  159

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.52    122     57    382    121      614 0.955 4.00000
benchtest  Linux 2.5.52    121     57    398    127      615 0.950 4.00000
benchtest  Linux 2.5.52    119     57    376    124      610 0.969 4.00000
benchtest  Linux 2.5.52    119     57    399    128      615 0.952 4.00000
benchtest  Linux 2.5.52    122     57    395    128      612 0.920 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.52  404  137   23    297    356    124    114  355   171
benchtest  Linux 2.5.52  342  137   23    296    355    124    113  354   170
benchtest  Linux 2.5.52  453  135   22    292    353    123    112  353   170
benchtest  Linux 2.5.52  453  137   23    296    353    123    113  352   169
benchtest  Linux 2.5.52  395  129   23    293    352    123    112  351   169

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.52   790 3.799     65    175
benchtest  Linux 2.5.52   790 3.797 8.8730    175
benchtest  Linux 2.5.52   790 3.801 8.8820    176
benchtest  Linux 2.5.52   790 3.799 8.8760    176
benchtest  Linux 2.5.52   790 3.798 8.9510    177


Regards,
Aniruddha Marathe
WIPRO technologies, India
Aniruddha.marathe@wipro.com			
+91-80-5502001 extn 5092
