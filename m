Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbRLNNsM>; Fri, 14 Dec 2001 08:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285368AbRLNNsE>; Fri, 14 Dec 2001 08:48:04 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:41396 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S285367AbRLNNrs>; Fri, 14 Dec 2001 08:47:48 -0500
Date: Fri, 14 Dec 2001 14:47:23 +0100 (CET)
From: erwin-rieger@t-online.de
To: <linux-kernel@vger.kernel.org>
cc: <er-ri@gmx.net>
Subject: PROBLEM: oops with 2.4.x while mounting sysv/sco/afs floppy
Message-ID: <Pine.LNX.4.33.0112141439440.1350-100000@ruebe.ibrieger.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[1.] One line summary of the problem:
     oops with 2.4.x while mounting sysv/sco/afs floppy
#
#
#
[2.] Full description of the problem/report:
     Tried to mount sysv floppies (SCO/afs) with my linux 2.4.5 box
     with the command:

       mount -rt sysv /dev/fd0h1440 /mnt/floppy

     Some of them worked, some had a corrupt fs which was correctly reported
     by mount - no problem so far.

     Then with one of the floppies (i assume with a very corrupt fs) i got the
     oops listed below.

     After this the terminal/process, where i issued the mount freezes, ps ax
     does not show mount. Processes like mount or sync that are started after
     the oops hang/freeze unkillable.

     I've transfered a dd image of the disk to an other floppy and it oopses
     the same way, so it is reproducable and i can send the image to you,
     if needed.

     I've uptdated my kernel to 2.4.10 (suse) with no success. Searches on
     the net, on this list and a look at the changes files of 2.4.11 to
     2.4.16 gave no more hints, so i am writing to you.

     Please reply to er-ri@gmx.net, since i've not subscribed to this list.
#
#
#
[3.] Keywords (i.e., modules, networking, kernel):
     mount, filesystems, sysv, lockd
#
#
#
[4.] Kernel version (from /proc/version):
     Linux version 2.4.10 (root@ruebe) (gcc version 2.95.3 20010315
     (SuSE)) #1 Don Dez 13 10:12:55 CET 2001
#
#
#
[5.] Output of Oops.. message
ksymoops 2.4.1 on i686 2.4.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says c185af74, /lib/modules/2.4.10/kernel/fs/lockd/lockd.o says c185a3a4.  Ignoring /lib/modules/2.4.10/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says c185af70, /lib/modules/2.4.10/kernel/fs/lockd/lockd.o says c185a3a0.  Ignoring /lib/modules/2.4.10/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says c185af78, /lib/modules/2.4.10/kernel/fs/lockd/lockd.o says c185a3a8.  Ignoring /lib/modules/2.4.10/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says c188e084, /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o says c188dd64.  Ignoring /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says c188e088, /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o says c188dd68.  Ignoring /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says c188e08c, /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o says c188dd6c.  Ignoring /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says c188e080, /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o says c188dd60.  Ignoring /lib/modules/2.4.10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c195fa20, /lib/modules/2.4.10/kernel/drivers/usb/usbcore.o says c195f8e0.  Ignoring /lib/modules/2.4.10/kernel/drivers/usb/usbcore.o entry
Dec 13 13:54:18 ruebe kernel: invalid operand: 0000
Dec 13 13:54:18 ruebe kernel: CPU:    0
Dec 13 13:54:18 ruebe kernel: EIP:    0010:[iput+274/456]
Dec 13 13:54:18 ruebe kernel: EFLAGS: 00010287
Dec 13 13:54:18 ruebe kernel: eax: 00000032   ebx: c6a54cc0   ecx: c5751000   edx: 00000001
Dec 13 13:54:18 ruebe kernel: esi: c1b714e4   edi: c1b74660   ebp: c0221fe0   esp: c1be5edc
Dec 13 13:54:18 ruebe kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 13:54:18 ruebe kernel: Process mount (pid: 1241, stackpage=c1be5000)
Dec 13 13:54:18 ruebe kernel: Stack: c54bfd60 c6a54cc0 c0140836 c6a54cc0 c7c11c00 c54bfd60 c013419c c54bfd60
Dec 13 13:54:18 ruebe kernel:        c54bfd60 c11e5360 c7c11c00 c1be5f78 c0221fe0 c1b748a8 c013303b c7c11c00
Dec 13 13:54:18 ruebe kernel:        c11e6210 c11e5360 c11e5360 ffffffec c01349b6 c11e5360 00000001 00000000
Dec 13 13:54:18 ruebe kernel: Call Trace: [dput+230/340] [kill_super+116/352] [lockd:nlmsvc_timeout+3250480/162802677] [__mntput+55/64] [do_add_mount+178/188]
Dec 13 13:54:18 ruebe kernel: Code: 0f 0b e9 a0 00 00 00 8d 76 00 39 1b 74 4c f6 83 18 01 00 00
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   e9 a0 00 00 00            jmp    a7 <_EIP+0xa7> 000000a7 Before first symbol
Code;  00000007 Before first symbol
   7:   8d 76 00                  lea    0x0(%esi),%esi
