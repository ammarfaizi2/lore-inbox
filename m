Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbSJPM0d>; Wed, 16 Oct 2002 08:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSJPM0Z>; Wed, 16 Oct 2002 08:26:25 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:37821 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262488AbSJPMYr>; Wed, 16 Oct 2002 08:24:47 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: LMBench (v2.0patch 2) results for 2.5 kernel.
Date: Wed, 16 Oct 2002 18:05:59 +0530
Message-ID: <004001c27510$94ef1c20$610b720a@m3xxx101262>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-278f552d-5417-4c92-a353-aaf80c02ce53"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-278f552d-5417-4c92-a353-aaf80c02ce53
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi All,

Here are the performance results of latest Linux 2.5 kernel tree using
LMBench (V2.0patch2).

There is a drop in performance for local communication from 2.5.42 kernel to
2.5.43 kernel.


Thanks,
pavan.

============================================================================
========
Test Machine details:
---------------------
processor       : 0 (single processor)
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 868.241
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1716.22

============================================================================
==========
                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
access1    Linux 2.5.42       i686-pc-linux-gnu  868
access1    Linux 2.5.42       i686-pc-linux-gnu  868
access1    Linux 2.5.42       i686-pc-linux-gnu  868
access1    Linux 2.5.42       i686-pc-linux-gnu  868
access1    Linux 2.5.42       i686-pc-linux-gnu  868

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec
sh
                             call  I/O stat clos TCP   inst hndl proc proc
proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- -
---
access1    Linux 2.5.42  868 0.42 0.78 24.6 26.1  32.7 1.04 4.93 471. 1823
8041
access1    Linux 2.5.42  868 0.39 0.78 24.6 26.0  30.0 1.04 4.94 486. 1616
7276
access1    Linux 2.5.42  868 0.41 0.78 24.6 26.2  33.3 1.04 4.93 426. 1620
7298
access1    Linux 2.5.42  868 0.39 0.77 24.6 26.2  30.0 1.04 4.94 473. 1610
7284
access1    Linux 2.5.42  868 0.41 0.79 24.6 26.1  30.0 1.04 4.93 421. 1590
7267

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
access1    Linux 2.5.42 1.240 4.5600   13.6 6.8500  191.3    48.5   192.4
access1    Linux 2.5.42 1.360 4.7200   15.6   12.7  154.9    35.7   155.2
access1    Linux 2.5.42 1.270 4.5700   13.3 5.8700  154.5    39.4   155.2
access1    Linux 2.5.42 1.320 4.5600   13.6 6.6800  155.1    35.9   156.4
access1    Linux 2.5.42 1.270 4.5400   13.6   12.6  154.5    36.3   155.0

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
access1    Linux 2.5.42 1.240 7.515 19.8  29.6  54.6 115.5 149.9 145.
access1    Linux 2.5.42 1.360 7.359 19.8  29.8  54.8 116.0 150.0 144.
access1    Linux 2.5.42 1.270 7.463 19.7  29.4  54.9 115.8 150.6 144.
access1    Linux 2.5.42 1.320 7.437 19.7  29.3  55.1 116.3 149.2 144.
access1    Linux 2.5.42 1.270 7.436 19.6  29.2  55.2 115.6 149.6 142.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
access1    Linux 2.5.42   98.6   53.3  294.9   89.3    499.0 1.058 4.00000
access1    Linux 2.5.42   97.8   52.1  267.4   86.7    501.0 1.054 4.00000
access1    Linux 2.5.42   97.8   52.2  268.7   86.7    498.0 1.061 4.00000
access1    Linux 2.5.42   97.6   52.1  268.5   86.7    511.0 1.050 3.00000
access1    Linux 2.5.42   97.7   52.0  267.8   86.5    494.0 1.075 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- ----
access1    Linux 2.5.42 348. 143. 33.8  298.6  338.5  108.2  100.4 339. 134.6
access1    Linux 2.5.42 439. 138. 19.2  349.6  408.9  131.8  125.2 406. 168.1
access1    Linux 2.5.42 395. 144. 19.0  354.9  408.1  131.2  126.3 409. 168.2
access1    Linux 2.5.42 275. 146. 38.6  353.0  400.1  131.1  123.1 407. 168.0
access1    Linux 2.5.42 456. 144. 19.1  350.6  409.4  130.9  127.7 397. 167.9

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
access1    Linux 2.5.42   868 3.491 8.2680  183.6
access1    Linux 2.5.42   868 3.494 8.1840  155.6
access1    Linux 2.5.42   868 3.489 9.5630  155.8
access1    Linux 2.5.42   868 3.491 8.1670  155.5
access1    Linux 2.5.42   868 3.490 8.1590  155.8

