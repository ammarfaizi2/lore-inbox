Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319341AbSIKVQs>; Wed, 11 Sep 2002 17:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319342AbSIKVQs>; Wed, 11 Sep 2002 17:16:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4616 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319341AbSIKVQq>;
	Wed, 11 Sep 2002 17:16:46 -0400
Message-Id: <200209112121.g8BLLY815560@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [OSDL] 2.5.34 LMBench 2.0 run with oprofile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Sep 2002 14:21:34 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Done due to a request - kernel 2.5.34 with oprofile results.

Full results at: http://www.osdl.org/archive/cliffw/lmb/index.html
Run without oprofile on simular hardware:
http://khack.osdl.org/stp/5093/


                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
cl007      Linux 2.5.34       i686-pc-linux-gnu 1000
cl007      Linux 2.5.34       i686-pc-linux-gnu 1000
cl007      Linux 2.5.34       i686-pc-linux-gnu 1000
cl007      Linux 2.5.34       i686-pc-linux-gnu 1000
cl007      Linux 2.5.34       i686-pc-linux-gnu 1000

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
cl007      Linux 2.5.34 1000 0.39 0.74 4.12 5.42  33.3 0.99 3.25 231. 933. 4810
cl007      Linux 2.5.34 1000 0.39 0.75 4.18 5.53  29.2 0.99 3.25 259. 951. 4815
cl007      Linux 2.5.34 1000 0.39 0.74 4.14 5.44  30.8 0.98 3.20 220. 928. 4769
cl007      Linux 2.5.34 1000 0.39 0.76 4.10 5.43  30.5 0.99 3.20 255. 937. 4795
cl007      Linux 2.5.34 1000 0.39 0.74 4.18 5.47  29.1 0.99 3.24 267. 953. 4850

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
cl007      Linux 2.5.34 1.130 4.5400   17.4 7.0100  101.4    14.6   112.8
cl007      Linux 2.5.34 1.170 4.2700   17.5 7.0300   94.5 9.05000   116.0
cl007      Linux 2.5.34 1.160 4.5300   13.5 6.0100  117.7 8.65000   120.6
cl007      Linux 2.5.34 1.140 7.4800   13.4 7.2300   85.8 9.47000   121.1
cl007      Linux 2.5.34 1.170 7.4200   17.2 6.9700   88.5    10.8   120.7

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
cl007      Linux 2.5.34 1.130 6.403 11.1  18.5  40.5  37.4  54.1 88.1
cl007      Linux 2.5.34 1.170 6.490 11.2  18.5  42.6  26.7  64.1 88.5
cl007      Linux 2.5.34 1.160 6.949 11.3  18.5  40.3  32.4  54.1 87.9
cl007      Linux 2.5.34 1.140 6.788 11.2  17.1  53.5  39.1  54.1 69.4
cl007      Linux 2.5.34 1.170 6.861 11.5  20.2  38.5  38.4  62.9 69.3

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
cl007      Linux 2.5.34   79.4   25.8  198.3   53.8    926.0 0.940 3.00000
cl007      Linux 2.5.34   76.1   24.9  190.6   50.2    948.0 1.000 3.00000
cl007      Linux 2.5.34   76.1   24.7  192.4   49.7    925.0 0.959 3.00000
cl007      Linux 2.5.34   80.5   27.4  198.1   53.8    923.0 1.042 3.00000
cl007      Linux 2.5.34   76.0   24.6  192.3   50.5    950.0 0.958 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
cl007      Linux 2.5.34 670. 353. 94.2  424.7  521.1  221.2  156.0 521. 212.6
cl007      Linux 2.5.34 671. 300. 97.3  424.9  521.4  218.8  154.1 521. 213.2
cl007      Linux 2.5.34 686. 269. 105.  426.9  521.4  217.7  153.7 521. 213.3
cl007      Linux 2.5.34 660. 381. 107.  425.7  521.5  217.8  153.8 521. 213.8
cl007      Linux 2.5.34 682. 357. 102.  423.9  521.5  218.4  155.9 521. 213.9

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
cl007      Linux 2.5.34  1000 3.477 8.1120  115.5
cl007      Linux 2.5.34  1000 3.477 8.2330  115.6
cl007      Linux 2.5.34  1000 3.478 8.1110  115.6
cl007      Linux 2.5.34  1000 3.478 8.1130  115.6
cl007      Linux 2.5.34  1000 3.478 8.1110  115.5


