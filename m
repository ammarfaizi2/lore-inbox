Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbRB0EFv>; Mon, 26 Feb 2001 23:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129555AbRB0EFm>; Mon, 26 Feb 2001 23:05:42 -0500
Received: from mail4.primary.net ([216.87.38.199]:57029 "EHLO
	mail4.primary.net") by vger.kernel.org with ESMTP
	id <S129552AbRB0EFh>; Mon, 26 Feb 2001 23:05:37 -0500
Message-ID: <3A9B2881.7060303@primary.net>
Date: Mon, 26 Feb 2001 22:09:37 -0600
From: Dale Christ <dechris@primary.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-K6 i586; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MO drive problems with 640MB disk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] one-line summary of the problem
     Segfault when trying to read from an 640MB MO disk (2048-byte sectors) Also causes a hard crash when writing...reset required
     
 
[2.] full description of the problem
     The problem did not occur when processing 128MB disks (they use a 512-byte sector size).  read and write work fine here... 
     
     
[3.] Keywords...
   fat vfat 2048-byte sector magneto-optical 

 
[4.] Kernel info:
Linux version 2.4.2K6 (root@localhost.localdomain) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #1 Mon Feb 26 18:11:39 CST 2001
[5.] OOPS info:
[6.] shell program or script

mount /mnt/MO
cp /mnt/MO/dechris.tar.gz . 

[7.] Environment:
BASH=/bin/bash
BASH_ENV=/root/.bashrc
BASH_VERSINFO=([0]="2" [1]="04" [2]="11" [3]="1" [4]="release" [5]="i386-redhat-linux-gnu")
BASH_VERSION='2.04.11(1)-release'
COLORTERM=gnome-terminal
DIRSTACK=()
DISPLAY=:0
EUID=0
GROUPS=()
HISTSIZE=1000
HOME=/root
HOSTNAME=localhost.localdomain
HOSTTYPE=i386
IFS=' 	
'
INPUTRC=/etc/inputrc
KDEDIR=/usr
LANG=en_US
LESSOPEN='|/usr/bin/lesspipe.sh %s'
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
MACHTYPE=i386-redhat-linux-gnu
MAIL=/var/spool/mail/root
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/root/bin
PIPESTATUS=([0]="0")
PPID=863
PS4='+ '
PWD=/root/bugrpt
QTDIR=/usr/lib/qt-2.2.0
SESSION_MANAGER=local/localhost.localdomain:/tmp/.ICE-unix/823
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:interactive-comments
SHLVL=4
SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass
TERM=xterm
UID=0
USER=root
USERNAME=root
WINDOWID=23068796
_='[7.] Environment:'
[7.1.] Software:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux localhost.localdomain 2.4.2K6 #1 Mon Feb 26 18:11:39 CST 2001 i586 unknown
Kernel modules         2.4.2
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         tulip emu10k1
[7.2.] Processor Information:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 9
model name	: AMD-K6(tm) 3D+ Processor
stepping	: 1
cpu MHz		: 451.030
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 897.84

[7.3.] Module Information:
tulip                  34192   1 (autoclean)
emu10k1                44848   1
[7.4.1.] ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
6400-641f : VIA Technologies, Inc. UHCI USB
  6400-641f : usb-uhci
6800-6807 : CMD Technology Inc PCI0649
  6800-6807 : ide2
6c00-6c03 : CMD Technology Inc PCI0649
  6c02-6c02 : ide2
7000-7007 : CMD Technology Inc PCI0649
  7000-7007 : ide3
7400-7403 : CMD Technology Inc PCI0649
  7402-7402 : ide3
7800-780f : CMD Technology Inc PCI0649
  7800-7807 : ide2
  7808-780f : ide3
7c00-7cff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
  7c00-7cff : eth0
8000-801f : Creative Labs SB Live! EMU10000
  8000-801f : EMU10K1
8400-8407 : Creative Labs SB Live!
e000-efff : PCI Bus #01
  e000-e0ff : 3Dfx Interactive, Inc. Voodoo 4
f000-f00f : VIA Technologies, Inc. Bus Master IDE
  f000-f007 : ide0
  f008-f00f : ide1
[7.4.2.] iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca5ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-002882ab : Kernel code
  002882ac-00321697 : Kernel data
