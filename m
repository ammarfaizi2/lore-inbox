Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTIOMta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbTIOMta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:49:30 -0400
Received: from main.gmane.org ([80.91.224.249]:31420 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261322AbTIOMtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:49:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH]O20.1int
Date: Mon, 15 Sep 2003 14:48:23 +0200
Message-ID: <yw1x4qzefca0.fsf@users.sourceforge.net>
References: <200309101300.20634.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:gWIa5vtutZgpRIFafHnQTuZzCDE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Con Kolivas <kernel@kolivas.org> writes:

> Should be the last of the O1int patches.
>
> Tiny tweak to keep top two interactive levels round robin at the fastest 
> (10ms) which keeps X smooth when another interactive task is also using 
> bursts of cpu (eg web browser).

I still see the occasional problem with XEmacs.  This time I managed
to get some traces of it.  It looks like it is switching madly between
XEmacs and X.


--=-=-=
Content-Disposition: attachment; filename=xemacs.top

top - 18:16:42 up 21:13,  1 user,  load average: 0.24, 0.14, 0.06
Tasks:  65 total,   1 running,  63 sleeping,   0 stopped,   1 zombie
Cpu(s):   1.2% user,   0.3% system,   0.0% nice,  98.0% idle,   0.6% IO-wait
Mem:    224128k total,   138548k used,    85580k free,    10504k buffers
Swap:   524280k total,      840k used,   523440k free,    61624k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  904 root      15   0 45364  10m  35m S  2.0  4.9   3:57.57 X
  962 mru       15   0 26560  21m 9492 S  2.0 10.0   1:00.76 xemacs
  923 mru       16   0  2388 1468 2060 S  1.0  0.7   0:00.35 bash
    1 root      16   0   480  228  456 S  0.0  0.1   0:05.69 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    3 root       5 -10     0    0    0 S  0.0  0.0   0:45.68 events/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
    5 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
    6 root      15   0     0    0    0 S  0.0  0.0   0:00.08 pdflush
    7 root      15   0     0    0    0 S  0.0  0.0   0:01.11 kswapd0
    8 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
    9 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
   10 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   27 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   35 root      16   0  1560  768 1344 S  0.0  0.3   0:00.00 devfsd
   60 root      18   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   61 root      19   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   62 root      15   0     0    0    0 S  0.0  0.0   0:00.06 kjournald
   63 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   64 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   65 root      15   0     0    0    0 S  0.0  0.0   0:00.04 kjournald
   66 root      15   0     0    0    0 S  0.0  0.0   0:00.03 kjournald
   67 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
  102 root      21   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  112 root      23   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  115 root      18   0  1496  692 1340 S  0.0  0.3   0:00.00 cardmgr
  164 root      16   0     0    0    0 S  0.0  0.0   0:00.00 knodemgrd_0
  187 root      15   0     0    0    0 S  0.0  0.0   0:00.00 khubd
  735 rpc       20   0  1508  568 1448 S  0.0  0.3   0:00.00 rpc.portmap
  741 root      16   0  1428  616 1364 S  0.0  0.3   0:00.00 syslogd
  744 root      16   0  1360  460 1320 S  0.0  0.2   0:00.00 klogd
  746 root      18   0  1400  528 1360 S  0.0  0.2   0:00.00 inetd
  765 root      16   0  1472  636 1420 S  0.0  0.3   0:00.00 automount
  852 lp        17   0  3388 1280 3260 S  0.0  0.6   0:00.10 lpd
  855 root      16   0  1484  592 1436 S  0.0  0.3   0:00.00 crond
  858 daemon    16   0  1492  656 1440 S  0.0  0.3   0:00.00 atd
  861 root      16   0  3288 1448 2644 S  0.0  0.6   0:00.06 sendmail
  864 smmsp     16   0  3284 1432 2644 S  0.0  0.6   0:00.00 sendmail
  868 root      15   0  1364  556 1316 S  0.0  0.2   0:00.01 acpid
  870 mru       17   0  2312 1180 2060 S  0.0  0.5   0:00.05 bash
  871 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  872 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  873 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  874 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  875 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  890 mru       18   0  2752  848 2508 S  0.0  0.4   0:00.00 ssh-agent
  891 mru       18   0  2052 1016 1936 S  0.0  0.5   0:00.00 startx
  903 mru       17   0  2232  652 2188 S  0.0  0.3   0:00.00 xinit
  910 mru       15   0  8508 3952 5196 S  0.0  1.8   0:08.43 sawfish
  916 mru       15   0  1464  680 1316 S  0.0  0.3   0:00.00 asus_acpid
  921 mru       16   0     0    0    0 Z  0.0  0.0   0:00.36 kdeskto <defunct>
  922 mru       15   0  7792 5328 4756 S  0.0  2.4   0:28.99 xterm
  928 mru       16   0 24360  12m  22m S  0.0  5.7   0:08.31 kdesktop
  930 mru       16   0 21196 8668  20m S  0.0  3.9   0:00.02 kdeinit
  933 mru       15   0 21328 9024  20m S  0.0  4.0   0:00.02 kdeinit
  936 mru       15   0 21416 9456  20m S  0.0  4.2   0:00.02 kdeinit
  938 mru       16   0 22428  11m  20m S  0.0  5.1   0:00.36 kdeinit
  960 mru       18   0  2036  944 1936 S  0.0  0.4   0:00.00 sh
  963 mru       16   0  3768 1072 3692 S  0.0  0.5   0:00.00 gnuserv
 2735 mru       15   0  2432 1452 1388 S  0.0  0.6   0:00.15 ispell
