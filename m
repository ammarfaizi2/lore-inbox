Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318175AbSHUKRB>; Wed, 21 Aug 2002 06:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSHUKRB>; Wed, 21 Aug 2002 06:17:01 -0400
Received: from balthasar.nuitari.net ([216.40.249.34]:17334 "HELO
	nuitari.nuitari.net") by vger.kernel.org with SMTP
	id <S318175AbSHUKQq>; Wed, 21 Aug 2002 06:16:46 -0400
Date: Wed, 21 Aug 2002 12:33:29 -0400 (EDT)
From: Nuitari <nuitari@balthasar.nuitari.net>
To: dri-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
cc: linux-usb-devel@lists.sourceforge.net
Subject: PROBLEM: Highmem + Matrox G400 DRM causes crashes or console freezes
Message-ID: <Pine.LNX.4.44.0208211205140.6953-200000@balthasar.nuitari.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="685253369-1572576946-1029947609=:6953"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--685253369-1572576946-1029947609=:6953
Content-Type: TEXT/PLAIN; charset=US-ASCII

[1.]
Highmem + Matrox G400 DRM causes crashes or console freezes

[2.]
When I have 1gb of ram installed in my computer, starting any opengl 
application will cause anything from a console freeze, an oops or a kernel 
panic.

[3.]
Kernel: 2.4.18 to 2.4.20-pre4

[4.]
[root@gandalf /root]# cat /proc/version
Linux version 2.4.20-pre4 (root@gandalf.nuitari.darktech.org) (gcc version 
3.1)
#7 Wed Aug 21 04:00:02 EDT 2002

[5.]
Oops information I got:
Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
c010c6f4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c010c6f4>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000018   ecx: e5b14000   edx: f7e11f1c
esi: e5b1a004   edi: fffffffb   ebp: 00000001   esp: e5b15f90
ds: 0018   es: 0018   ss: 0018
Process strace (pid: 694, stackpage=e5b15000)
Stack: e5b1a000 00000000 e5b65d74 40014023 00000023 e5b65d94 e5b140b8 
00000000
       e5b14000 00000000 00000018 bfffe79c c0108eaf 00000018 000002b7 
00000001
       00000000 00000018 bfffe79c 0000001a 0000002b 0000002b 0000001a 
400d7366
Call Trace:    [<c0108eaf>]

Code: 00 00 00 00 00 00 00 00 00 00 00 00 ea b3 42 43 7b 9a 43 43

Unable to handle kernel NULL pointer dereference at virtual address 
00000000
c010c6f4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c010c6f4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000018   ecx: e5b14000   edx: f7e11f1c
esi: e5b1a004   edi: fffffffb   ebp: 00000001   esp: e5b15f90
ds: 0018   es: 0018   ss: 0018
Process strace (pid: 694, stackpage=e5b15000)
Stack: e5b1a000 00000000 e5b65d74 40014023 00000023 e5b65d94 e5b140b8 
00000000
       e5b14000 00000000 00000018 bfffe79c c0108eaf 00000018 000002b7 
00000001
       00000000 00000018 bfffe79c 0000001a 0000002b 0000002b 0000001a 
400d7366
Call Trace:    [<c0108eaf>]
Code: 00 00 00 00 00 00 00 00 00 00 00 00 ea b3 42 43 7b 9a 43 43

>>EIP; c010c6f4 <sys_ptrace+274/5f0>   <=====
Trace; c0108eaf <system_call+2f/34>
Code;  c010c6f4 <sys_ptrace+274/5f0>   <=====
00000000 <_EIP>:   <=====
Code;  c010c700 <sys_ptrace+280/5f0>
   c:   ea b3 42 43 7b 9a 43      ljmp   $0x439a,$0x7b4342b3
Code;  c010c707 <sys_ptrace+287/5f0>
  13:   43                        inc    %ebx


1 warning issued.  Results may not be reliable.


Dump of assembler code for function str:
0x80493d0 <str>:        xor    %dh,(%eax)
0x80493d2 <str+2>:      add    %al,(%eax)
0x80493d4 <str+4>:      add    %al,(%eax)
0x80493d6 <str+6>:      add    %al,(%eax)
0x80493d8 <str+8>:      add    %al,(%eax)
0x80493da <str+10>:     add    %al,(%eax)
0x80493dc <str+12>:     add    %ch,%dl
0x80493de <str+14>:     mov    $0x42,%bl
0x80493e0 <str+16>:     inc    %ebx
0x80493e1 <str+17>:     jnp    0x804937d
0x80493e3 <str+19>:     inc    %ebx
0x80493e4 <str+20>:     inc    %ebx
0x80493e5 <str+21>:     add    %al,(%eax)
0x80493e7 <str+23>:     add    %al,(%eax)
End of assembler dump.

[6.]
Shell script:
Simply any program with opengl (ut, glxgears, mplayer -vo gl)

[7.]
Environment:
BASH=/bin/bash
BASH_VERSINFO=([0]="2" [1]="04" [2]="3" [3]="1" [4]="release" 
[5]="i586-mandrake-linux-gnu")
BASH_VERSION='2.04.3(1)-release'
CHROMIUM_DATA=/usr/share/games/chromium/data
CLASSPATH=/usr/java/lib
COLUMNS=80
DIRSTACK=()
ENV=/root/.bashrc
EUID=0
GROUPS=()
HISTFILE=/root/.bash_history
HISTFILESIZE=1000
HISTSIZE=1000
HOME=/root
HOSTNAME=gandalf.nuitari.darktech.org
HOSTTYPE=i586
I18N_CFG_FILE=/etc/sysconfig/i18n
IFS='
'
INPUTRC=/etc/inputrc
LANG=en
LANGUAGE=en_US:en
LC_COLLATE=en
LC_CTYPE=en
LC_MESSAGES=en
LC_MONETARY=en
LC_NUMERIC=en
LC_TIME=en
LESS=-MM
LESSKEY=/etc/.less
LESSOPEN='|/usr/bin/lesspipe.sh %s'
LINES=25
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.tbz2=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lha=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:*.tiff=01;35:'
MACHTYPE=i586-mandrake-linux-gnu
MAIL=/var/spool/mail/root
MAILCHECK=60
MOZILLA_HOME=/usr/netscape
OLDPWD=/root
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin
PIPESTATUS=([0]="0")
PPID=588
PS1='[\u@\h \W]\$ '
PS2='> '
PS4='+ '
PWD=/tmp
QTDIR=/usr/qt3
RPM_INSTALL_LANG=en_US:en
SECURE_LEVEL=4
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:histexpand:monitor:history:interactive-comments:emacs
SHLVL=1
TERM=linux
UID=0
USER=root
USERNAME=root
_=set
mc=()
{
    mkdir -p ~/.mc/tmp 2>/dev/null;
    chmod 700 ~/.mc/tmp;
    MC=~/.mc/tmp/mc-$$;
    /usr/bin/mc -P "$@" >"$MC";
    cd "`cat $MC`";
    rm -f "$MC";
    unset MC
}
screen=()
{
    if [ -z "$SCREENDIR" ]; then
        export SCREENDIR=$HOME/tmp;
    fi;
    /usr/bin/screen $@
}

[7.1.]
VerLinux output:


Linux gandalf.nuitari.darktech.org 2.4.20-pre4 #7 Wed Aug 21 04:00:02 EDT 
2002 i686 unknown

Gnu C                  gcc (GCC) 3.1 Copyright (C) 2002 Free Software 
Foundation, Inc. This is free software; see the source for copying 
conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS 
FOR A PARTICULAR PURPOSE.
Gnu make               3.79
binutils               2.9.5.0.31
util-linux             2.11c
mount                  2.11c
modutils               2.4.16
e2fsprogs              1.18
PPP                    2.4.1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Linux C++ Library      4.0.0
Procps                 2.0.6
Net-tools              1.55
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         sr_mod aic7xxx mga_vid st sg ov511_decomp ov511 
usb-uhci

[7.2.]
[root@gandalf linux]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) processor
stepping        : 1
cpu MHz         : 700.043
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91

[7.3.]
[root@gandalf linux]# cat /proc/modules
sr_mod                 15608   0 (unused)
aic7xxx               124372   0 (unused)
mga_vid                 8632   0 (unused)
st                     28592   0 (unused)
sg                     27788   0 (unused)
ov511_decomp           10884   0
ov511                  75484   1 [ov511_decomp]
usb-uhci               23084   0 (unused)

[7.4.]
[root@gandalf linux]# cat /proc/ioports |less
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
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-900f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  9000-9007 : ide0
  9008-900f : ide1
9400-941f : VIA Technologies, Inc. USB
  9400-941f : usb-uhci
9800-981f : VIA Technologies, Inc. USB (#2)
  9800-981f : usb-uhci
9c00-9cff : Adaptec AHA-2930CU
a000-a01f : Creative Labs SB Live! EMU10k1
  a000-a01f : EMU10K1
a400-a407 : Creative Labs SB Live! MIDI/Game Port
  a400-a407 : emu10k1-gp
a800-a8ff : IBM 16/4 Token ring UTP/STP controller
  a800-a8ff : olympic
ac00-ac07 : Lava Computer mfg Inc Lava Parallel
  ac00-ac02 : parport1
  ac03-ac07 : parport1
b000-b007 : Triones Technologies, Inc. HPT366/368/370/370A/372
  b000-b007 : ide2
b400-b403 : Triones Technologies, Inc. HPT366/368/370/370A/372
  b402-b402 : ide2
b800-b807 : Triones Technologies, Inc. HPT366/368/370/370A/372
bc00-bc03 : Triones Technologies, Inc. HPT366/368/370/370A/372
c000-c0ff : Triones Technologies, Inc. HPT366/368/370/370A/372
  c000-c007 : ide2
  c008-c00f : ide3
  c010-c0ff : HPT370


[root@gandalf linux]# cat /proc/iomem
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000c9000-000ccdff : Extension ROM
000cd000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-00306551 : Kernel code
  00306552-0038b8e7 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
e4000000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : Matrox Graphics, Inc. MGA G400 AGP
e6000000-e8ffffff : PCI Bus #01
  e6000000-e6003fff : Matrox Graphics, Inc. MGA G400 AGP
  e7000000-e77fffff : Matrox Graphics, Inc. MGA G400 AGP
ea000000-ea003fff : Matrox Graphics, Inc. MGA 2064W [Millennium]
eb000000-eb7fffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
ec000000-ec0007ff : IBM 16/4 Token ring UTP/STP controller
  ec000000-ec0007ff : olympic
ec001000-ec001fff : Adaptec AHA-2930CU
  ec001000-ec001fff : aic7xxx
ec002000-ec0020ff : IBM 16/4 Token ring UTP/STP controller
  ec002000-ec0020ff : olympic

[root@gandalf linux]# cat /proc/interrupts
           CPU0
  0:     256230          XT-PIC  timer
  1:      14602          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:        274          XT-PIC  serial
  5:      12330          XT-PIC  olympic
  7:        127          XT-PIC  parport0
  8:          1          XT-PIC  rtc
 10:        234          XT-PIC  ide2
 11:       1138          XT-PIC  EMU10K1, usb-uhci, usb-uhci, aic7xxx
 12:      34770          XT-PIC  PS/2 Mouse
 14:       5328          XT-PIC  ide0
 15:        971          XT-PIC  ide1
NMI:          0
ERR:          0

[7.5.]

[root@gandalf linux]# lspci -vvv|less
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
        Subsystem: ABIT Computer Corp.: Unknown device a401
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 8 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e6000000-e8ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 
40)
        Subsystem: ABIT Computer Corp.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 
06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.: Unknown device 0571
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at 9000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 9400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 9800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Subsystem: VIA Technologies, Inc.: Unknown device 3057
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 11
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
        Subsystem: Adaptec: Unknown device 3869
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 4 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9c00 [disabled] [size=256]
        Region 1: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 
07)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 20 max, 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 0: I/O ports at a400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Token ring network controller: IBM 16/4 Token ring UTP/STP 
controller (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 6 min, 120 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a800 [size=256]
        Region 1: Memory at ec002000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at ec000000 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at <unassigned> [disabled] [size=16K]

00:0f.0 Parallel controller: Lava Computer mfg Inc Lava Parallel (prog-if 
01 [BiDir])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at ac00 [size=8]

00:11.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W 
[Millennium]
(rev 01) (prog-if 00 [VGA])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at ea000000 (32-bit, non-prefetchable) [disabled] 
[size=16K]
        Region 1: Memory at eb000000 (32-bit, prefetchable) [disabled] 
[size=8M]        Expansion ROM at <unassigned> [disabled] [size=64K]
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 
(rev
03)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b000 [size=8]
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0378
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0378
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 min, 32 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=<none>

[7.6.]
[root@gandalf linux]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIPCD1024INT-A   Rev:  2,0
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DRM-1804X Rev: 0101
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 01
  Vendor: PIONEER  Model: CHANGR DRM-1804X Rev: 0101
  Type:   Medium Changer                   ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM DM-XX28   Rev: 3.08
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: USB      Model: CD-R/RW 4X4X6    Rev: A.EZ
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.]
[root@gandalf linux]# cat /proc/bus/usb/devices  |less
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 12/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=9800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=1189 ProdID=6000 Rev= a.03
S:  Product=USB Optical Storage Device
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=02 Prot=00 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=1ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=9400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05a9 ProdID=a511 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 0 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 0 Alt= 2 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS= 129 Ivl=1ms
I:  If#= 0 Alt= 3 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS= 257 Ivl=1ms
I:  If#= 0 Alt= 4 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS= 385 Ivl=1ms
I:  If#= 0 Alt= 5 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS= 513 Ivl=1ms
I:  If#= 0 Alt= 6 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS= 769 Ivl=1ms
I:  If#= 0 Alt= 7 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=ov511
E:  Ad=81(I) Atr=01(Isoc) MxPS= 961 Ivl=1ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
E:  Ad=81(I) Atr=01(Isoc) MxPS= 961 Ivl=1ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00e Rev=11.00
S:  Manufacturer=Logitech
S:  Product=USB-PS/2 Optical Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

[X.]
A workaround is just to run with  768Mb of RAM or just removing HIGHMEM 
support from the kernel.

Tomorrow I will test with another linux distribution to check if the 
problem is reproduced on it.

I tried with the minimalist system possible (only the G400, 1gb ram, root 
hard disk) and the problem still reproduced itself quite easyly.

Most of the tests were with glxgears.

Attached is an abridged log of the serial console. It's over many tests 
and is slightly edited.

