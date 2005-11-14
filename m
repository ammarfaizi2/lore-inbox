Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVKNA3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVKNA3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 19:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKNA3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 19:29:23 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:4240 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1750801AbVKNA3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 19:29:22 -0500
X-ORBL: [70.132.63.184]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:reply-to:subject:to:message-id:
	mime-version:content-type:content-disposition;
	b=hBw0fAukycc3vYC+Q5wHwbrHUyHc9ZnbmxZf8na4RtbM/a+adFXyGu6+U68v0e7D3
	K79OrqO2qljEE+0yUFbyQ==
Date: Sun, 13 Nov 2005 16:29:17 -0800 (PST)
From: "Wayne E. Harlan" <drharlan@pacbell.net>
Reply-To: "Wayne E. Harlan" <drharlan@pacbell.net>
Subject: 2.6.14.x kernel bug
To: linux-kernel@vger.kernel.org
Message-ID: <tkrat.9182ac9c6a13ef52@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found what appears to be a bug in versions 2.6.14 and following.
Currently I have verified it in 2.6.14 as well as 2.6.14.2.  Here are the
items requested on the web site
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html.
-------------------------

[1.] One line summary of the problem:
When the kernel option "vga=1" is used, additional tty's (alt+control+Fx
with x=2,3,4,5, etc) do not provide the full 50 lines of output.  The first
one does have 50 lines, however.

[2.] Full description of the problem/report:
These addtitional tty's show only 39 lines plus the top pixel of the 40-th
line.  The remaining lines are black and not shown.  Kernel version
2.6.13.4 does not show this problem.

[3.] Keywords (i.e., modules, networking, kernel):
Text mode only.

[4.] Kernel version (from /proc/version): 
Linux version 2.6.14.2 (wayne@home) (gcc version 3.4.4) #1 Sat Nov 12
23:08:21 PST 2005

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
No Oops occurred.

[6.] A small shell script or example program which triggers the
     problem (if possible)
No trigger necessary. This happens upon system boot.

[7.] Environment: This is taken in tty mode, not from an xterm.
BASH=/bin/bash
BASH_ARGC=()
BASH_ARGV=()
BASH_LINENO=()
BASH_SOURCE=()
BASH_VERSINFO=([0]="3" [1]="00" [2]="16" [3]="8" [4]="release" [5]="i686-pc-linux-gnu")
BASH_VERSION='3.00.16(8)-release'
COLUMNS=80
CVSROOT=/mnt/install
DIRSTACK=()
EUID=500
GROUPS=()
HISTFILE=/home/wayne/.bash_history
HISTFILESIZE=4096
HISTSIZE=2048
HOME=/home/wayne
HOSTNAME=home
HOSTTYPE=i686
HUSHLOGIN=FALSE
HZ=100
ICEWM_PRIVCFG=/home/wayne/.icewm
IFS=$' \t\n'
INPUTRC=/etc/inputrc
JAVA_HOME=/usr/X11R6/lib/java/jdk
LANG=en_US
LC_ALL=POSIX
LINES=44
LOCATE_PATH=/var/lib/locate/locatedb
LOGNAME=wayne
MACHTYPE=i686-pc-linux-gnu
MAIL=/var/mail/wayne
MAILCHECK=60
MANPATH=/usr/share/man:/usr/local/share/man:/usr/X11R6/share/man:/usr/X11R6/lib/java/jdk/man:/opt/qt/doc/man
MOZ_PLUGIN_PATH=/usr/X11R6/lib/plugins
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/X11R6/lib/java/jdk/bin:/opt/qt/bin
PIPESTATUS=([0]="0")
PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/X11R6/lib/pkgconfig:/opt/qt/lib/pkgconfig
PPID=1
PS1='[\u@\h] \w: '
PS2='> '
PS4='+ '
PWD=/home/wayne
QTDIR=/opt/qt
SHELL=/bin/bash
SHELLOPTS=braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor
SHLVL=1
TERM=xterm-color
TZ=America/Los_Angeles
TZDIR=/usr/share/zoneinfo
UID=500
USER=wayne
_=set

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux home 2.6.14.2 #1 Sat Nov 12 23:08:21 PST 2005 i686 pentium3 i386 GNU/Linux
 
Gnu C                  3.4.4
Gnu make               3.80
binutils               2.16
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      6.0.3
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   065
Modules Loaded         ipv6 nfsd exportfs lockd nfs_acl sunrpc ohci_hcd parport_pc parport 8250_pnp 8250 serial_core psmouse rtc tulip crc32 snd_ymfpci snd_ac97_codec snd_ac97_bus snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd jfs loop pdc202xx_new apm usb_storage usbcore sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 499.027
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 998.66

