Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268266AbTAMFdc>; Mon, 13 Jan 2003 00:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbTAMFdc>; Mon, 13 Jan 2003 00:33:32 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:54983 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267961AbTAMFdS> convert rfc822-to-8bit; Mon, 13 Jan 2003 00:33:18 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 2.5.56 Lmbench results
Date: Mon, 13 Jan 2003 11:11:54 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044E2E@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.56 Lmbench results
Thread-Index: AcK6xnpCN5ndwkE5QnepbjFA4Kr6jQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2003 05:41:55.0009 (UTC) FILETIME=[7B063310:01C2BAC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a comparison of results of 2.5.56 and 2.5.55. The figures in the table 
below indicate median of 5 repetitions of tests. This result doesn't have many 
Differences than the previous one.


						2.5.56	2.5.55
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. sh proc					6530		7117
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/0K ctxsw				1.500		1.100	
2. 2p/16K ctxsw				5.14		4.3800
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. PIPE					8.357		5.626	
4. TCP  					30		69
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. MMAP latency				611		472
------------------------------------------------------------------------------
*Local* Communication bandwidth in MB/s - bigger is better
1. PIPE					554		634
2. AF UNIX					135		437
==============================================================================

Full result
****************************************************************************
				Lmbench result
				kernel 2.5.56
****************************************************************************

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.56       i686-pc-linux-gnu  790
benchtest  Linux 2.5.56       i686-pc-linux-gnu  790
benchtest  Linux 2.5.56       i686-pc-linux-gnu  790
benchtest  Linux 2.5.56       i686-pc-linux-gnu  790
benchtest  Linux 2.5.56       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.56  790 0.46 0.81 6.94 8.38       1.30 3.78  297 1259 6563
benchtest  Linux 2.5.56  790 0.44 0.80 6.90 8.34    35 1.29 3.77  243 1230 6520
benchtest  Linux 2.5.56  790 0.44 0.80 6.92 8.37    35 1.27 3.82  258 1220 6530
benchtest  Linux 2.5.56  790 0.46 0.84 6.93 8.41    33 1.30 3.77  290 1240 6524
benchtest  Linux 2.5.56  790 0.46 0.81 6.89 8.37    36 1.30 3.77  269 1257 6534

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.56 1.410 5.2200     14 6.9200    174      38     177
benchtest  Linux 2.5.56 1.390 4.8300     14 7.8400    179      39     180
benchtest  Linux 2.5.56 1.500 5.1500     14 7.4500    182      40     181
benchtest  Linux 2.5.56 1.570 5.1400     14 6.4100    178      41     179
benchtest  Linux 2.5.56 1.540 4.7900     64 9.5500    176      41     179

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.56 1.410 8.282   13    24    46    30    60  103
benchtest  Linux 2.5.56 1.390 8.458   13    24    46    43    58  102
benchtest  Linux 2.5.56 1.500 8.315   14    24    46    43    59  102
benchtest  Linux 2.5.56 1.570 8.357   13    24    59    30    58  103
benchtest  Linux 2.5.56 1.540 8.380   14    24    46    30    57  105

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.56     90     30    332     82      615 0.913 4.00000
benchtest  Linux 2.5.56     90     30    321     82      605 0.930 4.00000
benchtest  Linux 2.5.56     90     30    324     82      609 0.919 4.00000
benchtest  Linux 2.5.56     90     30    323     82      611 0.917 4.00000
benchtest  Linux 2.5.56     90     30    333     79      612 0.895 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.56  510  482   53    298    353    124    113  354   170
benchtest  Linux 2.5.56  570  252   53    291    350    122    112  351   169
benchtest  Linux 2.5.56  590  437   51    297    352    123    112  352   169
benchtest  Linux 2.5.56  575  534   52    293    352    123    112  351   169
benchtest  Linux 2.5.56  521  327   51    294    352    123    112  352   169

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.56   790 3.799 8.8810    175
benchtest  Linux 2.5.56   790 3.798     56    176
benchtest  Linux 2.5.56   790 3.799 8.8820    176
benchtest  Linux 2.5.56   790 3.798 8.8830    176
benchtest  Linux 2.5.56   790 3.808 8.8730    176

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