16370 mru       16   0  7776 2736 4756 S  0.0  1.2   0:00.05 xterm
16371 mru       16   0  2308 1372 2060 S  0.0  0.6   0:00.00 bash
23957 mru       15   0  7776 2836 4756 S  0.0  1.3   0:00.14 xterm
23958 mru       16   0  2308 1376 2060 S  0.0  0.6   0:00.04 bash
24413 mru       16   0  1868  936 1740 R  0.0  0.4   0:00.00 top


top - 18:16:43 up 21:13,  1 user,  load average: 0.24, 0.14, 0.06
Tasks:  65 total,   1 running,  63 sleeping,   0 stopped,   1 zombie
Cpu(s):   1.0% user,   1.0% system,   0.0% nice,  98.0% idle,   0.0% IO-wait
Mem:    224128k total,   138548k used,    85580k free,    10504k buffers
Swap:   524280k total,      840k used,   523440k free,    61632k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
24413 mru       16   0  1880 1012 1740 R  1.0  0.5   0:00.01 top
    1 root      16   0   480  228  456 S  0.0  0.1   0:05.69 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    3 root       5 -10     0    0    0 S  0.0  0.0   0:45.68 events/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
    5 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
    6 root      15   0     0    0    0 S  0.0  0.0   0:00.08 pdflush
    7 root      15   0     0    0    0 S  0.0  0.0   0:01.11 kswapd0
    8 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
    9 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
   10 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   27 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   35 root      16   0  1560  768 1344 S  0.0  0.3   0:00.00 devfsd
   60 root      18   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   61 root      19   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   62 root      15   0     0    0    0 S  0.0  0.0   0:00.06 kjournald
   63 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   64 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   65 root      15   0     0    0    0 S  0.0  0.0   0:00.04 kjournald
   66 root      15   0     0    0    0 S  0.0  0.0   0:00.03 kjournald
   67 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
  102 root      21   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  112 root      23   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  115 root      18   0  1496  692 1340 S  0.0  0.3   0:00.00 cardmgr
  164 root      16   0     0    0    0 S  0.0  0.0   0:00.00 knodemgrd_0
  187 root      15   0     0    0    0 S  0.0  0.0   0:00.00 khubd
  735 rpc       20   0  1508  568 1448 S  0.0  0.3   0:00.00 rpc.portmap
  741 root      16   0  1428  616 1364 S  0.0  0.3   0:00.00 syslogd
  744 root      16   0  1360  460 1320 S  0.0  0.2   0:00.00 klogd
  746 root      18   0  1400  528 1360 S  0.0  0.2   0:00.00 inetd
  765 root      16   0  1472  636 1420 S  0.0  0.3   0:00.00 automount
  852 lp        17   0  3388 1280 3260 S  0.0  0.6   0:00.10 lpd
  855 root      16   0  1484  592 1436 S  0.0  0.3   0:00.00 crond
  858 daemon    16   0  1492  656 1440 S  0.0  0.3   0:00.00 atd
  861 root      16   0  3288 1448 2644 S  0.0  0.6   0:00.06 sendmail
  864 smmsp     16   0  3284 1432 2644 S  0.0  0.6   0:00.00 sendmail
  868 root      15   0  1364  556 1316 S  0.0  0.2   0:00.01 acpid
  870 mru       17   0  2312 1180 2060 S  0.0  0.5   0:00.05 bash
  871 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  872 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  873 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  874 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  875 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  890 mru       18   0  2752  848 2508 S  0.0  0.4   0:00.00 ssh-agent
  891 mru       18   0  2052 1016 1936 S  0.0  0.5   0:00.00 startx
  903 mru       17   0  2232  652 2188 S  0.0  0.3   0:00.00 xinit
  904 root      15   0 45364  10m  35m S  0.0  4.9   3:57.57 X
  910 mru       16   0  8508 3952 5196 S  0.0  1.8   0:08.43 sawfish
  916 mru       15   0  1464  680 1316 S  0.0  0.3   0:00.00 asus_acpid
  921 mru       16   0     0    0    0 Z  0.0  0.0   0:00.36 kdeskto <defunct>
  922 mru       15   0  7792 5328 4756 S  0.0  2.4   0:28.99 xterm
  923 mru       16   0  2388 1468 2060 S  0.0  0.7   0:00.35 bash
  928 mru       16   0 24360  12m  22m S  0.0  5.7   0:08.31 kdesktop
  930 mru       16   0 21196 8668  20m S  0.0  3.9   0:00.02 kdeinit
  933 mru       15   0 21328 9024  20m S  0.0  4.0   0:00.02 kdeinit
  936 mru       15   0 21416 9456  20m S  0.0  4.2   0:00.02 kdeinit
  938 mru       16   0 22428  11m  20m S  0.0  5.1   0:00.36 kdeinit
  960 mru       18   0  2036  944 1936 S  0.0  0.4   0:00.00 sh
  962 mru       15   0 26560  21m 9492 S  0.0 10.0   1:00.76 xemacs
  963 mru       16   0  3768 1072 3692 S  0.0  0.5   0:00.00 gnuserv
 2735 mru       15   0  2432 1452 1388 S  0.0  0.6   0:00.15 ispell