a0000000-afffffff : PCI Bus #01
  a0000000-a7ffffff : 3Dfx Interactive, Inc. Voodoo 4
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 3Dfx Interactive, Inc. Voodoo 4
e0000000-e0ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e1000000-e10000ff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
  e1000000-e10000ff : eth0
ffff0000-ffffffff : reserved
[7.5.] PCI Information
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=16M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d0000000-dfffffff
	Prefetchable memory behind bridge: a0000000-afffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0a.0 RAID bus controller: CMD Technology Inc: Unknown device 0649 (rev 01)
	Subsystem: CMD Technology Inc: Unknown device 0649
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6800 [size=8]
	Region 1: I/O ports at 6c00 [size=4]
	Region 2: I/O ports at 7000 [size=8]
	Region 3: I/O ports at 7400 [size=4]
	Region 4: I/O ports at 7800 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX Fast Ethernet Adapter (rev 25)
	Subsystem: Lite-On Communications Inc: Unknown device c001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 7c00 [size=256]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 05)
	Subsystem: Creative Labs CT4790 SoundBlaster PCI512
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 8000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at 8400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown device 0009 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 0004
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
	Region 1: Memory at a0000000 (32-bit, prefetchable) [size=128M]
	Region 2: I/O ports at e000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [54] AGP version 2.0
		Status: RQ=15 SBA+ 64bit+ FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: M25-MCC3064AP    Rev: 0051
  Type:   Optical Device                   ANSI SCSI revision: 02
[7.7.] Other information :
Feb 26 19:01:40 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Feb 26 19:01:40 localhost kernel:  printing eip:
Feb 26 19:01:40 localhost kernel: 00000000
Feb 26 19:01:40 localhost kernel: *pde = 00000000
Feb 26 19:01:40 localhost kernel: Oops: 0000
Feb 26 19:01:40 localhost kernel: CPU:    0
Feb 26 19:01:40 localhost kernel: EIP:    0010:[cpuid_exit+0/128]
Feb 26 19:01:40 localhost kernel: EFLAGS: 00010282
Feb 26 19:01:40 localhost kernel: eax: c030a500   ebx: c1de5200   ecx: 00000003   edx: c1de5200
Feb 26 19:01:40 localhost kernel: esi: ffffffea   edi: 00000000   ebp: 00001000   esp: c1687f68
Feb 26 19:01:40 localhost kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 19:01:40 localhost kernel: Process cp (pid: 888, stackpage=c1687000)
Feb 26 19:01:40 localhost kernel: Stack: c0162966 c1de5200 bfffe4a8 00001000 c1de5220 c0131828 c1de5200 bfffe4a8 
Feb 26 19:01:40 localhost kernel:        00001000 c1de5220 00000000 0000000c 00000000 c267ec20 bffff4d8 00000000 
Feb 26 19:01:40 localhost kernel:        c1de5200 bffff4a0 c1686000 00001000 bfffe4a8 bffff550 c0108fc3 00000003 
Feb 26 19:01:40 localhost kernel: Call Trace: [fat_file_read+38/48] [sys_read+152/208] [system_call+51/64] 
Feb 26 19:01:40 localhost kernel: 
Feb 26 19:01:40 localhost kernel: Code:  Bad EIP value.


[8.0]  My fix (based on 2.4.2):
patch starts ------>>>
--- /root/linux-2.4.2/fs/fat/file.c	Wed Apr 12 11:47:29 2000
+++ linux/fs/fat/file.c	Mon Feb 26 20:02:26 2001
@@ -49,8 +49,19 @@
 	loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	return MSDOS_SB(inode->i_sb)->cvf_format
-			->cvf_file_read(filp,buf,count,ppos);
+
+    if (MSDOS_SB(inode->i_sb)->cvf_format &&
+	    MSDOS_SB(inode->i_sb)->cvf_format->cvf_file_read)
+	    return MSDOS_SB(inode->i_sb)->cvf_format
+		  	->cvf_file_read(filp,buf,count,ppos);
+
+	/*
+	 * MS-DOS filesystems with a blocksize > 512 may have blocks
+	 * spread over several hardware sectors (unaligned), which
+	 * is not something the generic routines can (or would want
+	 * to) handle).
+	 */
+	return generic_file_read(filp, buf, count, ppos);		  	
 }
 
 
<<<------patch ends

