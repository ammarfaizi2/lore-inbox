Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUBKOVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUBKOVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:21:53 -0500
Received: from ns2.len.rkcom.net ([80.148.32.9]:24493 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S265777AbUBKOVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:21:44 -0500
From: Florian Schanda <ma1flfs@bath.ac.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 99% System load
Date: Wed, 11 Feb 2004 14:22:44 +0000
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0qjKAlotJmXoe/E"
Message-Id: <200402111423.02217.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0qjKAlotJmXoe/E
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have experianced a strage problem with recent 2.6.{0,1,2} kernels:

Sometimes (not allways, thats the problem, otherwise I could just avoid the=
=20
offending command) during paralel builds (for instance kde-libs or kde-base)
the build just stops, and I get a 99% system load.

=46or instance, just now I have (from top):

Tasks:  89 total,   5 running,  84 sleeping,   0 stopped,   0 zombie
 Cpu0 :  0.3% us, 99.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
 Cpu1 :  0.3% us, 99.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
 Cpu2 :  1.3% us, 98.7% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
 Cpu3 :  1.0% us, 99.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:   2071872k total,  1220772k used,   851100k free,    48080k buffers
Swap:   401616k total,        0k used,   401616k free,   892428k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5197 ma1flfs   25   0  2256  884 2184 R 99.5  0.0   6:29.38 sh
 5199 ma1flfs   25   0  2260  888 2184 R 99.5  0.0   6:28.02 sh
 5201 ma1flfs   25   0  2260  884 2184 R 98.5  0.0   6:29.99 sh
 5208 ma1flfs   25   0  1560  440 1404 R 98.5  0.0   6:32.03 grep
<snip>

I cannot kill -9 those processes. Is there some way to get rid of them with=
out=20
a reboot?

The strange thing is, resuming the build after the reboot with exactly the=
=20
same command (make -j4) will work fine... It's just not reproducible at all=
,=20
but it happend often enought to make it annoying.

(BTW, this never happened with non-paralel builds)

I have no idea where to start looking... I have attached a "ps -axfu" in ca=
se=20
that helps.

	Florian Schanda
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKjq5fCf8muQVS4cRApTDAJ9firqIMAEMYC0sWmtEYtpA+s8tKwCfXj8W
DKkrA9MxZxKXhoJcgxAuiL0=3D
=3DfV1B
=2D----END PGP SIGNATURE-----

--Boundary-00=_0qjKAlotJmXoe/E
Content-Type: text/plain;
  charset="us-ascii";
  name="proclist"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proclist"

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1484  492 ?        S    12:03   0:04 init [5]  
root         2  0.0  0.0     0    0 ?        SW   12:03   0:00 [migration/0]
root         3  0.0  0.0     0    0 ?        SWN  12:03   0:00 [ksoftirqd/0]
root         4  0.0  0.0     0    0 ?        SW   12:03   0:00 [migration/1]
root         5  0.0  0.0     0    0 ?        SWN  12:03   0:00 [ksoftirqd/1]
root         6  0.0  0.0     0    0 ?        SW   12:03   0:00 [migration/2]
root         7  0.0  0.0     0    0 ?        SWN  12:03   0:00 [ksoftirqd/2]
root         8  0.0  0.0     0    0 ?        SW   12:03   0:00 [migration/3]
root         9  0.0  0.0     0    0 ?        SWN  12:03   0:00 [ksoftirqd/3]
root        10  0.0  0.0     0    0 ?        SW<  12:03   0:00 [events/0]
root        11  0.0  0.0     0    0 ?        SW<  12:03   0:00 [events/1]
root        12  0.0  0.0     0    0 ?        SW<  12:03   0:00 [events/2]
root        13  0.0  0.0     0    0 ?        SW<  12:03   0:00 [events/3]
root        14  0.0  0.0     0    0 ?        SW<  12:03   0:00 [kblockd/0]
root        15  0.0  0.0     0    0 ?        SW<  12:03   0:00 [kblockd/1]
root        16  0.0  0.0     0    0 ?        SW<  12:03   0:00 [kblockd/2]
root        17  0.0  0.0     0    0 ?        SW<  12:03   0:00 [kblockd/3]
root        18  0.0  0.0     0    0 ?        SW   12:03   0:00 [khubd]
root        22  0.0  0.0     0    0 ?        SW   12:03   0:00 [kswapd0]
root        21  0.0  0.0     0    0 ?        SW   12:03   0:00 [pdflush]
root        19  0.0  0.0     0    0 ?        SW   12:03   0:00 [kirqd]
root        20  0.0  0.0     0    0 ?        SW   12:03   0:02 [pdflush]
root        23  0.0  0.0     0    0 ?        SW<  12:03   0:00 [aio/0]
root        24  0.0  0.0     0    0 ?        SW<  12:03   0:00 [aio/1]
root        25  0.0  0.0     0    0 ?        SW<  12:03   0:00 [aio/2]
root        26  0.0  0.0     0    0 ?        SW<  12:03   0:00 [aio/3]
root        27  0.0  0.0     0    0 ?        SW<  12:03   0:01 [xfslogd/0]
root        28  0.0  0.0     0    0 ?        SW<  12:03   0:00 [xfslogd/1]
root        29  0.0  0.0     0    0 ?        SW<  12:03   0:00 [xfslogd/2]
root        30  0.0  0.0     0    0 ?        SW<  12:03   0:00 [xfslogd/3]
root        31  0.0  0.0     0    0 ?        SW<  12:03   0:00 [xfsdatad/0]
root        32  0.0  0.0     0    0 ?        SW<  12:03   0:00 [xfsdatad/1]
root        33  0.0  0.0     0    0 ?        SW<  12:03   0:00 [xfsdatad/2]
root        34  0.0  0.0     0    0 ?        SW<  12:03   0:00 [xfsdatad/3]
root        35  0.0  0.0     0    0 ?        SW   12:03   0:00 [pagebufd]
root        36  0.0  0.0     0    0 ?        SW   12:03   0:00 [scsi_eh_0]
root        37  0.0  0.0     0    0 ?        SW   12:03   0:00 [ahc_dv_0]
root        38  0.0  0.0     0    0 ?        SW   12:03   0:00 [kseriod]
root        39  0.0  0.0     0    0 ?        SW   12:03   0:00 [xfs_syncd]
root        85  0.0  0.0     0    0 ?        SW   12:03   0:00 [xfs_syncd]
root       140  0.0  0.0  1536  596 ?        S    12:03   0:00 syslogd -m 0
root       143  0.0  0.0  2252 1344 ?        S    12:03   0:00 klogd
#1         166  0.0  0.0  1600  432 ?        S    12:03   0:00 /sbin/portmap
nobody     172  0.0  0.0  1660  716 ?        S    12:03   0:00 rpc.statd
root       178  0.0  0.0     0    0 ?        SW   12:03   0:00 [rpciod]
root       179  0.0  0.0     0    0 ?        SW   12:03   0:00 [lockd]
root       185  0.0  0.0  3116 1344 ?        S    12:03   0:00 /usr/sbin/sshd -p 50000
root       198  0.0  0.0  2808  736 ?        S    12:03   0:00 /opt/kde3/bin/kdm
root       206  1.4  0.8 281556 18176 ?      SL   12:03   1:59  \_ /usr/X11R6/bin/X vt7 -auth /var/run/xauth/A:0-AoIuu1
root       207  0.0  0.0  2972 1080 ?        S    12:03   0:00  \_ -:0              
ma1flfs    219  0.0  0.0  2280 1052 ?        S    12:04   0:00      \_ /bin/sh /opt/kde3/bin/startkde
ma1flfs    286  0.0  0.0  1480  328 ?        S    12:04   0:00          \_ kwrapper ksmserver
root       200  0.0  0.0  1476  416 tty1     S    12:03   0:00 /sbin/agetty vc/1 9600
root       201  0.0  0.0  1480  420 tty2     S    12:03   0:00 /sbin/agetty vc/2 9600
root       202  0.0  0.0  1480  420 tty3     S    12:03   0:00 /sbin/agetty vc/3 9600
root       203  0.0  0.0  1480  420 tty4     S    12:03   0:00 /sbin/agetty vc/4 9600
root       204  0.0  0.0  1480  420 tty5     S    12:03   0:00 /sbin/agetty vc/5 9600
root       205  0.0  0.0  1480  420 tty6     S    12:03   0:00 /sbin/agetty vc/6 9600
ma1flfs    240  0.0  0.4 21804 9836 ?        S    12:04   0:00 kdeinit: Running...      
ma1flfs    245  0.0  0.5 23148 11280 ?       S    12:04   0:00  \_ kdeinit: klauncher       
ma1flfs    280  1.3  0.5 40528 11536 ?       S    12:04   1:46  \_ /opt/kde3/bin/artsd -F 10 -S 4096 -a alsa -b 16 -s 60 -m artsmessage -c drkonqi -l 3 -f
ma1flfs    289  0.0  0.7 24656 14552 ?       S    12:04   0:07  \_ kdeinit: kwin            
ma1flfs    330  0.0  0.5 24624 12124 ?       S    12:06   0:01  \_ kdeinit: kio_pop3 pop3s /tmp/ksocket-ma1flfs/klauncherFD5c2b.slave-socket /tmp/ksocket-ma1flfs/kmailzuxKna.slave-socket
ma1flfs   5211  0.0  0.5 22744 10364 ?       S    14:03   0:00  \_ kdeinit: kio_file file /tmp/ksocket-ma1flfs/klauncherFD5c2b.slave-socket /tmp/ksocket-ma1flfs/kateCddIFa.slave-socket
ma1flfs   5249  0.1  0.7 26540 15656 ?       S    14:09   0:00  \_ kdeinit: konsole         
ma1flfs   5250  0.0  0.0  2412 1356 pts/1    R    14:09   0:00  |   \_ /bin/bash
ma1flfs   5263  0.0  0.0  2316  764 pts/1    R    14:17   0:00  |       \_ ps axfu
ma1flfs   5261  0.0  0.5 22752 10432 ?       S    14:17   0:00  \_ kdeinit: kio_file file /tmp/ksocket-ma1flfs/klauncherFD5c2b.slave-socket /tmp/ksocket-ma1flfs/kateYyJMVa.slave-socket
ma1flfs    243  0.0  0.4 21580 9900 ?        S    12:04   0:01 kdeinit: dcopserver --nosid
ma1flfs    248  0.0  0.7 26956 15800 ?       S    12:04   0:02 kdeinit: kded            
ma1flfs    255  0.0  0.6 24316 14040 ?       S    12:04   0:00 kdeinit: kxkb            
ma1flfs    282  0.0  0.8 29380 17656 ?       S    12:04   0:00 kdeinit: knotify         
ma1flfs    288  0.0  0.6 23164 12720 ?       S    12:04   0:00 kdeinit: ksmserver       
ma1flfs    291  0.0  0.7 25612 16160 ?       S    12:04   0:03 kdeinit: kdesktop        
ma1flfs    293  0.4  0.8 26796 17404 ?       S    12:04   0:32 kdeinit: kicker          
ma1flfs    296  0.0  0.0  1688  728 ?        S    12:04   0:00  \_ ksysguardd
ma1flfs    300  0.0  0.6 24184 13216 ?       S    12:04   0:00 kalarmd --login
ma1flfs    301  0.0  0.7 26320 15656 ?       S    12:04   0:00 kgpg
ma1flfs    302  0.0  0.7 26976 16044 ?       S    12:04   0:00 kalarm --tray
ma1flfs    311  0.0  0.6 24888 14460 ?       S    12:05   0:00 kdeinit: kio_uiserver    
ma1flfs    315  0.0  0.6 23488 13744 ?       S    12:05   0:00 kwalletmanager
ma1flfs    321  0.6  1.1 34464 23852 ?       S    12:05   0:48 juk -caption JuK -icon juk.png -miniicon juk.png
ma1flfs   5197 98.5  0.0  2256  884 ?        R    14:03  14:36 /bin/sh ../../libtool --silent --mode=compile --tag=CXX g++ -DHAVE_CONFIG_H -I. -I. -I../.. -I/opt/kde3/include -I/opt/qt/include -I/usr/X11R6/include -DQT_THREAD_SUPPORT -D_REENTRANT -Wnon-virtual-dtor -Wno-long-long -Wundef -Wall -W -Wpointer-arith -Wwrite-strings -ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion -Wchar-subscripts -DNDEBUG -DNO_DEBUG -O2 -O3 -march=pentium4 -mcpu=pentium4 -Wformat-security -Wmissing-format-attribute -fno-exceptions -fno-check-new -fno-common -DQT_CLEAN_NAMESPACE -DQT_NO_ASCII_CAST -DQT_NO_STL -DQT_NO_COMPAT -DQT_NO_TRANSLATION -D_GNU_SOURCE -MT kcmlocale.lo -MD -MP -MF .deps/kcmlocale.Tpo -c -o kcmlocale.lo kcmlocale.cpp
ma1flfs   5199 97.8  0.0  2260  888 ?        R    14:03  14:30 /bin/sh ../../libtool --silent --mode=compile --tag=CXX g++ -DHAVE_CONFIG_H -I. -I. -I../.. -I/opt/kde3/include -I/opt/qt/include -I/usr/X11R6/include -DQT_THREAD_SUPPORT -D_REENTRANT -Wnon-virtual-dtor -Wno-long-long -Wundef -Wall -W -Wpointer-arith -Wwrite-strings -ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion -Wchar-subscripts -DNDEBUG -DNO_DEBUG -O2 -O3 -march=pentium4 -mcpu=pentium4 -Wformat-security -Wmissing-format-attribute -fno-exceptions -fno-check-new -fno-common -DQT_CLEAN_NAMESPACE -DQT_NO_ASCII_CAST -DQT_NO_STL -DQT_NO_COMPAT -DQT_NO_TRANSLATION -D_GNU_SOURCE -MT toplevel.lo -MD -MP -MF .deps/toplevel.Tpo -c -o toplevel.lo toplevel.cpp
ma1flfs   5201 97.9  0.0  2260  884 ?        R    14:03  14:31 /bin/sh ../../libtool --silent --mode=compile --tag=CXX g++ -DHAVE_CONFIG_H -I. -I. -I../.. -I/opt/kde3/include -I/opt/qt/include -I/usr/X11R6/include -DQT_THREAD_SUPPORT -D_REENTRANT -Wnon-virtual-dtor -Wno-long-long -Wundef -Wall -W -Wpointer-arith -Wwrite-strings -ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion -Wchar-subscripts -DNDEBUG -DNO_DEBUG -O2 -O3 -march=pentium4 -mcpu=pentium4 -Wformat-security -Wmissing-format-attribute -fno-exceptions -fno-check-new -fno-common -DQT_CLEAN_NAMESPACE -DQT_NO_ASCII_CAST -DQT_NO_STL -DQT_NO_COMPAT -DQT_NO_TRANSLATION -D_GNU_SOURCE -MT klanguagebutton.lo -MD -MP -MF .deps/klanguagebutton.Tpo -c -o klanguagebutton.lo klanguagebutton.cpp
ma1flfs   5208 98.2  0.0  1560  440 ?        R    14:03  14:33 grep ^# ### BEGIN LIBTOOL TAG CONFIG: CXX$
ma1flfs   5246  1.8  4.0 97124 84304 ?       S    14:08   0:09 kmail -caption KMail -icon kmail -miniicon kmail
ma1flfs   5260  3.3  1.0 30200 20724 pts/1   S    14:17   0:01 kate proclist

--Boundary-00=_0qjKAlotJmXoe/E--
