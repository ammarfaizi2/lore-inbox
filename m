Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279818AbRKVPXV>; Thu, 22 Nov 2001 10:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279842AbRKVPXM>; Thu, 22 Nov 2001 10:23:12 -0500
Received: from [195.66.192.167] ([195.66.192.167]:33810 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279818AbRKVPXF>; Thu, 22 Nov 2001 10:23:05 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: OOM killer in 2.4.15pre1 still not 100% ok
Date: Thu, 22 Nov 2001 17:22:47 -0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01112217224700.01298@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I saw OOM killer in action for the very fist time.
Just want to inform that it still not 100% ok (IMHO):

I reconfigured my text box for NFS root fs operation
and turned off swap. The box has 128M RAM.

At the time of OOM I was in Midnight Commander on normal vc (not xterm).
X+KDE (Kmail and a couple of Konquerors) was loaded but I didn't work
in X a that moment.

OOM killed top. I have top permanently running on vc10.
I presume it was neither big nor newly fired process so I don't think it was 
right candidate for kill.

Last top screen is below.
(How nice: OOM killer taking snapshots of processes at kill time,
i.e. aids in its own debugging! :-)
(Oh, nice idea: dump top-like info in syslog after each OOM kill?)
--
vda

5:01pm  up  1:08,  3 users,  load average: 0.18, 0.10, 0.06
61 processes: 58 sleeping, 2 running, 1 zombie, 0 stopped
CPU states:  1.9% user, 15.6% system,  0.0% nice, 82.3% idle
Mem:  126272K av, 123428K used,   2844K free,      0K shrd,     16K buff
Swap:      0K av,      0K used,      0K free                 47748K cached

PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
  4 root      15   0     0    0     0 SW      0 13.8  0.0   0:02 kswapd
974 root       9   0  4852 4852  4724 S       0  2.3  3.8   0:17 mpg123
693 user0      9   0  1440 1440  1232 R       0  0.3  1.1   0:19 top c s
790 root       9   0  5052 5052  4756 S       0  0.1  4.0   0:08 kdeinit: kded
816 root       9   0  9428 9428  8080 S       0  0.1  7.4   0:01 kdeinit: 
kdesktop
975 root       9   0  1708 1708  1592 S       0  0.1  1.3   0:00 mpg123
  1 root       8   0   188  188   160 S       0  0.0  0.1   0:05 init
  2 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 keventd
  3 root      19  19     0    0     0 SWN     0  0.0  0.0   0:00 
ksoftirqd_CPU0
  5 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 bdflush
  6 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 kupdated
  7 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 eth0
  8 root       9   0     0    0     0 SW      0  0.0  0.0   0:00 rpciod
 14 root       9   0   580  580   496 S       0  0.0  0.4   0:00 devfsd /dev
687 root       9   0   624  624   528 S       0  0.0  0.4   0:00 syslogd
690 root       9   0  1120 1120   444 S       0  0.0  0.8   0:00 klogd -c 3
702 root       9   0   124  124    96 S       0  0.0  0.0   0:00 dhcpcd -t 20 
-R -d eth1
734 rpc        9   0   644  644   540 S       0  0.0  0.5   0:00 rpc.portmap
736 root       9   0   556  556   484 S       0  0.0  0.4   0:00 inetd
738 root       9   0   664  664   564 S       0  0.0  0.5   0:00 automount 
--timeout 5 /mnt/auto
740 root       9   0   488  488   420 S       0  0.0  0.3   0:00 gpm -2 -m 
/dev/psaux -t ps2
741 root       9   0   484  484   424 S       0  0.0  0.3   0:00 /sbin/agetty 
38400 tty1 linux
743 root       9   0  1168 1168   892 S       0  0.0  0.9   0:00 -bash
745 root       9   0  1168 1168   892 S       0  0.0  0.9   0:00 -bash
748 root       9   0   484  484   424 S       0  0.0  0.3   0:00 /sbin/agetty 
38400 tty4 linux
749 root       9   0   484  484   424 S       0  0.0  0.3   0:00 /sbin/agetty 
38400 tty5 linux
752 root       9   0   484  484   424 S       0  0.0  0.3   0:00 /sbin/agetty 
38400 tty6 linux
753 root       9   0   484  484   424 S       0  0.0  0.3   0:00 /sbin/agetty 
38400 tty7 linux
754 root       9   0  1116 1116   820 S       0  0.0  0.8   0:00 nmbd 
-l/var/log/samba/nmbd.log -
755 root       9   0  1168 1168  1060 S       0  0.0  0.9   0:00 -bash
