Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbSLKJxp>; Wed, 11 Dec 2002 04:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbSLKJxp>; Wed, 11 Dec 2002 04:53:45 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:55172 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S267097AbSLKJxn> convert rfc822-to-8bit; Wed, 11 Dec 2002 04:53:43 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] LM bench result for mm1 patch of 2.5.51
Date: Wed, 11 Dec 2002 15:31:14 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DE3B@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] LM bench result for mm1 patch of 2.5.51
Thread-Index: AcKg/DyUnroIn79zROeDRV+ug3/Vbw==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Dec 2002 10:01:14.0592 (UTC) FILETIME=[3DA06600:01C2A0FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Key findings after comparison with 2.5.51
1.performance for forc proc is bit less. Must be because of the code added to kernel/fork.c
2. mmap latency is a bit more.
3. pipe local communication bandwidth is quite less.
===============================================================================
			kernel 2.5.51 with mm1
			date: 11 December 2002
===============================================================================

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.51  790 0.46 0.83   27   29       1.29 5.21  353 1554 8130
benchtest  Linux 2.5.51  790 0.46 0.87   27   29    40 1.35 5.23  445 1627 8214
benchtest  Linux 2.5.51  790 0.44 0.85   27   29    38 1.31 5.21  383 1568 8176
benchtest  Linux 2.5.51  790 0.44 0.85   27   28    34 1.31 5.20  436 1589 8232
benchtest  Linux 2.5.51  790 0.44 0.84   27   28    38 1.28 5.22  403 1593 8292

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.51 1.210 4.9400     14 9.1200    175      43     177
benchtest  Linux 2.5.51 1.180 4.6400     14 5.7000    182      41     180
benchtest  Linux 2.5.51 1.200 4.9600     20 5.7900    180      38     179
benchtest  Linux 2.5.51 1.230 4.8400     14     14    183      44     180
benchtest  Linux 2.5.51 1.260 4.5800     14 6.2600    180      40     180

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.51 1.210 8.605   21    35    60   125   159  165
benchtest  Linux 2.5.51 1.180 7.995   21    35    60   125   159  166
benchtest  Linux 2.5.51 1.200 8.216   21    35    60   125   137  166
benchtest  Linux 2.5.51 1.230 8.123   21    35    60   126   141  167
benchtest  Linux 2.5.51 1.260 8.175   21    35    60   127   158  167

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.51    119     59    385    128      651 1.008 4.00000
benchtest  Linux 2.5.51    119     59    399    128      650 1.021 4.00000
benchtest  Linux 2.5.51    119     59    390    126      652 0.999 4.00000
benchtest  Linux 2.5.51    119     59    384    132      656 0.948 4.00000
benchtest  Linux 2.5.51    119     59    385    132      651 0.984 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.51  432  131   22    286    356    124    113  356   171
benchtest  Linux 2.5.51  327  136   23    290    352    123    112  353   169
benchtest  Linux 2.5.51  344  126   22    294    351    123    111  351   169
benchtest  Linux 2.5.51  288  123   22    292    350    123    112  350   168
benchtest  Linux 2.5.51  389  136   22    294    350    123    112  349   168

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.51   790 3.798 8.8740    175
benchtest  Linux 2.5.51   790 3.808 8.8840    176
benchtest  Linux 2.5.51   790 3.808 8.8840    176
benchtest  Linux 2.5.51   790 3.797 8.8830    177
benchtest  Linux 2.5.51   790 3.808 8.8850    177

===============================================================================
			kernel 2.5.51
			date: 11 December 2002
===============================================================================

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790
benchtest  Linux 2.5.51       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.51  790 0.46 0.83   27   28    32 1.28 5.07  362 1563 8041
benchtest  Linux 2.5.51  790 0.46 0.87   27   28    39 1.30 5.08  329 1592 8081
benchtest  Linux 2.5.51  790 0.44 0.80   27   28    31 1.28 5.08  360 1589 7988
benchtest  Linux 2.5.51  790 0.46 0.83   27   28    35 1.30 5.08  341 1592 8047
benchtest  Linux 2.5.51  790 0.46 0.80   27   28    36 1.28 5.09  386 1575 8086

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.51 1.170 4.8900     14 8.8900    177      40     180
benchtest  Linux 2.5.51 1.240 5.0400     14     10    178      38     180
benchtest  Linux 2.5.51 1.330 5.0500     14 6.4600    181      39     181
benchtest  Linux 2.5.51 1.490 4.9800     14 6.9800    180      44     180
benchtest  Linux 2.5.51 1.400 5.0100     14 7.1500    180      40     180

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.51 1.170 8.107   20    33    59   122   157  166
benchtest  Linux 2.5.51 1.240 8.260   20    33    59   123   156  161
benchtest  Linux 2.5.51 1.330 8.009   20    34    59   122   155  165
benchtest  Linux 2.5.51 1.490 8.312   21    33    59   122   157  161
benchtest  Linux 2.5.51 1.400 8.299   20    33    59   123   154  164

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.51    119     57    377    123      606 0.925 4.00000
benchtest  Linux 2.5.51    119     57    390    124      621 0.932 4.00000
benchtest  Linux 2.5.51    119     57    378    126      624 0.911 4.00000
benchtest  Linux 2.5.51    119     57    380    119      615 0.922 4.00000
benchtest  Linux 2.5.51    120     57    392    128      612 0.920 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.51  381   93   23    294    356    125    114  356   171
benchtest  Linux 2.5.51  392  133   22    295    353    124    113  354   170
benchtest  Linux 2.5.51  432  137   22    295    352    123    112  354   169
benchtest  Linux 2.5.51  436  137   22    294    351    123    112  352   169
benchtest  Linux 2.5.51  373  136   23    291    350    123    112  351   168

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)

---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.51   790 3.799     56    174
benchtest  Linux 2.5.51   790 3.798 8.8820    176
benchtest  Linux 2.5.51   790 3.808 8.8730    176
benchtest  Linux 2.5.51   790 3.799 8.8820    176
benchtest  Linux 2.5.51   790 3.808 8.8820    177

Regards,
---------------------------------------------------------------
Aniruddha Marathe
Systems Engineer,
4th floor, WIPRO technologies,
53/1, Hosur road,
Madivala,
Bangalore - 560068
Karnataka, India
Phone: +91-80-5502001 extension 5092
E-mail: aniruddha.marathe@wipro.com
---------------------------------------------------------------
