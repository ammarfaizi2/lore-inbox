Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTKWCLK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 21:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTKWCLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 21:11:10 -0500
Received: from smtp3.hushmail.com ([65.39.178.135]:36624 "EHLO
	smtp3.hushmail.com") by vger.kernel.org with ESMTP id S263190AbTKWCKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 21:10:35 -0500
Message-Id: <200311230210.hAN2AVss000603@mailserver2.hushmail.com>
Date: Sat, 22 Nov 2003 18:10:30 -0800
To: linux-kernel@vger.kernel.org
Subject: Problem:
From: <taylordl@hushmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] One line summary of the problem:
I attempted to run a Win2k virtual machine under VMware 4.0.5.6030 on
Gentoo and it wouldn't start.

[2.] Full description of the problem/report:
I attempted to run a Win2k virtual machine under VMware 4.0.5.6030 on
Gentoo and it wouldn't start. I happened to be debugging a problem with
usb so I was tailing /var/log/messages. I saw the kernel Bug message
and decided to send it in. I tried starting VMware 3 times and got the
same kernel Bug. This didn't happen on test9-mm1 or test9-mm2. I don't
know much about kernel debugging so if you need something else please
send a reply message and I will get what you need.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test9-mm4 (root@testarossa) (gcc version 3.2.3 20030422
(Gentoo Linux 1.4 3.2.3-r2, propolice)) #1 SMP Fri Nov 21 23:59:20 EST
2003

[5.] Output of Oops.. message (if applicable) with symbolic information

     resolved (see Documentation/oops-tracing.txt)