16370 mru       16   0  7776 2736 4756 S  0.0  1.2   0:00.05 xterm
16371 mru       16   0  2308 1372 2060 S  0.0  0.6   0:00.00 bash
23957 mru       15   0  7776 2836 4756 S  0.0  1.3   0:00.14 xterm
23958 mru       16   0  2308 1376 2060 S  0.0  0.6   0:00.04 bash


top - 18:16:44 up 21:13,  1 user,  load average: 0.24, 0.14, 0.06
Tasks:  66 total,   3 running,  62 sleeping,   0 stopped,   1 zombie
Cpu(s):  30.7% user,   9.9% system,   0.0% nice,  59.4% idle,   0.0% IO-wait
Mem:    224128k total,   138764k used,    85364k free,    10504k buffers
Swap:   524280k total,      840k used,   523440k free,    61636k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  962 mru       17   0 26560  21m 9492 R 24.8 10.0   1:01.01 xemacs
  904 root      15   0 45364  10m  35m S  7.0  4.9   3:57.64 X
24414 mru       25   0     0    0    0 R  2.0  0.0   0:00.02 make
    1 root      16   0   480  228  456 S  0.0  0.1   0:05.69 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    3 root       5 -10     0    0    0 S  0.0  0.0   0:45.68 events/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
    5 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
    6 root      15   0     0    0    0 S  0.0  0.0   0:00.08 pdflush
    7 root      15   0     0    0    0 S  0.0  0.0   0:01.11 kswapd0
    8 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
    9 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
   10 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   27 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   35 root      16   0  1560  768 1344 S  0.0  0.3   0:00.00 devfsd
   60 root      18   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   61 root      19   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   62 root      15   0     0    0    0 S  0.0  0.0   0:00.06 kjournald
   63 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   64 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   65 root      15   0     0    0    0 S  0.0  0.0   0:00.04 kjournald
   66 root      15   0     0    0    0 S  0.0  0.0   0:00.03 kjournald
   67 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
  102 root      21   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  112 root      23   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  115 root      18   0  1496  692 1340 S  0.0  0.3   0:00.00 cardmgr
  164 root      16   0     0    0    0 S  0.0  0.0   0:00.00 knodemgrd_0
  187 root      15   0     0    0    0 S  0.0  0.0   0:00.00 khubd
  735 rpc       20   0  1508  568 1448 S  0.0  0.3   0:00.00 rpc.portmap
  741 root      16   0  1428  616 1364 S  0.0  0.3   0:00.00 syslogd
  744 root      16   0  1360  460 1320 S  0.0  0.2   0:00.00 klogd
  746 root      18   0  1400  528 1360 S  0.0  0.2   0:00.00 inetd
  765 root      16   0  1472  636 1420 S  0.0  0.3   0:00.00 automount
  852 lp        17   0  3388 1280 3260 S  0.0  0.6   0:00.10 lpd
  855 root      16   0  1484  592 1436 S  0.0  0.3   0:00.00 crond
  858 daemon    16   0  1492  656 1440 S  0.0  0.3   0:00.00 atd
  861 root      16   0  3288 1448 2644 S  0.0  0.6   0:00.06 sendmail
  864 smmsp     16   0  3284 1432 2644 S  0.0  0.6   0:00.00 sendmail
  868 root      15   0  1364  556 1316 S  0.0  0.2   0:00.01 acpid
  870 mru       17   0  2312 1180 2060 S  0.0  0.5   0:00.05 bash
  871 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  872 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  873 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  874 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  875 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  890 mru       18   0  2752  848 2508 S  0.0  0.4   0:00.00 ssh-agent
  891 mru       18   0  2052 1016 1936 S  0.0  0.5   0:00.00 startx
  903 mru       17   0  2232  652 2188 S  0.0  0.3   0:00.00 xinit
  910 mru       16   0  8508 3952 5196 S  0.0  1.8   0:08.43 sawfish
  916 mru       15   0  1464  680 1316 S  0.0  0.3   0:00.00 asus_acpid
  921 mru       16   0     0    0    0 Z  0.0  0.0   0:00.36 kdeskto <defunct>
  922 mru       15   0  7792 5328 4756 S  0.0  2.4   0:28.99 xterm
  923 mru       16   0  2388 1468 2060 S  0.0  0.7   0:00.35 bash
  928 mru       16   0 24360  12m  22m S  0.0  5.7   0:08.31 kdesktop
  930 mru       16   0 21196 8668  20m S  0.0  3.9   0:00.02 kdeinit
  933 mru       15   0 21328 9024  20m S  0.0  4.0   0:00.02 kdeinit
  936 mru       15   0 21416 9456  20m S  0.0  4.2   0:00.02 kdeinit
  938 mru       16   0 22428  11m  20m S  0.0  5.1   0:00.36 kdeinit
  960 mru       18   0  2036  944 1936 S  0.0  0.4   0:00.00 sh
  963 mru       16   0  3768 1072 3692 S  0.0  0.5   0:00.00 gnuserv
 2735 mru       15   0  2432 1452 1388 S  0.0  0.6   0:00.15 ispell
