Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267205AbSK3Cbu>; Fri, 29 Nov 2002 21:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbSK3Cbu>; Fri, 29 Nov 2002 21:31:50 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:36172
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267205AbSK3Cbp>; Fri, 29 Nov 2002 21:31:45 -0500
Date: Fri, 29 Nov 2002 21:42:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Javier Marcet <jmarcet@pobox.com>
cc: Rik van Riel <riel@conectiva.com.br>, "" <linux-kernel@vger.kernel.org>
Subject: Re: Exaggerated swap usage
In-Reply-To: <20021130013832.GF15682@jerry.marcet.dyndns.org>
Message-ID: <Pine.LNX.4.50.0211292103200.26051-100000@montezuma.mastecende.com>
References: <20021129115405.GD15682@jerry.marcet.dyndns.org>
 <Pine.LNX.4.44L.0211291429260.15981-100000@imladris.surriel.com>
 <20021130013832.GF15682@jerry.marcet.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm i'm using 2.4.19-rmap15 and i find my box's performance exceptional
both whilst sitting at the main console and remotely from a laptop.
Currently there is someone working in openoffice at it whilst i work
in X11 remotely. This same box is also my NFS server for 5 other boxes.
Committed_AS would probably be in the region of 1.2GB+ in normal usage,
rmap15 does make good decisions about things to swap out in my case and
manages to keep the working sets of the bulk of my apps in physical.

Dual PII-400, swap device is an IBM 9G UW2 (aic7891) with overflow swap on
a UDMA33 ATA disk (PIIX4)

 21:34:26  up 6 days, 22:11, 34 users,  load average: 6.40, 6.06, 6.83

Filename			Type		Size	Used	Priority
/dev/sda1                       partition	1052216	805340	1
/dev/hdb1                       partition	1052216	0	0

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 4  0  1 804176   4016  12416 233564    5    3    18    28   14    21 12 12  5
14  0  0 804176   6940  12352 233024   32    0   488     0  918  3741 22 21 56
12  2  1 803816   4872  12424 234048    0    0   176  3832  886  3745 44 16 40
19  1  0 803816   6072  12444 233972    0    0   636     4  844  3685 60 31 10
 6  0  0 803840   4360  12476 234044    0    4   588     4  926  4123 68 23 10
13  1  0 803844   5908  12452 234096    0    0   668     0  836  3722 70 24  6
13  0  0 803844   4176  12456 234400    0    0   460     0  846  3740 64 25 11
24  2  0 803844   6688  12456 233716    0    0   376  5388  880  3893 24 18 58
 8  0  2 804952   4236  12124 232612    0 2104   488  2104  859  3762 65 25 10
25  0  0 804952   5072  12104 233624  316   64   476    64  870  3888 41 21 38

        total:    used:    free:  shared: buffers:  cached:
Mem:  525332480 522969088  2363392        0 10117120 365477888
Swap: 2154938368 873652224 1281286144
MemTotal:       513020 kB
MemFree:          2308 kB
MemShared:           0 kB
Buffers:          9880 kB
Cached:         282768 kB
SwapCached:      74144 kB
Active:         273452 kB
Inactive:       194068 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513020 kB
LowFree:          2308 kB
SwapTotal:     2104432 kB
SwapFree:      1251256 kB

