Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319607AbSIHOFI>; Sun, 8 Sep 2002 10:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319611AbSIHOFI>; Sun, 8 Sep 2002 10:05:08 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:53174 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S319607AbSIHOFG>; Sun, 8 Sep 2002 10:05:06 -0400
Message-ID: <20020908140944.347.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Sun, 08 Sep 2002 22:09:44 +0800
Subject: 2.5.33-mm5
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All/Andrew,
I've just compiled 2.5.33-mm5 (in the test report is 2.5.33M) and ran LMbench on it.
2.5.33 is preemption ON
2.5.33x is preemption OFF
2.5.33M is -mm5 preemption OFF


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
frodo     Linux 2.5.33x       i686-pc-linux-gnu  797
frodo     Linux 2.5.33M       i686-pc-linux-gnu  797

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
frodo      Linux 2.4.18  797 0.40 0.56 3.18 3.97       1.00 3.18 115. 1231 13.K
frodo      Linux 2.4.19  797 0.40 0.56 3.07 3.88       1.00 3.19 129. 1113 13.K
frodo      Linux 2.5.33  797 0.40 0.61 3.78 4.76       1.02 3.37 201. 1458 13.K
frodo     Linux 2.5.33x  797 0.40 0.60 3.51 4.38       1.02 3.27 159. 1430 13.K
frodo     Linux 2.5.33M  797 0.40 0.59 3.48 4.37       1.01 3.35 170. 1455 14.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
frodo      Linux 2.4.18 0.990 4.4200   13.8 6.2700  309.8    58.6   310.5
frodo      Linux 2.4.19 0.900 4.2900   15.3 5.9100  309.6    57.7   309.9
frodo      Linux 2.5.33 1.620 5.2800   15.3 9.3500  312.7    54.9   312.7
frodo     Linux 2.5.33x 1.040 4.3200   17.8 7.6200  312.5    49.9   312.5
frodo     Linux 2.5.33M 0.700 4.2700   14.0 8.7200  312.2    42.3   311.9

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
frodo      Linux 2.4.18 0.990 4.437 8.66                             
frodo      Linux 2.4.19 0.900 4.561 7.76                             
frodo      Linux 2.5.33 1.620 6.497 9.11                             
frodo     Linux 2.5.33x 1.040 4.888 8.70                             
frodo     Linux 2.5.33M 0.700 4.564 8.25                             

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
frodo      Linux 2.4.18   68.9   16.0  185.8   31.6    425.0 0.789 2.00000
frodo      Linux 2.4.19   68.9   14.9  186.5   29.8    416.0 0.798 2.00000
frodo      Linux 2.5.33   77.8   19.1  211.6   38.3    774.0 0.832 3.00000
frodo     Linux 2.5.33x   77.2   18.8  206.7   37.0    769.0 0.823 3.00000
frodo     Linux 2.5.33M   73.0   16.8  200.4   35.6    734.0 0.777 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
frodo      Linux 2.4.18 810. 650.       181.7  203.7  101.5  101.4 203. 195.3
frodo      Linux 2.4.19 808. 680.       187.2  203.8  101.5  101.4 203. 190.1
frodo      Linux 2.5.33 571. 636.       185.6  202.5  100.5  100.4 202. 190.3
frodo     Linux 2.5.33x 768. 710.       185.4  202.5  100.5  100.4 202. 189.5
frodo     Linux 2.5.33M 764. 707.       185.4  202.4  100.5  100.4 202. 185.8

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
frodo      Linux 2.4.18   797 3.767 8.7890  158.9
frodo      Linux 2.4.19   797 3.767 8.7980  158.9
frodo      Linux 2.5.33   797 3.798 8.8660  160.1
frodo     Linux 2.5.33x   797 3.796   45.5  160.2
frodo     Linux 2.5.33M   797 3.797 8.8660  160.2
make[1]: Leaving directory `/usr/src/LMbench/results'

Ciao,
           Paolo

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
