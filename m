Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVAWSmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVAWSmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 13:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVAWSmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 13:42:46 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:17286 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261338AbVAWSmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 13:42:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=B7huERZLXNWEswtdbzH/5LRuBEmPxK3rSRncxAi758qdgJ4hjkII0uQFgNEWY4QGqe3k8/veW8At5Zjm++FSZ+/fMdv1ZjfNMrQgtFD8FdQ4MoK3n3pWg5w+Mmil6oiQaxTKcgU1JfQ142O0AOHOpwOt3s5/0+RPJXjl+W9j4ME=
Message-ID: <b7e2d91a0501231042406192bf@mail.gmail.com>
Date: Sun, 23 Jan 2005 13:42:04 -0500
From: Rich McNeary <rich.mcneary@gmail.com>
Reply-To: Rich McNeary <rich.mcneary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: sony usb dvdr drive locks system when mounting disc
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First kernel bug report, sorry if I commit a faux pas.

This occurs when I attempt to mount a disc in a Sony DRX-510UL drive
connected by USB 2.0.

dbus and hal are running, ivman (automounter) is not running.

Turn on the drive, if there is a disc in it remove it.
Boot system.
Login to KDE.
Place a disc in the drive.
Open a terminal.
Type "mount /dev/sr0" (the drive already exists in fstab).
The disc spins up and after a few seconds the system becomes
unresponsive. Sometimes the cursor can be moved by the mouse, but it
won't interact with the desktop. The only way to "unlock" the system
is to push the reset or power button on the CPU.

The following were all captured BEFORE the disc was mounted, not
possible to capture afterwards.



Linux version: Linux version 2.6.10-gentoo-r6L (root@LNX-Glamdring)
(gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2,
pie-8.7.6)) #1 SMP Fri Jan 21 22:10:36 EST 2005



ver_linux:
Linux LNX-Glamdring 2.6.10-gentoo-r6L #1 SMP Fri Jan 21 22:10:36 EST
2005 i686 Intel(R) Pentium(R) 4 CPU 2.60GHz GenuineIntel GNU/Linux
 
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.18
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         w83781d eeprom i2c_sensor i2c_isa sd_mod
snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device 8139too snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
snd snd_page_alloc i2c_i801 i2c_core ehci_hcd usb_storage uhci_hcd
intel_agp agpgart rtc usbcore sr_mod scsi_mod



/proc/modules:
w83781d 34344 0 - Live 0xe0ef9000
eeprom 6936 0 - Live 0xe0e86000
i2c_sensor 3968 2 w83781d,eeprom, Live 0xe0e84000
i2c_isa 2816 0 - Live 0xe086c000
sd_mod 14848 0 - Live 0xe0e91000
snd_pcm_oss 50212 0 - Live 0xe0eeb000
snd_mixer_oss 18944 1 snd_pcm_oss, Live 0xe0e8b000
snd_seq_oss 33408 0 - Live 0xe0ed1000
snd_seq_midi_event 7296 1 snd_seq_oss, Live 0xe0e81000
snd_seq 51984 4 snd_seq_oss,snd_seq_midi_event, Live 0xe0ec3000
snd_seq_device 7948 2 snd_seq_oss,snd_seq, Live 0xe0e7e000
8139too 22016 0 - Live 0xe0e6a000
snd_intel8x0 29600 0 - Live 0xe0e61000
snd_ac97_codec 74080 1 snd_intel8x0, Live 0xe0eaf000
snd_pcm 86788 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xe0e98000
snd_timer 22532 2 snd_seq,snd_pcm, Live 0xe0e29000
snd 47332 9 snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,
Live 0xe0e71000
snd_page_alloc 8580 2 snd_intel8x0,snd_pcm, Live 0xe0826000
i2c_i801 8460 0 - Live 0xe083a000
i2c_core 19456 5 w83781d,eeprom,i2c_sensor,i2c_isa,i2c_i801, Live 0xe0e30000
ehci_hcd 28932 0 - Live 0xe0877000
usb_storage 29184 0 - Live 0xe0863000
uhci_hcd 31504 0 - Live 0xe086e000
intel_agp 20508 1 - Live 0xe085c000
agpgart 29484 1 intel_agp, Live 0xe0853000
rtc 11208 0 - Live 0xe0831000
usbcore 105720 4 ehci_hcd,usb_storage,uhci_hcd, Live 0xe0e0e000
sr_mod 16164 0 - Live 0xe082c000
scsi_mod 75488 3 sd_mod,usb_storage,sr_mod, Live 0xe083f000


