Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTLTDoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 22:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTLTDoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 22:44:38 -0500
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:33994 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S263791AbTLTDoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 22:44:34 -0500
Date: Sat, 20 Dec 2003 11:45:48 +0800
From: Huo =?gb2312?B?WmhpZ2FuZyi79Na+uNUp?= <zghuo@ncic.ac.cn>
To: linux-kernel@vger.kernel.org
Subject: lmbench 2.4.20-8(RH9), 2.4.20, 2.6.0
Message-ID: <20031220034548.GA4809@lucent>
Reply-To: Huo Zhigang <zghuo@ncic.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy, 

Is the network performance of 2.6.0 so bad or my test
totally wrong?

Could anyone tell me how to dig into performance
optimization of linux?

=================================================================

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes  
--------- ------------- ----------------------- ---- ----- ----- ------ ----
lucent.rd Linux 2.4.20-       i686-pc-linux-gnu 1595    14   128 1.6100    1
lucent.rd  Linux 2.4.20       i686-pc-linux-gnu 1592    66   128 1.6700    1
lucent.rd   Linux 2.6.0       i686-pc-linux-gnu 1572    63   128 1.6600    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
lucent.rd Linux 2.4.20- 1595 0.99 1.09 3.25 4.54 8.41 1.57 4.25 194. 671. 3273
lucent.rd  Linux 2.4.20 1592 1.01 1.11 14.5 15.9 10.4 1.58 5.42 185. 752. 3739
lucent.rd   Linux 2.6.0 1572 0.29 0.75 17.9 25.9 10.8 1.07 16.1 336. 1223 5075
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~??

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr  
                          bit   add    mul    div    mod   
--------- ------------- ------ ------ ------ ------ ------ 
lucent.rd Linux 2.4.20- 0.3200 0.3200 8.8500   36.8   41.3
lucent.rd  Linux 2.4.20 0.3200 0.3100 8.8400   36.6   40.5
lucent.rd   Linux 2.6.0 0.3200 0.3200 9.0300   37.7   42.4

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------ 
lucent.rd Linux 2.4.20- 3.1400 4.3900   27.5   27.1
lucent.rd  Linux 2.4.20 3.3800 4.3900   27.1   27.1
lucent.rd   Linux 2.6.0 3.1900 4.4800   27.4   27.4

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------ 
lucent.rd Linux 2.4.20- 3.1500 4.4300   27.1   27.1
lucent.rd  Linux 2.4.20 3.1300 4.3700   29.3   27.1
lucent.rd   Linux 2.6.0 3.1900 4.6600   27.4   27.5

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
lucent.rd Linux 2.4.20- 1.6600 2.0400 2.0900 3.1900   24.4 6.05000    34.6
lucent.rd  Linux 2.4.20 1.7300 0.8800                 14.7 0.10000    24.9
lucent.rd   Linux 2.6.0 1.5600 1.6500 1.9200 4.6500   30.5    10.0    40.4

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
lucent.rd Linux 2.4.20- 1.660 8.525 13.3              20.7        60.
lucent.rd  Linux 2.4.20 1.730 7.541 13.5              63.8        73.
lucent.rd   Linux 2.6.0 1.560 9.622 73.4             132.6       451.
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~??
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~??

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
lucent.rd Linux 2.4.20-   31.4 4.1380   66.9 8.2450  1124.0 1.327 2.95680 5.316
lucent.rd  Linux 2.4.20   43.1   15.6   76.2   20.7  1563.0 2.989 3.55410 7.224
lucent.rd   Linux 2.6.0   67.6   28.5  124.1   58.7  1198.0 1.094 3.41040  10.6

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
lucent.rd Linux 2.4.20- 799. 1348 378.  988.8 1522.1  406.9  418.0 1520 602.8
lucent.rd  Linux 2.4.20 754. 199.       758.3  900.5  304.3  341.9 971. 438.1
lucent.rd   Linux 2.6.0 671. 316. 92.9 1044.1 1472.6  447.5  466.0 1472 647.7

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Guesses
--------- -------------   ---   ----   ----    --------    -------
lucent.rd Linux 2.4.20-  1595 1.2980   11.6       135.9
lucent.rd  Linux 2.4.20  1592 1.3650   11.7       136.7
lucent.rd   Linux 2.6.0  1572 1.3000   11.8       144.2

--
"Mom-proof" linux is my dream.
