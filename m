Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbSJRJtC>; Fri, 18 Oct 2002 05:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSJRJtC>; Fri, 18 Oct 2002 05:49:02 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:62643 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264613AbSJRJs7>; Fri, 18 Oct 2002 05:48:59 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Lmbench-Users" <lmbench-users@bitmover.com>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Coe" <lin_coe@wipro.com>,
       "Wipro COE" <wipro-linuxcoe@sourceforge.wipro.com>
Subject: LMBench performance tool  results for 2.4 & 2.5  kernel
Date: Fri, 18 Oct 2002 15:30:15 +0530
Message-ID: <FDEHKENEPHHCPKOJCKLGEEDNCCAA.pavan.kumar@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-7394a1cc-bc3d-4a1d-ad79-0ea415e84f81"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-7394a1cc-bc3d-4a1d-ad79-0ea415e84f81
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi All,

Here I am putting the results of performance bench mark tool
LMBench (V2.0patch2).

Linux kernel 2.5.43 seems like taking more time for fork and exec
of process. Also taking long time for stat, open&close calls.

Local Communication latencies are also more for 2.5 kernel.

Can any one know why it is??

Thanks,
pavan.


==============================================================================
Linux Kernel - 2.4.20-pre11
==============================================================================

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
access1   Linux 2.4.20- i686-pc-linux-gnu_2.20-  868
access1   Linux 2.4.20- i686-pc-linux-gnu_2.20-  868
access1   Linux 2.4.20- i686-pc-linux-gnu_2.20-  868
access1   Linux 2.4.20- i686-pc-linux-gnu_2.20-  868
access1   Linux 2.4.20- i686-pc-linux-gnu_2.20-  868

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
access1   Linux 2.4.20-  868 0.41 0.70 3.97 5.17  30.7 0.96 3.06 195. 756. 4994
access1   Linux 2.4.20-  868 0.41 0.69 3.92 5.19  33.1 0.94 3.03 154. 725. 5209
access1   Linux 2.4.20-  868 0.39 0.74 3.98 5.18  36.1 0.94 3.05 161. 765. 5070
access1   Linux 2.4.20-  868 0.39 0.73 4.00 5.28  31.3 0.94 3.03 157. 796. 5086
access1   Linux 2.4.20-  868 0.39 0.69 4.01 5.13  28.5 0.94 3.05 150. 703. 5053

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
access1   Linux 2.4.20- 1.150 4.4300   13.7 7.5200  178.1    41.0   181.8
access1   Linux 2.4.20- 1.070 4.4600   14.3 7.4000  181.5    40.7   182.5
access1   Linux 2.4.20- 1.050 4.4600   13.1 7.0300  184.6    38.3   183.2
access1   Linux 2.4.20- 1.220 4.4400   14.1 6.5200  180.7    42.9   183.3
access1   Linux 2.4.20- 1.020 4.4600   13.3 9.1600  181.2    44.7   182.7

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
access1   Linux 2.4.20- 1.150 6.365 11.3  18.4  39.1  25.5  52.1 87.1
access1   Linux 2.4.20- 1.070 6.325 11.2  18.4  39.7  25.7  52.9 85.4
access1   Linux 2.4.20- 1.050 6.405 11.4  18.5  39.5  26.0  53.3 87.5
access1   Linux 2.4.20- 1.220 6.651 11.6  18.4  39.6  25.8  51.9 299K
access1   Linux 2.4.20- 1.020 6.429 11.2  18.2  39.4  25.8  51.8 189.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
access1   Linux 2.4.20-   72.4   26.3  232.9   51.9    282.0 0.785 3.00000
access1   Linux 2.4.20-   71.2   25.2  232.0   50.7    279.0 0.797 3.00000
access1   Linux 2.4.20-   72.6   26.5  237.1   52.0    279.0 0.797 2.00000
access1   Linux 2.4.20-   72.5   25.8  236.7   50.9    280.0 0.794 3.00000
access1   Linux 2.4.20-   71.3   25.4  234.5   50.7    278.0 0.797 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
access1   Linux 2.4.20- 680. 584. 115.  282.3  353.9  112.0  103.5 353. 142.1
access1   Linux 2.4.20- 684. 455. 155.  299.7  353.9  111.7  103.0 353. 141.6
access1   Linux 2.4.20- 712. 316. 144.  316.8  352.6  111.2  102.9 352. 141.4
access1   Linux 2.4.20- 668. 314. 145.  309.8  352.1  111.7  103.0 352. 141.2
access1   Linux 2.4.20- 706. 379. 111.  314.8  351.1  111.6  102.8 351. 141.1

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
access1   Linux 2.4.20-   868 3.456   54.5  177.0
access1   Linux 2.4.20-   868 3.456 8.0680  177.3
access1   Linux 2.4.20-   868 3.456 8.0630  177.8
access1   Linux 2.4.20-   868 3.471 8.0740  177.9
access1   Linux 2.4.20-   868 3.456 8.0750  177.8



