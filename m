Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbSLSIAi>; Thu, 19 Dec 2002 03:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbSLSIAi>; Thu, 19 Dec 2002 03:00:38 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:2708 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267564AbSLSIAg> convert rfc822-to-8bit; Thu, 19 Dec 2002 03:00:36 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] Lmbench result for 5.52 mm2 patch. 
Date: Thu, 19 Dec 2002 13:38:24 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201E1B7@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] Lmbench result for 5.52 mm2 patch. 
Thread-Index: AcKnNcynoatRssPfTECffncexnKUoQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Dec 2002 08:08:24.0160 (UTC) FILETIME=[CD707600:01C2A735]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of Lmbench on 2.5.52-mm2. I have made a table of prominent changes. The table entries are median values of 5 results.
* mmap latency that was on rise for some 5.52 and mm1 patches, is now decreased.
* also fork proc is giving better performance now.

								2.5.52-mm2 		2.5.52-mm1
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1.fork proc							441			400
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/0K ctxsw						1.390			1.290
2. 2p/16k ctxsw						5.08			4.62
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. 2p/0K							1.390			1.290
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. mmap latency						597			640
------------------------------------------------------------------------------
*Local* Communication bandwidths in MB/s - bigger is better
1. pipe							404			335
==============================================================================

Here are the complete results for mm2 patch.

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
benchtest  Linux 2.5.52  790 0.44 0.82   28   29       1.28 5.20  458 1546 7942
benchtest  Linux 2.5.52  790 0.44 0.80   28   29    34 1.28 5.21  445 1564 8118
benchtest  Linux 2.5.52  790 0.44 0.80   28   29    32 1.28 5.42  351 1550 8021
benchtest  Linux 2.5.52  790 0.46 0.82   28   30    32 1.30 5.43  441 1547 8096
benchtest  Linux 2.5.52  790 0.46 0.83   28   30    34 1.30 5.42  381 1572 8048

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.52 1.390 5.0800     15 8.2900    178      43     180
benchtest  Linux 2.5.52 1.360 5.2000     14 8.8000    178      42     180
benchtest  Linux 2.5.52 1.430 4.7800     17 6.9300    181      46     181
benchtest  Linux 2.5.52 1.370 5.1800     14 6.0600    179      45     180
benchtest  Linux 2.5.52 1.450 5.2200     14 9.0300    179      42     180

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.52 1.390 8.173   21    34    59   125   156  171
benchtest  Linux 2.5.52 1.360 7.991   21    35    60   127   156  171
benchtest  Linux 2.5.52 1.430 8.242   21    35    59   126   156  175
benchtest  Linux 2.5.52 1.370 8.415   21    35    59   125   158  174
benchtest  Linux 2.5.52 1.450 8.335   21    35    60   125   156  173

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.52    118     58    373    118      586 0.912 4.00000
benchtest  Linux 2.5.52    118     58    381    129      599 0.899 4.00000
benchtest  Linux 2.5.52    119     58    381    127      587 0.891 4.00000
benchtest  Linux 2.5.52    119     58    379    129      597 0.903 4.00000
benchtest  Linux 2.5.52    119     58    377    126      601 0.980 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.52  335  137   23    299    355    124    113  355   171
benchtest  Linux 2.5.52  432  130   22    295    352    123    112  353   169
benchtest  Linux 2.5.52  322  129   22    295    352    123    112  352   169
benchtest  Linux 2.5.52  407  134   22    293    352    123    112  352   168
benchtest  Linux 2.5.52  292  131   22    290    350    124    113  350   168

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.52   790 3.799 8.8840    174
benchtest  Linux 2.5.52   790 3.807 8.8830    176
benchtest  Linux 2.5.52   790 3.798 8.8830    176
benchtest  Linux 2.5.52   790 3.808 8.8740    176
benchtest  Linux 2.5.52   790 3.808     56    177

Regards,
Aniruddha Marathe
WIPRO Ttechnologies, India
Aniruddha.marathe@wipro.com
+91-80-5502001 extn 5092.