16370 mru       16   0  7776 2736 4756 S  0.0  1.2   0:00.05 xterm
16371 mru       16   0  2308 1372 2060 S  0.0  0.6   0:00.00 bash
23957 mru       15   0  7776 2836 4756 S  0.0  1.3   0:00.14 xterm
23958 mru       16   0  2308 1376 2060 S  0.0  0.6   0:00.04 bash
24413 mru       16   0  1880 1012 1740 R  0.0  0.5   0:00.01 top


top - 18:16:45 up 21:13,  1 user,  load average: 0.24, 0.14, 0.06
Tasks:  66 total,   3 running,  62 sleeping,   0 stopped,   1 zombie
Cpu(s):  84.0% user,  16.0% system,   0.0% nice,   0.0% idle,   0.0% IO-wait
Mem:    224128k total,   138764k used,    85364k free,    10504k buffers
Swap:   524280k total,      840k used,   523440k free,    61644k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  962 mru       18   0 26560  21m 9492 R 83.4 10.0   1:01.85 xemacs
  904 root      15   0 45364  10m  35m S 16.9  4.9   3:57.81 X
    1 root      16   0   480  228  456 S  0.0  0.1   0:05.69 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    3 root       5 -10     0    0    0 S  0.0  0.0   0:45.68 events/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
    5 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
    6 root      15   0     0    0    0 S  0.0  0.0   0:00.08 pdflush
    7 root      15   0     0    0    0 S  0.0  0.0   0:01.11 kswapd0
    8 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
    9 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
   10 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   27 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   35 root      16   0  1560  768 1344 S  0.0  0.3   0:00.00 devfsd
   60 root      18   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   61 root      19   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   62 root      15   0     0    0    0 S  0.0  0.0   0:00.06 kjournald
   63 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   64 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   65 root      15   0     0    0    0 S  0.0  0.0   0:00.04 kjournald
   66 root      15   0     0    0    0 S  0.0  0.0   0:00.03 kjournald
   67 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
  102 root      21   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  112 root      23   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  115 root      18   0  1496  692 1340 S  0.0  0.3   0:00.00 cardmgr
  164 root      16   0     0    0    0 S  0.0  0.0   0:00.00 knodemgrd_0
  187 root      15   0     0    0    0 S  0.0  0.0   0:00.00 khubd
  735 rpc       20   0  1508  568 1448 S  0.0  0.3   0:00.00 rpc.portmap
  741 root      16   0  1428  616 1364 S  0.0  0.3   0:00.00 syslogd
  744 root      16   0  1360  460 1320 S  0.0  0.2   0:00.00 klogd
  746 root      18   0  1400  528 1360 S  0.0  0.2   0:00.00 inetd
  765 root      16   0  1472  636 1420 S  0.0  0.3   0:00.00 automount
  852 lp        17   0  3388 1280 3260 S  0.0  0.6   0:00.10 lpd
  855 root      16   0  1484  592 1436 S  0.0  0.3   0:00.00 crond
  858 daemon    16   0  1492  656 1440 S  0.0  0.3   0:00.00 atd
  861 root      16   0  3288 1448 2644 S  0.0  0.6   0:00.06 sendmail
  864 smmsp     16   0  3284 1432 2644 S  0.0  0.6   0:00.00 sendmail
  868 root      15   0  1364  556 1316 S  0.0  0.2   0:00.01 acpid
  870 mru       17   0  2312 1180 2060 S  0.0  0.5   0:00.05 bash
  871 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  872 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  873 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  874 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  875 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  890 mru       18   0  2752  848 2508 S  0.0  0.4   0:00.00 ssh-agent
  891 mru       18   0  2052 1016 1936 S  0.0  0.5   0:00.00 startx
  903 mru       17   0  2232  652 2188 S  0.0  0.3   0:00.00 xinit
  910 mru       16   0  8508 3952 5196 S  0.0  1.8   0:08.43 sawfish
  916 mru       15   0  1464  680 1316 S  0.0  0.3   0:00.00 asus_acpid
  921 mru       16   0     0    0    0 Z  0.0  0.0   0:00.36 kdeskto <defunct>
  922 mru       15   0  7792 5328 4756 S  0.0  2.4   0:28.99 xterm
  923 mru       16   0  2388 1468 2060 S  0.0  0.7   0:00.35 bash
  928 mru       16   0 24360  12m  22m S  0.0  5.7   0:08.31 kdesktop
  930 mru       16   0 21196 8668  20m S  0.0  3.9   0:00.02 kdeinit
  933 mru       15   0 21328 9024  20m S  0.0  4.0   0:00.02 kdeinit
  936 mru       15   0 21416 9456  20m S  0.0  4.2   0:00.02 kdeinit
  938 mru       16   0 22428  11m  20m S  0.0  5.1   0:00.36 kdeinit
  960 mru       18   0  2036  944 1936 S  0.0  0.4   0:00.00 sh
  963 mru       16   0  3768 1072 3692 S  0.0  0.5   0:00.00 gnuserv
 2735 mru       15   0  2432 1452 1388 S  0.0  0.6   0:00.15 ispell
