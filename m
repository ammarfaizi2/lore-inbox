Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282117AbRKWLDJ>; Fri, 23 Nov 2001 06:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282120AbRKWLC7>; Fri, 23 Nov 2001 06:02:59 -0500
Received: from [195.66.192.167] ([195.66.192.167]:55050 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S282117AbRKWLCv>; Fri, 23 Nov 2001 06:02:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Subject: Re: OOM killer in 2.4.15pre1 still not 100% ok
Date: Fri, 23 Nov 2001 13:00:14 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01112217224700.01298@manta> <E166wVS-0004Vk-00@localhost>
In-Reply-To: <E166wVS-0004Vk-00@localhost>
MIME-Version: 1.0
Message-Id: <01112313001401.00886@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 14:15, Ryan Cumming wrote:
> Personally, I've found the new 2.4.14+ OOM killer to be highly accurate,
> I've run ext3's shared mappings torture test on my 384meg RAM (256meg swap)
> box repeatedly, and it pushes my computer to OOM every 60 seconds or so. It
> always kills the correct process, with my box remaining absolutely stable,
> even with less swap space than RAM.

OOM did it again, this time I ran glib 1.2.10 configure script and while it 
checked whether I have working -static, OOM again killed my top
(looks like it really likes my top :-). You can see newly started ld
which are about to trigger OOM within 5 secs in last screen of poor top.

Maybe I misunderstand something, but why OOM chose top? Is it how it is 
intended to work?

PS. I thought 128 Megs of RAM is enough for X+KDE+gcc...
Do we all have to play Gig'o'Rama these days?
[Yes I know that swap will help, let's not start a thread...]
--
vda

Out of Memory: Killed process 726 (top)

 12:20pm  up  1:12,  4 users,  load average: 0.39, 0.20, 0.11
 67 processes: 62 sleeping, 5 running, 0 zombie, 0 stopped
 CPU states: 12.4% user, 46.8% system,  0.0% nice, 40.7% idle
 Mem:  126272K av, 124856K used,   1416K free,      0K shrd,      0K buff
 Swap:      0K av,      0K used,      0K free                 45664K cached

 PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
   4 root      17   0     0    0     0 SW      0 14.5  0.0   0:05 kswapd
2071 root      14   0  2340 2340   728 R       0 11.0  1.8   0:00 /usr/bin/ld 
-m elf_i386 -static
 900 root      13   0  1916 1916  1788 R       0  3.5  1.5   0:35 mpg123
1964 root       9   0   968  968   856 S       0  2.1  0.7   0:00 /bin/sh 
../ltconfig --no-reexec
 868 root       9   0  7008 7008  6212 S       0  1.9  5.5   0:00 kdeinit: 
klipper -icon klipper -
1779 root       9   0   992  992   740 S       0  1.7  0.7   0:00 /bin/sh 
../configure --prefix=/u
2067 root       9   0   496  496   400 S       0  1.1  0.3   0:00 gcc -o 
conftest -g -O2 -static c
   8 root      10   0     0    0     0 SW      0  0.7  0.0   0:00 rpciod
 847 root      13   0  2272 2268  1580 R       0  0.7  1.7   0:00 artsd -F 10 
-S 4096
 726 user0      9   0  1340 1340  1128 R       0  0.5  1.0   0:21 top c s
2070 root       9   0   456  456   388 S       0  0.5  0.3   0:00 
/usr/lib/gcc301/lib/gcc-lib/i686
 820 root       9   0 47012  29M  1156 S       0  0.3 24.1   1:56 X :0 
-layout mga
 901 root      10   0  1684 1684  1568 S       0  0.3  1.3   0:01 mpg123
 844 root       9   0  5016 5016  4720 S       0  0.1  3.9   0:08 kdeinit: 
kded
 860 root       9   0  9804 9804  8368 S       0  0.1  7.7   0:01 kdeinit: 
kdesktop
   1 root       8   0    52   52    24 S       0  0.0  0.0   0:05 init
   2 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 keventd
   3 root      19  19     0    0     0 SWN     0  0.0  0.0   0:00 
ksoftirqd_CPU0
   5 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 bdflush
   6 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 kupdated
   7 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 eth0
  40 root       9   0   560  560   476 S       0  0.0  0.4   0:00 devfsd /dev
 720 root       9   0   624  624   528 S       0  0.0  0.4   0:00 syslogd
 723 root       9   0  1100 1100   424 S       0  0.0  0.8   0:00 klogd -c 3
 735 root       9   0   124  124    96 S       0  0.0  0.0   0:00 dhcpcd -t 
20 -R -d eth1
 767 rpc        9   0   644  644   540 S       0  0.0  0.5   0:00 rpc.portmap
 769 root       9   0   544  544   472 S       0  0.0  0.4   0:00 inetd
 773 root       9   0   472  472   404 S       0  0.0  0.3   0:00 gpm -2 -m 
/dev/psaux -t ps2
 790 root       9   0   484  484   424 S       0  0.0  0.3   0:00 
/sbin/agetty 38400 tty1 linux
 791 root       9   0  1168 1168   892 S       0  0.0  0.9   0:00 -bash
		   
