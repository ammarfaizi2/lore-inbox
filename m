Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbUKDA5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUKDA5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbUKDA4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:56:45 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:28589 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262036AbUKDAwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:52:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=VVceXyqhH839O5WwmC3+3mBiV985WYyRDrvLdG61bSVfmKbjHOKY3fXtiQMTn6f6+YsiWYKoKfsqLQFWgNHZvR8jSLEuWZY0iSJt38HVZp1CNPNLbXLd37vgbH6nozfkRTbUqnb7ysVSMZM9gP8Ytpx0bDK3AvoeBkvx68MNYGg=
Message-ID: <8393fff041103165225f9b3ef@mail.gmail.com>
Date: Wed, 3 Nov 2004 19:52:36 -0500
From: Martin Blais <martin.blais@gmail.com>
Reply-To: Martin Blais <blais@furius.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.9 freezes upon dereferencing invalid C++ ref in xxdiff.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

kernel 2.6.9 freezes upon dereferenceing invalid C++ ref in xxdiff.


[2.] Full description of the problem/report:

In xxdiff-3.0.2, there is a bug with an invalid C++ reference being
dereferenced, and it freezes kernel 2.6.9 (you have to reboot).  I tried running
it in gdb and the problem still occurs, debug or release builds.

Steps to reproduce:

