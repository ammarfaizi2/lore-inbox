Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQL1Dmm>; Wed, 27 Dec 2000 22:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQL1Dmc>; Wed, 27 Dec 2000 22:42:32 -0500
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:30214 "EHLO
	mail1.cinci.rr.com") by vger.kernel.org with ESMTP
	id <S129535AbQL1Dm1>; Wed, 27 Dec 2000 22:42:27 -0500
Date: Wed, 27 Dec 2000 23:12:18 -0500 (EST)
From: John Buswell <johnb@linuxcast.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: netfilter + 2.4.0-test10 causes connect:invalid argument
Message-ID: <Pine.LNX.4.21.0012272311290.22827-100000@bloatfish.opaquenetworks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. running 2.4.0-test10 with netfilter/iptables 1.1.2 ping/telnet gives
you invalid argument when connecting to ports on local interfaces.

2. when connecting to local interfaces (and/or local aliased
interfaces) from the local machine, ping/telnet (to any port) gives you a
connect: invalid argument. the connection works fine from remote systems
(eg. telnet remote 80 works, but telnet localhost 80 gives
connect: invalid). noticed same problem on a box in 2.4.0-test4.

3. networking 

4. Linux version 2.4.0-test11 (root@amdbox.opaquenetworks.net) (gcc
version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Sat Dec 2
12:10:42 EST 2000

5. no ooops

6. [avatar@avatar linux]$ telnet 10.37.87.53 80
Trying 10.37.87.53...
telnet: Unable to connect to remote host: Invalid argument

7. redhat 6.2

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 534.000556
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips        : 1064.96

[avatar@avatar linux]$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
dc00-dcff : Lite-On Communications Inc LNE100TX
  dc00-dcff : eth1
de00-deff : Lite-On Communications Inc LNE100TX (#2)
  de00-deff : eth0
ffa0-ffaf : Acer Laboratories Inc. [ALi] M5229 IDE

[avatar@avatar linux]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17ffffff : System RAM
  00100000-0025f38f : Kernel code
  0025f390-00274dc3 : Kernel data
deb00000-debfffff : PCI Bus #01
ded00000-dfdfffff : PCI Bus #01
  df400000-df7fffff : Trident Microsystems 3DIm`age 975
  df800000-dfbfffff : Trident Microsystems 3DIm`age 975
  dfde0000-dfdfffff : Trident Microsystems 3DIm`age 975
dffffe00-dffffeff : Lite-On Communications Inc LNE100TX
  dffffe00-dffffeff : eth1
dfffff00-dfffffff : Lite-On Communications Inc LNE100TX (#2)
  dfffff00-dfffffff : eth0
e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1621
fffe0000-ffffffff : reserved

named gives an invalid argument error (and is how i originally noticed the
problem) :)

thanks

-- 
John Buswell 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
