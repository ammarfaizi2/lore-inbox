Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312913AbSDETrF>; Fri, 5 Apr 2002 14:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313531AbSDETq4>; Fri, 5 Apr 2002 14:46:56 -0500
Received: from www.k.ro ([194.102.255.23]:23246 "EHLO www.k.ro")
	by vger.kernel.org with ESMTP id <S312913AbSDETqj>;
	Fri, 5 Apr 2002 14:46:39 -0500
Date: Fri, 05 Apr 2002 22:46:35 +0300
Message-Id: <200204051946.g35JkZv12382@www.k.ro>
From: George <Romeo2@k.ro>
X-Mailer: Super-Mail@k.ro http://mail.k.ro/
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Sender-IP: 213.233.65.104
To: linux-kernel@vger.kernel.org
Subject: Fealnx bug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  
Dear Linux Kernel Developers,
I wold like to report you a bug found in fealnx.c driver for Myson Network
Cards.
The problem is that if the network is uset at high transfers(ex nmap -sS)
the netowrk card gives this message:
Apr  5 20:45:05 romeo2 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr  5 20:45:05 romeo2 kernel: eth0: Transmit timed out, status 00000000,
reset
Apr  5 20:45:05 romeo2 kernel:   Rx ring cfcbf000:  80000000 80000000
80000000
Apr  5 20:45:05 romeo2 kernel:   Tx ring cfcbe000:  0000 0000 0000 80000000
000


My Kernel version is :
Linux version 2.4.18 (root@romeo2) (gcc version 2.95.4 20011006 (Debian
prerelease))

The linux_ver output of linux_ver script is:
Linux romeo2 2.4.18 #1 Wed Apr 3 20:19:54 EEST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11l
mount                  2.11l
modutils               2.4.10
e2fsprogs              1.25
pcmcia-cs              3.1.28
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         iptable_filter ip_tables ntfs nls_iso8859-1
nls_cp437
ppp_synctty pppoe pppox ppp_generic slhc fealnx mii cmpci smbfs vfat fat


The lspci result is:
romeo2:/usr/src/linux# lspci
00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev
02)
00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA
Bridge (ICH2) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE
U100 (rev 02)
00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB
(Hub
A) (rev 02)
00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev
02)
00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB
(Hub
B) (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M
Mobility
AGP 2x (rev 64)
02:02.0 Ethernet controller: MYSON Technology Inc: Unknown device 0803
02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)

The /proc/cpuinfo content is :
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 6
cpu MHz         : 797.084
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat
bogomips        : 1589.24


I hope that these bug report whill help you to fix the problem. Thank you
in
advice.
                                Best regards,
                                   George, a simple debian user






------------------------------
K Free E-mail http://www.k.ro/
by KappaNet http://www.kappa.ro/





