Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSLZEcj>; Wed, 25 Dec 2002 23:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSLZEcj>; Wed, 25 Dec 2002 23:32:39 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9187 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262395AbSLZEch> convert rfc822-to-8bit; Wed, 25 Dec 2002 23:32:37 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] Lmbench  results for 2.5.53
Date: Thu, 26 Dec 2002 10:10:36 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044243@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] Lmbench  results for 2.5.53
Thread-Index: AcKsmO6EdaaD9G6KTDWJagGGdVqQrw==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Dec 2002 04:40:37.0477 (UTC) FILETIME=[EF9BD950:01C2AC98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a comparison of results of 2.5.52 and 2.5.53. The figures in the table below indicate median of 5 repetitions of tests. This result doesn't have many 
Differences than the previous one.


						2.5.53	2.5.52
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. increase in time for sh proc 	8088		7979
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/0K ctxsw				1.390		1.190
2. 8p/16K ctxsw				7.74		6.47
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. RPC / TCP				165		159
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. prot fault				0.873		0.952
==============================================================================


*****************************************************************************
				Lmbench result
				kernel 2.5.53
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
benchtest  Linux 2.5.53  790 0.46 0.83   27   29       1.31 5.23  348 1582 7984
benchtest  Linux 2.5.53  790 0.44 0.83   27   29    36 1.30 5.46  360 1600 8089
benchtest  Linux 2.5.53  790 0.44 0.80   27   29    32 1.29 5.25  385 1598 8088
benchtest  Linux 2.5.53  790 0.46 0.84   27   29    36 1.30 5.46  384 1660 8146
benchtest  Linux 2.5.53  790 0.44 0.81   27   29    34 1.28 5.24  382 1612 8040

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.53 1.390 5.0200     14 6.1700    179      36     178
benchtest  Linux 2.5.53 1.430 5.2200     14 7.4400    178      44     181
benchtest  Linux 2.5.53 1.450 5.1000     14 7.7400    181      44     181
benchtest  Linux 2.5.53 1.470 5.0400     14 8.6800    182      41     181
benchtest  Linux 2.5.53 1.380 5.0800     14 8.5500    179      41     181

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.53 1.390 8.346   21    33    57   125   137  165
benchtest  Linux 2.5.53 1.430 8.303   21    33    57   125   153  165
benchtest  Linux 2.5.53 1.450 8.201   21    33    58   124   156  164
benchtest  Linux 2.5.53 1.470 8.611   21    33    58   124   157  164
benchtest  Linux 2.5.53 1.380 8.321   21    33    58   123   156  166

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.53    118     58    392    130      604 0.866 4.00000
benchtest  Linux 2.5.53    119     58    378    129      619 0.873 4.00000
benchtest  Linux 2.5.53    119     59    381    123      610 1.096 4.00000
benchtest  Linux 2.5.53    119     59    394    130      625 0.873 4.00000
benchtest  Linux 2.5.53    119     58    379    129      610 0.789 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.53  293  136   23    298    356    125    114  356   171
benchtest  Linux 2.5.53  412  136   23    291    352    123    112  352   169
benchtest  Linux 2.5.53  393  135   23    284    351    123    112  351   169
benchtest  Linux 2.5.53  386  137   22    280    350    123    112  350   168
benchtest  Linux 2.5.53  286  136   22    292    350    123    112  350   168

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.53   790 3.799 8.8850    175
benchtest  Linux 2.5.53   790 3.799 8.8830    176
benchtest  Linux 2.5.53   790 3.799 8.8820    176
benchtest  Linux 2.5.53   790 3.799 8.8740    177
benchtest  Linux 2.5.53   790 3.808 8.8870    177

Rest of the results are not much different.
	

Regards,
Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