/proc/ioports:
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
0290-0297 : w83781d
0376-0376 : ide1
03c0-03df : vga+
  03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0400-047f : 0000:00:1f.0
  0400-0403 : PM1a_EVT_BLK
  0404-0405 : PM1a_CNT_BLK
  0408-040b : PM_TMR
  0428-042f : GPE0_BLK
0480-04bf : 0000:00:1f.0
0500-051f : 0000:00:1f.3
  0500-050f : i801-smbus
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:00.0
a000-a0ff : 0000:02:02.0
  a000-a0ff : 8139too
b000-b01f : 0000:00:1d.1
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.3
  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.0
  bc00-bc1f : uhci_hcd
c000-c007 : 0000:00:1f.2
c400-c403 : 0000:00:1f.2
c800-c807 : 0000:00:1f.2
cc00-cc03 : 0000:00:1f.2
d000-d00f : 0000:00:1f.2
d800-d8ff : 0000:00:1f.5
  d800-d8ff : Intel ICH5
dc00-dc3f : 0000:00:1f.5
  dc00-dc3f : Intel ICH5
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1


lspci -vvv:
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM
Controller/Host-Hub Interface (rev 02)
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable)
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller
(rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: d0000000-efffffff
	Expansion ROM at 00009000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at bc00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at b000 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at b400 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB
UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at b800 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at fc000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface
to PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra
ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150
Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c000
	Region 1: I/O ports at c400 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at cc00 [size=4]
	Region 4: I/O ports at d000 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0500 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: ABIT Computer Corp.: Unknown device 100a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at d800
	Region 1: I/O ports at dc00 [size=64]
	Region 2: Memory at fc001000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at fc002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AP
[Radeon 9600] (prog-if 00 [VGA])
	Subsystem: C.P. Technology Co. Ltd: Unknown device 2064
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0000000 (32-bit, prefetchable)
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc RV350 AP [Radeon
9600] (Secondary)
	Subsystem: C.P. Technology Co. Ltd: Unknown device 2065
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e0000000 (32-bit, prefetchable) [disabled]
	Region 1: Memory at f9010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: ABIT Computer Corp.: Unknown device 1016
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at a000
	Region 1: Memory at fb000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



fstab:
# This file is edited by fstab-sync - see 'man fstab-sync' for details
# /etc/fstab: static file system information.
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/fstab,v 1.14
2003/10/13 20:03:38 azarah Exp $
#
# noatime turns off atimes for increased performance (atimes normally aren't
# needed; notail increases performance of ReiserFS (at the expense of storage
# efficiency).  It's safe to drop the noatime options if you want and to 
# switch between notail and tail freely.

# <fs>          	<mountpoint>    <type>  	<opts>      		<dump/pass>

# NOTE: If your BOOT partition is ReiserFS, add the notail option to opts.
/dev/hda8		/boot		ext3		noauto,noatime		1 1
/dev/hda10		/		reiserfs	noatime,notail		0 1
/dev/hda9		none		swap		sw			0 0
/dev/hda6		/mnt/win_e	vfat		user,noatime,uid=rich	0 2	


# NOTE: The next line is critical for boot!
none			/proc		proc		defaults		0 0


# glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
# POSIX shared memory (shm_open, shm_unlink). 
# (tmpfs is a dynamically expandable/shrinkable ramdisk, and will
#  use almost no memory if not populated with files)
# Adding the following line to /etc/fstab should take care of this:
/dev/hdc                /media/cdrw             auto   
exec,user,noauto,managed 0 0
/dev/sr0                /media/dvdr             auto   
exec,user,noauto,managed 0 0



This also occurs with the 2.6.9 kernel (that's the oldest one I still
have). That's it!

Rich
