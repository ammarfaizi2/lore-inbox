Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283439AbRK2XyA>; Thu, 29 Nov 2001 18:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283435AbRK2Xxv>; Thu, 29 Nov 2001 18:53:51 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:15233 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S283439AbRK2Xxm>;
	Thu, 29 Nov 2001 18:53:42 -0500
Date: Thu, 29 Nov 2001 15:53:38 -0800 (PST)
From: J Sloan <jjs@mirai.cx>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kswapd gone nuts in RH 2.4.9-13 kernel
In-Reply-To: <3C06C76E.4000106@candelatech.com>
Message-ID: <Pine.LNX.4.33.0111291552040.2740-100000@mirai.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I did notice that the rawhide kernel is now at 2.4.16 -

Who knows, it might be worth a shot...

cu

jjs

On Thu, 29 Nov 2001, Ben Greear wrote:

> Just in case anyone is running RH's latest updated kernel,
> I just noticed that it's kswapd is running at near MAX CPU usage
> on my just-installed RH 7.2 machine.
> 
> I'm running about 10Mbps of ethernet traffic on the machine, and
> a Java GUI and not much else.
> 
> I guess once again I'll be shipping a bleeding-edge hand-built
> kernel :P
> 
> top shows:
> 
>    3:39pm  up 40 min,  5 users,  load average: 1.83, 2.16, 2.10
> 90 processes: 88 sleeping, 2 running, 0 zombie, 0 stopped
> CPU states:  0.7% user, 99.2% system,  0.0% nice,  0.0% idle
> Mem:   253960K av,  249728K used,    4232K free,     900K shrd,   71404K buff
> Swap:  522104K av,   61764K used,  460340K free                   71668K cached
> 
>    PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>      5 root      20   0     0    0     0 RW   97.0  0.0  22:57 kswapd
> 22996 lanforge   9   0  1064 1064   852 S     0.7  0.4   0:02 top
> 24412 lanforge  13   0  1064 1064   832 R     0.7  0.4   0:00 top
>   3694 lanforge   9   0  3168 2672  2672 S     0.3  1.0   0:05 magicdev
>   1234 root       1 -18  4708 4236  3188 S <   0.1  1.6   2:40 btserver
>   4582 lanforge   9   0 32684  27M 25392 S     0.1 10.9   0:06 java
>   4665 lanforge   9   0 32684  27M 25392 S     0.1 10.9   0:26 java
> 22888 lanforge   9   0  4280 4232  3424 S     0.1  1.6   0:00 gnome-terminal
> 24273 root       9   0   816  800   700 S     0.1  0.3   0:00 in.telnetd
>      1 root       8   0   516  472   472 S     0.0  0.1   0:04 init
>      2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
>      3 root       9   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled
>      4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU0
>      6 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
>      7 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
>      8 root       9   0     0    0     0 SW    0.0  0.0   0:00 kupdated
>      9 root      -1 -20     0    0     0 SW<   0.0  0.0   0:00 mdrecoveryd
>     13 root       9   0     0    0     0 SW    0.0  0.0   0:00 kjournald
>     88 root       9   0     0    0     0 SW    0.0  0.0   0:00 khubd
>    243 root       9   0     0    0     0 SW    0.0  0.0   0:00 kjournald
>    672 root       9   0   624  572   572 S     0.0  0.2   0:00 syslogd
>    677 root       9   0  1148  500   500 S     0.0  0.1   0:00 klogd
>    697 rpc        9   0   584  492   492 S     0.0  0.1   0:00 portmap
>    725 rpcuser    9   0   764  656   656 S     0.0  0.2   0:00 rpc.statd
>    837 root       9   0   528  472   472 S     0.0  0.1   0:00 apmd
>    894 root       9   0  1248 1052  1052 S     0.0  0.4   0:00 sshd
>    927 root       9   0  1028  912   872 S     0.0  0.3   0:00 xinetd
>    967 root       9   0  2076 1584  1584 S     0.0  0.6   0:00 sendmail
>    986 root       9   0   484  444   444 S     0.0  0.1   0:00 gpm
>   1004 root       8   0   680  616   600 S     0.0  0.2   0:00 crond
>   1074 xfs        9   0  4008 2184  2184 S     0.0  0.8   0:00 xfs
>   1110 daemon     9   0   576  508   508 S     0.0  0.2   0:00 atd
>   1228 root       9   0  1008  836   836 S     0.0  0.3   0:00 run_client_1
>   1230 root       9   0  1004  836   836 S     0.0  0.3   0:00 run_mgr_0
>   1237 root       9   0  5940 5156  4380 S     0.0  2.0   0:08 btserver
>   1250 root       1 -18   784  724   720 S <   0.0  0.2   0:06 gnuserver
>   1258 root       9   0  1240  988   988 S     0.0  0.3   0:00 login
>   1259 root       9   0   440  380   380 S     0.0  0.1   0:00 mingetty
>   1260 root       9   0   440  380   380 S     0.0  0.1   0:00 mingetty
> 
> 