[7.3.] Module information (from /proc/modules):
ipv6 251008 12 - Live 0xd0beb000
nfsd 232672 8 - Live 0xd0b69000
exportfs 6016 1 nfsd, Live 0xd0ad7000
lockd 64264 2 nfsd, Live 0xd0af9000
nfs_acl 3840 1 nfsd, Live 0xd080f000
sunrpc 142780 3 nfsd,lockd,nfs_acl, Live 0xd0b0b000
ohci_hcd 20868 0 - Live 0xd0ade000
parport_pc 39492 0 - Live 0xd0aa9000
parport 35400 1 parport_pc, Live 0xd0acd000
8250_pnp 8960 0 - Live 0xd0a9c000
8250 22084 1 8250_pnp, Live 0xd0ac6000
serial_core 21120 1 8250, Live 0xd0abf000
psmouse 36228 0 - Live 0xd0ab5000
rtc 12344 0 - Live 0xd0a97000
tulip 51872 0 - Live 0xd0a74000
crc32 4352 1 tulip, Live 0xd0a71000
snd_ymfpci 57376 0 - Live 0xd0a82000
snd_ac97_codec 90364 1 snd_ymfpci, Live 0xd0a40000
snd_ac97_bus 2304 1 snd_ac97_codec, Live 0xd0811000
snd_pcm 88712 2 snd_ymfpci,snd_ac97_codec, Live 0xd0a5a000
snd_opl3_lib 10496 1 snd_ymfpci, Live 0xd0a28000
snd_timer 24324 3 snd_ymfpci,snd_pcm,snd_opl3_lib, Live 0xd0a39000
snd_hwdep 9248 1 snd_opl3_lib, Live 0xd0857000
snd_page_alloc 10760 2 snd_ymfpci,snd_pcm, Live 0xd084a000
snd_mpu401_uart 7296 1 snd_ymfpci, Live 0xd0847000
snd_rawmidi 24736 1 snd_mpu401_uart, Live 0xd0a31000
snd_seq_device 8844 2 snd_opl3_lib,snd_rawmidi, Live 0xd0843000
snd 54628 9 snd_ymfpci,snd_ac97_codec,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xd08e8000
soundcore 9696 1 snd, Live 0xd081b000
uhci_hcd 32016 0 - Live 0xd084e000
jfs 204356 5 - Live 0xd08f8000
loop 16520 0 - Live 0xd0800000
pdc202xx_new 8704 0 [permanent], Live 0xd080b000
apm 20832 1 - Live 0xd0814000
usb_storage 33796 0 - Live 0xd0839000
usbcore 118400 4 ohci_hcd,uhci_hcd,usb_storage, Live 0xd085c000
sd_mod 16272 0 - Live 0xd0806000
scsi_mod 98536 2 usb_storage,sd_mod, Live 0xd081f000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0370-0371 : pnp 00:00
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0a
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:0d.0
  1000-10ff : tulip
1400-14ff : 0000:00:0f.0
  1400-14ff : tulip
1800-181f : 0000:00:07.2
  1800-181f : uhci_hcd
1820-182f : 0000:00:07.1
  1820-1827 : ide0
  1828-182f : ide1
1830-183f : 0000:00:0e.0
  1830-1837 : ide2
  1838-183f : ide3
1840-1843 : 0000:00:0e.0
  1842-1842 : ide3
1844-1847 : 0000:00:0e.0
  1846-1846 : ide2
1848-184f : 0000:00:0e.0
  1848-184f : ide3
1850-1857 : 0000:00:0e.0
  1850-1857 : ide2
7000-701f : 0000:00:07.3
  7000-700f : pnp 00:0a
8000-803f : 0000:00:07.3
  8000-803f : pnp 00:0a

00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Adapter ROM
000e4000-000effff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0fffdbff : System RAM
  00100000-0025dddb : Kernel code
  0025dddc-002d1443 : Kernel data
0fffdc00-0ffffbff : ACPI Tables
0ffffc00-0fffffff : ACPI Non-volatile Storage
20000000-2003ffff : 0000:00:0d.0
20040000-2007ffff : 0000:00:0f.0
20080000-2008ffff : 0000:00:10.0
20090000-20093fff : 0000:00:0e.0
d0000000-d0007fff : 0000:00:0c.0
  d0000000-d0007fff : YMFPCI
d0008000-d000bfff : 0000:00:0e.0
d000c000-d000ffff : 0000:00:10.0
d0010000-d00100ff : 0000:00:0d.0
  d0010000-d00100ff : tulip
d0010400-d00104ff : 0000:00:0f.0
  d0010400-d00104ff : tulip
d0800000-d0ffffff : 0000:00:10.0
e0000000-efffffff : 0000:00:00.0
fffe7000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1820 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1800 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-740C [DS-1L Audio Controller] (rev 03)
	Subsystem: Intel Corp.: Unknown device 5332
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100] (rev 25)
	Subsystem: Kingston Technologies: Unknown device 000b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at d0010000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 20000000 [disabled] [size=256K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1850 [size=8]
	Region 1: I/O ports at 1844 [size=4]
	Region 2: I/O ports at 1848 [size=8]
	Region 3: I/O ports at 1840 [size=4]
	Region 4: I/O ports at 1830 [size=16]
	Region 5: Memory at d0008000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 20090000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at d0010400 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 20040000 [disabled] [size=256K]

00:10.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d000c000 (32-bit, non-prefetchable) [size=16K]
	Region 1: Memory at d0800000 (32-bit, prefetchable) [size=8M]
	Expansion ROM at 20080000 [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)
(No attached devices)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you think to
       be relevant):
None.

[X.] Other notes, patches, fixes, workarounds:
I have no patch, no fixes and the only workaround is to stay on tty0, which
is not always possible.


Wayne Harlan