Code;  0000000a Before first symbol
   a:   39 1b                     cmp    %ebx,(%ebx)
Code;  0000000c Before first symbol
   c:   74 4c                     je     5a <_EIP+0x5a> 0000005a Before first symbol
Code;  0000000e Before first symbol
   e:   f6 83 18 01 00 00 00      testb  $0x0,0x118(%ebx)
8 warnings issued.  Results may not be reliable.
#
#
#
[6.] A small shell script or example program which triggers the
     problem (if possible)
#
#
#
[7.] Environment
#
#
#
[7.1.] Software (add the output of the ver_linux script here)
Linux ruebe 2.4.10 #1 Don Dez 13 10:12:55 CET 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
pcmcia-cs              3.1.8
Linux C Library        x    1 root     root      1343073 Mai 11  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         sysv nfsd lockd sunrpc usb-uhci usbcore ne2k-pci 8390 3c59x st es1371 ac97_codec
#
#
#
[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.609
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19
#
#
#
[7.3.] Module information (from /proc/modules):
sysv                   18928   1 (autoclean)
nfsd                   64928   3 (autoclean)
lockd                  46160   1 (autoclean) [nfsd]
sunrpc                 57504   1 (autoclean) [nfsd lockd]
usb-uhci               21216   0 (unused)
usbcore                31360   0 [usb-uhci]
ne2k-pci                5056   0 (autoclean) (unused)
8390                    5824   0 (autoclean) [ne2k-pci]
3c59x                  25024   1 (autoclean)
st                     25616   0 (unused)
es1371                 27056   0 (autoclean)
ac97_codec              9440   0 (autoclean) [es1371]
#
#
#
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f0-03f5 : floppy
03f7-03f7 : floppy DIR
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Rage 128 RF
d000-d00f : VIA Technologies, Inc. Bus Master IDE
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d8ff : Adaptec 7892B
  d800-d8ff : aic7xxx
dc00-dc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  dc00-dc7f : 00:0a.0
e000-e01f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  e000-e01f : ne2k-pci
e400-e43f : Ensoniq ES1371 [AudioPCI-97]
  e400-e43f : es1371
/proc/iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ce5ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001edc9b : Kernel code
  001edc9c-0024869f : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d4000000-d7ffffff : PCI Bus #01
  d4000000-d7ffffff : ATI Technologies Inc Rage 128 RF
d8000000-d9ffffff : PCI Bus #01
  d9000000-d9003fff : ATI Technologies Inc Rage 128 RF
db000000-db000fff : Adaptec 7892B
  db000000-db000fff : aic7xxx
db001000-db00107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffff0000-ffffffff : reserved
#
#
#
[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d4000000-d7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
	Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 11) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 SCSI storage controller: Adaptec 7892B (rev 02)
	Subsystem: Adaptec: Unknown device 62a1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	BIST result: 00
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at db000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=128]
	Region 1: Memory at db001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e000 [size=32]

00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 07)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 8901
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at e400 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
#
#
#
[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SONY     Model: SDT-5000         Rev: 3.26
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6401TA Rev: 1001
  Type:   CD-ROM                           ANSI SCSI revision: 02
#
#
#
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
/proc/filesystems:
nodev	bdev
nodev	proc
nodev	sockfs
nodev	tmpfs
nodev	shm
nodev	pipefs
	ext2
nodev	devpts
	sysv
	v7
/proc/fs/nfs/exports:
# Version 1.1
# Path Client(Flags) # IPs
/proc/mounts:
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
/dev/sda6 /usr ext2 rw 0 0
#
#
#
[X.] Other notes, patches, fixes, workarounds:


Thank you, erri