Probably around 300 processes

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1336  436 ?        S    Nov22   0:04 init
root         2  0.0  0.0     0    0 ?        SW   Nov22   0:00 [migration_CPU0]
root         3  0.0  0.0     0    0 ?        SW   Nov22   0:00 [migration_CPU1]
root         4  0.0  0.0     0    0 ?        SW   Nov22   0:30 [keventd]
root         5  0.0  0.0     0    0 ?        SWN  Nov22   0:01 [ksoftirqd_CPU0]
root         6  0.0  0.0     0    0 ?        SWN  Nov22   0:01 [ksoftirqd_CPU1]
root         7  0.0  0.0     0    0 ?        SW   Nov22   5:46 [kswapd]
root         8  0.0  0.0     0    0 ?        SW   Nov22   0:00 [bdflush]
root         9  0.0  0.0     0    0 ?        SW   Nov22   0:11 [kupdated]
root        10  0.0  0.0     0    0 ?        SW   Nov22   0:00 [scsi_eh_0]
root        11  0.0  0.0     0    0 ?        SW   Nov22   0:00 [scsi_eh_1]
root        12  0.0  0.0     0    0 ?        SW   Nov22   0:00 [khubd]
root        13  0.0  0.0     0    0 ?        SW   Nov22   0:00 [mdrecoveryd]
root        14  0.0  0.0     0    0 ?        SW   Nov22   0:14 [kjournald]
root       117  0.0  0.0     0    0 ?        SW   Nov22   0:07 [kjournald]
root       118  0.0  0.0     0    0 ?        SW   Nov22   0:02 [kjournald]
root       119  0.0  0.0     0    0 ?        SW   Nov22   0:00 [kjournald]
root       120  0.0  0.0     0    0 ?        SW   Nov22   0:03 [kjournald]
root       408  0.0  0.0  1400  488 ?        S    Nov22   0:05 syslogd -m 0
root       412  0.0  0.0  1336  372 ?        S    Nov22   0:00 klogd -x
rpc        423  0.0  0.0  1488  408 ?        S    Nov22   0:00 portmap
rpcuser    442  0.0  0.0  1528  464 ?        S    Nov22   0:00 rpc.statd
root       545  0.0  0.0  1440  456 ?        S    Nov22   0:00 /usr/sbin/automou
named      558  0.0  0.1 14024  772 ?        S    Nov22   0:06 named -u named
root       575  0.0  0.0  3276  472 ?        S    Nov22   0:01 /usr/sbin/sshd
root       585  0.0  0.0  2092  456 ?        S    Nov22   0:00 xinetd -stayalive
lp         598  0.0  0.1  5192  536 ?        S    Nov22   0:00 lpd Waiting
root       613  0.0  0.0  3716  324 ?        S    Nov22   0:00 rpc.rquotad
root       617  0.0  0.0     0    0 ?        SW   Nov22   1:58 [nfsd]
root       618  0.0  0.0     0    0 ?        SW   Nov22   1:56 [nfsd]
root       619  0.0  0.0     0    0 ?        SW   Nov22   1:58 [nfsd]
root       620  0.0  0.0     0    0 ?        SW   Nov22   1:59 [nfsd]
root       621  0.0  0.0     0    0 ?        SW   Nov22   1:59 [nfsd]
root       622  0.0  0.0     0    0 ?        SW   Nov22   1:57 [nfsd]
root       623  0.0  0.0     0    0 ?        SW   Nov22   1:58 [nfsd]
root       624  0.0  0.0     0    0 ?        SW   Nov22   1:55 [nfsd]
root       625  0.0  0.0     0    0 ?        SW   Nov22   0:00 [lockd]
root       626  0.0  0.0     0    0 ?        SW   Nov22   0:00 [rpciod]
root       632  0.0  0.0  1556  488 ?        S    Nov22   0:00 rpc.mountd
root       641  0.0  0.1  2524  656 ?        S    Nov22   0:01 /usr/sbin/dhcpd
root       657  0.0  0.1  5040  756 ?        S    Nov22   0:04 sendmail: accepti
smmsp      666  0.0  0.0  4856  488 ?        S    Nov22   0:00 sendmail: Queue r
root       676  0.0  0.0 17792  508 ?        S    Nov22   0:01 /usr/bin/perl /us
root       697  0.0  0.1 13276  644 ?        S    Nov22   0:01 /usr/sbin/httpd
root       706  0.0  0.0  1516  480 ?        S    Nov22   0:00 crond
root       741  0.0  0.0  1312  224 ?        S    Nov22   0:00 /usr/bin/vmnet-br
root       759  0.0  0.0  1520  404 ?        S    Nov22   0:00 /usr/bin/vmnet-na
xfs       1049  0.0  0.0  4548  496 ?        S    Nov22   0:00 xfs -droppriv -da
root      1058  0.0  0.0  4936  452 ?        S    Nov22   0:00 smbd -D
root      1062  0.0  0.1  3792  800 ?        S    Nov22   0:05 nmbd -D
daemon    1080  0.0  0.0  1368  440 ?        S    Nov22   0:00 /usr/sbin/atd
root      1090  0.0  0.0  3552  448 ?        S    Nov22   0:00 rhnsd --interval
ident     1098  0.0  0.1  6268  948 ?        S    Nov22   0:00 /usr/bin/perl /us
root      1101  0.0  0.0  1316  332 tty2     S    Nov22   0:00 /sbin/mingetty tt
root      1102  0.0  0.0  1316  332 tty3     S    Nov22   0:00 /sbin/mingetty tt
root      1103  0.0  0.0  1316  332 tty4     S    Nov22   0:00 /sbin/mingetty tt
root      1104  0.0  0.0  1316  332 tty5     S    Nov22   0:00 /sbin/mingetty tt
root      1105  0.0  0.0  1316  332 tty6     S    Nov22   0:00 /sbin/mingetty tt
root      1106  0.0  0.1 13220  704 ?        S    Nov22   0:00 /usr/bin/gdm-bina
root      1139  0.0  0.1 13980  556 ?        S    Nov22   0:00 /usr/bin/gdm-bina
root      1140  8.0  6.4 337168 32948 ?      S<   Nov22 804:26 /usr/X11R6/bin/X
root      1143  0.0  0.0  1312  224 ?        S    Nov22   0:00 /usr/bin/vmnet-ne
root      1153  0.0  0.0  1684  452 ?        S    Nov22   0:00 /usr/bin/vmnet-dh
zwane     1163  0.0  0.0  4532  312 ?        S    Nov22   0:00 -/bin/tcsh -c /us
zwane     1225  0.0  0.1  4300  800 ?        S    Nov22   0:00 /bin/sh /usr/bin/
zwane     1226  0.0  0.0  2916  360 ?        S    Nov22   0:00 /usr/bin/ssh-agen
zwane     1269  0.0  0.2 20340 1048 ?        S    Nov22   0:02 kdeinit: Running.
zwane     1272  0.0  0.3 22344 1588 ?        S    Nov22   0:14 kdeinit: dcopserv
zwane     1275  0.0  0.3 23384 2008 ?        S    Nov22   0:01 kdeinit: klaunche
zwane     1277  0.0  0.5 23776 2616 ?        S    Nov22   2:17 kdeinit: kded
zwane     1288  0.0  0.4 26560 2288 ?        S    Nov22   0:13 kdeinit: knotify
zwane     1289  0.0  0.0  1392  264 ?        S    Nov22   0:01 kwrapper ksmserve
zwane     1291  0.0  0.4 23352 2104 ?        S    Nov22   0:11 kdeinit: ksmserve
zwane     1292  0.2  1.0 33140 5200 ?        S    Nov22  28:12 kdeinit: kwin -se
zwane     1293  0.0  0.0  4532  300 ?        S    Nov22   0:00 /bin/tcsh -c gkre
zwane     1295  0.0  0.0  4532  300 ?        S    Nov22   0:00 /bin/tcsh -c /usr
zwane     1301  0.0  0.0  4532  300 ?        S    Nov22   0:00 /bin/tcsh -c xter
zwane     1320  0.2  0.3 41448 1872 ?        S    Nov22  19:59 /opt/acrobat4/Rea
zwane     1383  0.1  0.3  9860 2004 ?        S    Nov22  18:02 gkrellm
zwane     1392  0.0  0.2  8416 1028 ?        S    Nov22   0:55 xterm -bg black -
zwane     1405  0.0  0.8 26408 4508 ?        S    Nov22   9:07 kdeinit: kdesktop
zwane     1407  0.0  0.0  4964  404 pts/0    S    Nov22   0:00 -csh
zwane     1438  0.0  0.5 28740 2808 ?        S    Nov22   5:46 kdeinit: klipper
zwane     1442  0.0  0.2 24068 1312 ?        S    Nov22   0:07 kdeinit: kwrited
zwane     1444  0.0  0.2 11148 1220 ?        S    Nov22   0:27 /usr/bin/pam-pane
zwane     1445  0.7  1.8 42296 9572 ?        S    Nov22  77:21 kdeinit: konquero
root      1446  0.0  0.0  1364  408 ?        S    Nov22   0:01 /sbin/pam_timesta
zwane     1447  0.2  0.8 28600 4176 ?        S    Nov22  25:05 kdeinit: konsole
zwane     1450  0.1  0.5 24252 2856 ?        S    Nov22  16:07 kdeinit: kmix -se
zwane     1451  0.2  1.5 29368 7816 ?        S    Nov22  26:38 kdeinit: konsole
zwane     1453  0.2  0.9 16360 4644 ?        S    Nov22  24:41 xchat --sm-config
zwane     1455  0.0  0.5 25216 2592 ?        S    Nov22   1:48 kworldclock -sess
zwane     1464  0.0  0.0  5064  408 pts/3    S    Nov22   0:00 -bin/tcsh
zwane     1466  0.0  0.2  5500 1028 pts/4    S    Nov22   0:03 -bin/tcsh
zwane     1473  0.0  0.2  5292 1196 pts/5    S    Nov22   0:03 -bin/tcsh
zwane     1476  0.0  0.0  5300  468 pts/6    S    Nov22   0:03 -bin/tcsh
zwane     1481  0.0  0.0  5272  472 pts/7    S    Nov22   0:01 -bin/tcsh
zwane     1487  0.0  0.1  5288  716 pts/8    S    Nov22   0:00 -bin/tcsh
zwane     1509  0.0  0.1  5292  740 pts/9    S    Nov22   0:01 -bin/tcsh
zwane     1527  0.0  0.1  5300  712 pts/10   S    Nov22   0:04 -bin/tcsh
zwane     1648  0.0  0.1  6120  888 ?        S    Nov22   0:25 fetchmail -d300
zwane     1682  0.0  0.2  9876 1280 ?        S    Nov22   7:24 /usr/bin/wish /us
zwane     1731 15.1  2.1 168200 11096 ?      R    Nov22 1507:36 /usr/bin/vmware
zwane     1732  0.0  5.4 121100 28008 ?      S    Nov22   1:29 vmware-ui -A 14 -
zwane     1733  0.1  0.1 24340 1024 ?        S    Nov22  17:44 vmware-mks -A 15
zwane     4489  0.0  0.0  5268  508 pts/11   S    Nov22   0:00 -bin/tcsh
zwane     4547  0.0  0.1  5252  732 pts/12   S    Nov22   0:00 -bin/tcsh
zwane     5334  0.0  0.4 24056 2344 ?        S    Nov22   0:19 kdeinit: kcalc -c
zwane    12186  0.0  0.2 11272 1240 ?        S    Nov23   1:00 gvim arch/i386/ke
zwane    24288  0.0  0.4 40960 2204 ?        S    Nov23   0:23 kdict
zwane    24289  0.0  0.1  4284  776 ?        S    Nov23   0:00 /bin/bash /opt/bi
zwane    24310  0.0  0.1 75208  836 ?        S    Nov23   0:08 /opt/kylix3/bin/b
zwane    26794  0.0  0.5 23940 2876 ?        S    Nov23   0:07 kdeinit: kio_uise
zwane    26903  0.0  0.0     0    0 ?        Z    Nov23   0:01 [drkonqi <defunct
zwane     1456  0.0  0.3 28912 1576 ?        T    Nov22   0:02 knotes -session 1
zwane    26939  0.0  0.4 28740 2232 ?        S    Nov23   0:13 knotes
zwane     2378  0.8  0.4 103300 2368 ?       S    Nov23  80:11 /usr/bin/vmware
zwane     2379  0.0  0.2 13616 1188 ?        S    Nov23   0:49 vmware-ui -A 14 -
zwane     2380  0.0  0.1 23916  864 ?        S    Nov23   6:19 vmware-mks -A 15
zwane     3466  0.8  1.0 103928 5196 ?       S    Nov23  75:30 /usr/bin/vmware
zwane     3470  0.8  0.1 162296 1000 ?       R    Nov23  75:03 /usr/bin/vmware
zwane     3472  0.0  0.2 13484 1176 ?        S    Nov23   0:47 vmware-ui -A 14 -
zwane     3473  0.0  0.1 23908  768 ?        S    Nov23   6:04 vmware-mks -A 15
zwane     3474  0.0  0.1 13492  968 ?        S    Nov23   0:47 vmware-ui -A 14 -
zwane     3475  0.0  0.1 23912  796 ?        S    Nov23   6:03 vmware-mks -A 15
zwane     3522  0.3  0.7 102792 4008 ?       S    Nov23  33:05 /usr/bin/vmware
zwane     3523  0.0  0.2 13484 1172 ?        S    Nov23   0:47 vmware-ui -A 14 -
zwane     3546  0.0  0.1 23904  752 ?        R    Nov23   5:59 vmware-mks -A 15
zwane     3896  0.0  0.1 137900 708 ?        S<   Nov23   0:00 vmware [ide0:0]
zwane     3902  0.0  0.1 137832 676 ?        S<   Nov23   0:00 vmware [ide1:0]
zwane     3994  0.0  0.1 72372  904 ?        S<   Nov23   0:10 vmware [ide0:0]
zwane     3995  0.0  0.1 72360  644 ?        S<   Nov23   0:00 vmware [ide1:0]
zwane     4047  0.0  0.1 72368  968 ?        S<   Nov23   0:27 vmware [ide0:0]
zwane     4113  0.0  0.1 72244  688 ?        S<   Nov23   0:00 vmware [ide1:0]
zwane    20494  0.1  1.0 151472 5480 ?       R    Nov23  20:11 /usr/lib/openoffi
apache   30995  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
apache   30996  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
apache   30997  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
apache   30998  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
apache   30999  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
apache   31000  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
apache   31001  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
apache   31002  0.0  0.1 13276  620 ?        S    Nov24   0:00 /usr/sbin/httpd
zwane    10640  0.0  0.1  4292  788 ?        S    Nov24   0:00 /bin/sh /usr/bin/
zwane    10641  0.1  1.3 35804 6720 ?        S    Nov24  14:17 /usr/lib/opera/6.
zwane    10656  0.0  0.0  2192  256 ?        S    Nov24   0:00 /usr/lib/opera/pl
zwane    10773  0.0  0.2 11176 1196 ?        S    Nov24   0:51 gvim init/do_moun
zwane    11851  0.0  0.1  5276  768 pts/13   S    Nov24   0:01 -bin/tcsh
zwane    11893  0.0  0.4 23392 2232 ?        S    Nov24   0:12 kcharselect -icon
zwane    12453  0.0  0.1  5264  744 pts/14   S    Nov24   0:00 -bin/tcsh
zwane    12694  0.0  0.3 23512 1928 ?        S    Nov24   0:05 kdeinit: kcookiej
zwane    12700  0.0  0.1 18912  992 ?        S    Nov24   0:00 /usr/bin/kdesud
zwane    13758  0.0  0.1  4644  612 pts/0    S    Nov24   0:10 minicom -o ttyS0
zwane    15739  0.0  0.1  5248  740 pts/15   S    Nov24   0:00 -bin/tcsh
zwane    15741  0.0  0.0  5248  512 pts/16   S    Nov24   0:00 -bin/tcsh
zwane    15765  0.0  0.0  5068  424 pts/17   S    Nov24   0:00 -bin/tcsh
zwane    15791  0.0  0.0  5248  512 pts/18   S    Nov24   0:00 -bin/tcsh
zwane    16129  0.0  0.1 72576  820 ?        S<   Nov24   0:52 vmware [ide0:0]
zwane    16130  0.0  0.1 72580  796 ?        S<   Nov24   0:00 vmware [ide1:0]
zwane    16131  0.0  0.2 72644 1124 ?        S<   Nov24   0:09 /usr/bin/vmware
zwane    17331  0.0  0.2 10916 1036 ?        S    Nov25   0:02 /usr/bin/gvim
zwane    24524  0.0  0.1  7944  824 ?        S    Nov25   0:00 xterm -bg black -
zwane    24532  0.0  0.0  5012  408 pts/19   S    Nov25   0:00 -csh
zwane    24567  0.0  0.0 35732   12 pts/19   S    Nov25   0:00 xski
zwane    26695  0.0  0.2 10856 1180 ?        S    Nov25   0:03 gvim iodev/ioapic
zwane    27457  0.0  0.1  3432  564 pts/18   S    Nov25   0:00 ssh freebsd
zwane    27458  0.0  0.0  2100  512 pts/17   S    Nov25   0:00 telnet netbsd
zwane    27473  0.0  0.0  2100  512 pts/16   S    Nov25   0:00 telnet qnx
zwane    31803  0.0  0.2 10924 1180 ?        S    Nov26   0:04 gvim irq.h
zwane     2373  0.0  0.0  3332  280 pts/4    S    Nov26   2:13 esd -as 60
zwane     2984  0.2  1.3 33788 6848 ?        S    Nov26  12:06 kdeinit: kicker
zwane     3147  0.0  0.5 27700 2776 ?        S    Nov26   1:49 appletproxy --con
zwane     5902  0.0  0.1  4332  824 ?        S    Nov27   0:00 /bin/sh /usr/lib/
zwane     5919  3.5  8.0 100180 41228 ?      S    Nov27 142:58 /usr/lib/mozilla/
zwane     5943  0.0  0.0     0    0 ?        Z    Nov27   0:00 [netstat <defunct
zwane     9883  0.7  0.1 46412 1012 ?        S    Nov27  31:03 /usr/bin/vmware
zwane     9884  0.0  0.2 13548 1036 ?        S    Nov27   0:22 vmware-ui -A 15 -
zwane     9885  0.0  0.1 23908  856 ?        R    Nov27   2:55 vmware-mks -A 16
zwane    10235  0.0  0.1 23100  768 ?        S<   Nov27   0:00 vmware [ide0:0]
zwane    10236  0.0  0.1 23092  772 ?        S<   Nov27   0:00 vmware [ide1:0]
zwane    14410  0.2  0.2 25532 1324 pts/11   S    Nov27   6:39 pine
zwane    28578  0.0  0.1  7872  868 ?        S    Nov27   0:00 xterm -bg black -
zwane    28694  0.0  0.0  5188  512 pts/2    S    Nov27   0:00 -csh
zwane     7709  0.0  0.1 138800 948 ?        S<   Nov27   0:11 vmware [ide1:0]
zwane     7710  0.0  0.3 138860 2008 ?       S<   Nov27   0:08 /usr/bin/vmware
root      7743  0.0  0.2  5468 1252 ?        S    Nov27   0:02 smbd -D
zwane     9439  0.0  0.2 75352 1144 ?        S<   Nov27   0:36 xine /raid/store/
zwane    12910  0.0  0.4 26716 2504 ?        S    Nov27   0:03 /usr/bin/kdesktop
zwane    17151  0.0  0.2 11212 1256 ?        S    Nov27   0:58 gvim debug
root     29455  0.0  0.1  4276  632 pts/3    S    Nov28   0:00 su -
root     29458  0.0  0.1  5300  880 pts/3    S    Nov28   0:01 -tcsh
zwane      406  0.0  0.0  3944  372 pts/6    S    Nov28   0:00 less the-bad-patc
zwane     2662  0.0  0.1  5072  664 pts/20   S    Nov28   0:00 -bin/tcsh
zwane     4289  0.0  0.0  1824  480 ?        S    Nov28   0:00 /usr/bin/lamd -H
zwane     6229  0.0  0.1  3612  968 pts/8    S    Nov28   0:12 xscreensaver
zwane    17473  0.0  0.1  8964  860 pts/7    S    08:37   0:00 vi netlink_dev.c
zwane    23334  0.0  0.1  3432  740 pts/20   S    10:48   0:00 ssh root@mondecin
zwane    23349  0.0  0.1  3540  740 pts/14   S    10:50   0:00 ssh root@mondecin
zwane    23385  0.0  0.1  3432  744 pts/15   S    10:54   0:00 ssh root@linux
zwane    24798  0.1  0.9 25948 4728 ?        S    12:33   0:40 kdeinit: konsole
zwane    24800  0.0  0.1  5424  812 pts/22   S    12:34   0:00 -bin/tcsh
zwane    24824  0.0  0.1  5164  832 pts/23   S    12:34   0:00 -bin/tcsh
zwane    24845  0.0  0.1  4984  720 pts/24   S    12:34   0:00 -bin/tcsh
zwane    24866  0.0  0.1  4740  648 pts/25   S    12:34   0:00 -bin/tcsh
zwane    24887  0.0  0.1  4740  648 pts/26   S    12:34   0:00 -bin/tcsh
zwane    24908  0.0  0.1  4740  648 pts/27   S    12:34   0:00 -bin/tcsh
zwane    25117  0.0  0.1  4300  900 pts/23   S    12:58   0:00 /bin/sh /opt/bin/
zwane    25140  0.0  0.0  3580  396 pts/23   S    12:58   0:00 tee /tmp/wine.log
zwane    25141  1.4  0.3 41024 1964 pts/23   S    12:58   7:28 /opt/bin/../wine/
zwane    25143  1.8  0.1  2796  652 ?        S    12:58   9:20 /opt/bin/../wine/
zwane    25157  0.0  0.1  4300  900 pts/24   S    13:00   0:00 /bin/sh /opt/bin/
zwane    25180  0.0  0.0  3580  396 pts/24   S    13:00   0:00 tee /tmp/wine.log
zwane    25181  0.6  0.4 24812 2080 pts/24   S    13:00   3:06 /opt/bin/../wine/
root     25248  0.0  0.0  1316  352 tty1     S    13:23   0:00 /sbin/mingetty tt
zwane    25589  0.0  0.3 10932 1988 ?        S    16:09   0:01 gvim debug
root     25706  0.0  0.2 13988 1196 ?        S    16:52   0:00 /usr/bin/gdm-bina
zwane    25713  0.0  0.1  4548  552 ?        S    16:53   0:00 -/bin/tcsh -c /us
zwane    25776  0.1  0.3  6996 1600 ?        S    16:53   0:19 /usr/bin/wmaker
zwane    25777  0.0  0.1  2916  552 ?        S    16:53   0:00 /usr/bin/ssh-agen
zwane    25780  0.1  0.4  9080 2328 ?        S    16:53   0:29 gkrellm
zwane    25781  0.0  0.2  5148 1080 ?        S    16:53   0:00 rxvt -bg black -f
zwane    25782  0.1  0.3  8236 1844 ?        S    16:53   0:30 wmxmms
zwane    25783  0.0  0.1  2668  672 ?        S    16:53   0:01 wmCalClock -24
zwane    25786  0.0  0.1  4772  664 pts/21   S    16:54   0:00 -csh
zwane    25859  0.1  1.2 29380 6296 ?        S    16:55   0:29 konsole
zwane    25861  0.0  0.4 19948 2156 ?        S    16:55   0:00 kdeinit: Running.
zwane    25864  0.0  0.5 22260 2580 ?        S    16:55   0:00 kdeinit: dcopserv
zwane    25867  0.0  0.4 22320 2508 ?        S    16:55   0:00 kdeinit: klaunche
zwane    25869  0.0  0.7 23116 3700 ?        S    16:55   0:03 kdeinit: kded
zwane    25872  0.0  0.1  5012  724 pts/28   S    16:55   0:00 -bin/tcsh
zwane    25896  0.4  1.0 16320 5564 ?        S    16:56   1:09 xchat
zwane    25905  0.0  0.2  5192 1088 pts/29   S    16:58   0:00 -bin/tcsh
zwane    25926  0.0  0.2  5200 1304 pts/30   S    16:58   0:00 -bin/tcsh
zwane    25947  0.0  0.2  5016 1332 pts/31   S    16:58   0:00 -bin/tcsh
zwane    25968  0.0  0.1  5016  696 pts/32   S    16:58   0:00 -bin/tcsh
zwane    26000  0.0  0.1  3432  756 pts/28   S    16:59   0:00 ssh presario
zwane    26008  2.8  1.0 63768 5376 pts/29   R    17:00   3:49 xmms
zwane    26030  0.0  0.2  5160 1172 ?        S    17:06   0:11 rxvt -bg black -f
zwane    26031  0.0  0.1  5016  696 pts/33   S    17:06   0:00 -csh
zwane    26051  0.2  0.7 20280 4104 pts/33   S    17:06   0:43 pine
zwane    26389  0.0  0.1  4332  904 ?        S    19:39   0:00 /bin/sh /usr/lib/
zwane    26406  1.6  0.6 52960 3500 ?        S    19:39   1:54 /usr/lib/mozilla/
zwane    29318  0.2  0.2  4132 1116 pts/5    S    21:32   0:00 make -j2 bzImage
zwane    29615  0.0  0.1  3812  808 pts/5    S    21:33   0:00 make -f scripts/M
zwane    31738  0.5  0.1  3808  804 pts/5    S    21:35   0:00 make -f scripts/M
zwane    31771  1.6  0.1  3844  840 pts/5    S    21:35   0:00 make -f scripts/M
zwane    31916  6.0  0.1  3812  808 pts/5    S    21:35   0:00 make -f scripts/M
zwane    31951  0.0  0.2  4308 1036 pts/5    S    21:35   0:00 /bin/sh -c set -e
zwane    31953  0.0  0.0  1340  324 pts/5    S    21:35   0:00 ccache gcc -Wp,-M
zwane    31954  0.0  0.0  3652  476 pts/5    S    21:35   0:00 /usr/bin/gcc -Wp,
zwane    31955  0.0  0.3  4908 1768 pts/5    R    21:35   0:00 /usr/lib/gcc-lib/
zwane    31956  0.0  0.2  3044 1132 pts/30   R    21:35   0:00 ps aux
zwane    31960  0.0  0.2  4308 1036 pts/5    S    21:35   0:00 /bin/sh -c set -e
zwane    31961  0.0  0.0  1340  324 pts/5    S    21:35   0:00 ccache gcc -Wp,-M
zwane    31962  0.0  0.0  3652  476 pts/5    S    21:35   0:00 /usr/bin/gcc -Wp,
zwane    31963  0.0  0.1  3920  732 pts/5    R    21:35   0:00 /usr/lib/gcc-lib/

I also tend to notice general kernel crappiness (ask Con Kolivas ;)

Cheers,
	Zwane

