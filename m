Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262834AbSJAWD3>; Tue, 1 Oct 2002 18:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262841AbSJAWD3>; Tue, 1 Oct 2002 18:03:29 -0400
Received: from p508EF4E0.dip.t-dialin.net ([80.142.244.224]:50633 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S262834AbSJAWD1>;
	Tue, 1 Oct 2002 18:03:27 -0400
Date: Wed, 2 Oct 2002 00:08:54 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: LMbench results for 2.5.40
Message-ID: <20021001220853.GA20022@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

these are LMbench results for 2.4.18 and 2.5.40 (two runs).
All results where obtained in single-user mode after a fresh
reboot.

2.5.40 was compiled with CONFIG_PREEMPT=n.

Could someone explain the results I marked with '???' ?
The ones under 'Local Communication Bandwidth'.

Patrick


                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
tony       Linux 2.4.18       i686-pc-linux-gnu 2400
tony       Linux 2.5.40       i686-pc-linux-gnu 2400
tony       Linux 2.5.40       i686-pc-linux-gnu 2400

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
tony       Linux 2.4.18 2400 0.67 0.75 1.42 2.29 6.637 1.12 2.71 93.5 445. 6145
tony       Linux 2.5.40 2400 0.66 0.77 1.51 2.41 6.830 1.14 2.83 116. 499. 6779
tony       Linux 2.5.40 2400 0.66 0.76 1.51 2.38 6.527 1.14 2.82 117. 512. 6577

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
tony       Linux 2.4.18 0.750 1.7800 4.3400 1.8500   23.8 3.85000    30.1
tony       Linux 2.5.40 1.130 1.8300 4.4200 2.0900   21.7 4.37000    30.6
tony       Linux 2.5.40 1.170 1.9300 4.4100 2.4100   21.8 3.70000    30.6

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
tony       Linux 2.4.18 0.750 4.979 7.29  12.9  23.2  14.3  28.0 44.1
tony       Linux 2.5.40 1.130 5.200 7.97  13.5  23.4  15.3  28.9 47.8
tony       Linux 2.5.40 1.170 5.575 8.02  13.7  23.8  15.2  29.6 47.9

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
tony       Linux 2.4.18   29.6 5.6840   56.9   10.4   1190.0 1.310 2.00000
tony       Linux 2.5.40   31.9 6.4960   61.2   14.4   1444.0 1.360 2.00000
tony       Linux 2.5.40   31.9 6.4530   60.5   14.4   1445.0 1.346 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
tony       Linux 2.4.18 1538 2303 1301 1967.1 2007.9  855.8  898.3 2004 1099.
tony       Linux 2.5.40 1360 2190 303. 1827.6 1979.3  804.8  857.5 1976 1201.
tony       Linux 2.5.40 1231 2140 309. 1836.3 1980.1  831.2  886.1 1979 1319.
			          ????

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
tony       Linux 2.4.18  2400 0.838 7.6860  118.2
tony       Linux 2.5.40  2400 0.862 7.7870  123.8
tony       Linux 2.5.40  2400 0.837 7.7820  123.0