When I tried with strace, the results differed (one of them being an oops 
in strace, another an oops in dnetc that I didn't manage to capture).
However I do recall it being with a similar stack page that the strace one

Process strace (pid: 694, stackpage=e5b15000)

According to iomem, that page is supposed to be used by the Matrox G400, 
and could be the possible cause of the lockups.

Some times everything would stop and the Caps Lock / Scroll Lock lights 
would blink (kernel panic, I presume).

I am also mailing it to the usb-devel list as on one occasion I had these 
messages while Xwindows started.

usb-uhci.c: Host controller halted, trying to restart.

I didn't manage to reproduce it.

I had problems since kernel 2.4.18 (when I got more then 1gb of ram).
Both the latest DRI drivers on numerous days and the official Matrox ones 
have the problem.

Sleep is starting to have effects on me. Please feel free to email me with 
any questions or any test that you'd like me to try.

Nuitari

--685253369-1572576946-1029947609=:6953
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="minicom.cap"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208211233290.6953@balthasar.nuitari.net>
Content-Description: 
Content-Disposition: attachment; filename="minicom.cap"

TGludXggdmVyc2lvbiAyLjQuMjAtcHJlNCAocm9vdEBnYW5kYWxmLm51aXRh
cmkuZGFya3RlY2gub3JnKSAoZ2NjIHZlcnNpb24gMy4xKSAjNyBXZWQgQXVn
IDIxIDA0OjAwOjAyIEVEVCAyMDAyDQpCSU9TLXByb3ZpZGVkIHBoeXNpY2Fs
IFJBTSBtYXA6DQogQklPUy1lODAxOiAwMDAwMDAwMDAwMDAwMDAwIC0gMDAw
MDAwMDAwMDA5ZjAwMCAodXNhYmxlKQ0KIEJJT1MtZTgwMTogMDAwMDAwMDAw
MDEwMDAwMCAtIDAwMDAwMDAwM2ZmZjAwMDAgKHVzYWJsZSkNCjEyN01CIEhJ
R0hNRU0gYXZhaWxhYmxlLg0KODk2TUIgTE9XTUVNIGF2YWlsYWJsZS4NCk9u
IG5vZGUgMCB0b3RhbHBhZ2VzOiAyNjIxMjgNCnpvbmUoMCk6IDQwOTYgcGFn
ZXMuDQp6b25lKDEpOiAyMjUyODAgcGFnZXMuDQp6b25lKDIpOiAzMjc1MiBw
YWdlcy4NCktlcm5lbCBjb21tYW5kIGxpbmU6IEJPT1RfSU1BR0U9bGludXh0
ZXN0IHJvIHJvb3Q9MzA3IHBhcnBvcnQ9MHgzNzgsNyBwYXJwb3J0PTB4YWMw
MCxub25lIHBsaXA9cGFycG9ydDAgaGRiPXNjc2kgY29uc29sZT10dHlTMA0K
aWRlX3NldHVwOiBoZGI9c2NzaQ0KSW5pdGlhbGl6aW5nIENQVSMwDQpEZXRl
Y3RlZCA3MDAuMDQ0IE1IeiBwcm9jZXNzb3IuDQpDb25zb2xlOiBjb2xvdXIg
VkdBKyA4MHgyNQ0KQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiAxMzk1Ljkx
IEJvZ29NSVBTDQpNZW1vcnk6IDEwMzI2NDRrLzEwNDg1MTJrIGF2YWlsYWJs
ZSAoMjA3M2sga2VybmVsIGNvZGUsIDE1NDgwayByZXNlcnZlZCwgNTMyayBk
YXRhLCAyODhrIGluaXQsIDEzMTAwOGsgaGlnaG1lbSkNCkRlbnRyeSBjYWNo
ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEzMTA3MiAob3JkZXI6IDgsIDEwNDg1
NzYgYnl0ZXMpDQpJbm9kZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDY1
NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQ0KTW91bnQtY2FjaGUgaGFz
aCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDUsIDEzMTA3MiBieXRl
cykNCkJ1ZmZlci1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChv
cmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQ0KUGFnZS1jYWNoZSBoYXNoIHRhYmxl
IGVudHJpZXM6IDI2MjE0NCAob3JkZXI6IDgsIDEwNDg1NzYgYnl0ZXMpDQpD
UFU6IEwxIEkgQ2FjaGU6IDY0SyAoNjQgYnl0ZXMvbGluZSksIEQgY2FjaGUg
NjRLICg2NCBieXRlcy9saW5lKQ0KQ1BVOiBMMiBDYWNoZTogNjRLICg2NCBi
eXRlcy9saW5lKQ0KSW50ZWwgbWFjaGluZSBjaGVjayBhcmNoaXRlY3R1cmUg
c3VwcG9ydGVkLg0KSW50ZWwgbWFjaGluZSBjaGVjayByZXBvcnRpbmcgZW5h
YmxlZCBvbiBDUFUjMC4NCkNQVTogQU1EIER1cm9uKHRtKSBwcm9jZXNzb3Ig
c3RlcHBpbmcgMDENCkVuYWJsaW5nIGZhc3QgRlBVIHNhdmUgYW5kIHJlc3Rv
cmUuLi4gZG9uZS4NCkNoZWNraW5nICdobHQnIGluc3RydWN0aW9uLi4uIE9L
Lg0KUE9TSVggY29uZm9ybWFuY2UgdGVzdGluZyBieSBVTklGSVgNCm10cnI6
IHYxLjQwICgyMDAxMDMyNykgUmljaGFyZCBHb29jaCAocmdvb2NoQGF0bmYu
Y3Npcm8uYXUpDQptdHJyOiBkZXRlY3RlZCBtdHJyIHR5cGU6IEludGVsDQpQ
Q0k6IFBDSSBCSU9TIHJldmlzaW9uIDIuMTAgZW50cnkgYXQgMHhmYjRlMCwg
bGFzdCBidXM9MQ0KUENJOiBVc2luZyBjb25maWd1cmF0aW9uIHR5cGUgMQ0K
UENJOiBQcm9iaW5nIFBDSSBoYXJkd2FyZQ0KRGlzYWJsaW5nIFZJQSBtZW1v
cnkgd3JpdGUgcXVldWUgKFBDSSBJRCAwMzA1LCByZXYgMDMpOiBbNTVdIDg5
ICYgMWYgLT4gMDkNClVua25vd24gYnJpZGdlIHJlc291cmNlIDA6IGFzc3Vt
aW5nIHRyYW5zcGFyZW50DQpQQ0k6IFVzaW5nIElSUSByb3V0ZXIgVklBIFsx
MTA2LzA2ODZdIGF0IDAwOjA3LjANCkFwcGx5aW5nIFZJQSBzb3V0aGJyaWRn
ZSB3b3JrYXJvdW5kLg0KTGludXggTkVUNC4wIGZvciBMaW51eCAyLjQNCkJh
c2VkIHVwb24gU3dhbnNlYSBVbml2ZXJzaXR5IENvbXB1dGVyIFNvY2lldHkg
TkVUMy4wMzkNCkluaXRpYWxpemluZyBSVCBuZXRsaW5rIHNvY2tldA0KYXBt
OiBCSU9TIHZlcnNpb24gMS4yIEZsYWdzIDB4MDcgKERyaXZlciB2ZXJzaW9u
IDEuMTYpDQpTdGFydGluZyBrc3dhcGQNCmFsbG9jYXRlZCAzMiBwYWdlcyBh
bmQgMzIgYmhzIHJlc2VydmVkIGZvciB0aGUgaGlnaG1lbSBib3VuY2VzDQpJ
bnN0YWxsaW5nIGtuZnNkIChjb3B5cmlnaHQgKEMpIDE5OTYgb2tpckBtb25h
ZC5zd2IuZGUpLg0KdWRmOiByZWdpc3RlcmluZyBmaWxlc3lzdGVtDQpwYXJw
b3J0MDogUEMtc3R5bGUgYXQgMHgzNzggKDB4Nzc4KSwgaXJxIDcsIHVzaW5n
IEZJRk8gW1BDU1BQLFRSSVNUQVRFLENPTVBBVCxFQ1BdDQpwYXJwb3J0MTog
UEMtc3R5bGUgYXQgMHhhYzAwIFtQQ1NQUCxUUklTVEFURSxFUFBdDQpwdHk6
IDI1NiBVbml4OTggcHR5cyBjb25maWd1cmVkDQpTZXJpYWwgZHJpdmVyIHZl
cnNpb24gNS4wNWMgKDIwMDEtMDctMDgpIHdpdGggTUFOWV9QT1JUUyBTSEFS
RV9JUlEgU0VSSUFMX1BDSSBlbmFibGVkDQp0dHlTMDAgYXQgMHgwM2Y4IChp
cnEgPSA0KSBpcyBhIDE2NTUwQQ0KdHR5UzAxIGF0IDB4MDJmOCAoaXJxID0g
MykgaXMgYSAxNjU1MEENCmdhbWVwb3J0MDogRW11MTBrMSBHYW1lcG9ydCBh
dCAweGE0MDAgc2l6ZSA4IHNwZWVkIDEyNDIga0h6DQppbnB1dDA6IEFuYWxv
ZyAyLWF4aXMgNC1idXR0b24gam95c3RpY2sgYXQgZ2FtZXBvcnQwLjAgW1RT
QyB0aW1lciwgNjk4IE1IeiBjbG9jaywgODMzIG5zIHJlc10NClJlYWwgVGlt
ZSBDbG9jayBEcml2ZXIgdjEuMTBlDQpVbmlmb3JtIE11bHRpLVBsYXRmb3Jt
IEUtSURFIGRyaXZlciBSZXZpc2lvbjogNi4zMQ0KaWRlOiBBc3N1bWluZyAz
M01IeiBzeXN0ZW0gYnVzIHNwZWVkIGZvciBQSU8gbW9kZXM7IG92ZXJyaWRl
IHdpdGggaWRlYnVzPXh4DQpWUF9JREU6IElERSBjb250cm9sbGVyIG9uIFBD
SSBidXMgMDAgZGV2IDM5DQpWUF9JREU6IGNoaXBzZXQgcmV2aXNpb24gNg0K
VlBfSURFOiBub3QgMTAwJSBuYXRpdmUgbW9kZTogd2lsbCBwcm9iZSBpcnFz
IGxhdGVyDQpWUF9JREU6IFZJQSB2dDgyYzY4NmIgKHJldiA0MCkgSURFIFVE
TUExMDAgY29udHJvbGxlciBvbiBwY2kwMDowNy4xDQogICAgaWRlMDogQk0t
RE1BIGF0IDB4OTAwMC0weDkwMDcsIEJJT1Mgc2V0dGluZ3M6IGhkYTpETUEs
IGhkYjpETUENCiAgICBpZGUxOiBCTS1ETUEgYXQgMHg5MDA4LTB4OTAwZiwg
QklPUyBzZXR0aW5nczogaGRjOkRNQSwgaGRkOkRNQQ0KSFBUMzcwOiBJREUg
Y29udHJvbGxlciBvbiBQQ0kgYnVzIDAwIGRldiA5OA0KUENJOiBGb3VuZCBJ
UlEgMTAgZm9yIGRldmljZSAwMDoxMy4wDQpIUFQzNzA6IGNoaXBzZXQgcmV2
aXNpb24gMw0KSFBUMzcwOiBub3QgMTAwJSBuYXRpdmUgbW9kZTogd2lsbCBw
cm9iZSBpcnFzIGxhdGVyDQpIUFQzNzA6IHVzaW5nIDMzTUh6IFBDSSBjbG9j
aw0KICAgIGlkZTI6IEJNLURNQSBhdCAweGMwMDAtMHhjMDA3LCBCSU9TIHNl
dHRpbmdzOiBoZGU6RE1BLCBoZGY6RE1BDQogICAgaWRlMzogQk0tRE1BIGF0
IDB4YzAwOC0weGMwMGYsIEJJT1Mgc2V0dGluZ3M6IGhkZzpwaW8sIGhkaDpw
aW8NCmhkYTogRlVKSVRTVSBNUEYzMjA0QVQsIEFUQSBESVNLIGRyaXZlDQpo
ZGI6IFpJUENEMTAyNElOVC1BLCBBVEFQSSBDRC9EVkQtUk9NIGRyaXZlDQpo
ZGM6IE1heHRvciA1VDA2MEg2LCBBVEEgRElTSyBkcml2ZQ0KaGRkOiBNQVRT
SElUQSBDUi01ODUsIEFUQVBJIENEL0RWRC1ST00gZHJpdmUNCmhkZTogU0FN
U1VORyBTVjIwNDRELCBBVEEgRElTSyBkcml2ZQ0KaGRmOiBTQU1TVU5HIFNW
MjA0MkgsIEFUQSBESVNLIGRyaXZlDQppZGUwIGF0IDB4MWYwLTB4MWY3LDB4
M2Y2IG9uIGlycSAxNA0KaWRlMSBhdCAweDE3MC0weDE3NywweDM3NiBvbiBp
cnEgMTUNCmlkZTIgYXQgMHhiMDAwLTB4YjAwNywweGI0MDIgb24gaXJxIDEw
DQpibGs6IHF1ZXVlIGMwM2ZlZTA0LCBJL08gbGltaXQgNDA5NU1iIChtYXNr
IDB4ZmZmZmZmZmYpDQpoZGE6IDQwMDMxNzEyIHNlY3RvcnMgKDIwNDk2IE1C
KSB3LzUxMktpQiBDYWNoZSwgQ0hTPTI0OTEvMjU1LzYzLCBVRE1BKDY2KQ0K
YmxrOiBxdWV1ZSBjMDNmZjE0OCwgSS9PIGxpbWl0IDQwOTUgOChtYXNrIDB4
ZmZmZmZmZmYpDQpoZGM6IDEyMDEwMzIwMCBzZWN0b3JzICg2MTQ5MyBNQikg
dy8yMDQ4S2lCIENhY2hlLCBDSFM9MTE5MTUwLzE2LzYzLCBVRE1BKDEwMCkN
CmJsazogcXVldWUgYzAzZmY0OGMsIEkvTyBsaW1pdCA0MDk1TWIgKG1hc2sg
MHhmZmZmZmZmZikNCmhkZTogMzk4NjIzNjggc2VjdG9ycyAoMjA0MTAgTUIp
IHcvNDcyS2lCIENhY2hlLCBDSFM9Mzk1NDYvMTYvNjMsIFVETUEoNjYpDQpi
bGs6IHF1ZXVlIGMwM2ZmNWM4LCBJL08gbGltaXQgNDA5NU1iIChtYXNrIDB4
ZmZmZmZmZmYpDQpoZGY6IDM5ODY1MzkyIHNlY3RvcnMgKDIwNDExIE1CKSB3
LzQyNktpQiBDYWNoZSwgQ0hTPTM5NTQ5LzE2LzYzLCBVRE1BKDEwMCkNCmlk
ZS1jZDogcGFzc2luZyBkcml2ZSBoZGIgdG8gaWRlLXNjc2kgZW11bGF0aW9u
Lg0KaGRkOiBBVEFQSSAyNFggQ0QtUk9NIGRyaXZlLCAxMjhrQiBDYWNoZSwg
RE1BDQpVbmlmb3JtIENELVJPTSBkcml2ZXIgUmV2aXNpb246IDMuMTINClBh
cnRpdGlvbiBjaGVjazoNCiBoZGE6IGhkYTEgaGRhMiBoZGE0IDwgaGRhNSBo
ZGE2IGhkYTcgaGRhOCA+DQogaGRjOiBbUFRCTF0gWzc0NzYvMjU1LzYzXSBo
ZGMxIGhkYzIgPCBoZGM1IGhkYzYgaGRjNyA+DQogaGRlOiBbUFRCTF0gWzI0
ODEvMjU1LzYzXSBoZGUxDQogaGRmOiB1bmtub3duIHBhcnRpdGlvbiB0YWJs
ZQ0KU0xJUDogdmVyc2lvbiAwLjguNC1ORVQzLjAxOS1ORVdUVFkgKGR5bmFt
aWMgY2hhbm5lbHMsIG1heD0yNTYpLg0KUkFNRElTSyBkcml2ZXIgaW5pdGlh
bGl6ZWQ6IDE2IFJBTSBkaXNrcyBvZiA0MDk2SyBzaXplIDEwMjQgYmxvY2tz
aXplDQpsb29wOiBsb2FkZWQgKG1heCA4IGRldmljZXMpDQpORVQzIFBMSVAg
dmVyc2lvbiAyLjQtcGFycG9ydCBnbmlpYmVAbXJpLmNvLmpwDQpwbGlwMDog
UGFyYWxsZWwgcG9ydCBhdCAweDM3OCwgdXNpbmcgSVJRIDcuDQpQUFAgZ2Vu
ZXJpYyBkcml2ZXIgdmVyc2lvbiAyLjQuMg0KUFBQIERlZmxhdGUgQ29tcHJl
c3Npb24gbW9kdWxlIHJlZ2lzdGVyZWQNClBQUCBCU0QgQ29tcHJlc3Npb24g
bW9kdWxlIHJlZ2lzdGVyZWQNCkxpbnV4IHZpZGVvIGNhcHR1cmUgaW50ZXJm
YWNlOiB2MS4wMA0KTGludXggYWdwZ2FydCBpbnRlcmZhY2UgdjAuOTkgKGMp
IEplZmYgSGFydG1hbm4NCmFncGdhcnQ6IE1heGltdW0gbWFpbiBtZW1vcnkg
dG8gdXNlIGZvciBhZ3AgbWVtb3J5OiA4MTZNDQphZ3BnYXJ0OiBEZXRlY3Rl
ZCBWaWEgQXBvbGxvIFBybyBLVDEzMyBjaGlwc2V0DQphZ3BnYXJ0OiBBR1Ag
YXBlcnR1cmUgaXMgNjRNIEAgMHhlMDAwMDAwMA0KW2RybV0gQUdQIDAuOTkg
b24gVklBIEFwb2xsbyBLVDEzMyBAIDB4ZTAwMDAwMDAgNjRNQg0KW2RybV0g
SW5pdGlhbGl6ZWQgbWdhIDMuMC4yIDIwMDEwMzIxIG9uIG1pbm9yIDANClBD
STogRm91bmQgSVJRIDUgZm9yIGRldmljZSAwMDowZC4wDQpQQ0k6IFNoYXJp
bmcgSVJRIDUgd2l0aCAwMDowZi4wDQpPbHltcGljLmMgdjEuMC4wIDIvOS8w
MiAgLSBQZXRlciBEZSBTY2hyaWp2ZXIgJiBNaWtlIFBoaWxsaXBzIA0KSUJN
IDE2LzQgVG9rZW4gcmluZyBVVFAvU1RQIGNvbnRyb2xsZXIuIEkvTyBhdCBh
ODAwLCBNTUlPIGF0IGY4ODIzMDAwLCBMQVAgYXQgZjg4MjUwMDAsIHVzaW5n
IGlycSA1DQpPbHltcGljOiBJQk0gMTYvNCBUb2tlbiByaW5nIFVUUC9TVFAg
Y29udHJvbGxlciByZWdpc3RlcmVkIGFzOiB0cjANCiBhdGFyYWlkL2QwOiBh
dGFyYWlkL2QwcDENCkhpZ2hwb2ludCBIUFQzNzAgU29mdHdhcmVyYWlkIGRy
aXZlciBmb3IgbGludXggdmVyc2lvbiAwLjAxDQpEcml2ZSAwIGlzIDE5NDY0
IE1iIA0KRHJpdmUgMSBpcyAxOTQ2NSBNYiANClJhaWQgYXJyYXkgY29uc2lz
dHMgb2YgMiBkcml2ZXMuIA0KU0NTSSBzdWJzeXN0ZW0gZHJpdmVyIFJldmlz
aW9uOiAxLjAwDQpzY3NpMCA6IFNDU0kgaG9zdCBhZGFwdGVyIGVtdWxhdGlv
biBmb3IgSURFIEFUQVBJIGRldmljZXMNCiAgVmVuZG9yOiBJT01FR0EgICAg
TW9kZWw6IFpJUENEMTAyNElOVC1BICAgIFJldjogIDIsMA0KICBUeXBlOiAg
IENELVJPTSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU5TSSBTQ1NJ
IHJldmlzaW9uOiAwMg0KQ3JlYXRpdmUgRU1VMTBLMSBQQ0kgQXVkaW8gRHJp
dmVyLCB2ZXJzaW9uIDAuMTksIDA0OjAxOjM2IEF1ZyAyMSAyMDAyDQpQQ0k6
IEZvdW5kIElSUSAxMSBmb3IgZGV2aWNlIDAwOjBiLjANClBDSTogU2hhcmlu
ZyBJUlEgMTEgd2l0aCAwMDowNy4yDQpQQ0k6IFNoYXJpbmcgSVJRIDExIHdp
dGggMDA6MDcuMw0KUENJOiBTaGFyaW5nIElSUSAxMSB3aXRoIDAwOjA4LjAN
CmVtdTEwazE6IEVNVTEwSzEgcmV2IDcgbW9kZWwgMHg4MDI3IGZvdW5kLCBJ
TyBhdCAweGEwMDAtMHhhMDFmLCBJUlEgMTENCmFjOTdfY29kZWM6IEFDOTcg
IGNvZGVjLCBpZDogMHg1NDUyOjB4NDEyMyAoVHJpVGVjaCBUUiBBNSkNCnVz
Yi5jOiByZWdpc3RlcmVkIG5ldyBkcml2ZXIgdXNiZGV2ZnMNCnVzYi5jOiBy
ZWdpc3RlcmVkIG5ldyBkcml2ZXIgaHViDQp1c2IuYzogcmVnaXN0ZXJlZCBu
ZXcgZHJpdmVyIGhpZGRldg0KdXNiLmM6IHJlZ2lzdGVyZWQgbmV3IGRyaXZl
ciBoaWQNCmhpZC1jb3JlLmM6IHYxLjguMSBBbmRyZWFzIEdhbCwgVm9qdGVj
aCBQYXZsaWsgPHZvanRlY2hAc3VzZS5jej4NCmhpZC1jb3JlLmM6IFVTQiBI
SUQgc3VwcG9ydCBkcml2ZXJzDQpJbml0aWFsaXppbmcgVVNCIE1hc3MgU3Rv
cmFnZSBkcml2ZXIuLi4NCnVzYi5jOiByZWdpc3RlcmVkIG5ldyBkcml2ZXIg
dXNiLXN0b3JhZ2UNClVTQiBNYXNzIFN0b3JhZ2Ugc3VwcG9ydCByZWdpc3Rl
cmVkLg0KbWljZTogUFMvMiBtb3VzZSBkZXZpY2UgY29tbW9uIGZvciBhbGwg
bWljZQ0KbWQ6IGxpbmVhciBwZXJzb25hbGl0eSByZWdpc3RlcmVkIGFzIG5y
IDENCm1kOiByYWlkMCBwZXJzb25hbGl0eSByZWdpc3RlcmVkIGFzIG5yIDIN
Cm1kOiByYWlkMSBwZXJzb25hbGl0eSByZWdpc3RlcmVkIGFzIG5yIDMNCm1k
OiByYWlkNSBwZXJzb25hbGl0eSByZWdpc3RlcmVkIGFzIG5yIDQNCnJhaWQ1
OiBtZWFzdXJpbmcgY2hlY2tzdW1taW5nIHNwZWVkDQogICA4cmVncyAgICAg
OiAgIDk0Ni44MDAgTUIvc2VjDQogICAzMnJlZ3MgICAgOiAgIDgxNy42MDAg
TUIvc2VjDQogICBwSUlfbW14ICAgOiAgMTY0MC4wMDAgTUIvc2VjDQogICBw
NV9tbXggICAgOiAgMjEwNC4wMDAgTUIvc2VjDQpyYWlkNTogdXNpbmcgZnVu
Y3Rpb246IHA1X21teCAoMjEwNC4wMDAgTUIvc2VjKQ0KbWQ6IG1kIGRyaXZl
ciAwLjkwLjAgTUFYX01EX0RFVlM9MjU2LCBNRF9TQl9ESVNLUz0yNw0KbWQ6
IEF1dG9kZXRlY3RpbmcgUkFJRCBhcnJheXMuDQogW2V2ZW50czogMDAwMDAw
N2ZdDQogW2V2ZW50czogMDAwMDAwN2ZdDQpoZGUxOiBiYWQgYWNjZXNzOiBi
bG9jaz03OTcxNDMwNCwgY291bnQ9OA0KZW5kX3JlcXVlc3Q6IEkvTyBlcnJv
ciwgZGV2IDIxOjAxIChoZGUpLCBzZWN0b3IgNzk3MTQzMDQNCm1kOiBkaXNh
YmxlZCBkZXZpY2UgaGRlMSwgY291bGQgbm90IHJlYWQgc3VwZXJibG9jay4N
Cm1kOiBjb3VsZCBub3QgcmVhZCBoZGUxJ3Mgc2IsIG5vdCBpbXBvcnRpbmch
DQptZDogY291bGQgbm90IGltcG9ydCBoZGUxIQ0KIFtldmVudHM6IDAwMDAw
MDdmXQ0KbWQ6IGF1dG9ydW4gLi4uDQptZDogY29uc2lkZXJpbmcgYXRhcmFp
ZC9kMHAxIC4uLg0KbWQ6ICBhZGRpbmcgYXRhcmFpZC9kMHAxIC4uLg0KbWQ6
ICBhZGRpbmcgaGRjNSAuLi4NCm1kOiAgYWRkaW5nIGhkYTggLi4uDQptZDog
Y3JlYXRlZCBtZDANCm1kOiBiaW5kPGhkYTgsMT4NCm1kOiBiaW5kPGhkYzUs
Mj4NCm1kOiBiaW5kPGF0YXJhaWQvZDBwMSwzPg0KbWQ6IHJ1bm5pbmc6IDxh
dGFyYWlkL2QwcDE+PGhkYzU+PGhkYTg+DQptZDogYXRhcmFpZC9kMHAxJ3Mg
ZXZlbnQgY291bnRlcjogMDAwMDAwN2YNCm1kOiBoZGM1J3MgZXZlbnQgY291
bnRlcjogMDAwMDAwN2YNCm1kOiBoZGE4J3MgZXZlbnQgY291bnRlcjogMDAw
MDAwN2YNCm1kMDogbWF4IHRvdGFsIHJlYWRhaGVhZCB3aW5kb3cgc2V0IHRv
IDc0NGsNCm1kMDogMyBkYXRhLWRpc2tzLCBtYXggcmVhZGFoZWFkIHBlciBk
YXRhLWRpc2s6IDI0OGsNCnJhaWQwOiBsb29raW5nIGF0IGhkYTgNCnJhaWQw
OiAgIGNvbXBhcmluZyBoZGE4KDEyMzUzODU2KSB3aXRoIGhkYTgoMTIzNTM4
NTYpDQpyYWlkMDogICBFTkQNCnJhaWQwOiAgID09PiBVTklRVUUNCnJhaWQw
OiAxIHpvbmVzDQpyYWlkMDogbG9va2luZyBhdCBoZGM1DQpyYWlkMDogICBj
b21wYXJpbmcgaGRjNSg0MDk3MzYzMikgd2l0aCBoZGE4KDEyMzUzODU2KQ0K
cmFpZDA6ICAgTk9UIEVRVUFMDQpyYWlkMDogICBjb21wYXJpbmcgaGRjNSg0
MDk3MzYzMikgd2l0aCBoZGM1KDQwOTczNjMyKQ0KcmFpZDA6ICAgRU5EDQpy
YWlkMDogICA9PT4gVU5JUVVFDQpyYWlkMDogMiB6b25lcw0KcmFpZDA6IGxv
b2tpbmcgYXQgYXRhcmFpZC9kMHAxDQpyYWlkMDogICBjb21wYXJpbmcgYXRh
cmFpZC9kMHAxKDM5ODU3MTUyKSB3aXRoIGhkYTgoMTIzNTM4NTYpDQpyYWlk
MDogICBPNVQgRVFVQUwNCnJhaWQwOiAgIGNvbXBhcmluZyBhdGFyYWlkL2Qw
cDEoMzk4NTcxNTIpIHdpdGggaGRjNSg0MDk3MzYzMikNCnJhaWQwOiAgIE5P
VCBFUVVBTA0KcmFpZDA6ICAgY29tcGFyaW5nIGF0YXJhaWQvZDBwMSgzOTg1
NzE1Mikgd2l0aCBhdGFyYWlkL2QwcDEoMzk4NTcxNTIpDQpyYWlkMDogICBF
TkQNCnJhaWQwOiAgID09PiBVTklRVUUNCnJhaWQwOiAzIHpvbmVzDQpyYWlk
MDogRklOQUwgMyB6b25lcw0KcmFpZDA6IHpvbmUgMA0KcmFpZDA6IGNoZWNr
aW5nIGhkYTggLi4uIGNvbnRhaW5lZCBhcyBkZXZpY2UgMA0KICAoMTIzNTM4
NTYpIGlzIHNtYWxsZXN0IS4NCnJhaWQwOiBjaGVja2luZyBoZGM1IC4uLiBj
b250YWluZWQgYXMgZGV2aWNlIDENCnJhaWQwOiBjaGVja2luZyBhdGFyYWlk
L2QwcDEgLi4uIGNvbnRhaW5lZCBhcyBkZXZpY2UgMg0KcmFpZDA6IHpvbmUt
Pm5iX2RldjogMywgc2l6ZTogMzcwNjE1NjgNCnJhaWQwOiBjdXJyZW50IHpv
bmUgb2Zmc2V0OiAxMjM1Mzg1Ng0KcmFpZDA6IHpvbmUgMQ0KcmFpZDA6IGNo
ZWNraW5nIGhkYTggLi4uIG5vcGUuDQpyYWlkMDogY2hlY2tpbmcgaGRjNSAu
Li4gY29udGFpbmVkIGFzIGRldmljZSAwDQogICg0MDk3MzYzMikgaXMgc21h
bGxlc3QhLg0KcmFpZDA6IGNoZWNraW5nIGF0YXJhaWQvZDBwMSAuLi4gY29u
dGFpbmVkIGFzIGRldmljZSAxDQogICgzOTg1NzE1MikgaXMgc21hbGxlc3Qh
Lg0KcmFpZDA6IHpvbmUtPm5iX2RldjogMiwgc2l6ZTogNTUwMDY1OTINCnJh
aWQwOiBjdXJyZW50IHpvbmUgb2Zmc2V0OiAzOTg1NzE1Mg0KcmFpZDA6IHpv
bmUgMg0KcmFpZDA6IGNoZWNraW5nIGhkYTggLi4uIG5vcGUuDQpyYWlkMDog
Y2hlY2tpbmcgaGRjNSAuLi4gY29udGFpbmVkIGFzIGRldmljZSAwDQogICg0
MDk3MzYzMikgaXMgc21hbGxlc3QhLg0KcmFpZDA6IGNoZWNraW5nIGF0YXJh
aWQvZDBwMSAuLi4gbm9wZS4NCnJhaWQwOiB6b25lLT5uYl9kZXY6IDEsIHNp
emU6IDExMTY0ODANCnJhaWQwOiBjdXJyZW50IHpvbmUgb2Zmc2V0OiA0MDk3
MzYzMg0KcmFpZDA6IGRvbmUuDQpyYWlkMCA6IG1kX3NpemUgaXMgOTMxODQ2
NDAgYmxvY2tzLg0KcmFpZDAgOiBjb25mLT5zbWFsbGVzdC0+c2l6ZSBpcyAx
MTE2NDgwIGJsb2Nrcy4NCnJhaWQwIDogbmJfem9uZSBpcyA4NC4NCnJhaWQw
IDogQWxsb2NhdGluZyA2NzIgYnl0ZXMgZm9yIGhhc2guDQptZDogdXBkYXRp
bmcgbWQwIFJBSUQgc3VwZXJibG9jayBvbiBkZXZpY2UNCm1kOiBhdGFyYWlk
L2QwcDEgW2V2ZW50czogMDAwMDAwODBdPDY+KHdyaXRlKSBhdGFyYWlkL2Qw
cDEncyBzYiBvZmZzZXQ6IDM5ODU3MTUyDQptZDogaGRjNSBbZXZlbnRzOiAw
MDAwMDA4MF08Nj4od3JpdGUpIGhkYzUncyBzYiBvZmZzZXQ6IDQwOTczNjMy
DQptZDogaGRhOCBbZXZlbnRzOiAwMDAwMDA4MF08Nj4od3JpdGUpIGhkYTgn
cyBzYiBvZmZzZXQ6IDEyMzUzODU2DQptZDogLi4uIGF1dG9ydW4gRE9ORS4N
Ck5FVDQ6IExpbnV4IFRDUC9JUCAxLjAgZm9yIE5FVDQuMA0KSVAgUHJvdG9j
b2xzOiBJQ01QLCBVRFAsIFRDUCwgSUdNUA0KSVA6IHJvdXRpbmcgY2FjaGUg
aGFzaCB0YWJsZSBvZiA4MTkyIGJ1Y2tldHMsIDY0S2J5dGVzDQpUQ1A6IEhh
c2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlzaGVkIDI2MjE0NCBiaW5k
IDY1NTM2KQ0KTGludXggSVAgbXVsdGljYXN0IHJvdXRlciAwLjA2IHBsdXMg
UElNLVNNDQpORVQ0OiBVbml4IGRvbWFpbiBzb2NrZXRzIDEuMC9TTVAgZm9y
IExpbnV4IE5FVDQuMC4NCk5FVDQ6IExpbnV4IElQWCAwLjQ3IGZvciBORVQ0
LjANCklQWCBQb3J0aW9ucyBDb3B5cmlnaHQgKGMpIDE5OTUgQ2FsZGVyYSwg
SW5jLg0KSVBYIFBvcnRpb25zIENvcHlyaWdodCAoYykgMjAwMCwgMjAwMSBD
b25lY3RpdmEsIEluYy4NCk5FVDQ6IEFwcGxlVGFsayAwLjE4YSBmb3IgTGlu
dXggTkVUNC4wDQpWRlM6IE1vdW50ZWQgcm9vdCAoZXh0MiBmaWxlc3lzdGVt
KSByZWFkb25seS4NCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDI4
OGsgZnJlZWQNCklOSVQ6IHZlcnNpb24gMi43OCBib290aW5nDQoJCQlXZWxj
b21lIHRvIExpbnV4IE1hbmRyYWtlDQoJCVByZXNzICdJJyB0byBlbnRlciBp
bnRlcmFjdGl2ZSBzdGFydHVwLg0KTW91bnRpbmcgcHJvYyBmaWxlc3lzdGVt
IFsgIE9LICBdDQpDb25maWd1cmluZyBrZXJuZWwgcGFyYW1ldGVycyBbICBP
SyAgXQ0KU2V0dGluZyBjbG9jayAgKHV0Yyk6IFdlZCBBdWcgMjEgMDQ6MzU6
MTAgRURUIDIwMDIgWyAgT0sgIF0NClsgIE9LICBdDQpBY3RpdmF0aW5nIHN3
YXAgcGFydGl0aW9ucyBbICBPSyAgXQ0KU2V0dGluZyBob3N0bmFtZSBnYW5k
YWxmLm51aXRhcmkuZGFya3RlY2gub3JnIFsgIE9LICBdDQpDaGVja2luZyBy
b290IGZpbGVzeXN0ZW0NCi9kZXYvaGRhNyB3YXMgbm90IGNsZWFubHkgdW5t
b3VudGVkLCBjaGVjayBmb3JjZWQuDQovZGV2L2hkYTc6IElub2RlIDgyMTM5
LCBpX2Jsb2NrcyBpcyA2NCwgc2hvdWxkIGJlIDguICBGSVhFRC4NCi9kZXYv
aGRhNzogSW5vZGUgMjU5MzU0LCBpX2Jsb2NrcyBpcyA2NCwgc2hvdWxkIGJl
IDguICBGSVhFRC4NCi9kZXYvaGRhNzogMTM1MjA1LzUxMDk3NiBmaWxlcyAo
MS43JSBub24tY29udGlndW91cyksIDkxNzUxNC8xMDIwMTE5IGJsb2Nrcw0K
Wy9zYmluL2ZzY2suZXh0MiAtLSAvXSBmc2NrLmV4dDIgLWEgL2Rldi9oZGE3
IA0KW1BBU1NFRF0NClNldHRpbmcgdXAgSVNBIFBOUCBkZXZpY2VzIC9ldGMv
aXNhcG5wLmNvbmY6MjAgLS0gRmF0YWwgLSBFcnJvciBvY2N1cnJlZCBleGVj
dXRpbmcgcmVxdWVzdCAnSVNPTEFURSBQUkVTRVJWRScgLS0tIGZ1cnRoZXIg
YWN0aW9uIGFib3J0ZWQNCltGQUlMRURdDQpSZW1vdW50aW5nIHJvb3QgZmls
ZXN5c3RlbSBpbiByZWFkLXdyaXRlIG1vZGUgWyAgT0sgIF0NCkZpbmRpbmcg
bW9kdWxlIGRlcGVuZGVuY2llcyBbICBPSyAgXQ0KQ2hlY2tpbmcgZmlsZXN5
c3RlbXMNCi9kZXYvaGRhMSB3YXMgbm90IGNsZWFubHkgdW5tb3VudGVkLCBj
aGVjayBmb3JjZWQuDQovZGV2L2hkYTE6IDQ5LzQwMTYgZmlsZXMgKDIyLjQl
IG5vbi1jb250aWd1b3VzKSwgMTE0NTcvMTYwMzMgYmxvY2tzDQpDaGVja2lu
ZyBhbGwgZmlsZSBzeXN0ZW1zLg0KWy9zYmluL2ZzY2suZXh0MiAtLSAvYm9v
dF0gZnNjay5leHQyIC1hIC9kZXYvaGRhMSANClsvc2Jpbi9mc2NrLnJlaXNl
cmZzIC0tIC9ob21lXSBmc2NrLnJlaXNlcmZzIC1hIC9kZXYvbWQwIA0KWy9z
YmluL2ZzY2sucmVpc2VyZnMgLS0gL2lzb10gZnNjay5yZWlzZXJmcyAtYSAv
ZGV2L2hkYzcgDQpbL3NiaW4vZnNjay5yZWlzZXJmcyAtLSAvdXNyL3NyY10g
ZnNjay5yZWlzZXJmcyAtYSAvZGV2L2hkYzYgDQpbL3NiaW4vZnNjay5yZWlz
ZXJmcyAtLSAvZmdmc10gZnNjay5yZWlzZXJmcyAtYSAvZGV2L2hkYzEgDQpb
UEFTU0VEXQ0KTW91bnRpbmcgbG9jYWwgZmlsZXN5c3RlbXMgbW9kcHJvYmU6
IG1vZHByb2JlOiBDYW4ndCBsb2NhdGUgbW9kdWxlIG1mcw0KbW91bnQ6IGZz
IHR5cGUgbWZzIG5vdCBzdXBwb3J0ZWQgYnkga2VybmVsDQpbRkFJTEVEXQ0K
Q2hlY2tpbmcgbG9vcGJhY2sgZmlsZXN5c3RlbXNDaGVja2luZyBhbGwgZmls
ZSBzeXN0ZW1zLg0KWyAgT0sgIF0NCk1vdW50aW5nIGxvb3BiYWNrIGZpbGVz
eXN0ZW1zIFsgIE9LICBdDQpUdXJuaW5nIG9uIHVzZXIgYW5kIGdyb3VwIHF1
b3RhcyBmb3IgbG9jYWwgZmlsZXN5c3RlbXMgWyAgT0sgIF0NCkVuYWJsaW5n
IHN3YXAgc3BhY2UgWyAgT0sgIF0NCkJ1aWxkaW5nIFdpbmRvdyBNYW5hZ2Vy
IFNlc3Npb25zIENhbid0IHdyaXRlIHRvIC9ldGMvWDExL2dkbS9TZXNzaW9u
cy9rZGUNCltGQUlMRURdDQpDbGVhbi11cCAvdG1wIGRpcmVjdG9yeTogWyAg
T0sgIF0NCklOSVQ6IEVudGVyaW5nIHJ1bmxldmVsOiA1DQpFbnRlcmluZyBu
b24taW50ZXJhY3RpdmUgc3RhcnR1cA0KU2V0dGluZyBuZXR3b3JrIHBhcmFt
ZXRlcnMgWyAgT0sgIF0NCkJyaW5naW5nIHVwIGludGVyZmFjZSBsbyBbICBP
SyAgXQ0KRW5hYmxpbmcgSVB2NCBwYWNrZXQgZm9yd2FyZGluZyBbICBPSyAg
XQ0KQnJpbmdpbmcgdXAgaW50ZXJmYWNlIHRyMCBbICBPSyAgXQ0KU3RhcnRp
bmcgc3lzdGVtIGxvZ2dlcjogWyAgT0sgIF0NClN0YXJ0aW5nIGtlcm5lbCBs
b2dnZXI6IFsgIE9LICBdDQpTdGFydGluZyBjcm9uIGRhZW1vbjogWyAgT0sg
IF0NCi9ldGMvcmMuZC9yYzUuZC9TNDVhdGQ6IC9wcm9jLzM0NS9sb2NrOiBO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQpTdGFydGluZyBhdCBkYWVtb246
IFsgIE9LICBdDQpTdGFydGluZyBJTkVUIHNlcnZpY2VzOiBbICBPSyAgXQ0K
U3RhcnRpbmcgcG9ydG1hcHBlcjogWyAgT0sgIF0NClN0YXJ0aW5nIGxwZDog
WyAgT0sgIF0NCkxvYWRpbmcgY29tcG9zZSBrZXlzOiBjb21wb3NlLmxhdGlu
IFsgIE9LICBdDQpUaGUgQmFja1NwYWNlIGtleSBzZW5kczogXj9bICBPSyAg
XQ0KTG9hZGluZyBzeXN0ZW0gZm9udDogIFsgIE9LICBdDQpTdGFydGluZyBw
b3N0Zml4IFsgIE9LICBdDQpTdGFydGluZyBjb25zb2xlIG1vdXNlIHNlcnZp
Y2VzOiBbICBPSyAgXQ0KU3RhcnRpbmcgWCBGb250IFNlcnZlcjogU3RhcnRp
bmcgbXlzcWxkIGRhZW1vbiB3aXRoIGRhdGFiYXNlcyBmcm9tIC92YXIvbGli
L215c3FsDQpbICBPSyAgXQ0KU3RhcnRpbmcgaHR0cGQ6IFsgIE9LICBdDQpJ
bml0aWFsaXppbmcgTU9TSVguLi4NCkVycm9yOiB0aGlzIGlzIG5vdCBNT1NJ
WCENCg0KYmxrOiBxdWV1ZSBjMDNmZWUwNCwgL2Rldi9oZGE6DQogc2V0dEkv
TyBsaW1pdCA0MDk1TWIgKG1hc2sgMHhmZmZmZmZmZikNCmluZyB1c2luZ19k
bWEgdG8gMSAob24pDQogdXNpbmdfZG1hICAgID0gYmxrOiBxdWV1ZSBjMDNm
ZjE0OCwgIDEgKG9uKQ0KDQovZGV2L0kvTyBsaW1pdCA0MDk1TWIgKG1hc2sg
MHhmZmZmZmZmZikNCmhkYzoNCiBzZXR0aW5nIHVzaW5nX2RtYSB0byAxIChv
bikNCiB1c2luZ19kbWEgICAgPSAgMSAob24pDQoNCi9kZXYvaGRhOg0KIHNl
dHRpbmcgMzItYml0IEkvTyBzdXBwb3J0IGZsYWcgdG8gMQ0KIEkvTyBzdXBw
b3J0ICA9ICAxICgzMi1iaXQpDQpTSU9DU0lGTVRVOiBJbnZhbGlkIGFyZ3Vt
ZW50DQptb2Rwcm9iZTogQ2FuJ3QgbG9jYXRlIG1vZHVsZSBpMmMtaXNhDQpt
b2Rwcm9iZTogQ2FuJ3QgbG9jYXRlIG1vZHVsZSB2aWE2ODZhDQpDYW4ndCBh
Y2Nlc3MgL3Byb2MgZmlsZQ0KL3Byb2Mvc3lzL2Rldi9zZW5zb3JzL2NoaXBz
IG9yIC9wcm9jL2J1cy9pMmMgdW5yZWFkYWJsZTsNCk1ha2Ugc3VyZSB5b3Ug
aGF2ZSBkb25lICdtb2Rwcm9iZSBpMmMtcHJvYychDQptb2Rwcm9iZTogQ2Fu
J3QgbG9jYXRlIG1vZHVsZSBlbXUxMGsxDQptb2Rwcm9iZTogQ2FuJ3QgbG9j
YXRlIG1vZHVsZSBhZ3BnYXJ0DQptb2Rwcm9iZTogQ2FuJ3QgbG9jYXRlIG1v
ZHVsZSBlbXUxMGsxLWdwDQpzc2hkOiBTU0ggU2VjdXJlIFNoZWxsIDIuMy4w
IChub24tY29tbWVyY2lhbCB2ZXJzaW9uKSBvbiBpNjg2LXBjLWxpbnV4LWdu
dQ0KbW9kcHJvYmU6IHVzYi11aGNpLmM6ICRSZXZpc2lvbjogMS4yNzUgJCB0
aW1lIDAzOjA1OjE0IEF1ZyAyMSAyMDAyDQpDYW4ndCBsb2NhdGUgbW9kdXNi
LXVoY2kuYzogSGlnaCBiYW5kd2lkdGggbW9kZSBlbmFibGVkDQp1bGUgdmlk
ZW9kZXYNClBDSTogRm91bmQgSVJRIDExIGZvciBkZXZpY2UgMDA6MDcuMg0K
UENJOiBTaGFyaW5nIElSUSAxMSB3aXRoIDAwOjA3LjMNClBDSTogU2hhcmlu
ZyBJUlEgMTEgd2l0aCAwMDowOC4wDQpQQ0k6IFNoYXJpbmcgSVJRIDExIHdp
dGggMDA6MGIuMA0KdXNiLXVoY2kuYzogVVNCIFVIQ0kgYXQgSS9PIDB4OTQw
MCwgSVJRIDExDQp1c2ItdWhjaS5jOiBEZXRlY3RlZCAyIHBvcnRzDQp1c2Iu
YzogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJl
ciAxDQpodWIuYzogVVNCIGh1YiBmdSBuZA0KaHViLmM6IDIgcG9ydHMgZGV0
ZWN0ZWQNClBDSTogRm91bmQgSVJRIDExIGZvciBkZXZpY2UgMDA6MDcuMw0K
UENJOiBTaGFyaW5nIElSUSAxMSB3aXRoIDAwOjA3LjINClBDSTogU2hhcmlu
ZyBJUlEgMTEgd2l0aCAwMDowOC4wDQpQQ0k6IFNoYXJpbmcgSVJRIDExIHdp
dGggMDA6MGIuMA0KdXNiLXVoY2kuYzogVVNCIFVIQ0kgYXQgSS9PIDB4OTgw
MCwgSVJRIDExDQp1c2ItdWhjaS5jOiBEZXRlY3RlZCAyIHBvcnRzDQp1c2Iu
YzogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJl
ciAyDQpodWIuYzogVVNCIGh1YiBmb3VuZA0KaHViLmM6IDIgcG9ydHMgZGV0
ZWN0ZWQNCnVzYi11aGNpLmM6IHYxLjI3NTpVU0IgVW5pdmVyc2FsIEhvc3Qg
Q29udHJvbGxlciBJbnRlcmZhY2UgZHJpdmVyDQp1c2IuYzogcmVnaXN0ZXJl
ZCBuZXcgZHJpdmVyIG92NTExDQpvdjUxMS5jOiB2MS42MiA6IG92NTExIFVT
QiBDYW1lcmEgRHJpdmVyDQpvdjUxMV9kZWNvbXAuYzogdjEuNiA6IE9WNTEx
IERlY29tcHJlc3Npb24gTW9kdWxlDQptb2Rwcm9iZTogQ2FuJ3QgbG9jYXRl
IG1vZHVsZSB1c2Itc3RvcmFnZQ0KbW9kcHJvYmU6IENhbid0TWF0cm94IE1H
QSBHMjAwL0c0MDAvRzQ1MC9HNTUwIFlVViBWaWRlbyBpbnRlcmZhY2UgdjIu
MDEgKGMpIEFhcm9uIEhvbHR6bWFuICYgQSdycGkNCiBsb2NhdGUgbW9kdWxl
IGFtZ2FfdmlkOiBGb3VuZCBNR0EgRzQwMC9HNDUwDQpuYWxvZw0KbW9kcHJv
YmU6bWdhX3ZpZDogTU1JTyBhdCAweGY4YjRlMDAwIElSUTogOSAgZnJhbWVi
dWZmZXI6IDB4RTQwMDAwMDANCiBDYW4ndCBsb2NhdGUgbW9tZ2FfdmlkOiBP
UFRJT04gd29yZDogMHg1MDA0MEQyMCAgbWVtOiAweDAzICBTRFJBTQ0KZHVs
ZSBoaWQNCm1vZHByb21nYV92aWQ6IGRldGVjdGVkIFJBTVNJWkUgaXMgMzIg
TUINCmJlOiBDYW4ndCBsb2NhdGVzeW5jZmIgKG1nYSk6IElSUSBkaXNhYmxl
ZCBpbiBtZ2FfdmlkLmMNCiBtb2R1bGUgbW91c2VkZXYNCm1vdW50OiBub25l
IGFsUENJOiBGb3VuZCBJUlEgMTEgZm9yIGRldmljZSAwMDowOC4wDQpyZWFk
eSBtb3VudGVkIG9yUENJOiBTaGFyaW5nIElSUSAxMSB3aXRoIDAwOjA3LjIN
CiAvcHJvYy9idXMvdXNiIGJQQ0k6IFNoYXJpbmcgSVJRIDExIHdpdGggMDA6
MDcuMw0KdXN5DQptb3VudDogYWNjb1BDSTogU2hhcmluZyBJUlEgMTEgd2l0
aCAwMDowYi4wDQpyZGluZyB0byBtdGFiLCBuaHViLmM6IFVTQiBuZXcgZGV2
aWNlIGNvbm5lY3Qgb24gYnVzMS8xLCBhc3NpZ25lZCBkZXZpY2UgbnVtYmVy
IDINCm9uZSBpcyBhbHJlYWR5IG1zY3NpMSA6IEFkYXB0ZWMgQUlDN1hYWCBF
SVNBL1ZMQi9QQ0kgU0NTSSBIQkEgRFJJVkVSLCBSZXYgNi4yLjgNCm91bnRl
ZCBvbiAvcHJvYy8gICAgICAgIDxBZGFwdGVjIDI5MzBDVSBTQ1NJIGFkYXB0
ZXI+DQpidXMvdXNiDQptb2Rwcm9iICAgICAgICBhaWM3ODYwOiBVbHRyYSBT
aW5nbGUgQ2hhbm5lbCBBLCBTQ1NJIElkPTcsIDMvMjUzIFNDQnMNCmU6IENh
bid0IGxvY2F0ZSANCm1vZHVsZSBkZHJtYXQNCm1ibGs6IHF1ZXVlIGY3YjVi
YmYwLCBvZHByb2JlOiBDYW4ndCBsSS9PIGxpbWl0IDQwOTVNYiAobWFzayAw
eGZmZmZmZmZmKQ0Kb2NhdGUgbW9kdWxlIGpveW92NTExLmM6IFVTQiBPVjUx
MSsgdmlkZW8gZGV2aWNlIGZvdW5kDQpkZXYNCm92NTExLmM6IG1vZGVsOiBD
cmVhdGl2ZSBMYWJzIFdlYkNhbSAzDQpvdjUxMS5jOiBTZW5zb3IgaXMgYW4g
T1Y3NjIwDQpvdjUxMS5jOiBEZXZpY2UgcmVnaXN0ZXJlZCBvbiBtaW5vciAw
DQpodWIuYzogVVNCIG5ldyBkZXZpY2UgY29ubmVjdCBvbiBidXMxLzIsIGFz
c2lnbmVkIGRldmljZSBudW1iZXIgMw0KaW5wdXQxOiBVU0IgSElEIHYxLjEw
IE1vdXNlIFtMb2dpdGVjaCBVU0ItUFMvMiBPcHRpY2FsIE1vdXNlXSBvbiB1
c2IxOjMuMA0KaHViLmM6IFVTQiBuZXcgZGV2aWNlIGNvbm5lY3Qgb24gYnVz
Mi8xLCBhc3NpZ25lZCBkZXZpY2UgbnVtYmVyIDINCnNjc2kyIDogU0NTSSBl
bXVsYXRpb24gZm9yIFVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlcw0KICBWZW5k
b3I6IFVTQiAgICAgICBNb2RlbDogQ0QtUi9SVyA0WDRYNiAgICAgUmV2OiBB
LkVaDQogIFR5cGU6ICAgQ0QtUk9NICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBBTlNJIFNDU0kgcmV2aXNpb246IDAyDQpyZXNpemVfZG1hX3Bvb2w6
IHVua25vd24gZGV2aWNlIHR5cGUgLTENCiAgVmVuZG9yOiBQSU9ORUVSICAg
TW9kZWw6IENELVJPTSBEUk0tMTgwNFggIFJldjogMDEwMQ0KICBUeXBlOiAg
IENELVJPTSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU5TSSBTQ1NJ
IHJldmlzaW9uOiAwMg0KYmxrOiBxdWV1ZSBmN2I1YjJhOCwgSS9PIGxpbWl0
IDQwOTVNYiAobWFzayAweGZmZmZmZmZmKQ0KKHNjc2kxOkE6MSk6IDUuMDAw
TUIvcyB0cmFuc2ZlcnMgKDUuMDAwTUh6LCBvZmZzZXQgMTUpDQogIFZlbmRv
cjogUElPTkVFUiAgIE1vZGVsOiBDSEFOR1IgRFJNLTE4MDRYICBSZXY6IDAx
MDENCiAgVHlwZTogICBNZWRpdW0gQ2hhbmdlciAgICAgICAgICAgICAgICAg
ICAgIEFOU0kgU0NTSSByZXZpc2lvbjogMDINCmJsazogcXVldWUgZjdiNWJj
ZjgsIEkvTyBsaW1pdCA0MDk1TWIgKG1hc2sgMHhmZmZmZmZmZikNCiAgVmVu
ZG9yOiBQTEVYVE9SICAgTW9kZWw6IENELVJPTSBETS1YWDI4ICAgIFJldjog
My4wOA0KICBUeXBlOiAgIENELVJPTSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQU5TSSBTQ1NJIHJldmlzaW9uOiAwMg0KYmxrOiBxdWV1ZSBmN2I1
YjRiOCwgSS9PIGxpbWl0IDQwOTVNYiAobWFzayAweGZmZmZmZmZmKQ0KQXR0
YWNoZWQgc2NzaSBnZW5lcmljIHNnMyBhdCBzY3NpMSwgY2hhbm5lbCAwLCBp
ZCAxLCBsdW4gMSwgIHR5cGUgOA0KQXR0YWNoZWQgc2NzaSBDRC1ST00gc3Iw
IGF0IHNjc2kwLCBjaGFubmVsIDAsIGlkIDAsIGx1biAwDQpBdHRhY2hlZCBz
Y3NpIENELVJPTSBzcjEgYXQgc2NzaTEsIGNoYW5uZWwgMCwgaWQgMSwgbHVu
IDANCkF0dGFjaGVkIHNjc2kgQ0QtUk9NIHNyMiBhdCBzY3NpMSwgY2hhbm5l
bCAwLCBpZCA1LCBsdW4gMA0KQXR0YWNoZWQgc2NzaSBDRC1ST00gc3IzIGF0
IHNjc2kyLCBjaGFubmVsIDAsIGlkIDAsIGx1biAwDQpzcjA6IHNjc2kzLW1t
YyBkcml2ZTogMzJ4LzMyeCB3cml0ZXIgY2QvcncgeGEvZm9ybTIgY2RkYSB0
cmF5DQpzcjE6IHNjc2ktMSBkcml2ZQ0Kc3IyOiBzY3NpLTEgZHJpdmUNCnNy
Mzogc2NzaTMtbW1jIGRyaXZlOiA2eC82eCB3cml0ZXIgY2QvcncgeGEvZm9y
bTIgY2RkYSB0cmF5DQpteXNxbGQgZGFlbW9uIGVuZGVkDQpVbmFibGUgdG8g
aGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmly
dHVhbCBhZGRyZXNzIDAwMDAwMDAwDQogcHJpbnRpbmcgZWlwOg0KYzAxMGM2
ZjQNCipwZGUgPSAwMDAwMDAwMA0KT29wczogMDAwMg0KQ1BVOiAgICAwDQpF
SVA6ICAgIDAwMTA6WzxjMDEwYzZmND5dICAgIE5vdCB0YWludGVkDQpFRkxB
R1M6IDAwMDEwMjQ2DQplYXg6IDAwMDAwMDAwICAgZWJ4OiAwMDAwMDAxOCAg
IGVjeDogZTViMTQwMDAgICBlZHg6IGY3ZTExZjFjDQplc2k6IGU1YjFhMDA0
ICAgZWRpOiBmZmZmZmZmYiAgIGVicDogMDAwMDAwMDEgICBlc3A6IGU1YjE1
ZjkwDQpkczogMDAxOCAgIGVzOiAwMDE4ICAgc3M6IDAwMTgNClByb2Nlc3Mg
c3RyYWNlIChwaWQ6IDY5NCwgc3RhY2twYWdlPWU1YjE1MDAwKQ0KU3RhY2s6
IGU1YjFhMDAwIDAwMDAwMDAwIGU1YjY1ZDc0IDQwMDE0MDIzIDAwMDAwMDIz
IGU1YjY1ZDk0IGU1YjE0MGI4IDAwMDAwMDAwIA0KICAgICAgIGU1YjE0MDAw
IDAwMDAwMDAwIDAwMDAwMDE4IGJmZmZlNzljIGMwMTA4ZWFmIDAwMDAwMDE4
IDAwMDAwMmI3IDAwMDAwMDAxIA0KICAgICAgIDAwMDAwMDAwIDAwMDAwMDE4
IGJmZmZlNzljIDAwMDAwMDFhIDAwMDAwMDJiIDAwMDAwMDJiIDAwMDAwMDFh
IDQwMGQ3MzY2IA0KQ2FsbCBUcmFjZTogICAgWzxjMDEwOGVhZj5dDQoNCkNv
ZGU6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIGVhIGIz
IDQyIDQzIDdiIDlhIDQzIDQzIA0KIG15c3FsZCBkYWVtb24gZW5kZWQNCnJl
aXNlcmZzOiBjaGVja2luZyB0cmFuc2FjdGlvbiBsb2cgKGRldmljZSAxNjow
NikgLi4uDQpVc2luZyByNSBoYXNoIHRvIHNvcnQgbmFtZXMNCnJlaXNlcmZz
OiB1c2luZyAzLjUueCBkaXNrIGZvcm1hdA0KUmVpc2VyRlMgdmVyc2lvbiAz
LjYuMjUNClN5c1JxIDogSEVMUCA6IGxvZ2xldmVsMC04IHJlQm9vdCB0RXJt
IGtJbGwgc2FLIHNob3dNZW0gT2ZmIHNob3dQYyB1blJhdyBTeW5jIHNob3dU
YXNrcyBVbm1vdW50IA0KU3lzUnEgOiBTaG93IE1lbW9yeQ0KTWVtLWluZm86
DQpGcmVlIHBhZ2VzOiAgICAgIDY4MzAwNGtCICggODIyMjBrQiBIaWdoTWVt
KQ0KWm9uZTpETUEgZnJlZXBhZ2VzOiAxMzAxMmtCIG1pbjogICAxMjhrQiBs
b3c6ICAgMjU2a0IgaGlnaDogICAzODRrQg0KWm9uZTpOb3JtYWwgZnJlZXBh
Z2VzOjU4Nzc3MmtCIG1pbjogIDEwMjBrQiBsb3c6ICAyMDQwa0IgaGlnaDog
IDMwNjBrQg0KWm9uZTpIaWdoTWVtIGZyZWVwYWdlczogODIyMjBrQiBtaW46
ICAxMDIwa0IgbG93OiAgMjA0MGtCIGhpZ2g6ICAzMDYwa0INCiggQWN0aXZl
OiA0NTg3LCBpbmFjdGl2ZTogNzUxOTksIGZyZWU6IDE3MDc1MSApDQoxKjRr
QiAwKjhrQiAxKjE2a0IgMiozMmtCIDQqNjRrQiAzKjEyOGtCIDIqMjU2a0Ig
MSo1MTJrQiAxKjEwMjRrQiA1KjIwNDhrQiA9IDEzMDEya0IpDQo5KjRrQiA1
KjhrQiAxKjE2a0IgMjUqMzJrQiAxODYqNjRrQiA1MioxMjhrQiA0KjI1NmtC
IDIqNTEya0IgMSoxMDI0a0IgMjc2KjIwNDhrQiA9IDU4Nzc3MmtCKQ0KMSo0
a0IgMSo4a0IgMCoxNmtCIDEqMzJrQiAwKjY0a0IgMCoxMjhrQiAxKjI1NmtC
IDAqNTEya0IgMCoxMDI0a0IgNDAqMjA0OGtCID0gODIyMjBrQikNClN3YXAg
Y2FjaGU6IGFkZCAwLCBkZWxldGUgMCwgZmluZCAwLzAsIHJhY2UgMCswDQpG
cmVlIHN3YXA6ICAgICAgIDI0ODkyOGtCDQoyNjIxMjggcGFnZXMgb2YgUkFN
DQozMjc1MiBwYWdlcyBvZiBISUdITUVNDQozOTExIHJlc2VydmVkIHBhZ2Vz
DQo4NzM4NiBwYWdlcyBzaGFyZWQNCjAgcGFnZXMgc3dhcCBjYWNoZWQNCjQg
cGFnZXMgaW4gcGFnZSB0YWJsZSBjYWNoZQ0KQnVmZmVyIG1lbW9yeTogICAg
IDE5MDRrQg0KQ2FjaGUgbWVtb3J5OiAgIDI5NzcwMGtCDQpTeXNScSA6IEhF
TFAgOiBsb2dsZXZlbDAtOCByZUJvb3QgdEVybSBrSWxsIHNhSyBzaG93TWVt
IE9mZiBzaG93UGMgdW5SYXcgU3luYyBzaG93VGFza3MgVW5tb3VudCANClN5
c1JxIDogU2hvdyBNZW1vcnkNCk1lbS1pbmZvOg0KRnJlZSBwYWdlczogICAg
ICA2ODI5OTJrQiAoIDgyMjE2a0IgSGlnaE1lbSkNClpvbmU6RE1BIGZyZWVw
YWdlczogMTMwMTJrQiBtaW46ICAgMTI4a0IgbG93OiAgIDI1NmtCIGhpZ2g6
ICAgMzg0a0INClpvbmU6Tm9ybWFsIGZyZWVwYWdlczo1ODc3NjRrQiBtaW46
ICAxMDIwa0IgbG93OiAgMjA0MGtCIGhpZ2g6ICAzMDYwa0INClpvbmU6SGln
aE1lbSBmcmVlcGFnZXM6IDgyMjE2a0IgbWluOiAgMTAyMGtCIGxvdzogIDIw
NDBrQiBoaWdoOiAgMzA2MGtCDQooIEFjdGl2ZTogNDU4OCwgaW5hY3RpdmU6
IDc1MTk5LCBmcmVlOiAxNzA3NDggKQ0KMSo0a0IgMCo4a0IgMSoxNmtCIDIq
MzJrQiA0KjY0a0IgMyoxMjhrQiAyKjI1NmtCIDEqNTEya0IgMSoxMDI0a0Ig
NSoyMDQ4a0IgPSAxMzAxMmtCKQ0KNyo0a0IgNSo4a0IgMSoxNmtCIDI1KjMy
a0IgMTg2KjY0a0IgNTIqMTI4a0IgNCoyNTZrQiAyKjUxMmtCIDEqMTAyNGtC
IDI3NioyMDQ4a0IgPSA1ODc3NjRrQikNCjQqNGtCIDEqOGtCIDEqMTZrQiAw
KjMya0IgMCo2NGtCIDAqMTI4a0IgMSoyNTZrQiAwKjUxMmtCIDAqMTAyNGtC
IDQwKjIwNDhrQiA9IDgyMjE2a0IpDQpTd2FwIGNhY2hlOiBhZGQgMCwgZGVs
ZXRlIDAsIGZpbmQgMC8wLCByYWNlIDArMA0KRnJlZSBzd2FwOiAgICAgICAy
NDg5MjhrQg0KMjYyMTI4IHBhZ2VzIG9mIFJBTQ0KMzI3NTIgcGFnZXMgb2Yg
SElHSE1FTQ0KMzkxMSByZXNlcnZlZCBwYWdlcw0KODczODcgcGFnZXMgc2hh
cmVkDQowIHBhZ2VzIHN3YXAgY2FjaGVkDQo2IHBhZ2VzIGluIHBhZ2UgdGFi
bGUgY2FjaGUNCkJ1ZmZlciBtZW1vcnk6ICAgICAxOTA0a0INCkNhY2hlIG1l
bW9yeTogICAyOTc3MDRrQg0KU3lzUnEgOiBIRUxQIDogbG9nbGV2ZWwwLTgg
cmVCb290IHRFcm0ga0lsbCBzYUsgc2hvd01lbSBPZmYgc2hvd1BjIHVuUmF3
IFN5bmMgc2hvd1Rhc2tzIFVubW91bnQgDQpTeXNScSA6IFNob3cgU3RhdGUN
Cg0KICAgICAgICAgICAgICAgICAgICAgICAgIGZyZWUgICAgICAgICAgICAg
ICAgICAgICAgICBzaWJsaW5nDQogIHRhc2sgICAgICAgICAgICAgUEMgICAg
c3RhY2sgICBwaWQgZmF0aGVyIGNoaWxkIHlvdW5nZXIgb2xkZXINCmluaXQg
ICAgICAgICAgUyBDMDM2NzZGNCAgNDY0NCAgICAgMSAgICAgIDAgICA2MDIg
ICAgICAgICAgICAgICAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2
MjI4Pl0gWzxjMDEzMmQwYz5dIFs8YzAxMTYxODA+XSBbPGMwMTQyZTM3Pl0g
WzxjMDE0OGI2Yj5dDQogIFs8YzAxNDhmZjE+XSBbPGMwMTQwYzk5Pl0gWzxj
MDEwOGVhZj5dDQprZXZlbnRkICAgICAgIFIgMDAwMDAwMDEgIDYwODQgICAg
IDIgICAgICAxICAgICAgICAgICAgIDMgICAgICAgKEwtVExCKQ0KQ2FsbCBU
cmFjZTogICAgWzxjMDEyNjI2ND5dIFs8YzAxMjYxNjA+XSBbPGMwMTA1MDAw
Pl0gWzxjMDEwNzJmZT5dIFs8YzAxMjYxNjA+XQ0Ka2FwbWQgICAgICAgICBT
IEY3RUY3RkI0ICA2MDE2ICAgICAzICAgICAgMSAgICAgICAgICAgICA0ICAg
ICAyIChMLVRMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMTYyMjg+XSBbPGMw
MTE2MTgwPl0gWzxjMDExNDE1YT5dIFs8YzAxMTQzZmI+XSBbPGMwMTE0Yjkx
Pl0NCiAgWzxjMDEwNTAwMD5dIFs8YzAxMDcyZmU+XSBbPGMwMTE0YWEwPl0N
Cmtzb2Z0aXJxZF9DUFUgUyBDMDNENkRDMCAgNjQwNCAgICAgNCAgICAgIDEg
ICAgICAgICAgICAgNSAgICAgMyAoTC1UTEIpDQpDYWxsIFRyYWNlOiAgICBb
PGMwMTFkZGE2Pl0gWzxjMDExZTA0ZT5dIFs8YzAxMDUwMDA+XSBbPGMwMTA3
MmZlPl0gWzxjMDExZGZkMD5dDQprc3dhcGQgICAgICAgIFMgMDAwMDAwMDAg
IDY2MzYgICAgIDUgICAgICAxICAgICAgICAgICAgIDYgICAgIDQgKEwtVExC
KQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEzMWU3Nj5dIFs8YzAxMzFkZjA+XSBb
PGMwMTA1MDAwPl0gWzxjMDEwNzJmZT5dIFs8YzAxMzFkZjA+XQ0KYmRmbHVz
aCAgICAgICBTIDAwMDAwMDAwICA2NjI0ICAgICA2ICAgICAgMSAgICAgICAg
ICAgICA3ICAgICA1IChMLVRMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMTY4
ODg+XSBbPGMwMTNkZjkyPl0gWzxjMDEwNTAwMD5dIFs8YzAxMDcyZmU+XSBb
PGMwMTNkZWUwPl0NCmt1cGRhdGVkICAgICAgUyAwMDAwMTAwMCAgNjAwOCAg
ICAgNyAgICAgIDEgICAgICAgICAgICAgOCAgICAgNiAoTC1UTEIpDQpDYWxs
IFRyYWNlOiAgICBbPGMwMTE2MjI4Pl0gWzxjMDExNjE4MD5dIFs8YzAxM2Uw
Mjk+XSBbPGMwMTA1MDAwPl0gWzxjMDEwNTAwMD5dDQogIFs8YzAxMDcyZmU+
XSBbPGMwMTNkZmEwPl0NCmtodWJkICAgICAgICAgUyBFNDVGRTAwMCAgNTI3
MiAgICAgOCAgICAgIDEgICAgICAgICAgICAgOSAgICAgNyAoTC1UTEIpDQpD
YWxsIFRyYWNlOiAgICBbPGMwMjdlZDZlPl0gWzxjMDEwOGY1NT5dIFs8YzAx
MDUwMDA+XSBbPGMwMTA3MmZlPl0gWzxjMDI3ZWNlMD5dDQptZHJlY292ZXJ5
ZCAgIFMgQzFDMTdGNDQgIDY1NTIgICAgIDkgICAgICAxICAgICAgICAgICAz
MjMgICAgIDggKEwtVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDJmYjEyNz5d
IFs8YzAyOWQ1YjQ+XSBbPGMwMTA3MmZlPl0gWzxjMDI5ZDQ3MD5dDQpzeXNs
b2dkICAgICAgIFMgMDAwMDAwMDAgIDE2MzIgICAzMjMgICAgICAxICAgICAg
ICAgICAzMzEgICAgIDkgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEz
MmJiMT5dIFs8YzAxMTYyNzM+XSBbPGMwMTQ4OTExPl0gWzxjMDJhNTJiZT5d
IFs8YzAxNDhiNmI+XQ0KICBbPGMwMTQ4ZmYxPl0gWzxjMDEwOGVhZj5dDQpr
bG9nZCAgICAgICAgIFIgQzFDMEQzRDggIDE2MzIgICAzMzEgICAgICAxICAg
ICAgICAgICAzNDQgICAzMjMgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxj
MDExOTBhNz5dIFs8YzAxMzk4MjM+XSBbPGMwMTA4ZWFmPl0NCmNyb25kICAg
ICAgICAgUyAwMDAwMDAwMCAgNjA2NCAgIDM0NCAgICAgIDEgICAgICAgICAg
IDM1NyAgIDMzMSAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2MjI4
Pl0gWzxjMDExNjE4MD5dIFs8YzAxMjE3ODA+XSBbPGMwMTA4ZWFmPl0NCmF0
ZCAgICAgICAgICAgUyBDMDE0MDk5MCAgMjY1NiAgIDM1NyAgICAgIDEgICAg
ICAgICAgIDM3MCAgIDM0NCAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMw
MTQwOTkwPl0gWzxjMDExNjIyOD5dIFs8YzAxMTYxODA+XSBbPGMwMTIxNzgw
Pl0gWzxjMDEwOGVhZj5dDQppbmV0ZCAgICAgICAgIFMgQzAzNjc1OTAgIDYw
ODAgICAzNzAgICAgICAxICAgICAgICAgICAzODMgICAzNTcgKE5PVExCKQ0K
Q2FsbCBUcmFjZTogICAgWzxjMDExNjI3Mz5dIFs8YzAyYmFkMTc+XSBbPGMw
MTQ4YjZiPl0gWzxjMDE0OGZmMT5dIFs8YzAxMDhlYWY+XQ0KcG9ydG1hcCAg
ICAgICBTIDAwMDAwMDAwICAyNjYwICAgMzgzICAgICAgMSAgICAgICAgICAg
Mzk2ICAgMzcwIChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMzJiYjE+
XSBbPGMwMTE2MjczPl0gWzxjMDJiYWQxNz5dIFs8YzAxNDhiNmI+XSBbPGMw
MTQ4ZmYxPl0NCiAgWzxjMDEwOGVhZj5dDQpscGQgICAgICAgICAgIFMgMDAw
MDAwMDAgIDI2NjAgICAzOTYgICAgICAxICAgICAgICAgICA0NzUgICAzODMg
KE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEzMmJiMT5dIFs8YzAxMTYy
NzM+XSBbPGMwMmJhZDE3Pl0gWzxjMDE0OGI2Yj5dIFs8YzAxNDhmZjE+XQ0K
ICBbPGMwMTA4ZWFmPl0NCm1hc3RlciAgICAgICAgUyBDMDM2NzU5MCAgNTAz
NiAgIDQ3NSAgICAgIDEgICA0ODMgICAgIDQ5MCAgIDM5NiAoTk9UTEIpDQpD
YWxsIFRyYWNlOiAgICBbPGMwMTE2MjI4Pl0gWzxjMDExNjE4MD5dIFs8YzAx
NDhiNmI+XSBbPGMwMTQ4ZmYxPl0gWzxjMDEwOGVhZj5dDQpwaWNrdXAgICAg
ICAgIFMgMDAwMDAwMDAgIDI2NjAgICA0ODIgICAgNDc1ICAgICAgICAgICA0
ODMgICAgICAgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEzMmJiMT5d
IFs8YzAyYTIyNzg+XSBbPGMwMTE2MjI4Pl0gWzxjMDExNjE4MD5dIFs8YzAx
NDJlMzc+XQ0KICBbPGMwMTQ4YjZiPl0gWzxjMDE0OGZmMT5dIFs8YzAxMDhl
YWY+XQ0KcW1nciAgICAgICAgICBTIDAwMDAwMDAwICA1MDM2ICAgNDgzICAg
IDQ3NSAgICAgICAgICAgICAgICAgNDgyIChOT1RMQikNCkNhbGwgVHJhY2U6
ICAgIFs8YzAxMzJiYjE+XSBbPGMwMTJkOWU4Pl0gWzxjMDExNjIyOD5dIFs8
YzAxMTYxODA+XSBbPGMwMTQyZTM3Pl0NCiAgWzxjMDE0OGI2Yj5dIFs8YzAx
NDhmZjE+XSBbPGMwMTNhNzY2Pl0gWzxjMDEwOGVhZj5dDQpncG0gICAgICAg
ICAgIFMgRTREN0JGMzQgIDYwNzIgICA0OTAgICAgICAxICAgICAgICAgICA1
NzUgICA0NzUgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEzYTM2ZT5d
IFs8YzAxMTYyMjg+XSBbPGMwMTE2MTgwPl0gWzxjMDEyMTc4MD5dIFs8YzAx
MDhlYWY+XQ0KZG5ldGMgICAgICAgICBSIGN1cnJlbnQgICA1MDM2ICAgNTQ2
ICAgICAgMSAgICAgICAgICAgNTk3ICAgNTk0IChOT1RMQikNCkNhbGwgVHJh
Y2U6ICAgIFs8YzAxMGE1NTU+XSBbPGMwMTBjYjE4Pl0NCnNzaGQgICAgICAg
ICAgUyBDMDM2NzU5MCAgNjExNiAgIDU3NSAgICAgIDEgICAgICAgICAgIDU5
MiAgIDQ5MCAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2MjczPl0g
WzxjMDJiYWQxNz5dIFs8YzAxNDhiNmI+XSBbPGMwMTQ4ZmYxPl0gWzxjMDE4
PGVhZj5dDQpzY3NpX2VoXzEgICAgIFMgQzBGZUFFOEIgIDY4czQgICA1OTIg
ICBFICAxICAgICAgIDUgICA1OTMgICA1NSAgKEwtVExCKQ0KQzlhbGwgVHJh
Y2UgVCAgIFs8YzAyZmUNCjhiPl0gWzwwIDEwN2I3MT5dIDxdZjhiNmY2MDA+
IDFbPGMwMTA3YzFmPiAxWzxjMDI1NDkxNT5dDQogIFs8MDAxMDcyZmU+XSA8
DQpjMDI1NDkzMD4NCmZ1c2Itc3Rvcmc1ZS0wIFMgMDB1MDAwMDAgIDI2NTYg
UyA1OTMgICAgMCAxICAgICAgICAgICA1OTQgMCA1OTIgKEwtVExCKQ0KQ2Fs
bCBUcmFjZTogICAgWzxjMDEwN2I3MT5dIFs8YzAxMDdjMWY+XSBbPGMwMjhj
Zjk4Pl0gWzxjMDEwOGU2YT5dIFs8YzAyOGJkZjA+XQ0KICBbPGMwMTA3MmZl
Pl0gWzxjMDI4YmRmMD5dDQpzY3NpX2VoXzIgICAgIFMgQzAyRkFFOEIgIDYz
ODQgICA1OTQgICAgICAxICAgICAgICAgICA1NDYgICA1OTMgKEwtVExCKQ0K
Q2FsbCBUcmFjZTogICAgWzxjMDJmYWU4Yj5dIFs8YzAxMDdiNzE+XSBbPGMw
MTA3YzFmPl0gWzxjMDI1NGM5NT5dIFs8YzAxMDcyZmU+XQ0KICBbPGMwMjU0
OTMwPl0NCmxvZ2luICAgICAgICAgUyAwMDAwMDI0NiAgNDk4MCAgIDU5NyAg
ICAgIDEgICA2MDUgICAgIDU5OCAgIDU0NiAoTk9UTEIpDQpDYWxsIFRyYWNl
OiAgICBbPGMwMTFjNmVjPl0gWzxjMDEwOGVhZj5dDQptaW5nZXR0eSAgICAg
IFMgRTQ1OEEwMDAgIDUwMjAgICA1OTggICAgICAxICAgICAgICAgICA1OTkg
ICA1OTcgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDExNjI3Mz5dIFs8
YzAyMGE2N2I+XSBbPGMwMWZkYzI3Pl0gWzxjMDFmZDcxZT5dIFs8YzAxZjk4
NWM+XQ0KICBbPGMwMTM5ODIzPl0gWzxjMDEzOGRmYT5dIFs8YzAxMDhlYWY+
XQ0KbWluZ2V0dHkgICAgICBTIEU0NTg0MDAwICAyNjU2ICAgNTk5ICAgICAg
MSAgICAgICAgICAgNjAwICAgNTk4IChOT1RMQikNCkNhbGwgVHJhOk4gICAg
WzxjMDExNjI3Mz5dIFs8YzAyMGE2N2I+XSBbPGMwMWZkYzI3Pl0gWzxjMDFm
ZDcxZT5dIFs8YzAxZjk4NWM+XQ0KICBbPGMwMTM5ODIzPl0gWzxjMDEzOGRm
YT5dIFs8YzAxMDhlYWY+XQ0KbWluZ2V0dHkgICAgICBTIEU0NTg3MDAwICA1
MzQ0ICAgNjAwICAgICAgMSAgICAgICAgICAgNjAxICAgNTk5IChOT1RMQikN
CkNhbGwgVHJhY2U6ICAgIFs8YzAxMTYyNzM+XSBbPGMwMjBhNjdiPl0gWzxj
MDFmZGMyNz5dIFs8YzAxZmQ3MWU+XSBbPGMwMWY5ODVjPl0NCiAgWzxjMDEz
OTgyMz5dIFs8YzAxMzhkZmE+XSBbPGMwMTA4ZWFmPl0NCm1pbmdldHR5ICAg
ICAgUyBFNDU3RjAwMCAgNTM0NCAgIDYwMSAgICAgIDEgICAgICAgICAgIDYw
MiAgIDYwMCAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2MjczPl0g
WzxjMDIwYTY3Yj5dIFs8YzAxZmRjMjc+XSBbPGMwMWZkNzFlPl0gWzxjMDFm
OTg1Yz5dDQogIFs8YzAxMzk4MjM+XSBbPGMwMTM4ZGZhPl0gWzxjMDEwOGVh
Zj5dDQptaW5nZXR0eSAgICAgIFMgRjdCQkIwMDAgIDUzNDQgICA2MDIgICAg
ICAxICAgICAgICAgICAgICAgICA2MDEgKE5PVExCKQ0KQ2FsbCBUcmFjZTog
ICAgWzxjMDExNjI3Mz5dIFs8YzAyMGE2N2I+XSBbPGMwMWZkYzI3Pl0gWzxj
MDFmZDcxZT5dIFs8YzAxZjk4NWM+XQ0KICBbPGMwMTM5ODIzPl0gWzxjMDEz
OGRmYT5dIFs8YzAxMDhlYWY+XQ0KYmFzaCAgICAgICAgICBTIDAwMDAwMjQ2
ICA1MzQ0ICAgNjA1ICAgIDU5NyAgIDYzNCAgICAgICAgICAgICAgIChOT1RM
QikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMWM2ZWM+XSBbPGMwMTA4ZWFmPl0N
CnN0YXJ0eCAgICAgICAgUyAwMDAwMDI0NiAgMjY1NiAgIDYzNCAgICA2MDUg
ICA2NDIgICAgICAgICAgICAgICAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBb
PGMwMTFjNmVjPl0gWzxjMDEwOGVhZj5dDQp4aW5pdCAgICAgICAgIFMgMDAw
MDAwMDEgIDUwODAgICA2NDIgICAgNjM0ICAgNjQ4ICAgICAgICAgICAgICAg
KE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDExYzZlYz5dIFs8YzAxMDhl
YWY+XQ0KWCAgICAgICAgICAgICBTIEU0OERBNTYwICAgICAwICAgNjQzICAg
IDY0MiAgICAgICAgICAgNjQ4ICAgICAgIChOT1RMQikNCkNhbGwgVHJhY2U6
ICAgIFs8YzAyMmRmM2U+XSBbPGMwMjJkZGY4Pl0gWzxjMDIyZGQzMD5dIFs8
YzAxNDdkN2E+XSBbPGMwMTA4ZWFmPl0NCnh0ZXJtICAgICAgICAgUyAwMDAw
MDAwMCAgMjY1NiAgIDY0OCAgICA2NDIgICA2NTQgICAgICAgICAgIDY0MyAo
Tk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTMyYmIxPl0gWzxjMDExNjI3
Mz5dIFs8YzAxZmRkZTY+XSBbPGMwMWZhYTYzPl0gWzxjMDE0OGI2Yj5dDQog
IFs8YzAxNDhmZjE+XSBbPGMwMTA4ZWFmPl0NCnR3bSAgICAgICAgICAgUyAw
MDAwMDAwMCAgNTAzNiAgIDY0OSAgICA2NDggICAgICAgICAgIDY1MCAgICAg
ICAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTMyYmIxPl0gWzxjMDJh
MjI3OD5dIFs8YzAxMTYyNzM+XSBbPGMwMTQ4OTExPl0gWzxjMDJlMzM4ZT5d
DQogIFs8YzAxNDhiNmI+XSBbPGMwMTQ4ZmYxPl0gWzxjMDEwOGVhZj5dDQp4
Y2xvY2sgICAgICAgIFMgMDAwMDAwMDAgIDUxNjggICA2NTAgICAgNjQ4ICAg
ICAgICAgICA2NTEgICA2NDkgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxj
MDEzMmJiMT5dIFs8YzAxMTYyMjg+XSBbPGMwMTE2MTgwPl0gWzxjMDE0OGI2
Yj5dIFs8YzAxNDhmZjE+XQ0KICBbPGMwMTA4ZWFmPl0NCnh0ZXJtICAgICAg
ICAgUyAwMDAwMDAwMCAgNTM0NCAgIDY1MSAgICA2NDggICA2NTMgICAgIDY1
MiAgIDY1MCAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTMyYmIxPl0g
WzxjMDExNjI3Mz5dIFs8YzAxZmRkZTY+XSBbPGMwMWZhYTYzPl0gWzxjMDE0
OGI2Yj5dDQogIFs8YzAxNDhmZjE+XSBbPGMwMTA4ZWFmPl0NCnh0ZXJtICAg
ICAgICAgUyAwMDAwMDAwMCAgNTAzNiAgIDY1MiAgICA2NDggICA2NTUgICAg
IDY1NCAgIDY1MSAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTMyYmIx
Pl0gWzxjMDJhMjI3OD5dIFs8YzAxMTYyNzM+XSBbPGMwMWZkZGU2Pl0gWzxj
MDFmYWE2Mz5dDQogIFs8YzAxNDhiNmI+XSBbPGMwMTQ4ZmYxPl0gWzxjMDEw
OGVhZj5dDQpiYXNoICAgICAgICAgIFMgMDAwMDAyNDYgIDI2NjAgICA2NTMg
ICAgNjUxICAgNjkyICAgICAgICAgICAgICAgKE5PVExCKQ0KQ2FsbCBUcmFj
ZTogICAgWzxjMDExYzZlYz5dIFs8YzAxMDhlYWY+XQ0KYmFzaCAgICAgICAg
ICBTIEMwMTIyMDIzICA1MzQ0ICAgNjU0ICAgIDY0OCAgICAgICAgICAgICAg
ICAgNjUyIChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMjIwMjM+XSBb
PGMwMTE2MjczPl0gWzxjMDExNTVhYj5dIFs8YzAxZmQ3MWU+XSBbPGMwMWY5
ODVjPl0NCiAgWzxjMDEzOTgyMz5dIFs8YzAxMDhlYWY+XQ0KYmFzaCAgICAg
ICAgICBTIEMwMTIyMDIzICA1MzQ0ICAgNjU1ICAgIDY1MiAgICAgICAgICAg
ICAgICAgICAgIChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMjIwMjM+
XSBbPGMwMTE2MjczPl0gWzxjMDExNTVhYj5dIFs8YzAxZmQ3MWU+XSBbPGMw
MWY5ODVjPl0NCiAgWzxjMDEzOTgyMz5dIFs8YzAxMDhlYWY+XQ0KZ2x4Z2Vh
cnMgICAgICBSIDAwMDAwMDAwICA1MDgwICAgNjkyICAgIDY1MyAgICAgICAg
ICAgICAgICAgICAgIChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMDhm
NTU+XQ0KU3lzUnEgOiBIRUxQIDogbG9nbGV2ZWwwLTggcmVCb290IHRFcm0g
a0lsbCBzYUsgc2hvd01lbSBPZmYgc2hvd1BjIHVuUmF3IFN5bmMgc2hvd1Rh
c2tzIFVubW91bnQgDQpTeXNScSA6IEhFTFAgOiBsb2dsZXZlbDAtOCByZUJv
b3QgdEVybSBrSWxsIHNhSyBzaG93TWVtIE9mZiBzaG93UGMgdW5SYXcgU3lu
YyBzaG93VGFza3MgVW5tb3VudCANClN5c1JxIDogSEVMUCA6IGxvZ2xldmVs
MC04IHJlQm9vdCB0RXJtIGtJbGwgc2FLIHNob3dNZW0gT2ZmIHNob3dQYyB1
blJhdyBTeW5jIHNob3dUYXNrcyBVbm1vdW50IA0KU3lzUnEgOiBIRUxQIDog
bG9nbGV2ZWwwLTggcmVCb290IHRFcm0ga0lsbCBzYUsgc2hvd01lbSBPZmYg
c2hvd1BjIHVuUmF3IFN5bmMgc2hvd1Rhc2tzIFVubW91bnQgDQpTeXNScSA6
IEhFTFAgOiBsb2dsZXZlbDAtOCByZUJvb3QgdEVybSBrSWxsIHNhSyBzaG93
TWVtIE9mZiBzaG93UGMgdW5SYXcgU3luYyBzaG93VGFza3MgVW5tb3VudCAN
ClN5c1JxIDogSEVMUCA6IGxvZ2xldmVsMC04IHJlQm9vdCB0RXJtIGtJbGwg
c2FLIHNob3dNZW0gT2ZmIHNob3dQYyB1blJhdyBTeW5jIHNob3dUYXNrcyBV
bm1vdW50IA0KU3lzUnEgOiBQb3dlciBPZmYNCg0KU3lzUnEgOiBIRUxQIDog
bG9nbGV2ZWwwLTggcmVCb290IHRFcm0ga0lsbCBzYUsgc2hvd01lbSBPZmYg
c2hvd1BjIHVuUmF3IFN5bmMgc2hvd1Rhc2tzIFVubW91bnQgDQpTeXNScSA6
IFNob3cgTWVtb3J5DQpNZW0taW5mbzoNCkZyZWUgcGFnZXM6ICAgICAgNjg0
Njgwa0IgKCA4MzE5MmtCIEhpZ2hNZW0pDQpab25lOkRNQSBmcmVlcGFnZXM6
IDEzMDEya0IgbWluOiAgIDEyOGtCIGxvdzogICAyNTZrQiBoaWdoOiAgIDM4
NGtCDQpab25lOk5vcm1hbCBmcmVlcGFnZXM6NTg4NDc2a0IgbWluOiAgMTAy
MGtCIGxvdzogIDIwNDBrQiBoaWdoOiAgMzA2MGtCDQpab25lOkhpZ2hNZW0g
ZnJlZXBhZ2VzOiA4MzE5MmtCIG1pbjogIDEwMjBrQiBsb3c6ICAyMDQwa0Ig
aGlnaDogIDMwNjBrQg0KKCBBY3RpdmU6IDQ2OTIsIGluYWN0aXZlOiA3NDgz
NiwgZnJlZTogMTcxMTcwICkNCjEqNGtCIDAqOGtCIDEqMTZrQiAyKjMya0Ig
NCo2NGtCIDMqMTI4a0IgMioyNTZrQiAxKjUxMmtCIDEqMTAyNGtCIDUqMjA0
OGtCID0gMTMwMTJrQikNCjEqNGtCIDMqOGtCIDAqMTZrQiAxKjMya0IgMCo2
NGtCIDEqMTI4a0IgMioyNTZrQiAyKjUxMmtCIDEqMTAyNGtCIDI4NioyMDQ4
a0IgPSA1ODg0NzZrQikNCjAqNGtCIDEqOGtCIDEqMTZrQiAxKjMya0IgMSo2
NGtCIDEqMTI4a0IgMCoyNTZrQiAwKjUxMmtCIDEqMTAyNGtCIDQwKjIwNDhr
QiA9IDgzMTkya0IpDQpTd2FwIGNhY2hlOiBhZGQgMCwgZGVsZXRlIDAsIGZp
bmQgMC8wLCByYWNlIDArMA0KRnJlZSBzd2FwOiAgICAgICAyNDg5MjhrQg0K
MjYyMTI4IHBhZ2VzIG9mIFJBTQ0KMzI3NTIgcGFnZXMgb2YgSElHSE1FTQ0K
MzkxMSByZXNlcnZlZCBwYWdlcw0KODcxMzcgcGFnZXMgc2hhcmVkDQowIHBh
Z2VzIHN3YXAgY2FjaGVkDQoxIHBhZ2VzIGluIHBhZ2UgdGFibGUgY2FjaGUN
CkJ1ZmZlciBtZW1vcnk6ICAgICAxNzkya0INCkNhY2hlIG1lbW9yeTogICAy
OTY3ODhrQg0KU3lzUnEgOiBTaG93IFJlZ3MNCg0KUGlkOiA2ODMsIGNvbW06
ICAgICAgICAgICAgIGdseGdlYXJzDQpFSVA6IDAwMjM6Wzw0MDNiN2UwZD5d
IENQVTogMCBFU1A6IDAwMmI6YmZmZmY3YzAgRUZMQUdTOiAwMDIwMDIwNyAg
ICBOb3QgdGFpbnRlZA0KRUFYOiAwMDAwMDAwMCBFQlg6IDAwMDAwMDJiIEVD
WDogNDAwODY0NDEgRURYOiBiZmZmZjc5MA0KRVNJOiAwMDAwMDAwMCBFREk6
IDA4MDc3MTIwIEVCUDogYmZmZmY3ZjggRFM6IDAwMmIgRVM6IDAwMmINCkNS
MDogODAwNTAwM2IgQ1IyOiAwODA3ODA0OCBDUjM6IDI1YjQwMDAwIENSNDog
MDAwMDAyZDANCkNhbGwgVHJhY2U6ICAgDQpTeXNScSA6IFNob3cgU3RhdGUN
Cg0KICAgICAgICAgICAgICAgICAgICAgICAgIGZyZWUgICAgICAgICAgICAg
ICAgICAgICAgICBzaWJsaW5nDQogIHRhc2sgICAgICAgICAgICAgUEMgICAg
c3RhY2sgICBwaWQgZmF0aGVyIGNoaWxkIHlvdW5nZXIgb2xkZXINCmluaXQg
ICAgICAgICAgUyBDMDM2NzZGNCAgNDY0NCAgICAgMSAgICAgIDAgICA2MDAg
ICAgICAgICAgICAgICAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2
MjI4Pl0gWzxjMDEzMmQwYz5dIFs8YzAxMTYxODA+XSBbPGMwMTQyZTM3Pl0g
WzxjMDE0OGI2Yj5dDQogIFs8YzAxNDhmZjE+XSBbPGMwMTQwYzk5Pl0gWzxj
MDEwOGVhZj5dDQprZXZlbnRkICAgICAgIFIgMDAwMDAwMDEgIDYxNjggICAg
IDIgICAgICAxICAgICAgICAgICAgIDMgICAgICAgKEwtVExCKQ0KQ2FsbCBU
cmFjZTogICAgWzxjMDEyNjI2ND5dIFs8YzAxMjYxNjA+XSBbPGMwMTA1MDAw
Pl0gWzxjMDEwNzJmZT5dIFs8YzAxMjYxNjA+XQ0Ka2FwbWQgICAgICAgICBT
IEY3RUY3RkI0ICA2MDE2ICAgICAzICAgICAgMSAgICAgICAgICAgICA0ICAg
ICAyIChMLVRMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMTYyMjg+XSBbPGMw
MTE2MTgwPl0gWzxjMDExNDE1YT5dIFs8YzAxMTQzZmI+XSBbPGMwMTE0Yjkx
Pl0NCiAgWzxjMDEwNTAwMD5dIFs8YzAxMDcyZmU+XSBbPGMwMTE0YWEwPl0N
Cmtzb2Z0aXJxZF9DUFUgUyBDMDNENkRDMCAgNjQwNCAgICAgNCAgICAgIDEg
ICAgICAgICAgICAgNSAgICAgMyAoTC1UTEIpDQpDYWxsIFRyYWNlOiAgICBb
PGMwMTFkZGE2Pl0gWzxjMDExZTA0ZT5dIFs8YzAxMDUwMDA+XSBbPGMwMTA3
MmZlPl0gWzxjMDExZGZkMD5dDQprc3dhcGQgICAgICAgIFMgMDAwMDAwMDAg
IDY2MzYgICAgIDUgICAgICAxICAgICAgICAgICAgIDYgICAgIDQgKEwtVExC
KQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEzMWU3Nj5dIFs8YzAxMzFkZjA+XSBb
PGMwMTA1MDAwPl0gWzxjMDEwNzJmZT5dIFs8YzAxMzFkZjA+XQ0KYmRmbHVz
aCAgICAgICBTIDAwMDAwMDAwICA2NjI0ICAgICA2ICAgICAgMSAgICAgICAg
ICAgICA3ICAgICA1IChMLVRMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMTY4
ODg+XSBbPGMwMTNkZjkyPl0gWzxjMDEwNTAwMD5dIFs8YzAxMDcyZmU+XSBb
PGMwMTNkZWUwPl0NCmt1cGRhdGVkICAgICAgUyAwMDAwMDAwOCAgNTk3NiAg
ICAgNyAgICAgIDEgICAgICAgICAgICAgOCAgICAgNiAoTC1UTEIpDQpDYWxs
IFRyYWNlOiAgICBbPGMwMTE2MjI4Pl0gWzxjMDIzYTYwYT5dIFs8YzAxMTYx
ODA+XSBbPGMwMTFkZmJkPl0gWzxjMDEzZTAyOT5dDQogIFs8YzAxMDUwMDA+
XSBbPGMwMTA1MDAwPl0gWzxjMDEwNzJmZT5dIFs8YzAxM2RmYTA+XQ0Ka2h1
YmQgICAgICAgICBTIEU2NjFCMDAwICA1MjcyICAgICA4ICAgICAgMSAgICAg
ICAgICAgICA5ICAgICA3IChMLVRMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAy
N2VkNmU+XSBbPGMwMTA4ZjU1Pl0gWzxjMDEwNTAwMD5dIFs8YzAxMDcyZmU+
XSBbPGMwMjdlY2UwPl0NCm1kcmVjb3ZlcnlkICAgUyBDMUMxN0Y0NCAgNjU1
MiAgICAgOSAgICAgIDEgICAgICAgICAgIDMyMSAgICAgOCAoTC1UTEIpDQpD
YWxsIFRyYWNlOiAgICBbPGMwMmZiMTI3Pl0gWzxjMDI5ZDViND5dIFs8YzAx
MDcyZmU+XSBbPGMwMjlkNDcwPl0NCnN5c2xvZ2QgICA0ICBTIDAwMDAwMDAw
ICAxNjMyICAgMzIxICAgICAgMSAgICAgICAgICAgMzI5ICAgICA5IChOT1RM
QikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMzJiYjE+XSBbPGMwMTE2MjczPl0g
WzxjMDE0ODkxMT5dIFs8YzAyYTUyYmU+XSBbPGMwMTQ4YjZiPl0NCiAgWzxj
MDE0OGZmMT5dIFs8YzAxMDgwZjg+XSBbPGMwMTA4ZWFmPl0NCmtsb2dkICAg
ICAgICAgUiBDMUMwRDNEOCAgMTYzMiAgIDMyOSAgICAgIDEgICAgICAgICAg
IDM0MiAgIDMyMSAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE5MGE3
Pl0gWzxjMDEzOTgyMz5dIFs8YzAxMDhlYWY+XQ0KY3JvbmQgICAgICAgICBT
IEMwMTQwOTkwICA2MDgwICAgMzQyICAgICAgMSAgICAgICAgICAgMzU1ICAg
MzI5IChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxNDA5OTA+XSBbPGMw
MTE2MjI4Pl0gWzxjMDExNjE4MD5dIFs8YzAxMjE3ODA+XSBbPGMwMTA4ZWFm
Pl0NCmF0ZCAgICAgICAgICAgUyBDMDE0MDk5MCAgNjEwOCAgIDM1NSAgICAg
IDEgICAgICAgICAgIDM2OCAgIDM0MiAoTk9UTEIpDQpDYWxsIFRyYWNlOiAg
ICBbPGMwMTQwOTkwPl0gWzxjMDExNjIyOD5dIFs8YzAxMTYxODA+XSBbPGMw
MTIxNzgwPl0gWzxjMDEwOGVhZj5dDQppbmV0ZCAgICAgICAgIFMgQzAzNjc1
OTAgIDI2NjAgICAzNjggICAgICAxICAgICAgICAgICAzODEgICAzNTUgKE5P
VExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDExNjI3Mz5dIFs8YzAyYmFkMTc+
XSBbPGMwMTQ4YjZiPl0gWzxjMDE0OGZmMT5dIFs8YzAxMDhlYWY+XQ0KcG9y
dG1hcCAgICAgICBTIDAwMDAwMDAwICA1OTY0ICAgMzgxICAgICAgMSAgICAg
ICAgICAgMzk0ICAgMzY4IChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAx
MzJiYjE+XSBbPGMwMTE2MjczPl0gWzxjMDJiYWQxNz5dIFs8YzAxNDhiNmI+
XSBbPGMwMTQ4ZmYxPl0NCiAgWzxjMDEwOGVhZj5dDQpscGQgICAgICAgICAg
IFMgMDAwMDAwMDAgIDYwMDggICAzOTQgICAgICAxICAgICAgICAgICA0NzMg
ICAzODEgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEzMmJiMT5dIFs8
YzAxMTYyNzM+XSBbPGMwMmJhZDE3Pl0gWzxjMDE0OGI2Yj5dIFs8YzAxNDhm
ZjE+XQ0KICBbPGMwMTA4ZWFmPl0NCm1hc3RlciAgICAgICAgUyBDMDM2NzU5
MCAgNTA4MCAgIDQ3MyAgICAgIDEgICA0ODEgICAgIDQ4OCAgIDM5NCAoTk9U
TEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2MjI4Pl0gWzxjMDExNjE4MD5d
IFs8YzAxNDhiNmI+XSBbPGMwMTQ4ZmYxPl0gWzxjMDEwOGVhZj5dDQpwaWNr
dXAgICAgICAgIFMgMDAwMDAwMDAgIDI2NjAgICA0ODAgICAgNDczICAgICAg
ICAgICA0ODEgICAgICAgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEz
MmJiMT5dIFs8YzAyYTIyNzg+XSBbPGMwMTE2MjI4Pl0gWzxjMDExNjE4MD5d
IFs8YzAxNDJlMzc+XQ0KICBbPGMwMTQ4YjZiPl0gWzxjMDE0OGZmMT5dIFs8
YzAxMDhlYWY+XQ0KcW1nciAgICAgICAgICBTIDAwMDAwMDAwICA1MDM2ICAg
NDgxICAgIDQ3MyAgICAgICAgICAgICAgICAgNDgwIChOT1RMQikNCkNhbGwg
VHJhY2U6ICAgIFs8YzAxMzJiYjE+XSBbPGMwMTJkOWU4Pl0gWzxjMDExNjIy
OD5dIFs8YzAxMTYxODA+XSBbPGMwMTQyZTM3Pl0NCiAgWzxjMDE0OGI2Yj5d
IFs8YzAxNDhmZjE+XSBbPGMwMTNhNzY2Pl0gWzxjMDEwOGVhZj5dDQpncG0g
ICAgICAgICAgIFMgRTVEMEIxQTQgIDYwMDAgICA0ODggICAgICAxICAgICAg
ICAgICA1NzMgICA0NzMgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEz
YTM2ZT5dIFs8YzAxMTYyMjg+XSBbPGMwMTE2MTgwPl0gWzxjMDEyMTc4MD5d
IFs8YzAxMDhlYWY+XQ0KZG5ldGMgICAgICAgICBSIDAwMDAwMDAwICAxNjMy
ICAgNTQ0ICAgICAgMSAgICAgICAgICAgNTk1ICAgNTkyIChOT1RMQikNCkNh
bGwgVHJhY2U6ICAgIFs8YzAxMDhmNTU+XQ0Kc3NoZCAgICAgICAgICBTIEMw
MzY3NTkwICA2MTE2ICAgNTczICAgICAgMSAgICAgICAgICAgNTkwICAgNDg4
IChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAxMTYyNzM+XSBbPGMwMmJh
ZDE3Pl0gWzxjMDE0OGI2Yj5dIFs8YzAxNDhmZjE+XSBbPGMwMTA4ZWFmPl0N
CnNjc2lfZWhfMSAgICAgUyBDMDJGQUU4QiAgNjM4NCAgIDU5MCAgICAgIDEg
ICAgICAgICAgIDU5MSAgIDU3MyAoTC1UTEIpDQpDYWxsIFRyYWNlOiAgICBb
PGMwMmZhZThiPl0gWzxjMDEwN2I3MT5dIFs8ZjhiNmY2MDA+XSBbPGMwMTA3
YzFmPl0gWzxjMDI1NGM5NT5dDQogIFs8YzAxMDcyZmU+XSBbPGMwMjU0OTMw
Pl0NCnVzYi1zdG9yYWdlLTAgUyAwMDAwMDAwMCAgNjA4NCAgIDU5MSAgICAg
IDEgICAgICAgICAgIDU5MiAgIDU5MCAoTC1UTEIpDQpDYWxsIFRyYWNlOiAg
ICBbPGMwMTA3YjcxPl0gWzxjMDEwN2MxZj5dIFs8YzAyOGNmOTg+XSBbPGMw
MTA4ZTZhPl0gWzxjMDI4YmRmMD5dDQogIFs8YzAxMDcyZmU+XSBbPGMwMjhi
ZGYwPl0NCnNjc2lfZWhfMiAgICAgUyBDMDJGQUU4QiAgNjM4NCAgIDU5MiAg
ICAgIDEgICAgICAgICAgIDU0NCAgIDU5MSAoTC1UTEIpDQpDYWxsIFRyYWNl
OiAgICBbPGMwMmZhZThiPl0gWzxjMDEwN2I3MT5dIFs8YzAxMDdjMWY+XSBb
PGMwMjU0Yzk1Pl0gWzxjMDEwNzJmZT5dDQogIFs8YzAyNTQ5MzA+XQ0KbG9n
aW4gICAgICAgICBTIDAwMDAwMjQ2ICA0ODg0ICAgNTk1ICAgICAgMSAgIDYw
MyAgICAgNTk2ICAgNTQ0IChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAx
MWM2ZWM+XSBbPGMwMTA4ZWFmPl0NCm1pbmdldHR5ICAgICAgUyBFNjVBNzAw
MCAgNDg3MiAgIDU5NiAgICAgIDEgICAgICAgICAgIDU5NyAgIDU5NSAoTk9U
TEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2MjczPl0gWzxjMDIwYTY3Yj5d
IFs8YzAxZmRjMjc+XSBbPGMwMWZkNzFlPl0gWzxjMDFmOTg1Yz5dDQogIFs8
YzAxMzk4MjM+XSBbPGMwMTM4ZGZhPl0gWzxjMDEwOGVhZj5dDQptaW5nZXR0
eSAgICAgIFMgRTY1QTEwMDAgIDUzNDQgICA1OTcgICAgICAxICAgICAgICAg
ICA1OTggICA1OTYgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDExNjI3
Mz5dIFs8YzAyMGE2N2I+XSBbPGMwMWZkYzI3Pl0gWzxjMDFmZDcxZT5dIFs8
YzAxZjk4NWM+XQ0KICBbPGMwMTM5ODIzPl0gWzxjMDEzOGRmYT5dIFs8YzAx
MDhlYWY+XQ0KbWluZ2V0dHkgICAgICBTIEU2NUE0MDAwICA1MzQ0ICAgNTk4
ICAgICAgMSAgICAgICAgICAgNTk5ICAgNTk3IChOT1RMQikNCkNhbGwgVHJh
Y2U6ICAgIFs8YzAxMTYyNzM+XSBbPGMwMjBhNjdiPl0gWzxjMDFmZGMyNz5d
IFs8YzAxZmQ3MWU+XSBbPGMwMWY5ODVjPl0NCiAgWzxjMDEzOTgyMz5dIFs8
YzAxMzhkZmE+XSBbPGMwMTA4ZWFmPl0NCm1pbmdldHR5ICAgICAgUyBFNjU5
QzAwMCAgNTM0NCAgIDU5OSAgICAgIDEgICAgICAgICAgIDYwMCAgIDU5OCAo
Tk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2MjczPl0gWzxjMDIwYTY3
Yj5dIFs8YzAxZmRjMjc+XSBbPGMwMWZkNzFlPl0gWzxjMDFmOTg1Yz5dDQog
IFs8YzAxMzk4MjM+XSBbPGMwMTM4ZGZhPl0gWzxjMDEwOGVhZj5dDQptaW5n
ZXR0eSAgICAgIFMgRTY1OUUwMDAgIDUzNDQgICA2MDAgICAgICAxICAgICAg
ICAgICAgICAgICA1OTkgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEx
NjI3Mz5dIFs8YzAyMGE2N2I+XSBbPGMwMWZkYzI3Pl0gWzxjMDFmZDcxZT5d
IFs8YzAxZjk4NWM+XQ0KICBbPGMwMTM5ODIzPl0gWzxjMDEzOGRmYT5dIFs8
YzAxMDhlYWY+XQ0KYmFzaCAgICAgICAgICBTIDAwMDAwMjQ2ICA1MzQ0ICAg
NjAzICAgIDU5NSAgIDYyNSAgICAgICAgICAgICAgIChOT1RMQikNCkNhbGwg
VHJhY2U6ICAgIFs8YzAxMWM2ZWM+XSBbPGMwMTA4ZWFmPl0NCnN0YXJ0eCAg
ICAgICAgUyAwMDAwMDI0NiAgNTA4MCAgIDYyNSAgICA2MDMgICA2MzMgICAg
ICAgICAgICAgICAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTFjNmVj
Pl0gWzxjMDEwOGVhZj5dDQp4aW5pdCAgICAgICAgIFMgMDAwMDAwMDEgIDI2
NTYgICA2MzMgICAgNjI1ICAgNjM5ICAgICAgICAgICAgICAgKE5PVExCKQ0K
Q2FsbCBUcmFjZTogICAgWzxjMDExYzZlYz5dIFs8YzAxMDhlYWY+XQ0KWCAg
ICAgICAgICAgICBTIEU2OEI2NTYwICAgICAwICAgNjM0ICAgIDYzMyAgICAg
ICAgICAgNjM5ICAgICAgIChOT1RMQikNCkNhbGwgVHJhY2U6ICAgIFs8YzAy
MmRmM2U+XSBbPGMwMjJkZGY4Pl0gWzxjMDIyZGQzMD5dIFs8YzAxNDdkN2E+
XSBbPGMwMTA4ZWFmPl0NCnh0ZXJtICAgICAgICAgUyAwMDAwMDAwMCAgMTYz
MiAgIDYzOSAgICA2MzMgICA2NDUgICAgICAgICAgIDYzNCAoTk9UTEIpDQpD
YWxsIFRyYWNlOiAgICBbPGMwMTMyYmIxPl0gWzxjMDJhMjI3OD5dIFs8YzAx
MTYyNzM+XSBbPGMwMWZkZGU2Pl0gWzxjMDFmYWE2Mz5dDQogIFs8YzAxNDhi
NmI+XSBbPGMwMTQ4ZmYxPl0gWzxjMDEwOGVhZj5dDQp0d20gICAgICAgICAg
IFMgMDAwMDAwMDAgIDUwMzYgICA2NDAgICAgNjM5ICAgICAgICAgICA2NDEg
ICAgICAgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDEzMmJiMT5dIFs8
YzAyYTIyNzg+XSBbPGMwMTE2MjczPl0gWzxjMDE0ODkxMT5dIFs8YzAyZTMz
OGU+XQ0KICBbPGMwMTQ4YjZiPl0gWzxjMDE0OGZmMT5dIFs8YzAxMDhlYWY+
XQ0KeGNsb2NrICAgICAgICBTIDAwMDAwMDAwICA1MTY4ICAgNjQxICAgIDYz
OSAgICAgICAgICAgNjQyICAgNjQwIChOT1RMQikNCkNhbGwgVHJhY2U6ICAg
IFs8YzAxMzJiYjE+XSBbPGMwMmEyMjc4Pl0gWzxjMDExNjIyOD5dIFs8YzAx
MTYxODA+XSBbPGMwMTQ4YjZiPl0NCiAgWzxjMDE0OGZmMT5dIFs8YzAxMDhl
YWY+XQ0KeHRlcm0gICAgICAgICBTIDAwMDAwMDAwICA1MDM2ICAgNjQyICAg
IDYzOSAgIDY0NiAgICAgNjQzICAgNjQxIChOT1RMQikNCkNhbGwgVHJhY2U6
ICAgIFs8YzAxMzJiYjE+XSBbPGMwMmEyMjc4Pl0gWzxjMDExNjI3Mz5dIFs8
YzAxZmRkZTY+XSBbPGMwMWZhYTYzPl0NCiAgWzxjMDE0OGI2Yj5dIFs8YzAx
NDhmZjE+XSBbPGMwMTA4ZWFmPl0NCnh0ZXJtICAgICAgICAgUyAwMDAwMDAw
MCAgNTM0NCAgIDY0MyAgICA2MzkgICA2NDQgICAgIDY0NSAgIDY0MiAoTk9U
TEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTMyYmIxPl0gWzxjMDJhMjI3OD5d
IFs8YzAxMTYyNzM+XSBbPGMwMWZkZGU2Pl0gWzxjMDFmYWE2Mz5dDQogIFs8
YzAxNDhiNmI+XSBbPGMwMTQ4ZmYxPl0gWzxjMDEwOGVhZj5dDQpiYXNoICAg
ICAgICAgIFMgNUQ2NDJFMzMgIDUzNDQgICA2NDQgICAgNjQzICAgICAgICAg
ICAgICAgICAgICAgKE5PVExCKQ0KQ2FsbCBUcmFjZTogICAgWzxjMDExNjI3
Mz5dIFs8YzAxMTU1YWI+XSBbPGMwMWZkNzFlPl0gWzxjMDFmOTg1Yz5dIFs8
YzAxMzk4MjM+XQ0KICBbPGMwMTA4ZWFmPl0NCmJhc2ggICAgICAgICAgUyA1
RDY0MkUzMyAgNTM0NCAgIDY0NSAgICA2MzkgICAgICAgICAgICAgICAgIDY0
MyAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMwMTE2MjczPl0gWzxjMDEx
NTVhYj5dIFs8YzAxZmQ3MWU+XSBbPGMwMWY5ODVjPl0gWzxjMDEzOTgyMz5d
DQogIFs8YzAxMDhlYWY+XQ0KYmFzaCAgICAgICAgICBTIDAwMDAwMjQ2ICA1
MzQ0ICAgNjQ2ICAgIDY0MiAgIDY4MyAgICAgICAgICAgICAgIChOT1RMQikN
CkNhbGwgVHJhY2U6ICAgIFs8YzAxMWM2ZWM+XSBbPGMwMTA4ZWFmPl0NCmds
eGdlYXJzICAgICAgUiBjdXJyZW50ICAgNTA4MCAgIDY4MyAgICA2NDYgICAg
ICAgICAgICAgICAgICAgICAoTk9UTEIpDQpDYWxsIFRyYWNlOiAgICBbPGMw
MTBhNTU1Pl0gWzxjMDEwY2IxOD5dDQpTeXNScSA6IEhFTFAgOiBsb2dsZXZl
bDAtOCByZUJvb3QgdEVybSBrSWxsIHNhSyBzaG93TWVtIE9mZiBzaG93UGMg
dW5SYXcgU3luYyBzaG93VGFza3MgVW5tb3VudCANClN5c1JxIDogVGVybWlu
YXRlIEFsbCBUYXNrcw0KU3lzUnEgOiBLaWxsIEFsbCBUYXNrcw0KU3lzUnEg
OiBFbWVyZ2VuY3kgU3luYw0KU3luY2luZyBkZXZpY2UgMDM6MDcgLi4uIE9L
DQpTeW5jaW5nIGRldmljZSAwMzowMSAuLi4gT0sNCkRvbmUuDQpTeXNScSA6
IEVtZXJnZW5jeSBSZW1vdW50IFIvTw0KUmVtb3VudGluZyBkZXZpY2UgMDM6
MDcgLi4uIE9LDQpSZW1vdW50aW5nIGRldmljZSAwMzowMSAuLi4gT0sNCkRv
bmUuDQpTeXNScSA6IEVtZXJnZW5jeSBTeW5jDQpTeW5jaW5nIGRldmljZSAw
MzowNyAuLi4gT0sNClN5bmNpbmcgZGV2aWNlIDAzOjAxIC4uLiBPSw0KRG9u
ZS4NClN5c1JxIDogUmVzZXR0aW5nDQpwbGlwMDogdHJhbnNtaXQgdGltZW91
dCgxLDg4KQ0K
--685253369-1572576946-1029947609=:6953--
