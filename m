Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUHWQxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUHWQxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUHWQxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:53:04 -0400
Received: from smtp.wp.pl ([212.77.101.160]:25267 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S265144AbUHWQwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:52:02 -0400
Date: Mon, 23 Aug 2004 18:51:59 +0200
From: "Matthew Qvapul" <pikpus@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: strange softdog message on 2.4.20 kernel...
Message-ID: <412a20af1d388@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
Organization: Poczta Wirtualnej Polski S.A. http://www.wp.pl/
X-IP: 157.25.157.162
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-AS1: NOSPAM                                               
X-WP-AS3: NOSPAM 
X-WP-SPAM: NO 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo
I have a strange problem with wdt/softdog mechanism on my mashine
`uname -a`:
Linux pikpok2 2.4.20-28.7 #1 Thu Dec 18 11:23:36 EST 2003 i686
unknown

while performing the following operations I get the message which
is at the end of commands sequence:
1) /bin/mknod /dev/watchdog c 10 130
2) /sbin/modprobe softdog soft_margin=900
3) grep "adg" > /dev/watchdog

SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!

what is strange I did exactly the same thing on my friend's
mashine, `uname -a`:
Linux klif 2.4.18-18.7.x.a1smp #1 SMP Mon Nov 25 17:39:43 CET
2002 i686 unknown

and there was no message.


what is more, while performing this on my mashine (2.4.20..) , it
reset after some time ( maybe it was 900 secs ). I think this
this was the reason.
I tried it a few times ( together with opening /dev/watchdog file
with emacs ) and I also caused kernel panic :(

some more info about my mashine. Mayebe it'll be helphul:


[4.] Kernel version (from /proc/version):
Linux version 2.4.20-28.7 (bhcompile@bugs.devel.redhat.com) (gcc
version 2.96 20
000731 (Red Hat Linux 7.3 2.96-126)) #1 Thu Dec 18 11:23:36 EST 2003




[7.] Environment
BASH=/bin/bash
BASH_ENV=/root/.bashrc
BASH_VERSINFO=([0]="2" [1]="05a" [2]="0" [3]="1" [4]="release"
[5]="i686-pc-linux-gnu")
BASH_VERSION='2.05a.0(1)-release'
COLORS=/etc/DIR_COLORS
COLORTERM=
COLUMNS=80
DIRSTACK=()
DISPLAY=:0.0
EUID=0
GROUPS=()
GS_LIB=/root/.kde/share/fonts
GTK_RC_FILES=/etc/gtk/gtkrc:/root/.gtkrc:/root/.gtkrc-kde
HISTFILE=/root/.bash_history
HISTFILESIZE=1000
HISTSIZE=1000
HOME=/root
HOSTNAME=pikpok2
HOSTTYPE=i686
IFS=$' \t\n'
INPUTRC=/etc/inputrc
KDE_MULTIHEAD=false
KONSOLE_DCOP='DCOPRef(konsole-1414,konsole)'
KONSOLE_DCOP_SESSION='DCOPRef(konsole-1414,session-1)'
LANG=en_US.iso885915
LESSOPEN='|/usr/bin/lesspipe.sh %s'
LINES=40
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
MACHTYPE=i686-pc-linux-gnu
MAIL=/var/spool/mail/root
MAILCHECK=60
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/root/bin
PIPESTATUS=([0]="0")
PPID=1414
PROMPT_COMMAND='echo -ne
"\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
PS1='[\u@\h \W]\$ '
PS2='> '
PS4='+ '
PWD=/root
QTDIR=/usr/lib/qt3-gcc2.96
SESSION_MANAGER=local/pikpok2:/tmp/.ICE-unix/1362
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:histexpand:monitor:history:interactive-comments:emacs
SHLVL=3
SUPPORTED=en_US.iso885915:en_US:en
TERM=xterm
UID=0
USER=root
USERNAME=root
XDM_MANAGED=/var/run/xdmctl/xdmctl-:0,maysd,mayfn,sched
XMODIFIERS=@im=none
_=
i=/etc/profile.d/which-2.sh
langfile=/root/.i18n

[7.1.] redhat version
Red Hat Linux release 7.3 (Valhalla)

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 501.140
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 999.42


[7.3.] Module information (from /proc/modules):
nls_iso8859-1           3456   1 (autoclean)
nls_cp437               5088   1 (autoclean)
vfat                   11484   1 (autoclean)
fat                    35992   0 (autoclean) [vfat]
es1371                 29856   1 (autoclean)
gameport                3312   0 (autoclean) [es1371]
ac97_codec             13184   0 (autoclean) [es1371]
soundcore               6212   4 (autoclean) [es1371]
agpgart                43520   0 (unused)
autofs                 11588   0 (autoclean) (unused)
3c59x                  27464   1
ide-cd                 31616   0 (autoclean)
cdrom                  33152   0 (autoclean) [ide-cd]
usb-uhci               23620   0 (unused)
usbcore                71680   1 [usb-uhci]
ext3                   63328   2
jbd                    45740   2 [ext3]


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
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Rage 128 RF/SG AGP
a000-a07f : 3Com Corporation 3cSOHO100-TX Hurricane
  a000-a07f : 02:04.0
a400-a43f : Ensoniq 5880 AudioPCI
  a400-a43f : es1371
b000-b01f : Intel Corp. 82801AA USB
  b000-b01f : usb-uhci
f000-f00f : Intel Corp. 82801AA IDE
  f000-f007 : ide0
  f008-f00f : ide1


iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-00226219 : Kernel code
  0022621a-0031f71f : Kernel data
d0000000-d3ffffff : Intel Corp. 82815 815 Chipset Host Bridge and
Memory Controller Hub
d4000000-d7ffffff : PCI Bus #01
  d4000000-d7ffffff : ATI Technologies Inc Rage 128 RF/SG AGP
d8000000-d9ffffff : PCI Bus #01
  d9000000-d9003fff : ATI Technologies Inc Rage 128 RF/SG AGP
db000000-db00007f : 3Com Corporation 3cSOHO100-TX Hurricane
ffb00000-ffffffff : reserved



[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge
and Memory Controller Hub (rev 02)
	Subsystem: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev
02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d4000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: da000000-dbffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if
80 [Master])
	Subsystem: Intel Corp. 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if
00 [UHCI])
	Subsystem: Intel Corp. 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at b000 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128
RF/SG AGP (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Magnum/Xpert128/X99/Xpert2000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX
Hurricane (rev 30)
	Subsystem: 3Com Corporation 3cSOHO100-TX Hurricane
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=128]
	Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 04)
	Subsystem: Ensoniq: Unknown device 8001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a400 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

the system is freshly installed and that problem also occured on
my previous RH9.0 with the newest kernel updated.

greetings
pikpus

----------------------------------------------------
Chcesz na bie¿±co otrzymywaæ informacje z Olimpiady?
Zanim zd±¿y je podaæ radio, telewizja lub prasa?!
-->> Zaprenumeruj za darmo przez wpkontakt! ---> Kliknij:
http://klik.wp.pl/?adr=http%3A%2F%2Fwpkontakt.wp.pl%2Fkanaly.html%23ksport&sid=229


