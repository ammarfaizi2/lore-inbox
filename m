Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTFDUvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTFDUvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:51:48 -0400
Received: from zeus.kernel.org ([204.152.189.113]:16808 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264127AbTFDUve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:51:34 -0400
Subject: 2.4.20 Oops (semms in reiserfs)
From: Daniel Sobe <daniel.sobe@epost.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Jun 2003 22:38:56 +0200
Message-Id: <1054759139.1100.58.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

working a while in X i got these errors (second error repeating for some
time, i was able to use SysRq to sync, mount ro and reboot). seems to be
related to reiserfs.

please cc me because I'm not subscribed to the list.

thanks, 

daniel

Linux version 2.4.20 (root@localhost) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Son Jun 1 23:03:12 MEST 2003

debian woody

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 648.759
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 1294.33

-------------------------------------------

ppp_deflate             3008   0 (autoclean)
zlib_inflate           18592   0 (autoclean) [ppp_deflate]
zlib_deflate           17984   0 (autoclean) [ppp_deflate]
bsd_comp                4032   0 (autoclean)
ppp_async               6592   1 (autoclean)
hsfbasic2              95208   2 (autoclean)
hsfserial              17088   1 (autoclean)
hsfengine             856236   0 (autoclean) [hsfserial]
hsfosspec              21176   1 (autoclean) [hsfbasic2 hsfserial
hsfengine]
ppp_generic            16044   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    4704   0 (autoclean) [ppp_generic]
pwcx-i386              87104   0
pwc                    45248   0 (autoclean) [pwcx-i386]
parport_pc             25256   1 (autoclean)
lp                      6528   0 (autoclean)
parport                24992   1 (autoclean) [parport_pc lp]
rtc                     6012   0 (autoclean)
8139too                15520   1 (autoclean)
mii                     2320   0 (autoclean) [8139too]
usb-ohci               17856   0 (unused)
usbcore                61952   1 [pwc usb-ohci]
serial                 44160   0 (autoclean)
btaudio                10240   0 (unused)
tuner                   8772   1 (autoclean)
tvaudio                11296   0 (autoclean) (unused)
msp3400                14480   1 (autoclean)
bttv                   69696   0
i2c-algo-bit            7180   1 [bttv]
i2c-core               12960   0 [tuner tvaudio msp3400 bttv
i2c-algo-bit]
videodev                4000   4 [pwc bttv]
analog                  7520   0 (unused)
joydev                  6848   0 (unused)
input                   3360   0 [analog joydev]
es1371                 27040   1
soundcore               3588   7 [btaudio bttv es1371]
ac97_codec             10240   0 [es1371]
gameport                1548   0 [analog es1371]
ide-scsi                7744   0
ncr53c8xx              51744   0 (unused)
scsi_mod               83560   2 [ide-scsi ncr53c8xx]
ide-cd                 27200   0
cdrom                  29024   0 [ide-cd]
ide-floppy             11936   0

---------------------------------

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
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-d003 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller
d400-d4ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
  d400-d47f : ncr53c8xx
d800-d83f : Ensoniq 5880 AudioPCI
  d800-d83f : es1371
dc00-dcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  dc00-dcff : 8139too
e000-e007 : Rockwell International HCF 56k Data/Fax/Voice/Spkp
(w/Handset) Modem
f000-f00f : Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1

-----------------------------------

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03feffff : System RAM
  00100000-00230436 : Kernel code
  00230437-00287397 : Kernel data
03ff0000-03ff2fff : ACPI Non-volatile Storage
03ff3000-03ffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation NV11 [GeForce2 MX]
e0000000-e1ffffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation NV11 [GeForce2 MX]
e2000000-e200ffff : Rockwell International HCF 56k Data/Fax/Voice/Spkp
(w/Handset) Modem
e2010000-e2010fff : Advanced Micro Devices [AMD] AMD-756 [Viper] USB
  e2010000-e2010fff : usb-ohci
e2011000-e2011fff : Brooktree Corporation Bt878 Video Capture
  e2011000-e2011fff : bttv
e2012000-e2012fff : Brooktree Corporation Bt878 Audio Capture
  e2012000-e2012fff : btaudio
e2013000-e20130ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
e2014000-e20140ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  e2014000-e20140ff : 8139too
e2015000-e2015fff : Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller
ffff0000-ffffffff : reserved

--------------------------------------

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e2015000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d000 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP
Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA
(rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
(rev 03) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev
03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
(rev 06) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at e2010000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e2011000 (32-bit, prefetchable) [size=4K]

00:08.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e2012000 (32-bit, prefetchable) [size=4K]

00:09.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c810 (rev 23)
	Subsystem: LSI Logic / Symbios Logic (formerly NCR) 8100S
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at e2013000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at e2014000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Communication controller: Rockwell International HCF 56k
Data/Fax/Voice/Spkp (w/Handset) Modem (rev 01)
	Subsystem: Rockwell International HCF 56k Data/Fax/Voice/Spkp
(w/Handset) Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at e000 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev a1) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2830
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

-------------------------------------------------

Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: YAMAHA   Model: CRW4260          Rev: 1.0q
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IDE-CD   Model: R/RW 4x4x32      Rev: 1.4B
  Type:   CD-ROM                           ANSI SCSI revision: 02

the kernel is tainted due to the pwcx-i386 module foir the usb webcam
and the modules for the conexant softmodem driver, both do not seem to
be related to the filesystem.

below is the original oops and what ksymoops did from it.

----------------------------------


Jun  4 15:14:13 localhost kernel:  printing eip: 
Jun  4 15:14:13 localhost kernel: c012a9b3 
Jun  4 15:14:13 localhost kernel: Oops: 0000 
Jun  4 15:14:13 localhost kernel: CPU:    0 
Jun  4 15:14:13 localhost kernel: EIP:   
0010:[kmem_cache_alloc+131/224]    Tainted: PF 
Jun  4 15:14:13 localhost kernel: EFLAGS: 00010803 
Jun  4 15:14:13 localhost kernel: eax: 00400002   ebx: 43449440   ecx:
c3449000   edx: c10b8000 
Jun  4 15:14:13 localhost kernel: esi: c10b7130   edi: 00000246   ebp:
000001f0   esp: c2467e04 
Jun  4 15:14:13 localhost kernel: ds: 0018   es: 0018   ss: 0018 
Jun  4 15:14:13 localhost kernel: Process mc (pid: 1638,
stackpage=c2467000) 
Jun  4 15:14:13 localhost kernel: Stack: 00000000 c10bf9b8 c10bf9b8
c3caa000 c014494c c10b7130 000001f0 00000000 
Jun  4 15:14:14 localhost kernel:        c10bf9b8 0000e3b7 c3caa000
c0144c46 c3caa000 0000e3b7 c10bf9b8 c0176410 
Jun  4 15:14:14 localhost kernel:        c2467e74 00000000 c2467ef8
c2467e94 c2ad37c0 c0176457 c3caa000 0000e3b7 
Jun  4 15:14:14 localhost kernel: Call Trace:    [get_new_inode+28/368]
[iget4+198/224] [reiserfs_find_actor+0/32] [reiserfs_iget+39/112]
[reiserfs_find_actor+0/32] 
Jun  4 15:14:14 localhost kernel:   [reiserfs_lookup+143/208]
[real_lookup+83/192] [link_path_walk+1495/2144] [path_walk+26/32]
[path_lookup+27/48] [__user_walk+38/64] 
Jun  4 15:14:14 localhost kernel:   [sys_lstat64+25/112]
[sys_write+231/240] [system_call+51/56] 
Jun  4 15:14:14 localhost kernel: 
Jun  4 15:14:14 localhost kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75
23 8b 41 04 8b 11 89 42 04 

>>eax; 00400002 Before first symbol 
>>ebx; 43449440 Before first symbol 
>>ecx; c3449000 <_end+3152b64/4605b64> 
>>edx; c10b8000 <_end+dc1b64/4605b64> 
>>esi; c10b7130 <_end+dc0c94/4605b64> 
>>esp; c2467e04 <_end+2171968/4605b64> 

Code;  00000000 Before first symbol 
00000000 <_EIP>: 
Code;  00000000 Before first symbol 
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax 
Code;  00000004 Before first symbol 
   4:   89 41 14                  mov    %eax,0x14(%ecx) 
Code;  00000007 Before first symbol 
   7:   83 f8 ff                  cmp    $0xffffffff,%eax 
Code;  0000000a Before first symbol 
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol 
Code;  0000000c Before first symbol 
   c:   8b 41 04                  mov    0x4(%ecx),%eax 
Code;  0000000f Before first symbol 
   f:   8b 11                     mov    (%ecx),%edx 
Code;  00000011 Before first symbol 
  11:   89 42 04                  mov    %eax,0x4(%edx) 

Jun  4 15:14:14 localhost kernel:  <1>Unable to handle kernel paging
request at virtual address c4449020 
Jun  4 15:14:14 localhost kernel:  printing eip: 
Jun  4 15:14:14 localhost kernel: c012a9b3 
Jun  4 15:14:14 localhost kernel: Oops: 0000 
Jun  4 15:14:14 localhost kernel: CPU:    0 
Jun  4 15:14:14 localhost kernel: EIP:   
0010:[kmem_cache_alloc+131/224]    Tainted: PF 
Jun  4 15:14:14 localhost kernel: EFLAGS: 00010803 
Jun  4 15:14:14 localhost kernel: eax: 00400002   ebx: 43449440   ecx:
c3449000   edx: c02f38a0 
Jun  4 15:14:14 localhost kernel: esi: c10b7130   edi: 00000246   ebp:
000001f0   esp: c1949f1c 
Jun  4 15:14:14 localhost kernel: ds: 0018   es: 0018   ss: 0018 
Jun  4 15:14:14 localhost kernel: Process wmxmms (pid: 625,
stackpage=c1949000) 
Jun  4 15:14:14 localhost kernel: Stack: 00000001 00000004 c02f38a0
00000001 c01448a9 c10b7130 000001f0 00000001 
Jun  4 15:14:14 localhost kernel:        c01e7f06 00000001 c01e883d
00000001 08097eb0 0805b248 bffffb8c 00000c69 
Jun  4 15:14:14 localhost kernel:        c012ca1b c012ca3a c013f1aa
00000000 080980f0 080980e0 c013fdc4 c01e88ad 
Jun  4 15:14:14 localhost kernel: Call Trace:   
[get_empty_inode+25/160] [sock_alloc+6/192] [sock_create+173/256]
[__free_pages+27/32] [free_pages+26/32] 
Jun  4 15:14:14 localhost kernel:   [poll_freewait+58/80]
[sys_poll+724/752] [sys_socket+29/96] [sys_socketcall+99/512]
[system_call+51/56] 
Jun  4 15:14:14 localhost kernel: 
Jun  4 15:14:14 localhost kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75
23 8b 41 04 8b 11 89 42 04 

>>eax; 00400002 Before first symbol 
>>ebx; 43449440 Before first symbol 
>>ecx; c3449000 <_end+3152b64/4605b64> 
>>edx; c02f38a0 <net_families+0/80> 
>>esi; c10b7130 <_end+dc0c94/4605b64> 
>>esp; c1949f1c <_end+1653a80/4605b64> 

Code;  00000000 Before first symbol 
00000000 <_EIP>: 
Code;  00000000 Before first symbol 
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax 
Code;  00000004 Before first symbol 
   4:   89 41 14                  mov    %eax,0x14(%ecx) 
Code;  00000007 Before first symbol 
   7:   83 f8 ff                  cmp    $0xffffffff,%eax 
Code;  0000000a Before first symbol 
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol 
Code;  0000000c Before first symbol 
   c:   8b 41 04                  mov    0x4(%ecx),%eax 
Code;  0000000f Before first symbol 
   f:   8b 11                     mov    (%ecx),%edx 
Code;  00000011 Before first symbol 
  11:   89 42 04                  mov    %eax,0x4(%edx) 