16370 mru       16   0  7776 2736 4756 S  0.0  1.2   0:00.05 xterm
16371 mru       16   0  2308 1372 2060 S  0.0  0.6   0:00.00 bash
23957 mru       15   0  7776 2836 4756 S  0.0  1.3   0:00.14 xterm
23958 mru       16   0  2308 1376 2060 S  0.0  0.6   0:00.04 bash
24413 mru       16   0  1880 1012 1740 R  0.0  0.5   0:00.01 top
24414 mru       25   0     0    0    0 R  0.0  0.0   0:00.02 make


top - 18:16:46 up 21:13,  1 user,  load average: 0.22, 0.14, 0.05
Tasks:  65 total,   1 running,  63 sleeping,   0 stopped,   1 zombie
Cpu(s):  39.6% user,   7.9% system,   0.0% nice,  52.5% idle,   0.0% IO-wait
Mem:    224128k total,   138764k used,    85364k free,    10516k buffers
Swap:   524280k total,      840k used,   523440k free,    61648k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  962 mru       16   0 26560  21m 9492 S 37.7 10.0   1:02.23 xemacs
  904 root      15   0 45364  10m  35m S  7.9  4.9   3:57.89 X
24413 mru       16   0  1880 1012 1740 R  2.0  0.5   0:00.03 top
    1 root      16   0   480  228  456 S  0.0  0.1   0:05.69 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    3 root       5 -10     0    0    0 S  0.0  0.0   0:45.68 events/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
    5 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
    6 root      15   0     0    0    0 S  0.0  0.0   0:00.08 pdflush
    7 root      15   0     0    0    0 S  0.0  0.0   0:01.11 kswapd0
    8 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
    9 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
   10 root      23   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   27 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   35 root      16   0  1560  768 1344 S  0.0  0.3   0:00.00 devfsd
   60 root      18   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   61 root      19   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   62 root      15   0     0    0    0 S  0.0  0.0   0:00.06 kjournald
   63 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   64 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
   65 root      15   0     0    0    0 S  0.0  0.0   0:00.04 kjournald
   66 root      15   0     0    0    0 S  0.0  0.0   0:00.03 kjournald
   67 root      15   0     0    0    0 S  0.0  0.0   0:00.01 kjournald
  102 root      21   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  112 root      23   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
  115 root      18   0  1496  692 1340 S  0.0  0.3   0:00.00 cardmgr
  164 root      16   0     0    0    0 S  0.0  0.0   0:00.00 knodemgrd_0
  187 root      15   0     0    0    0 S  0.0  0.0   0:00.00 khubd
  735 rpc       20   0  1508  568 1448 S  0.0  0.3   0:00.00 rpc.portmap
  741 root      16   0  1428  616 1364 S  0.0  0.3   0:00.00 syslogd
  744 root      16   0  1360  460 1320 S  0.0  0.2   0:00.00 klogd
  746 root      18   0  1400  528 1360 S  0.0  0.2   0:00.00 inetd
  765 root      16   0  1472  636 1420 S  0.0  0.3   0:00.00 automount
  852 lp        17   0  3388 1280 3260 S  0.0  0.6   0:00.10 lpd
  855 root      16   0  1484  592 1436 S  0.0  0.3   0:00.00 crond
  858 daemon    16   0  1492  656 1440 S  0.0  0.3   0:00.00 atd
  861 root      16   0  3288 1448 2644 S  0.0  0.6   0:00.06 sendmail
  864 smmsp     16   0  3284 1432 2644 S  0.0  0.6   0:00.00 sendmail
  868 root      15   0  1364  556 1316 S  0.0  0.2   0:00.01 acpid
  870 mru       17   0  2312 1180 2060 S  0.0  0.5   0:00.05 bash
  871 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  872 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  873 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  874 root      16   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  875 root      17   0  1356  416 1312 S  0.0  0.2   0:00.00 agetty
  890 mru       18   0  2752  848 2508 S  0.0  0.4   0:00.00 ssh-agent
  891 mru       18   0  2052 1016 1936 S  0.0  0.5   0:00.00 startx
  903 mru       17   0  2232  652 2188 S  0.0  0.3   0:00.00 xinit
  910 mru       16   0  8508 3952 5196 S  0.0  1.8   0:08.43 sawfish
  916 mru       15   0  1464  680 1316 S  0.0  0.3   0:00.00 asus_acpid
  921 mru       16   0     0    0    0 Z  0.0  0.0   0:00.36 kdeskto <defunct>
  922 mru       15   0  7792 5328 4756 S  0.0  2.4   0:28.99 xterm
  923 mru       16   0  2388 1468 2060 S  0.0  0.7   0:00.35 bash
  928 mru       16   0 24360  12m  22m S  0.0  5.7   0:08.31 kdesktop
  930 mru       16   0 21196 8668  20m S  0.0  3.9   0:00.02 kdeinit
  933 mru       15   0 21328 9024  20m S  0.0  4.0   0:00.02 kdeinit
  936 mru       15   0 21416 9456  20m S  0.0  4.2   0:00.02 kdeinit
  938 mru       16   0 22428  11m  20m S  0.0  5.1   0:00.36 kdeinit
  960 mru       18   0  2036  944 1936 S  0.0  0.4   0:00.00 sh
  963 mru       16   0  3768 1072 3692 S  0.0  0.5   0:00.00 gnuserv
 2735 mru       15   0  2432 1452 1388 S  0.0  0.6   0:00.15 ispell
16370 mru       16   0  7776 2736 4756 S  0.0  1.2   0:00.05 xterm
16371 mru       16   0  2308 1372 2060 S  0.0  0.6   0:00.00 bash
23957 mru       15   0  7776 2836 4756 S  0.0  1.3   0:00.14 xterm
23958 mru       16   0  2308 1376 2060 S  0.0  0.6   0:00.04 bash


--=-=-=
Content-Disposition: attachment; filename=xemacs.vmstat

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0    840  84740  10960  62168    0    0    12     4  481    93  1  0 98  1
 0  0    840  84660  10964  62168    0    0     0     7 1317   292  1  0 99  0
 2  0    840  84500  10964  62168    0    0     0     0 1302  5179 56 15 29  0
 2  0    840  84500  10964  62168    0    0     0     0 1002  8510 85 15  0  0
 0  0    840  84500  10964  62168    0    0     0     0 1016  4278 43 11 46  0

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


-- 
Måns Rullgård
mru@users.sf.net

--=-=-=--

