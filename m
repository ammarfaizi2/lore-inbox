Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTACIus>; Fri, 3 Jan 2003 03:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTACIus>; Fri, 3 Jan 2003 03:50:48 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9702 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267439AbTACIuq> convert rfc822-to-8bit; Fri, 3 Jan 2003 03:50:46 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
Date: Fri, 3 Jan 2003 14:29:04 +0530
Message-ID: <94F20261551DC141B6B559DC4910867204491F@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
Thread-Index: AcKzBl1UO225yeCRQZ2gL7kD8rTCVQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Jan 2003 08:59:04.0683 (UTC) FILETIME=[5DEDB3B0:01C2B306]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a comparison of results of 2.5.54 with mm2 and 2.5.54. 
There are many improvements with mm2. Please see the short summary below.
The figures in the table below indicate median of 5 repetitions of tests. 
This result doesn't have many 
Differences than the previous one.


						2.5.54mm2	2.5.54
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. sig handle				3.59		5.38
2. proc fs					1212		1534
3. sh proc					6606		7872
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/0K ctxsw				1.370		1.560
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1.AF UNIX					13		19
2.UDP						24		30
3.TCP						58		75 
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. 0K create				90		118
2. 0k delete				28		55
3. 10K create				313		375
4. 10 K delete				79		126
------------------------------------------------------------------------------
*Local* Communication bandwidths in MB/s - bigger is better
1. AF UNIX					277		109
2. TCP					51		25
==============================================================================


*****************************************************************************
				Lmbench result
				kernel 2.5.54-mm2
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
Host                 	OS  Mhz null null      open selct sig  sig  fork exec sh  
                             	call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.54  790 0.44 0.81 6.28 7.58       1.27 3.63  282 1212 6618
benchtest  Linux 2.5.54  790 0.46 0.83 6.42 7.71    33 1.27 3.59  304 1217 6569
benchtest  Linux 2.5.54  790 0.46 0.82 6.39 7.68    30 1.24 3.59  337 1211 6609
benchtest  Linux 2.5.54  790 0.46 0.82 6.40 7.61    30 1.27 3.63  318 1212 6588
benchtest  Linux 2.5.54  790 0.46 0.80 6.41 7.72    32 1.24 3.59  274 1232 6606

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.54 1.350 4.8700     71 6.8600    176      41     180
benchtest  Linux 2.5.54 1.410 4.8200     18 8.3300    180      41     180
benchtest  Linux 2.5.54 1.390 4.7400     17 7.8600    179      43     180
benchtest  Linux 2.5.54 1.370 4.8200     18 8.0500    178      39     180
benchtest  Linux 2.5.54 1.370 4.7900     73     10    178      39     181

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.54 1.350 8.273   13    23    45    32    58  104
benchtest  Linux 2.5.54 1.410 8.174   13    24    45    28    58  104
benchtest  Linux 2.5.54 1.390 8.221   13    24    45    32    58  104
benchtest  Linux 2.5.54 1.370 8.279   13    24    45    32    58  104
benchtest  Linux 2.5.54 1.370 8.143   13    21    45    32    58  104

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.54     90     28    311     72      640 0.962 4.00000
benchtest  Linux 2.5.54     91     29    316     79      637 0.963 5.00000
benchtest  Linux 2.5.54     90     28    313     79      635 0.971 4.00000
benchtest  Linux 2.5.54     90     28    315     77      643 0.969 4.00000
benchtest  Linux 2.5.54     90     28    312     79      636 0.965 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.54  581  230   51    299    355    125    114  354   170
benchtest  Linux 2.5.54  595  454   52    294    352    123    112  352   169
benchtest  Linux 2.5.54  582  277   51    294    352    123    112  351   168
benchtest  Linux 2.5.54  589  238   53    281    352    123    112  351   168
benchtest  Linux 2.5.54  566  397   51    294    351    123    112  351   168

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.54   790 3.799 8.8810    175
benchtest  Linux 2.5.54   790 3.798 8.8810    176
benchtest  Linux 2.5.54   790 3.797 8.8810    176
benchtest  Linux 2.5.54   790 3.808 8.8800    176
benchtest  Linux 2.5.54   790 3.798 8.8710    176

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
