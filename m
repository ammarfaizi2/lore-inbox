Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264156AbSIVMhv>; Sun, 22 Sep 2002 08:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbSIVMhv>; Sun, 22 Sep 2002 08:37:51 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:12455 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264156AbSIVMhs>; Sun, 22 Sep 2002 08:37:48 -0400
Message-ID: <20020922124203.32475.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 22 Sep 2002 20:42:03 +0800
Subject: LMbench2.0 results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
here it goes the results of LMbench2.0
HW is a laptop, PII@800, 256MiB of RAM.

cd results && make summary percent 2>/dev/null | more
make[1]: Entering directory `/usr/src/LMbench/results'

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
frodo      Linux 2.4.18       i686-pc-linux-gnu  797
frodo      Linux 2.4.19       i686-pc-linux-gnu  797
frodo      Linux 2.5.33       i686-pc-linux-gnu  797
frodo      Linux 2.5.34       i686-pc-linux-gnu  797
frodo      Linux 2.5.36       i686-pc-linux-gnu  797
frodo      Linux 2.5.37       i686-pc-linux-gnu  797
frodo      Linux 2.5.38       i686-pc-linux-gnu  797

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
frodo      Linux 2.4.18  797 0.40 0.57 3.18 3.96  19.4 1.00 3.18 114. 1260 13.K
frodo      Linux 2.4.19  797 0.40 0.56 3.16 4.01  16.9 1.00 3.19 112. 1136 12.K
frodo      Linux 2.5.33  797 0.40 0.62 3.70 4.74  21.8 1.02 3.31 187. 1507 13.K
frodo      Linux 2.5.34  797 0.40 0.61 3.65 4.65  15.6 1.05 3.34 184. 1505 13.K
frodo      Linux 2.5.36  797 0.38 0.57 3.44 4.30       1.02 3.29 154. 1444 13.K
frodo      Linux 2.5.37  797 0.38 0.59 3.60 4.54       1.03 3.37 164. 1460 5404
frodo      Linux 2.5.38  797 0.38 0.59 3.61 4.45       1.03 3.37 161. 1497 14.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
frodo      Linux 2.4.18 0.870 4.4000   14.0 5.7500  327.4    57.8   323.2
frodo      Linux 2.4.19 0.680 4.3000   13.9 5.7300  309.9    48.2   309.8
frodo      Linux 2.5.33 1.670 5.3300   15.1 9.6100  313.7    40.1   313.4
frodo      Linux 2.5.34 1.540 5.2200   90.7 9.1800  312.1    39.2   311.9
frodo      Linux 2.5.36 1.070 4.2000   13.9 6.8600  312.2    44.1   312.2
frodo      Linux 2.5.37 1.540 5.0000   68.7 8.1400  313.4    56.5   312.9
frodo      Linux 2.5.38 1.040 5.0300   14.8 7.6100  313.6    65.8   313.3

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
frodo      Linux 2.4.18 0.870 4.631 8.64  14.9  35.5  23.4  49.3 79.4
frodo      Linux 2.4.19 0.680 4.612 7.64  15.3  35.6  20.9  47.1 76.2
frodo      Linux 2.5.33 1.670 7.697 9.21  15.9  38.8  22.8  53.8 86.7
frodo      Linux 2.5.34 1.540 7.344 8.78  16.8  37.9  25.1  51.9 85.9
frodo      Linux 2.5.36 1.070 4.488 8.05  16.3  35.5  23.9  50.1 300K
frodo      Linux 2.5.37 1.540 6.173 9.04                             
frodo      Linux 2.5.38 1.040 7.406 8.76  16.8  37.5  24.9  51.8 87.3

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
frodo      Linux 2.4.18   68.9   16.0  186.6   31.5    426.0 0.794 2.00000
frodo      Linux 2.4.19   69.3   15.6  190.6   30.7    414.0 0.792 2.00000
frodo      Linux 2.5.33   78.2   19.8  208.6   38.2    768.0 0.816 3.00000
frodo      Linux 2.5.34   77.4   18.7  206.8   38.1    768.0 0.845 3.00000
frodo      Linux 2.5.36   75.7   17.1  203.8   35.8    736.0 0.821 3.00000
frodo      Linux 2.5.37   76.9   17.9  205.8   37.9    780.0 0.825 3.00000
frodo      Linux 2.5.38   77.2   19.0  205.8   38.5    786.0 0.827 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
frodo      Linux 2.4.18 806. 295. 132.  181.7  203.8   69.0   98.1 196. 184.2
frodo      Linux 2.4.19 765. 690. 249.  185.5  203.8  101.5  101.4 203. 190.2
frodo      Linux 2.5.33 535. 645. 44.8  185.6  202.5  100.5  100.4 202. 189.7
frodo      Linux 2.5.34 465. 649. 44.8  185.5  202.5  100.5  100.4 202. 189.4
frodo      Linux 2.5.36 759. 458. 51.4  184.0  202.6  100.5  100.4 202. 189.8
frodo      Linux 2.5.37 589. 676.       184.8  202.3  100.5  100.4 202. 191.4
frodo      Linux 2.5.38 728. 653. 48.0  184.3  202.4  100.5  100.5 202. 192.1

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
frodo      Linux 2.4.18   797 3.766 8.7970  158.9
frodo      Linux 2.4.19   797 3.767 8.7880  158.9
frodo      Linux 2.5.33   797 3.797 8.8720  160.1
frodo      Linux 2.5.34   797 3.806 8.8770  160.2
frodo      Linux 2.5.36   797 3.798 8.8730  160.1
frodo      Linux 2.5.37   797 3.799   45.0  160.2
frodo      Linux 2.5.38   797 3.795 8.8740  160.2
make[1]: Leaving directory `/usr/src/LMbench/results'

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
