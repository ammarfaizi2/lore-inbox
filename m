Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319261AbSIKSN2>; Wed, 11 Sep 2002 14:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSIKSN2>; Wed, 11 Sep 2002 14:13:28 -0400
Received: from smtp5.wanadoo.es ([62.37.236.139]:51168 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id <S319261AbSIKSNP> convert rfc822-to-8bit;
	Wed, 11 Sep 2002 14:13:15 -0400
Subject: Bug in kernel 2.4.19?
From: Sergio Costas <raster@rastersoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 20:17:51 +0200
Message-Id: <1031768280.998.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello: 

I think I found a bug in kernel 2.4.19. I enclose all the information
you say in www.kernel.org

Bug in memory management in kernel 2.4.19 

This kernel seems to have a problem when a huge amount of memory is
allocated by a program. In my case, I work with GIMP, with a picture of
5000 x 3500 pixels. When I try to move a 'big' selection (25% or more of
the surface of the picture), my linux system simply reboots. No kernel
panic, no hangs, no popups... simply reboots after accessing a lot to
the hard disk (for memory swapping, of course). There's no problem with
kernel 2.4.18 (I changed to it after discover this), so it seems to be a
new bug. 

kernel memory management 



Linux version 2.4.19 (root@localhost.localdomain) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-85)) #3 mié sep 11 19:44:45 CEST 2002


processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 451.041
cache size	: 64 KB
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



ppp_deflate            40832   0 (autoclean)
bsd_comp                4192   0 (autoclean)
ppp_async               6720   1 (autoclean)
ppp_generic            15820   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    4608   1 (autoclean) [ppp_generic]
sr_mod                 12184   0 (autoclean)
cdrom                  27712   0 (autoclean) [sr_mod]
via82cxxx_audio        17920   1 (autoclean)
ac97_codec              9664   0 (autoclean) [via82cxxx_audio]
soundcore               3684   2 (autoclean) [via82cxxx_audio]
8139too                12992   1 (autoclean)
mii                     1104   0 (autoclean) [8139too]
ide-scsi                7808   0
scsi_mod               83192   2 [sr_mod ide-scsi]
rtc                     6332   0 (autoclean)


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
03c0-03df : sis6326fb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c07f : Silicon Integrated Systems [SiS] 86C326
d000-d00f : VIA Technologies, Inc. Bus Master IDE
dc00-dcff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  dc00-dcff : via82cxxx_audio
e000-e003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  e000-e003 : via82cxxx_audio
e400-e403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  e400-e403 : via82cxxx_audio
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  e800-e8ff : 8139too


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001d9349 : Kernel code
  001d934a-00211d7f : Kernel data
d0000000-d7ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
d8000000-d9ffffff : PCI Bus #01
  d9000000-d900ffff : Silicon Integrated Systems [SiS] 86C326
db000000-db7fffff : PCI Bus #01
  db000000-db7fffff : Silicon Integrated Systems [SiS] 86C326
    db000000-db3fffff : sis6326fb
db800000-db800fff : Brooktree Corporation Bt878
db801000-db8010ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  db801000-db8010ff : 8139too
db802000-db802fff : Brooktree Corporation Bt878
ffff0000-ffffffff : reserved



00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev
04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: db000000-db7fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 1b)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 20)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 21)
	Subsystem: VIA Technologies, Inc. AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
	Subsystem: Askey Computer Corp. MagicTView CPH060 - Video
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at db802000 (32-bit, prefetchable) [size=4K]

00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Askey Computer Corp. MagicTView CPH060 - Audio
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at db800000 (32-bit, prefetchable) [size=4K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at db801000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
86C326 (rev d2) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS6326 GUI Accelerator
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Region 0: Memory at db000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at c000 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


/proc/memimfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  263794688 147288064 116506624        0  4112384 66719744
Swap: 320745472        0 320745472
MemTotal:       257612 kB
MemFree:        113776 kB
MemShared:           0 kB
Buffers:          4016 kB
Cached:          65156 kB
SwapCached:          0 kB
Active:          24816 kB
Inactive:       100304 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       257612 kB
LowFree:        113776 kB
SwapTotal:      313228 kB
SwapFree:       313228 kB


I maintain my system updated with RedCarpet.

-- 
Nos leemos
		           RASTER

raster@rastersoft.com                   http://www.rastersoft.com

Have you tried GAG?  http://www.rastersoft.com/gageng.htm