Nov 22 13:22:47 testarossa kernel:  ------------[ cut here ]---------
- ---
Nov 22 13:22:47 testarossa kernel: kernel BUG at mm/memory.c:793!
Nov 22 13:22:47 testarossa kernel: invalid operand: 0000 [#3]
Nov 22 13:22:47 testarossa kernel: PREEMPT SMP
Nov 22 13:22:47 testarossa kernel: CPU:    0
Nov 22 13:22:47 testarossa kernel: EIP:    0060:[<c0151c4f>]    Tainted:
PF  VLI
Nov 22 13:22:47 testarossa kernel: EFLAGS: 00013286
Nov 22 13:22:47 testarossa kernel: EIP is at get_user_pages+0x13f/0x400
Nov 22 13:22:47 testarossa kernel: eax: f3bff405   ebx: f49ae000   ecx:
f4514cc0   edx: 0156ef60
Nov 22 13:22:47 testarossa kernel: esi: 40637000   edi: f49ae000   ebp:
f5dc73e0   esp: f49afcd0
Nov 22 13:22:47 testarossa kernel: ds: 007b   es: 007b   ss: 0068
Nov 22 13:22:47 testarossa kernel: Process vmware-vmx (pid: 5683, threadinfo=f49ae000
task=f660ace0)
Nov 22 13:22:47 testarossa kernel: Stack: f5dc73e0 f655dbe0 40637000
00000001 f49ae000 00000004 f49ae000 f5dc7410
Nov 22 13:22:47 testarossa kernel:        f49ae000 f655dbe0 00000002
00000000 00000000 f49ae000 f5dc73e0 00040637
Nov 22 13:22:47 testarossa kernel:        f49afd40 f8f3330b f660ace0
f5dc73e0 40637000 00000001 00000001 00000000
Nov 22 13:22:47 testarossa kernel: Call Trace:
Nov 22 13:22:47 testarossa kernel:  [<f8f3330b>] HostIFGetUserPage+0x3b/0x68
[vmmon]
Nov 22 13:22:47 testarossa kernel:  [<f8f33387>] HostIF_LockPage+0x4f/0x2a6
[vmmon]
Nov 22 13:22:47 testarossa kernel:  [<f8f35479>] Vmx86_LockPage+0x63/0xe0
[vmmon]
Nov 22 13:22:47 testarossa kernel:  [<c0148f33>] read_pages+0x1d3/0x1e0
Nov 22 13:22:47 testarossa kernel:  [<f8f30e90>] __LinuxDriver_Ioctl+0x37a/0xa1a
[vmmon]
Nov 22 13:22:47 testarossa kernel:  [<c017dcf0>] dput+0x30/0x2d0
Nov 22 13:22:47 testarossa kernel:  [<c0173e0b>] link_path_walk+0x79b/0xb70
Nov 22 13:22:47 testarossa kernel:  [<c014159c>] find_get_page+0x3c/0x80
Nov 22 13:22:47 testarossa kernel:  [<c0142d0c>] filemap_nopage+0x2ec/0x4b0
Nov 22 13:22:47 testarossa kernel:  [<c0146401>] buffered_rmqueue+0xf1/0x1c0
Nov 22 13:22:47 testarossa kernel:  [<c0146580>] __alloc_pages+0xb0/0x350
Nov 22 13:22:47 testarossa kernel:  [<c0146853>] __get_free_pages+0x33/0x40
Nov 22 13:22:47 testarossa kernel:  [<c024f962>] rb_insert_color+0xd2/0xf0
Nov 22 13:22:47 testarossa kernel:  [<c015469a>] __vma_link+0x3a/0xa0
Nov 22 13:22:47 testarossa kernel:  [<c0154769>] vma_link+0x69/0xb0
Nov 22 13:22:47 testarossa kernel:  [<f8f315d5>] LinuxDriver_IoctlV4+0x4d/0xd2
[vmmon]
Nov 22 13:22:47 testarossa kernel:  [<c015507b>] do_mmap_pgoff+0x41b/0x720
Nov 22 13:22:47 testarossa kernel:  [<f8f31f63>] LinuxDriver_Ioctl+0x131/0x1b8
[vmmon]
Nov 22 13:22:47 testarossa kernel:  [<f8f31e32>] LinuxDriver_Ioctl+0x0/0x1b8
[vmmon]
Nov 22 13:22:47 testarossa kernel:  [<c0178ba8>] sys_ioctl+0x148/0x2e0
Nov 22 13:22:47 testarossa kernel:  [<c0386007>] syscall_call+0x7/0xb
Nov 22 13:22:47 testarossa kernel:  [<c038007b>] pfkey_broadcast+0x8b/0x2c0
Nov 22 13:22:47 testarossa kernel:
Nov 22 13:22:47 testarossa kernel: Code: 08 8b 44 24 58 8b 54 24 24 89
2c 24 89 44 24 0c 89 54 24 04 e8 43 1b 00 00 85 c0 74 6a 85 c0 7e 4b
83 f8 01 74 36 83 f8 02 74 25 <0f> 0b 19 03 76 d9 3a c0 ff 47 14 31 c0
86 45 30 84 c0 7f 8d 8b

[6.] A small shell script or example program which triggers the
     problem (if possible)
Attempt to start Win2k virtual machine under VMware.

[7.] Environment
Gentoo Linux

MANPATH=/usr/share/man:/usr/local/share/man:/usr/share/gcc-data/i686-
pc-linux-gnu/3.2/man:/usr/X11R6/man:/opt/blackdown-jdk-1.4.1/man:/usr/qt/3/man:/opt/vmware/man
INFODIR=/usr/share/info:/usr/athena/info:/usr/X11R6/info
KDE_MULTIHEAD=false
HOSTNAME=testarossa
TERM=xterm
CATALINA_HOME=/opt/tomcat
XDM_MANAGED=/var/run/xdmctl/xdmctl-:0,maysd,mayfn,sched
GS_LIB=/home/dtaylor/.kde/share/fonts
GTK_RC_FILES=/etc/gtk/gtkrc:/home/dtaylor/.gtkrc:/home/dtaylor/.gtkrc-
kde
QTDIR=/usr/qt/3
MOZILLA_FIVE_HOME=/usr/lib/mozilla
USER=dtaylor
LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:
GDK_USE_XFT=1
KDEDIR=/usr/kde/3.1
PYTHONDOCS=/usr/share/doc/python-docs-2.2.3/html
SESSION_MANAGER=local/testarossa:/tmp/.ICE-unix/4524
MANDIR=/usr/athena/man
CONFIG_PROTECT_MASK=/etc/gconf
PAGER=/usr/bin/less
XINITRC=/etc/X11/xinit/xinitrc
KONSOLE_DCOP=DCOPRef(konsole-4555,konsole)
PATH=/sbin:/bin:/usr/sbin:/usr/bin
INPUTRC=/etc/inputrc
PWD=/home/dtaylor
KONSOLE_DCOP_SESSION=DCOPRef(konsole-4555,session-1)
JAVA_HOME=/opt/blackdown-jdk-1.4.1
EDITOR=/usr/bin/vim
JAVAC=/opt/blackdown-jdk-1.4.1/bin/javac
KDEDIRS=/usr
QMAKESPEC=linux-g++
CXX=g++
HOME=/root
JDK_HOME=/opt/blackdown-jdk-1.4.1
SHLVL=4
LESS=-R
LOGNAME=dtaylor
CVS_RSH=ssh
CLASSPATH=/opt/blackdown-jdk-1.4.1/jre/lib/rt.jar:.:/usr/share/ant/lib/ant.jar:/usr/share/ant/lib/optional.jar
LESSOPEN=|lesspipe.sh %s
INFOPATH=/usr/share/info:/usr/share/gcc-data/i686-pc-linux-gnu/3.2/info
CC=gcc
DISPLAY=:0.0
XSESSION=kde-3.1.4
SANE_CONFIG_DIR=/etc/sane.d
CONFIG_PROTECT=/usr/X11R6/lib/X11/xkb /opt/tomcat/conf /usr/kde/3.1/share/config
/usr/share/texmf/tex/generic/config/ /usr/share/texmf/tex/platex/config/
/usr/share/config
G_BROKEN_FILENAMES=1
COLORTERM=
_=/bin/env

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux testarossa 2.6.0-test9-mm4 #1 SMP Fri Nov 21 23:59:20 EST 2003
i686 Pentium III (Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.12
e2fsprogs              1.33
reiserfsprogs          3.6.8
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         vmnet vmmon usb_storage snd_pcm_oss snd_mixer_oss
lp parport_pc parport uhci_hcd snd_ens1371 snd_rawmidi snd_seq_device
snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd soundcore gameport
usbcore e100

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 696.605
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1376.25

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 696.605
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1388.54

[7.3.] Module information (from /proc/modules):
vmnet 30936 8 - Live 0xf8ee1000
vmmon 72500 3 - Live 0xf8f30000
usb_storage 41344 0 - Live 0xf8ec5000
snd_pcm_oss 55236 0 - Live 0xf8f08000
snd_mixer_oss 19648 2 snd_pcm_oss, Live 0xf8edb000
lp 11168 0 - Live 0xf8e36000
parport_pc 21000 1 - Live 0xf8e8a000
parport 45440 2 lp,parport_pc, Live 0xf8eea000
uhci_hcd 35528 0 - Live 0xf8ed1000
snd_ens1371 23268 1 - Live 0xf8e9b000
snd_rawmidi 25984 1 snd_ens1371, Live 0xf8e93000
snd_seq_device 8292 1 snd_rawmidi, Live 0xf8e3a000
snd_pcm 105792 2 snd_pcm_oss,snd_ens1371, Live 0xf8eaa000
snd_page_alloc 12260 1 snd_pcm, Live 0xf8e2d000
snd_timer 27456 1 snd_pcm, Live 0xf8e40000
snd_ac97_codec 55588 1 snd_ens1371, Live 0xf8e7b000
snd 56100 8 snd_pcm_oss,snd_mixer_oss,snd_ens1371,snd_rawmidi,snd_seq_device,
snd_pcm,snd_timer,snd_ac97_codec, Live 0xf8e6c000
soundcore 10016 2 snd, Live 0xf8e32000
gameport 5056 1 snd_ens1371, Live 0xf8e2a000
usbcore 123636 4 usb_storage,uhci_hcd, Live 0xf8e4c000
e100 61412 0 - Live 0xf8a05000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0c00-0c3f : 0000:00:12.3
0cf8-0cff : PCI conf1
1040-105f : 0000:00:12.3
2000-20ff : 0000:00:0c.0
  2000-20ff : aic7xxx
2400-24ff : 0000:00:0c.1
  2400-24ff : aic7xxx
2800-283f : 0000:00:0b.0
  2800-283f : Ensoniq AudioPCI
2840-287f : 0000:00:0e.0
  2840-287f : e100
2880-289f : 0000:00:12.2
  2880-289f : uhci_hcd
28a0-28af : 0000:00:12.1
  28a0-28a7 : ide0
  28a8-28af : ide1
3000-4fff : PCI Bus #01
  3000-4fff : PCI Bus #02
    3000-300f : 0000:02:07.0
      3000-3007 : ide2
      3008-300f : ide3
    3010-3013 : 0000:02:07.0
    3014-3017 : 0000:02:07.0
      3016-3016 : ide2
    3018-301f : 0000:02:07.0
    3020-3027 : 0000:02:07.0
      3020-3027 : ide2
    4000-4fff : PCI Bus #03
      4000-401f : 0000:03:04.0
        4000-401f : e100
      4020-403f : 0000:03:05.0
        4020-403f : e100

00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c8000-000cdfff : Extension ROM
000ce000-000cf7ff : Extension ROM
000cf800-000d1fff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00386cab : Kernel code
  00386cac-0044c8df : Kernel data
3fff0000-3ffffbff : ACPI Tables
3ffffc00-3fffffff : ACPI Non-volatile Storage
f4000000-f40fffff : 0000:00:0e.0
  f4000000-f40fffff : e100
f4100000-f4100fff : 0000:00:0c.0
  f4100000-f4100fff : aic7xxx
f4101000-f4101fff : 0000:00:0c.1
  f4101000-f4101fff : aic7xxx
f4102000-f4102fff : 0000:00:0e.0
  f4102000-f4102fff : e100
f4103000-f4103fff : 0000:00:14.0
f4200000-f44fffff : PCI Bus #01
  f4200000-f44fffff : PCI Bus #02
    f4200000-f4203fff : 0000:02:07.0
    f4300000-f44fffff : PCI Bus #03
      f4300000-f43fffff : 0000:03:04.0
        f4300000-f43fffff : e100
      f4400000-f44fffff : 0000:03:05.0
        f4400000-f44fffff : e100
f6000000-f7ffffff : 0000:00:14.0
f8000000-fbffffff : 0000:00:00.0
fc000000-fc0fffff : PCI Bus #01
  fc000000-fc0fffff : PCI Bus #02
    fc000000-fc0fffff : PCI Bus #03
      fc000000-fc000fff : 0000:03:04.0
        fc000000-fc000fff : e100
      fc001000-fc001fff : 0000:03:05.0
        fc001000-fc001fff : e100
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
 HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
 Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=64
        I/O behind bridge: 00003000-00004fff
        Memory behind bridge: f4200000-f44fffff
        Prefetchable memory behind bridge: fc000000-fc0fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B+

00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
 <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: I/O ports at 2800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-
,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
        Subsystem: Adaptec: Unknown device 0053
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 217
        BIST result: 00
        Region 0: I/O ports at 2000 [size=256]
        Region 1: Memory at f4100000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-
,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 SCSI storage controller: Adaptec AIC-7896U2/7897U2
        Subsystem: Adaptec: Unknown device 0053
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 217
        BIST result: 00
        Region 0: I/O ports at 2400 [size=256]
        Region 1: Memory at f4101000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-
,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at f4102000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2840 [size=64]
        Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,
D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
 Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:12.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-
if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 28a0 [size=16]

00:12.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 177
        Region 4: I/O ports at 2880 [size=32]

00:12.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-
if 00 [VGA])
        Subsystem: Cirrus Logic CL-GD5480
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 2500ns max)
        Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at f4103000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev
06) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 240, cache line size 08
        Bus: primary=01, secondary=02, subordinate=03, sec-latency=68
        I/O behind bridge: 00003000-00004fff
        Memory behind bridge: f4200000-f44fffff
        Prefetchable memory behind bridge: 00000000fc000000-00000000fc000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-
,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

02:04.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 208, cache line size 08
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=68
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: f4300000-f44fffff
        Prefetchable memory behind bridge: 00000000fc000000-00000000fc000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,
D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

02:07.0 Unknown mass storage controller: Promise Technology, Inc. 20269
(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 208 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at 3020 [size=8]
        Region 1: I/O ports at 3014 [size=4]
        Region 2: I/O ports at 3018 [size=8]
        Region 3: I/O ports at 3010 [size=4]
        Region 4: I/O ports at 3000 [size=16]
        Region 5: Memory at f4200000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-
,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Dual Port Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 225
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at 4000 [size=32]
        Region 2: Memory at f4300000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,
D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Dual Port Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
 <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at fc001000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at 4020 [size=32]
        Region 2: Memory at f4400000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,
D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: m  m  m  Model: m  m  m m  m  m  Rev: 0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: iomega   Model: jaz 1GB          Rev: J^77
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CDRW/DVD SM-352B Rev: T805
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: CD-540E          Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: I0MEGA   Model: Mini 128*IOM     Rev: 3.04
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

Dee
___________________________

"I can accept failure, but
I can't accpet not trying."
Michael Jordan
-----BEGIN PGP SIGNATURE-----
Note: This signature can be verified at https://www.hushtools.com/verify
Version: Hush 2.3

wkYEARECAAYFAj/AFmcACgkQLeGeB7AWr4UVFgCdEYiEIkH10pKneLHEbLkzmjCWul4A
oJT99ikpH2rgkc7qeQ4Do45u23CX
=uUAq
-----END PGP SIGNATURE-----

