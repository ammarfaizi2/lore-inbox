Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286253AbRL0LWW>; Thu, 27 Dec 2001 06:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286252AbRL0LWD>; Thu, 27 Dec 2001 06:22:03 -0500
Received: from [195.2.9.241] ([195.2.9.241]:25106 "EHLO
	lingate.intern.may.co.at") by vger.kernel.org with ESMTP
	id <S273261AbRL0LWA>; Thu, 27 Dec 2001 06:22:00 -0500
Message-ID: <90B53A874299D411810500D0B7892DDA068084@srv3.intern.may.co.at>
From: Holzer Harald <hholzer@may.co.at>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Out of Memory at 20GB of free memory ??
Date: Thu, 27 Dec 2001 12:18:42 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am testing a system with 32GB ram and getting a "Out of Memory" at 20GB of
free memory.
I run 5 processes like this "dd if=/dev/urandom of=testx bs=4k count=1000000
&".
After 1 hour the system becomes very slow, and the kernel begins to killing
processes, at 20GB of free memory !?
After this the system, is going to die.
All processes are going the be killed (including init), and i must reset the
server.

Any ideas what could cause this ?

System:
Intel SRPM8 Server with 8 Intel PIII Xeon 700Mhz CPUs
32 GB Ram
2 Raid Partitions of 1 TB with ext3 fs
Redhat 7.2

Tested Kernels:
 2.4.7-10 (Redhat 7.2)
 2.4.16 (Redhat Rawhide RPM)
 2.4.17-rc2 (kernel.org)
 2.4.17 with rmap8 patch

/var/log/messages:
Dec 26 15:31:43 localhost kernel: Out of Memory: Killed process 964 (xfs).

/proc/meminfo after the first process kill:

        total:    used:    free:  shared: buffers:  cached:
Mem:  33815060480 13490249728 20324810752        0 15745024 13089452032
Swap:        0        0        0
MemTotal:     33022520 kB
MemFree:      19848448 kB
MemShared:           0 kB
Buffers:         15376 kB
Cached:       12782668 kB
SwapCached:          0 kB
Active:          27904 kB
Inactive:     12777576 kB
HighTotal:    32636928 kB
HighFree:     19846272 kB
LowTotal:       385592 kB
LowFree:          2176 kB
SwapTotal:           0 kB
SwapFree:            0 kB

top:
  3:32pm  up  1:26,  3 users,  load average: 9.79, 9.03, 7.20
49 processes: 39 sleeping, 10 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
CPU1 states:  0.0% user, 83.4% system,  0.0% nice, 16.1% idle
CPU2 states:  0.1% user, 99.1% system,  0.0% nice,  0.3% idle
CPU3 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
CPU4 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
CPU5 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
CPU6 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
CPU7 states:  0.0% user, 100.0% system,  0.0% nice,  0.0% idle
Mem:  33022520K av, 13177240K used, 19845280K free,       0K shrd,   15396K
buffSwap:       0K av,       0K used,       0K free
12789744K cached
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1353 root      15   0   548  548   472 R    99.9  0.0  71:42 dd
 1354 root      15   0   548  548   472 R    99.9  0.0  72:09 dd
 1355 root      15   0   548  548   472 R    99.9  0.0  71:03 dd
 1426 root      12   0   548  548   472 R    99.9  0.0  57:01 dd
 1427 root      15   0   548  548   472 R    99.9  0.0  56:39 dd
 1479 root      16   0   700  696   584 R    93.7  0.0   0:20 ps
  196 root      14   0     0    0     0 RW   92.3  0.0  12:29 kjournald
   11 root      14   0     0    0     0 RW   73.3  0.0   9:14 kswapd
 1408 root      15   0  1068 1068   860 R    13.4  0.0   8:47 top
   24 root       9   0     0    0     0 SW    4.5  0.0   0:32 kjournald


