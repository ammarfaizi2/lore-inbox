Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275675AbRJFUGe>; Sat, 6 Oct 2001 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275676AbRJFUGZ>; Sat, 6 Oct 2001 16:06:25 -0400
Received: from [192.132.92.2] ([192.132.92.2]:42704 "EHLO
	bitmover.bitmover.com") by vger.kernel.org with ESMTP
	id <S275675AbRJFUGR>; Sat, 6 Oct 2001 16:06:17 -0400
Date: Sat, 6 Oct 2001 13:06:47 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: sis630/celeron perf sucks?
Message-ID: <20011006130647.B26223@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone out there seen similar problems with SIS630 motherboards?
I know that we discussed this recently and people said that the graphics
chip is eating memory bandwidth but I am not using it, it isn't even in
SVGA mode, it's in text mode and screen blanked.  I also tried setting
the AGP mem down to 2MB and that made no difference.

The reason I care is that I like these little cheap boxes called "book pcs"
and the older model was BK810 and used the i810 chipset but the newer ones
are BK630 and use the SIS630 chipset.

The new ones suck on all the stuff I care about, compiles, BitKeeper
regressions, just general software dev stuff.

Any insight appreciated.

----- Forwarded message from Larry McVoy <lm@bitmover.com> -----

From: Larry McVoy <lm@bitmover.com>
Date: Sat, 6 Oct 2001 13:02:36 -0700
To: wscott@bitmover.com
Subject: sis/celeron perf sucks?
Cc: lm@bitmover.com

This is a 633mhz system on PC133 mem
    CPU: L1 I cache: 16K, L1 D cache: 16K
    CPU: L2 cache: 128K
    Intel machine check architecture supported.
    Intel machine check reporting enabled on CPU#0.
    CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
    CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
    CPU: Common caps: 0383f9ff 00000000 00000000 00000000
    CPU: Intel Celeron (Coppermine) stepping 06

And this is a 466Mhz system on unknown (probably PC66 or PC100) mem:
    CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
    CPU: L1 I cache: 16K, L1 D cache: 16K
    CPU: L2 cache: 128K
    Intel machine check architecture supported.
    Intel machine check reporting enabled on CPU#0.
    CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
    CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
    CPU: Common caps: 0183f9ff 00000000 00000000 00000000
    CPU: Intel Celeron (Mendocino) stepping 05

The bummer is that the memory subsystem sucks doggy doo doo on the former.
Is this a motherboard problem or do the newer celerons suck that bad on
purpose?

Check out the bandwidth stuff, the second row should be faster but isn't:

                 L M B E N C H  1 . 9   S U M M A R Y
                 ------------------------------------
                 (Alpha software, do not distribute)

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos       inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
i686-linu Linux 2.4.3-2  468  0.6  0.9    5    7 0.06K  1.8    5 0.4K   3K  15K
i686-linu Linux 2.4.2-2  634  0.5  0.7    4    5 0.03K  1.3    3 0.7K   4K  17K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
i686-linu Linux 2.4.3-2    1      9    137    40    207      60     209
i686-linu Linux 2.4.2-2    0      5    214    82    469     133     470

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
i686-linu Linux 2.4.3-2     1     8   14    27          45        180
i686-linu Linux 2.4.2-2     0     5    9    26          33        188

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
i686-linu Linux 2.4.3-2     14      1     27      2      385     1    0.0K
i686-linu Linux 2.4.2-2      9      1     38      5      274     0    0.0K

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
i686-linu Linux 2.4.3-2  192   68   49    161    284    109    111  284   158
i686-linu Linux 2.4.2-2   93   30   15     82    140     42     42  140    53

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------   ---  ----   ----    --------    -------
i686-linu Linux 2.4.3-2   468     6    159         203
i686-linu Linux 2.4.2-2   634     4    133         230

----- End forwarded message -----

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
