Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267985AbTBMJWm>; Thu, 13 Feb 2003 04:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267992AbTBMJWm>; Thu, 13 Feb 2003 04:22:42 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:20186 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267985AbTBMJWj> convert rfc822-to-8bit; Thu, 13 Feb 2003 04:22:39 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: [BENCHMARK] 2.5.60 Lmbench performance
Date: Thu, 13 Feb 2003 15:02:12 +0530
Message-ID: <94F20261551DC141B6B559DC4910867217BE35@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.60 Lmbench performance
Thread-Index: AcLTQslsPjXakv6QQmaqWz03Xc1o3w==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Feb 2003 09:32:13.0566 (UTC) FILETIME=[CA54E9E0:01C2D342]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are results of Lmbench for 2.5.60. Also look at the summary comparison below.

						2.5.60		2.5.59	
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. sh proc					6652		6770
------------------------------------------------------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/0K ctxsw					1.430		1.660		
------------------------------------------------------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. TCP connection 				101		110
------------------------------------------------------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. Prot fault					0.562		1.035
-------------------------------------------------------------------------------------------------------------------------------
*Local* Communication bandwidth in MB/s - bigger is better
1. AF unix					411		559
==============================================================================


*********************************************************************************************
		LMBENCH for kernel 2.5.60
*********************************************************************************************

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.60       i686-pc-linux-gnu  790
benchtest  Linux 2.5.60       i686-pc-linux-gnu  790
benchtest  Linux 2.5.60       i686-pc-linux-gnu  790
benchtest  Linux 2.5.60       i686-pc-linux-gnu  790
benchtest  Linux 2.5.60       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.60  790 0.44 0.81 7.13 8.77       1.26 4.01  282 1281 6584
benchtest  Linux 2.5.60  790 0.46 0.82 7.13 8.71    34 1.25 3.98  326 1287 6652
benchtest  Linux 2.5.60  790 0.46 0.82 7.12 8.68    34 1.26 4.01  311 1303 6627
benchtest  Linux 2.5.60  790 0.46 0.82 7.16 8.73    34 1.26 3.98  293 1302 6679
benchtest  Linux 2.5.60  790 0.44 0.82 7.30 8.80    34 1.26 3.99  336 1299 6644

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.60 1.350 4.8400     32 9.8000    175      43     178
benchtest  Linux 2.5.60 1.480 4.7900     14     10    178      41     179
benchtest  Linux 2.5.60 1.430 4.7900     14     11    178      43     179
benchtest  Linux 2.5.60 1.370 4.7400     16 9.2700    178      40     179
benchtest  Linux 2.5.60 1.430 4.8300     14 8.6300    178      42     179

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.60 1.350 8.616   13    25    47    30    57  101
benchtest  Linux 2.5.60 1.480 8.370   13    25    46    30    57  102
benchtest  Linux 2.5.60 1.430 8.384   13    24    46    31    57  102
benchtest  Linux 2.5.60 1.370 8.498   14    24    46    30    57  103
benchtest  Linux 2.5.60 1.430 8.562   14    25    46    30    58  102

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.60     92     31    362     85      641 0.562 4.00000
benchtest  Linux 2.5.60     91     30    324     80      608 0.602 4.00000
benchtest  Linux 2.5.60     91     31    325     84      618 0.574 4.00000
benchtest  Linux 2.5.60     90     30    325     83      636 0.605 4.00000
benchtest  Linux 2.5.60     90     30    325     83      624 0.605 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.60  344  309   51    295    355    124    113  355   170
benchtest  Linux 2.5.60  544  253   53    298    353    123    112  354   169
benchtest  Linux 2.5.60  511  411   52    296    353    123    112  354   169
benchtest  Linux 2.5.60  575  552   52    272    353    123    112  354   169
benchtest  Linux 2.5.60  577  477   53    295    353    123    113  354   170

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.60   790 3.800     56    174
benchtest  Linux 2.5.60   790 3.804 8.8710    175
benchtest  Linux 2.5.60   790 3.798 8.8810    175
benchtest  Linux 2.5.60   790 3.801 8.8810    175
benchtest  Linux 2.5.60   790 3.798     10    175

Aniruddha Marathe
WIPRO technologies, India
