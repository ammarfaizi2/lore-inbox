Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265551AbSKFDht>; Tue, 5 Nov 2002 22:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265553AbSKFDht>; Tue, 5 Nov 2002 22:37:49 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:52966 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S265551AbSKFDho>; Tue, 5 Nov 2002 22:37:44 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-c6de2f7f-66db-48ad-9536-eefdfda3a7c1"
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Subject: Latest kernel LMBench performance results.(with HZ=1000)
Date: Wed, 6 Nov 2002 09:14:12 +0530
Message-ID: <7F396B9772328640B7593FA817EEEDAD08AAC3@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latest kernel LMBench performance results.(with HZ=1000)
Thread-Index: AcKEx7+a0lw/AXugRb+l/QBOIXOM7gAfvedA
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2002 03:44:12.0815 (UTC) FILETIME=[C589E9F0:01C28546]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-c6de2f7f-66db-48ad-9536-eefdfda3a7c1
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable



Hi All,

Here is the summary of the LMBench performance test result of different
Linux kernels.

There is not much difference between kernels except there is
a little increase in file system and memory latency=20
between 2.5.45 and 2.5.46 kernels.


-pavan

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D

                L M B E N C H  2 . 0 [PATCH 3]  S U M M A R Y
      =20
       ------------------------------------------------------------


Hardware Specifications:
--------------------------------------

# CPU's                             : 1 - Intel PIII
Motherboard                         : Intel 810
CPU Freq                            : 859 MHz
RAM                                 : 128MB
L1 I Cache                          : 16K
L1 D Cache                          : 16K
L2 Cache                            : 256K
File System                         : ext3
glibc ver.                          : 2.2.5-34
eth0                                : RTL8139
HZ (linux/include/asm-i386/param.h)	: 1000


Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------
 OS          null null      open  selct  sig  sig  fork exec sh
             call I/O  stat close TCP    inst hndl proc proc proc
------------------------------------------------------------------
Lx2.4.19     0.39 0.68 3.98 5.33  28.8   0.95 3.07 147. 792. 5351
Lx2.4.20rc1  0.39 0.69 3.79 4.97  32.3   0.94 3.07 149. 762. 5299

Lx2.5.43     0.39 0.77 24.6 26.1  30.0   1.02 4.71 437. 1575 7817
Lx2.5.44     0.39 0.75 24.6 26.2  30.0   1.02 4.84 364. 1562 7661
Lx2.5.45     0.39 0.80 24.9 26.3  34.9   1.17 6.00 380. 1492 7551
Lx2.5.46     0.39 0.76 24.6 26.5  33.7   1.18 5.95 379. 1574 7759
------------------------------------------------------------------


Context switching - times in microseconds - smaller is better
--------------------------------------------------------------------
 OS          2p/0K  2p/16K  2p/64K  8p/16K  8p/64K  16p/16K 16p/64K
             ctxsw  ctxsw   ctxsw   ctxsw   ctxsw   ctxsw   ctxsw
--------------------------------------------------------------------
Lx2.4.19     1.120  4.4900   13.4   9.6600  186.6   42.5    188.7
Lx2.4.20rc1  1.140  4.4700   13.3   8.4400  188.0   45.1    187.6

Lx 2.5.43    1.210  4.5300   13.2   7.9600  187.2   44.4    189.7
Lx 2.5.44    1.070  4.4100   13.1   7.8600  187.1   43.4    189.8
Lx 2.5.45    1.260  4.5800   13.2   7.7400  189.0   43.3    190.2
Lx 2.5.46    1.240  4.5600   13.2   7.7500  187.7   44.7    189.3=20
--------------------------------------------------------------------


*Local* Communication latencies in microseconds - smaller is better
--------------------------------------------------------------------
 OS          2p/0K   Pipe    AF      UDP    RPC/   TCP    RPC/ TCP
             ctxsw           UNIX           UDP           TCP  conn
--------------------------------------------------------------------
Lx2.4.19     1.120   6.371   11.4    17.9   38.3   24.5   50.7 84.5
Lx2.4.20rc1  1.140   6.348   11.6    18.3   38.8   25.8   51.7 86.4

Lx2.5.43     1.140   6.936   21.6    30.1   53.7   113.7  145.4 142.
Lx2.5.44     1.170   7.010   19.1    29.8   55.5   113.5  146.1 143.
Lx2.5.45     1.190   7.537   17.9    30.2   53.6    73.3  101.2 149.
Lx2.5.46     1.240   6.858   19.3    31.5   54.4   113.4  141.8 148.
---------------------------------------------------------------------


File & VM system latencies in microseconds - smaller is better
------------------------------------------------------------------
 OS             0K File       10K File     Mmap     Prot    Page
             Create Delete  Create Delete  Latency  Fault   Fault
------------------------------------------------------------------
Lx2.4.19     71.7    23.6    238.3   48.9   293.0   0.771 2.00000
Lx2.4.20rc1  72.3    24.8    243.2   49.4   287.0   0.758 2.00000

Lx2.5.43     97.7    52.9    294.8   88.6   510.0   0.971 3.00000
Lx2.5.44     98.2    53.2    298.2   88.4   505.0   0.927 3.00000
Lx2.5.45     105.8   54.4    308.3   92.4   508.0   0.957 3.00000
Lx2.5.46     102.4   56.4    303.9   95.5   563.0   1.020 3.00000
------------------------------------------------------------------


*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------
OS           Pipe AF   TCP  File   Mmap   Bcopy Bcopy Mem  Mem
                  UNIX      reread reread (libc)(hand)read write
-----------------------------------------------------------------
Lx2.4.19     719. 337. 150. 310.3  344.8  110.4 102.2 345. 139.7
Lx2.4.20rc1  721. 409. 150. 311.1  345.4  110.6 101.6 344. 139.9

Lx2.5.43     387. 147. 17.7 304.9  344.5  110.6 102.8 345. 139.5
Lx2.5.44     402. 150. 17.1 307.1  344.4  110.6 102.7 344. 139.7
Lx2.5.45     383. 250. 22.0 305.2  344.8  111.2 102.5 344. 139.6
Lx2.5.46     359. 147. 21.2 304.4  344.0  110.9 102.1 343. 139.5
-----------------------------------------------------------------


Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
-----------------------------------------------------------------
OS                  Mhz  L1 $     L2 $    Main mem      Guesses
-----------------------------------------------------------------
Linux 2.4.19        859  3.490   8.1530   180.9
Linux 2.4.20rc1     859  3.490   8.1530   180.6

Linux 2.5.43        859  3.490   8.1540   180.8
Linux 2.5.44        859  3.491   8.1540   181.0
Linux 2.5.45        859  3.490   8.1540   179.6=20
Linux 2.5.46        859  3.491   8.1570   181.3
-----------------------------------------------------------------

Note: All results are average of five iterations.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PAVAN KUMAR REDDY N.S.
Sr.Software Engineer
Wipro Technologies
53/1, Hosur road, Madivala
Bangalore - 68.
pavan.kumar@wipro.com
Phone Off: +91-80-5502001-8 extn: 5086.
      Res: +91-80-6685179
http://www.wipro.com/linux/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =20

------=_NextPartTM-000-c6de2f7f-66db-48ad-9536-eefdfda3a7c1
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

------=_NextPartTM-000-c6de2f7f-66db-48ad-9536-eefdfda3a7c1--
