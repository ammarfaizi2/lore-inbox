Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbTAILN6>; Thu, 9 Jan 2003 06:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTAILN6>; Thu, 9 Jan 2003 06:13:58 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:32674 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262620AbTAILN4> convert rfc822-to-8bit; Thu, 9 Jan 2003 06:13:56 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 2.5.55 Lmbench performance.
Date: Thu, 9 Jan 2003 16:52:25 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044CB3@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.55 Lmbench performance.
Thread-Index: AcK30WIu9ipDX+J+RuqBa+Z576bbmQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2003 11:22:25.0349 (UTC) FILETIME=[62CDAF50:01C2B7D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a comparison of results of 2.5.55 and 2.5.54. The figures in the table below indicate median of 5 repetitions of tests. This result doesn't have many 
Differences than the previous one.


						2.5.55	2.5.54
==============================================================================
Processor, Processes - times in microseconds - smaller is better

1. Null call				0.41		0.44
2. Null I/O					0.58		0.82
3. stat					25		29
4. open close				26		30
5. sh proc					7117		7872
6. exec proc				1285		1528
------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better

1. 2p/0K ctxsw				1.100		1.560		
------------------------------------------------------------------------------
*Local* Communication latencies in microseconds - smaller is better
1. PIPE					5.626		8.426		
2. AF UNIX					13		19
3. UDP					24		30
4. TCP connection 			126		146
------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
1. MMAP latency				472		599
------------------------------------------------------------------------------
*Local* Communication bandwidth in MB/s - bigger is better
1. PIPE					554		634
==============================================================================

Full result
****************************************************************************
				Lmbench result
				kernel 2.5.55
****************************************************************************

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.55       i686-pc-linux-gnu  790
benchtest  Linux 2.5.55       i686-pc-linux-gnu  790
benchtest  Linux 2.5.55       i686-pc-linux-gnu  790
benchtest  Linux 2.5.55       i686-pc-linux-gnu  790
benchtest  Linux 2.5.55       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.55  790 0.38 0.58   25   26    20 1.20 4.70  303 1354 7228
benchtest  Linux 2.5.55  790 0.41 0.58   25   26    18 1.22 4.93  239 1265 7047
benchtest  Linux 2.5.55  790 0.38 0.57   25   26    21 1.20 4.92  253 1285 7061
benchtest  Linux 2.5.55  790 0.41 0.58   25   26    19 1.22 4.99  291 1304 7117
benchtest  Linux 2.5.55  790 0.41 0.56   25   26    17 1.20 4.93  237 1252 7080

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.55 1.040 4.2600     15 4.7500    175      37     173
benchtest  Linux 2.5.55 1.120 4.3800     14 6.4800    173      38     175
benchtest  Linux 2.5.55 1.120 4.4500     14 8.0100    178      41     178
benchtest  Linux 2.5.55 1.100 4.3800     14 5.0000    179      38     176
benchtest  Linux 2.5.55 1.100 4.3700     14 6.8700    176      33     176

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.55 1.040 5.489   13    24    47    69    97  126
benchtest  Linux 2.5.55 1.120 5.626   14    24    47    70    97  126
benchtest  Linux 2.5.55 1.120 5.775   14    24    47    69    97  126
benchtest  Linux 2.5.55 1.100 5.692   13    24    47    69    97  126
benchtest  Linux 2.5.55 1.100 5.612   13    24    47    69    97  126

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.55    106     43    317     94      472 0.843 3.00000
benchtest  Linux 2.5.55    106     44    304     96      481 0.842 3.00000
benchtest  Linux 2.5.55    107     44    316     96      470 0.872 3.00000
benchtest  Linux 2.5.55    107     44    302     99      470 0.849 3.00000
benchtest  Linux 2.5.55    106     44    317     96      479 0.890 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.55  634  133   24    308    356    124    113  356   171
benchtest  Linux 2.5.55  248  135   25    286    353    123    112  354   170
benchtest  Linux 2.5.55  608  129   25    304    353    123    112  353   169
benchtest  Linux 2.5.55  667  138   25    301    353    123    112  353   169
benchtest  Linux 2.5.55  681  108   25    295    351    124    113  351   169

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.55   790 3.796 8.8720    174
benchtest  Linux 2.5.55   790 3.798 8.8650    175
benchtest  Linux 2.5.55   790 3.793 8.8730    175
benchtest  Linux 2.5.55   790 3.793 8.8640    176
benchtest  Linux 2.5.55   790 3.803 8.8670    176

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 

