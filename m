Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131132AbRAFAZ6>; Fri, 5 Jan 2001 19:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbRAFAZr>; Fri, 5 Jan 2001 19:25:47 -0500
Received: from cable-166-81-237-24.anchorageak.net ([24.237.81.166]:48014 "EHLO
	schu.net") by vger.kernel.org with ESMTP id <S131132AbRAFAZk>;
	Fri, 5 Jan 2001 19:25:40 -0500
Message-ID: <3A56653C.BF55B6E0@schu.net>
Date: Fri, 05 Jan 2001 15:22:20 -0900
From: Matthew Schumacher <schu@schu.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.0 Kernel Fails to compile when CONFIG_IP_NF_FTP is selected
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

2.4.0 Kernel Fails to compile when CONFIG_IP_NF_FTP is selected

[2.] Full description of the problem/report:

2.4.0 Kernel Fails to compile when CONFIG_IP_NF_FTP is selected (see
error output below)

[3.] Keywords (i.e., modules, networking, kernel):

2.4.0, NAT, IPFILTER, FTP

[4.] Kernel version (from /proc/version):

Linux version 2.2.17 (root@kenobi) (gcc version egcs-2.91.66
19990314/Linux 
(egcs-1.1.2 release)) #4 Mon Dec 18 14:08:32 AKST 2000

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

make bzImage


[7.] Environment

LESSOPEN=|/usr/bin/lesspipe.sh %s
USERNAME=
COLORTERM=rxvt-xpm
HISTSIZE=1000
HOSTNAME=kenobi
LOGNAME=schu
ORACLE_SID=orcl
MAIL=/var/spool/mail/schu
ORACLE_BASE=/home/oracle
COLORFGBG=15;default;0
TERM=xterm
HOSTTYPE=i386
PATH=/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:/home/schu/bin:/home/schu/scripts:/home/oracle/bin:/usr/bin
HOME=/root
INPUTRC=/etc/inputrc
WMAKER_BIN_NAME=wmaker
SHELL=/bin/bash
USER=schu
BASH_ENV=/home/schu/.bashrc
DISPLAY=unix:0.0
ORACLE_HOME=/home/oracle
LANG=en_US
WRASTER_COLOR_RESOLUTION0=4
OSTYPE=Linux
WINDOWID=41943042
SHLVL=4
LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:
_=/usr/bin/env


[7.1.] Software (add the output of the ver_linux script here)

Linux kenobi 2.2.17 #4 Mon Dec 18 14:08:32 AKST 2000 i686 unknown
Kernel modules         2.3.10-pre1
Gnu C                  egcs-2.91.66
Gnu Make               3.78.1
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         agpgart smbfs vmnet vmmon


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 730.971
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr xmm
bogomips        : 1458.18


[7.3.] Module information (from /proc/modules):

agpgart                 4724   1 (autoclean)
smbfs                  24880   1 (autoclean)
vmnet                  15488   1
vmmon                  17088   0


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
ec00-ec7f : eth0
ecc0-ecff : es1371
ffa0-ffa7 : ide0
ffa8-ffaf : ide1

/proc/iomem doesn't exsist

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 82810E GMCH [Graphics Memory
Controller Hub] (rev 03)
        Subsystem: Dell Computer Corporation: Unknown device 00b4
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set

00:01.0 VGA compatible controller: Intel Corporation 82810E CGC [Chipset
Graphics Controller] (rev 03) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00b4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f4000000 (32-bit, prefetchable)
        Region 1: Memory at ff000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801AA 82810 PCI Bridge (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fd000000-feffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
00:1e.0 PCI bridge: Intel Corporation 82801AA 82810 PCI Bridge (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fd000000-feffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA 82810 Chipset ISA Bridge
(LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:1f.1 IDE interface: Intel Corporation 82801AA 82810 Chipset IDE (rev
02) (prog-if 80 [Master])
        Subsystem: Intel Corporation: Unknown device 2411
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Region 4: I/O ports at ffa0

00:1f.2 USB Controller: Intel Corporation 82801AA 82810 Chipset USB (rev
02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 2412
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at ff80
00:1f.3 SMBus: Intel Corporation 82801AA 82810 Chipset SMBus (rev 02)
        Subsystem: Intel Corporation: Unknown device 2413
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at dcd0

01:07.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
06)
        Subsystem: Ensoniq: Unknown device 1371
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 12 min, 128 max, 64 set
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at ecc0
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1- D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78)
        Subsystem: Dell Computer Corporation: Unknown device 00b4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at ec00
        Region 1: Memory at fdfffc00 (32-bit, non-prefetchable)
        Expansion ROM at fe000000 [disabled]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)

non-scsi system


[7.7.] Other information that might be relevant to the problem

output from the compile:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe 
-march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.0/include/linux/modversions.h   -c -o ip_nat_ftp.o
ip_nat_ftp.c
ip_nat_ftp.c: In function `help':
ip_nat_ftp.c:315: structure has no member named `nat'
make[2]: *** [ip_nat_ftp.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.0/net/ipv4/netfilter'
make[1]: *** [_modsubdir_ipv4/netfilter] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0/net'
make: *** [_mod_net] Error 2

This is the error I get if I try to compile in the kernel or as a
module.

If you have any other questions contact me at schu@schu.net

thanks

schu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