==============================================================================
Linux Kernel - 2.5.43
==============================================================================

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
access1    Linux 2.5.43  868 0.39 0.77 24.6 26.2  29.9 1.02 4.73 469. 1617 7590
access1    Linux 2.5.43  868 0.39 0.77 24.6 26.3       1.02 4.73 388. 1619 7840
access1    Linux 2.5.43  868 0.41 0.81 24.6 26.2  33.2 1.06 4.72 354. 1557 7704
access1    Linux 2.5.43  868 0.39 0.79 24.7 26.3  34.4 1.02 4.73 348. 1582 7676
access1    Linux 2.5.43  868 0.39 0.77 24.6 26.3  34.9 1.02 4.72 420. 1591 7650

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
access1    Linux 2.5.43 1.230 4.5300   13.2 5.7400  187.7    44.1   188.3
access1    Linux 2.5.43 1.210 4.5400   13.1 4.8400  187.0    43.1   189.8
access1    Linux 2.5.43 1.270 4.7700   13.5 6.0400  189.9    48.5   189.8
access1    Linux 2.5.43 1.130 4.5500   13.3 6.4000  188.0    45.7   190.1
access1    Linux 2.5.43 1.080 4.5200   13.4 7.8700  189.0    43.7   189.8

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
access1    Linux 2.5.43 1.230 7.071 19.9  28.9  53.5 113.7 146.9 141.
access1    Linux 2.5.43 1.210 7.021 20.2  28.8  54.1 113.9 147.6 140.
access1    Linux 2.5.43 1.270 7.748 20.3  29.7  53.6 113.7 127.5 141.
access1    Linux 2.5.43 1.130 7.650 20.5  29.7  53.8 114.0 148.1 145.
access1    Linux 2.5.43 1.080 7.333 20.3  28.9  54.2 114.1 152.2 145.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
access1    Linux 2.5.43   98.2   53.1  283.5   88.6    498.0 0.993 4.00000
access1    Linux 2.5.43   98.4   53.3  285.3   89.1    516.0 0.991 4.00000
access1    Linux 2.5.43   98.4   53.4  285.1   88.9    506.0 1.012 4.00000
access1    Linux 2.5.43   98.4   53.4  287.3   88.4    504.0 0.998 4.00000
access1    Linux 2.5.43   98.2   53.3  287.0   89.3    513.0 0.995 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
access1    Linux 2.5.43 368. 148. 17.7  310.1  348.2  111.4  103.5 348. 140.7
access1    Linux 2.5.43 491. 145. 17.6  306.0  343.4  110.7  102.6 344. 139.4
access1    Linux 2.5.43 473. 149. 17.4  288.7  343.8  110.8  102.6 344. 139.5
access1    Linux 2.5.43 473. 143. 17.5  307.4  344.7  110.4  102.6 344. 139.5
access1    Linux 2.5.43 493. 141. 16.9  305.7  344.8  111.0  103.1 344. 139.6

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
access1    Linux 2.5.43   868 3.490 8.1540  179.8
access1    Linux 2.5.43   868 3.492 8.1540  181.2
access1    Linux 2.5.43   868 3.489   63.2  180.9
access1    Linux 2.5.43   868 3.489 8.1880  180.8
access1    Linux 2.5.43   868 3.490   57.8  181.2
==============================================================================

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

------=_NextPartTM-000-7394a1cc-bc3d-4a1d-ad79-0ea415e84f81
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

------=_NextPartTM-000-7394a1cc-bc3d-4a1d-ad79-0ea415e84f81--
