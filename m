Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbSK2I2L>; Fri, 29 Nov 2002 03:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbSK2I2L>; Fri, 29 Nov 2002 03:28:11 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:14774 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S266981AbSK2I2H> convert rfc822-to-8bit; Fri, 29 Nov 2002 03:28:07 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Subject: Results of LMbench tests on 2.5.49 and 2.5.50
Date: Fri, 29 Nov 2002 14:05:16 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DAE6@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Results of LMbench tests on 2.5.49 and 2.5.50
Thread-Index: AcKXgEJSwj8LUnQESaKkw5v1jjqdIwAAB/igAAAuRaA=
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Nov 2002 08:35:16.0797 (UTC) FILETIME=[3E6256D0:01C29782]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Here are the results of LMbench tests carried out on kernel 2.5.49 and 2.5.50. Seems that 2.5.49 outperforms 2.5.50  in all the tests that are carried out by LMbench. I did repeated testing on 2.5.50 but I am getting same results. Any clue why it is the case ? 

*****************************************************************************************
                                  RESULTS FOR 2.5.49
*****************************************************************************************

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.49       i686-pc-linux-gnu  790
benchtest  Linux 2.5.49       i686-pc-linux-gnu  790
benchtest  Linux 2.5.49       i686-pc-linux-gnu  790
benchtest  Linux 2.5.49       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.49  790 0.38 0.59   26   27       1.20 5.95  327 1448 7579
benchtest  Linux 2.5.49  790 0.40 0.58   26   27    19 1.20 6.01  301 1440 7525
benchtest  Linux 2.5.49  790 0.38 0.61   26   27    22 1.21 5.99  341 1462 7654
benchtest  Linux 2.5.49  790 0.38 0.61   26   27    19 1.22 6.01  301 1482 7641

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.49 1.050 4.5600     14 6.5700    171      36     175
benchtest  Linux 2.5.49 1.110 4.4200     14 7.0600    176      39     176
benchtest  Linux 2.5.49 1.030 4.3500     14 8.4300    178      41     177
benchtest  Linux 2.5.49 1.080 4.6900     14     12    173      34     176

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.49 1.050 5.658   16    27    51   116   212  133
benchtest  Linux 2.5.49 1.110 5.672   16    28    50   167   147  133
benchtest  Linux 2.5.49 1.030 5.676   16    27         116   193 3.0M
benchtest  Linux 2.5.49 1.080 5.757   16    27    50   116   146  35M

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.49    109     46    410    105      466 0.986 3.00000
benchtest  Linux 2.5.49    109     46    314     92      462 0.909 3.00000
benchtest  Linux 2.5.49    109     47    374    104      467 0.834 3.00000
benchtest  Linux 2.5.49    111     47    333    104      472 0.918 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.49  419  138   23    301    355    124    113  356   170
benchtest  Linux 2.5.49  378  141   23    301    353    123    112  353   169
benchtest  Linux 2.5.49  514  140   23    302    351    123    111  352   168
benchtest  Linux 2.5.49  510  135   23    297    350    123    112  351   168

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.49   790 3.794     60    175
benchtest  Linux 2.5.49   790 3.797 8.8730    175
benchtest  Linux 2.5.49   790 3.803 8.8630    176
benchtest  Linux 2.5.49   790 3.795 8.8810    177

*****************************************************************************************
                                  RESULTS FOR 2.5.50
*****************************************************************************************


                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.50       i686-pc-linux-gnu  790
benchtest  Linux 2.5.50       i686-pc-linux-gnu  790
benchtest  Linux 2.5.50       i686-pc-linux-gnu  790
benchtest  Linux 2.5.50       i686-pc-linux-gnu  790
benchtest  Linux 2.5.50       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.50  790 0.45 0.80   27   29    37 1.29 6.53  435 1687 8182
benchtest  Linux 2.5.50  790 0.45 0.88   27   29    35 1.31 6.53  354 1669 8228
benchtest  Linux 2.5.50  790 0.43 0.81   27   29    36 1.35 6.53  447 1669 8118
benchtest  Linux 2.5.50  790 0.45 0.80   27   29    37 1.29 6.53  404 1659 8201
benchtest  Linux 2.5.50  790 0.43 0.87   27   29    40 1.29 6.48  458 1688 8213

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.50 1.200 4.8700     14 5.8200    177      42     178
benchtest  Linux 2.5.50 1.280 4.8400     14 7.5200    177      41     179
benchtest  Linux 2.5.50 1.370 4.9100     14 6.4000    180      45     181
benchtest  Linux 2.5.50 1.350 4.9200     14 5.8300    178      38     181
benchtest  Linux 2.5.50 1.320 5.0100     14     12    182      44     183

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.50 1.200 8.452   20    34    59   123   154  159
benchtest  Linux 2.5.50 1.280 8.532   21    34    59   124   155  159
benchtest  Linux 2.5.50 1.370 8.449   21    34    59   123   155  161
benchtest  Linux 2.5.50 1.350 8.328   20    34    59   123   154  160
benchtest  Linux 2.5.50 1.320 8.630   20    34    59   123   155  159

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.50    119     56    389    117      600 1.025 4.00000
benchtest  Linux 2.5.50    119     56    405    122      609 1.052 4.00000
benchtest  Linux 2.5.50    119     56    386    124      610 1.031 4.00000
benchtest  Linux 2.5.50    119     56    393    125      615 1.006 4.00000
benchtest  Linux 2.5.50    119     56    391    128      618 1.013 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.50  323  137   22    294    356    124    113  356   171
benchtest  Linux 2.5.50  433  125   22    292    352    123    112  351   168
benchtest  Linux 2.5.50  285  131   22    294    352    123    112  352   168
benchtest  Linux 2.5.50  335  136   22    287    350    122    112  351   168
benchtest  Linux 2.5.50  391  129   22    279    348    124    113  349   167

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.50   790 3.801 8.8780    175
benchtest  Linux 2.5.50   790 3.808 8.8820    176
benchtest  Linux 2.5.50   790 3.798 8.8730    176
benchtest  Linux 2.5.50   790 3.807 8.8820    176
benchtest  Linux 2.5.50   790 3.808 8.8830    177
*****************************************************************************************

regards,
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