1. compile xxdiff-3.0.2 (get it from http://xxdiff.sourceforge.net)
   (Note: the problem is fixed in 3.0.3, get exactly version 3.0.2)

2. run it on two valid files

3. invoke the "File -> Edit Left File" menu

4. Linux freezes.

Someone else reported the problem to me and I verified this with the same kernel
(2.6.9).


[3.] Keywords (i.e., modules, networking, kernel):

kernel, freeze


[4.] Kernel version (from /proc/version):

Linux version 2.6.9 (root@elbow.tapholov.com) (gcc version 3.2.3
20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 SMP Tue Oct 26
17:36:30 EDT 2004


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

No oops, freeze doesn't print anything.


[6.] A small shell script or example program which triggers the
     problem (if possible)

I tried reproducing it using only a copy of the local function that has the bug
and could not make it freeze (it segfaults, as it should).  I suppose you can
use whatever kernel debugging tools exist to find this (I don't have any
experience with this, and cannot look at it now).


[7.] Environment

BIBINPUTS=.:/home/blais/p/priv/bib
INFODIR=/usr/share/info:/usr/X11R6/info
MANPATH=/home/blais/p/conf/common/man:/usr/share/man:/usr/local/share/man:/usr/share/gcc-data/i686-pc-linux-gnu/3.2/man:/usr/X11R6/man:/opt/blackdown-jdk-1.4.1/man:/usr/qt/3/man:/usr/qt/3/doc/man:/usr/man:/usr/X11R6/man
NNTPSERVER=news1.qc.sympatico.ca
RXVT_RANDOM_BACKGROUND=/home/blais/p/conf-local/common/share/shell-backgrounds/Need-The-Feeling-2.xpm.gz
SSH_AGENT_PID=5260
HOSTNAME=elbow.tapholov.com
CVS_WRAPPER_CONFIG=/home/blais/p/conf/common/etc/cvsw.conf
BSTINPUTS=.:/home/blais/p/conf/common/tex/bst
GPG_AGENT_INFO=/tmp/gpg-y9zUAs/S.gpg-agent:5263:1
TERM=xterm
SHELL=bash
HOST=elbow.tapholov.com
ADDRESSBOOK=/home/blais/p/priv/addrbook
PERL5LIB=/home/blais/p/conf/common/lib/perl/lib
CVSROOT=/home/blais/cvsroot
JUKEBOX=/mnt/jukebox
WINDOWID=8388610
INDEXSTYLE=/home/blais/p/conf/common/tex/index
CURATOR_TEMPLATE=/home/blais/p/curator/share/templates/blais
OLDPWD=/home/blais/p
QTDIR=/usr/qt/3
CONF_LOCAL=/home/blais/p/conf-local
TMAKEPATH=/usr/lib/tmake/linux-g++
USER=blais
SGML_CATALOG_FILES=/etc/sgml/sgml-ent.cat:/etc/sgml/sgml-docbook.cat:/etc/sgml/sgml-lite.cat:/etc/sgml/html401.cat:/etc/sgml/xhtml1.cat:/etc/sgml/sgml-docbook-4.2.cat:/etc/sgml/dsssl-docbook-stylesheets.cat:/etc/sgml/openjade-1.3.2.cat:/etc/sgml/sgml-docbook-3.1.cat
SVN_EDITOR=vi
XMLLINT_INDENT=   
LD_LIBRARY_PATH=/home/blais/p/conf/common/lib:/usr/lib:/usr/local/lib
GDK_USE_XFT=1
SANTERIADB=/home/blais/p/santeriadb-src/share/db/batadb.xml
PROJECTS=/home/blais/p
SSH_AUTH_SOCK=/tmp/ssh-CcDd5259/agent.5259
PYTHONDOCS=/usr/share/doc/python-docs-2.2.3/html
KDEDIR=/usr/kde/3.2
USERNAME=blais
PAGER=less
CONFIG_PROTECT_MASK=/etc/gconf /etc/terminfo
SITE=home
XPSERVERLIST=:2
XINITRC=/etc/X11/xinit/xinitrc
SSH_WRAPPER_CONFIG=/home/blais/p/conf/common/etc/sshw.conf
PATH=/home/blais/p/conf/common/bin:/home/blais/p/conf/plat/i686-pc-linux/bin:/home/blais/p/conf/site/home/bin:/home/blais/p/conf-local/common/bin:/home/blais/p/conf-local/plat/i686-pc-linux/bin:/home/blais/p/arubomu/bin:/home/blais/p/arubomu/old/bin:/home/blais/p/camtools/bin:/home/blais/p/contract-tools/bin:/home/blais/p/curator/bin:/home/blais/p/jukebox/bin:/home/blais/p/optcomplete/bin:/home/blais/p/projects/bin:/home/blais/p/santeriadb-src/bin:/home/blais/p/xxdiff/bin:/usr/local/zope/bin:/bin:/usr/bin:/usr/local/bin:/opt/bin:/usr/i686-pc-linux-gnu/gcc-bin/3.2:/opt/Acrobat5:/usr/X11R6/bin:/opt/blackdown-jdk-1.4.1/bin:/opt/blackdown-jdk-1.4.1/jre/bin:/usr/qt/3/bin:/usr/kde/3.2/bin:/usr/kde/3.1/bin:/usr/qt/2/bin:/usr/games/bin:/opt/limewire:/sbin:/usr/sbin:/usr/X11R6/bin
XML_CATALOG_FILES= /home/blais/p/arubomu/share/dtd/catalog
/home/blais/p/arubomu/share/dtd/catalog
/home/blais/p/arubomu/share/dtd/catalog
PWD=/home/blais/p/xxdiff/src
SMTPSERVER=smtp1.qc.sympatico.ca
JAVA_HOME=/opt/blackdown-jdk-1.4.1
CONF=/home/blais/p/conf
JAVAC=/opt/blackdown-jdk-1.4.1/bin/javac
EDITOR=emacsclient
SCP_WRAPPER_CONFIG=/home/blais/p/conf/common/etc/scpw.conf
LANG=C
SUDO_LD_LIBRARY_PATH=/home/blais/p/conf/common/lib:/usr/lib:/usr/local/lib
QMAKESPEC=linux-g++
KDEDIRS=/usr
XUSERFILESEARCHPATH=/home/blais/p/conf/common/app-defaults/%N:/home/blais/app-defaults/%N:/home/blais/p/conf-local/plat/i686-pc-linux/app-defaults/%N
PS1=\h:$(echo \w | /bin/sed -e "s+$PHYS_HOME+~+;\
s+\(/[@a-zA-Z0-9_]*/\).*\(/[@a-zA-Z0-9_]*/[@a-zA-Z0-9_]*\)+\1...\2+g")\$ 
JUKEBOX_COVERS=/home/blais/p/jukebox-data/jukebox.covers
GDMSESSION=Xsession
CXX=g++
TEXINPUTS=/home/blais/p/conf/common/tex/inputs:
COLORFGBG=15;default;12
HOME=/home/blais
SHLVL=5
JDK_HOME=/opt/blackdown-jdk-1.4.1
MANPAGER=less
XPCONFIGDIR=/usr/share/Xprint/xserver/C/print
PHYS_HOME=/home/blais
LOGNAME=blais
LESS=-R
PYTHONPATH=/home/blais/p/conf/common/lib/python:/home/blais/p/adventures/lib/python:/home/blais/p/arubomu/lib/python:/home/blais/p/camtools/lib/python:/home/blais/p/curator/lib/python:/home/blais/p/jukebox/lib/python:/home/blais/p/optcomplete/lib/python:/home/blais/p/santeriadb-src/lib/python:/home/blais/p/conf/common/lib/python-fallback:/home/blais/p/adventures/lib/python-fallback:/home/blais/p/camtools/lib/python-fallback:/home/blais/src/docutils
LATEXINPUTS=/home/blais/p/conf/common/tex/inputs
BOOKMARKS=/home/blais/p/priv/bookmarks
CVS_RSH=ssh
CLASSPATH=/opt/blackdown-jdk-1.4.1/jre/lib/rt.jar:.
JUKEBOX_PLAYFILE=/home/blais/p/priv/playfiles/playmon-index.xml
LESSOPEN=|lesspipe.sh %s
JUKEBOX_INDEXES=/home/blais/p/priv/cdindex
EMAIL=blais@furius.ca
JUKEBOX_XML=/home/blais/p/jukebox-data/jukebox.xml
INFOPATH=/usr/share/info:/usr/share/gcc-data/i686-pc-linux-gnu/3.2/info
CC=gcc
DISPLAY=:0.0
PLAT=i686-pc-linux
RSYNC_RSH=sshw
G_BROKEN_FILENAMES=1
CONFIG_PROTECT=/usr/X11R6/lib/X11/xkb /usr/kde/3.2/share/config
/usr/kde/3.1/share/config /usr/share/texmf/tex/generic/config/
/usr/share/texmf/tex/platex/config/ /usr/share/texmf/dvips/config/
/usr/share/texmf/dvipdfm/config/ /usr/share/texmf/xdvi/
/usr/share/config
GNUPGHOME=/home/blais/p/conf/common/gnupg
COLORTERM=rxvt-xpm
XAUTHORITY=/home/blais/.Xauthority
_=/bin/printenv



[7.1.] Software (add the output of the ver_linux script here)

elbow linux # ./scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux elbow.tapholov.com 2.6.9 #1 SMP Tue Oct 26 17:36:30 EDT 2004
i686 Intel(R) Pentium(R) 4 CPU 2.40GHz GenuineIntel GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12b
mount                  2.12b
module-init-tools      0.9.15-pre4
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         nvidia



[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2406.113
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 4751.36

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2406.113
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 4800.51


[7.3.] Module information (from /proc/modules):

nvidia 4813344 12 - Live 0xf8e73000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

elbow linux # cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
d800-d8ff : 0000:02:05.0
dc00-dc7f : 0000:02:03.0
df40-df5f : 0000:02:0a.0
  df40-df5f : ne2k-pci
df90-df9f : 0000:02:04.0
dfa0-dfa7 : 0000:02:04.0
dfa8-dfab : 0000:02:04.0
dfac-dfaf : 0000:02:04.0
dfe0-dfe7 : 0000:02:04.0
e800-e8ff : 0000:00:1f.5
  e800-e8ff : Intel ICH5
ee80-eebf : 0000:00:1f.5
  ee80-eebf : Intel ICH5
ef00-ef1f : 0000:00:1d.0
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.1
  ef20-ef3f : uhci_hcd
ef40-ef5f : 0000:00:1d.2
  ef40-ef5f : uhci_hcd
ef80-ef9f : 0000:00:1d.3
  ef80-ef9f : uhci_hcd
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

elbow linux # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000f0000-000fffff : System ROM
00100000-3ff2ffff : System RAM
  00100000-003975ef : Kernel code
  003975f0-004dd7ff : Kernel data
3ff30000-3ff3ffff : ACPI Tables
3ff40000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
40000000-400003ff : 0000:00:1f.1
e7f00000-f7efffff : PCI Bus #01
  e8000000-efffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fc900000-fe9fffff : PCI Bus #01
  fd000000-fdffffff : 0000:01:00.0
    fd000000-fdffffff : nvidia
feaf8000-feafbfff : 0000:02:05.0
feaff800-feafffff : 0000:02:03.0
  feaff800-feafffff : ohci1394
febff400-febff4ff : 0000:00:1f.5
  febff400-febff4ff : Intel ICH5
febff800-febff9ff : 0000:00:1f.5
  febff800-febff9ff : Intel ICH5
febffc00-febfffff : 0000:00:1d.7
  febffc00-febfffff : ehci_hcd
ffb80000-ffffffff : reserved



[7.5.] PCI information ('lspci -vvv' as root)

elbow linux # lspci -vvv
00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O
Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f2
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Intel Corp. 82865G/PE/P Processor to AGP
Controller (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc900000-fe9fffff
        Prefetchable memory behind bridge: e7f00000-f7efffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ef00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at ef20 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at ef40 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ef80 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage
Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio
Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at e800 [size=256]
        Region 1: I/O ports at ee80 [size=64]
        Region 2: Memory at febff800 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at febff400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
0322 (rev a1) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 0407
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fe9e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns max), cache line size 04
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at dc00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 RAID bus controller: VIA Technologies, Inc.: Unknown device
3164 (rev 06)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at dfe0 [size=8]
        Region 1: I/O ports at dfac [size=4]
        Region 2: I/O ports at dfa0 [size=8]
        Region 3: I/O ports at dfa8 [size=4]
        Region 4: I/O ports at df90 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 80eb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), cache line size 04
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at d800 [size=256]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=7 DScale=1 PME-
        Capabilities: [50] Vital Product Data

02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: D-Link System Inc DE-528
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at df40 [size=32]



[7.6.] SCSI information (from /proc/scsi/scsi)

elbow linux # cat /proc/scsi/scsi 
Attached devices:



[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:




Any additional information needed let me know.

cheers,


--
Martin Blais <blais@furius.ca>