============================================================================
========

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
access1    Linux 2.5.43       i686-pc-linux-gnu  868
access1    Linux 2.5.43       i686-pc-linux-gnu  868
access1    Linux 2.5.43       i686-pc-linux-gnu  868
access1    Linux 2.5.43       i686-pc-linux-gnu  868
access1    Linux 2.5.43       i686-pc-linux-gnu  868

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
access1    Linux 2.5.43  868 0.41 0.79 24.8 26.3       1.04 4.73 459. 1786 8022
access1    Linux 2.5.43  868 0.40 0.79 24.5 26.3       1.04 4.73 457. 1775 7934
access1    Linux 2.5.43  868 0.41 0.80 24.7 26.3  35.8 1.02 4.72 466. 1778 8045
access1    Linux 2.5.43  868 0.41 0.80 24.6 26.4  33.7 1.06 4.75 490. 1751 7965
access1    Linux 2.5.43  868 0.41 0.78 24.6 26.4  31.7 1.02 4.73 418. 1769 7949

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
access1    Linux 2.5.43 1.430 4.6700   13.6 7.0500  187.0    42.0   184.1
access1    Linux 2.5.43 1.330 4.7600   13.7   10.6  182.8    44.4   184.2
access1    Linux 2.5.43 1.320 4.8400   13.6   10.9  186.5    45.6   186.1
access1    Linux 2.5.43 1.410 4.7100   13.8 6.6600  182.5    42.9   184.4
access1    Linux 2.5.43 1.280 4.6300   13.4 6.1300  195.7    50.6   192.1

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
access1    Linux 2.5.43 1.430 7.980 21.6  30.5  54.8 117.7 151.3 141.
access1    Linux 2.5.43 1.330 7.381 20.8  29.8  54.7 116.6 150.9 141.
access1    Linux 2.5.43 1.320 8.595 21.0  30.6  55.5 117.6 154.9 142.
access1    Linux 2.5.43 1.410 7.603 23.6  30.2  55.0 119.4 150.3 143.
access1    Linux 2.5.43 1.280 7.409 21.7  29.9  54.9 120.1 150.0 141.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
access1    Linux 2.5.43   97.8   52.4  283.2   87.5    517.0 1.140 4.00000
access1    Linux 2.5.43   98.0   52.7  284.9   87.7    507.0 1.392 4.00000
access1    Linux 2.5.43   99.1   52.7  287.7   87.5    509.0 1.013 4.00000
access1    Linux 2.5.43   98.1   52.6  285.3   87.9    520.0 1.097 4.00000
access1    Linux 2.5.43   97.9   52.5  283.5   87.8    513.0 1.139 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read
write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- ----
-
access1    Linux 2.5.43 388. 140. 17.0  296.3  351.3  108.8  104.7 346.
138.5
access1    Linux 2.5.43 322. 144. 17.1  309.9  349.6  110.7   99.5 351.
141.7
access1    Linux 2.5.43 270. 142. 17.2  309.8  350.5  106.6  100.2 351.
137.8
access1    Linux 2.5.43 312. 134. 17.4  306.6  351.4  112.2  100.5 352.
138.4
access1    Linux 2.5.43 444. 141. 17.4  309.4  351.6  113.5  104.9 352.
138.6

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
access1    Linux 2.5.43   868 3.489 8.1600  178.3
access1    Linux 2.5.43   868 3.490 8.1540  177.5
access1    Linux 2.5.43   868 3.491 8.2640  176.3
access1    Linux 2.5.43   868 3.490 8.1970  177.1
access1    Linux 2.5.43   868 3.492   59.8  176.8


============================================
PAVAN KUMAR REDDY N.S.
Sr.Software Engineer
Wipro Technologies
53/1, Hosur road, Madivala
Bangalore - 68.
Phone Off: +91-80-5502001-8 extn: 6087.
      Res: +91-80-6685179
http://www.wipro.com/linux/
============================================


------=_NextPartTM-000-278f552d-5417-4c92-a353-aaf80c02ce53
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-278f552d-5417-4c92-a353-aaf80c02ce53--
