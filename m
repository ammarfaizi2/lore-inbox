Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265755AbUFVUMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUFVUMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUFVUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:08:52 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:38063 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265118AbUFVT7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:59:06 -0400
Date: Tue, 22 Jun 2004 19:12:56 +0200
To: linux-kernel@vger.kernel.org
Subject: Deadlock when mounting cdrom (kernel 2.4.26)
Message-ID: <20040622171256.GA15178@plant.adj.org>
Reply-To: alain.didierjean@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Alain DIDIERJEAN <didierj@plant.adj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. The machine freezes when mounting a cdrom  
2. The command: mount cdrom           displays
   hdb DMA interrupt recovery
   hdb lost interrupt
   and never returns. The whole machine freezes in about half a second.
   The IDE LED stays on. Only a reset affects the machine to an unclean reboot.
   The drive is OK : I can boot from it, it works fine on a 2.4.18 kernel and
   has worked ok on a 2.4.23.
   There are no problems with the 2 ide disks.
3. kernel ide cdrom
4. 2.4.26
   Linux version 2.4.26 (root@plant) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP jeu jun 17 19:06:10 CEST 2004
5. N.A.
6. mount /cdrom
7.
7.1 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux plant 2.4.26 #1 SMP jeu jun 17 19:06:10 CEST 2004 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.12.90.0.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate zlib_deflate zlib_inflate hid ne 8390 isa-pnp input usb-uhci rtc
7.2
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 4
cpu MHz		: 267.277
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips	: 532.48

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 4
cpu MHz		: 267.277
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips	: 534.11
7.3
ppp_deflate             2944   0 (autoclean)
zlib_deflate           17536   0 (autoclean) [ppp_deflate]
zlib_inflate           18432   0 (autoclean) [ppp_deflate]
hid                    13856   0 (unused)
ne                      6656   1
8390                    6464   0 [ne]
isa-pnp                28252   0 [ne]
input                   3488   0 [hid]
usb-uhci               22148   0 (unused)
rtc                     6588   0 (autoclean)
7.4
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
0240-025f : eth0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a000-a07f : Advanced Micro Devices [AMD] 53c974 [PCscsi]
  a000-a07f : tmscsim
a400-a40f : PCI device 1283:8212 (Integrated Technology Express, Inc.)
a800-a803 : PCI device 1283:8212 (Integrated Technology Express, Inc.)
b000-b007 : PCI device 1283:8212 (Integrated Technology Express, Inc.)
b400-b403 : PCI device 1283:8212 (Integrated Technology Express, Inc.)
b800-b807 : PCI device 1283:8212 (Integrated Technology Express, Inc.)
c000-c03f : Ensoniq 5880 AudioPCI
  c000-c03f : es1371
c400-c41f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  c400-c41f : usb-uhci
c800-c80f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  c800-c807 : ide0
  c808-c80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e400-e43f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
e800-e81f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c99ff : Extension ROM
000f0000-000fffff : System ROM
00100000-17ffcfff : System RAM
  00100000-0027e9e5 : Kernel code
  0027e9e6-00323cff : Kernel data
17ffd000-17ffefff : ACPI Tables
17fff000-17ffffff : ACPI Non-volatile Storage
ce000000-cedfffff : PCI Bus #01
  ce000000-ce000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
cef00000-cfffffff : PCI Bus #01
  cf000000-cfffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
d0000000-dfffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
7.5
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
		Latency: 64
		Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
		Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
		Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64
		Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
		I/O behind bridge: 0000d000-0000dfff
		Memory behind bridge: ce000000-cedfffff
		Prefetchable memory behind bridge: cef00000-cfffffff
		BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
		Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32
		Region 4: I/O ports at c800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32
		Interrupt: pin D routed to IRQ 9
		Region 4: I/O ports at c400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
		Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
		Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
		Latency: 32 (3000ns min, 32000ns max)
		Interrupt: pin A routed to IRQ 9
		Region 0: I/O ports at c000 [size=64]
		Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 RAID bus controller: Integrated Technology Express, Inc.: Unknown device 8212 (rev 11)
		Subsystem: Integrated Technology Express, Inc.: Unknown device 0001
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 0 (2000ns min, 2000ns max)
		Interrupt: pin A routed to IRQ 5
		Region 0: I/O ports at b800 [size=8]
		Region 1: I/O ports at b400 [size=4]
		Region 2: I/O ports at b000 [size=8]
		Region 3: I/O ports at a800 [size=4]
		Region 4: I/O ports at a400 [size=16]
		Expansion ROM at <unassigned> [disabled] [size=128K]
		Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 10)
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping+ SERR+ FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 32 (1000ns min, 10000ns max)
		Interrupt: pin A routed to IRQ 10
		Region 0: I/O ports at a000 [size=128]
		Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
		Subsystem: ATI Technologies Inc 3D Rage Pro AGP 1X/2X
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64 (2000ns min), cache line size 08
		Region 0: Memory at cf000000 (32-bit, prefetchable) [size=16M]
		Region 1: I/O ports at d800 [size=256]
		Region 2: Memory at ce000000 (32-bit, non-prefetchable) [size=4K]
		Expansion ROM at cefe0000 [disabled] [size=128K]
		Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
7.6
Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DSAS-3540        Rev: S47W
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: QUANTUM  Model: TRB850S          Rev: 0404
  Type:   Direct-Access                    ANSI SCSI revision: 02
7.7
cat /proc/ide/ide0/hdb/identify
85a0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 5531
3049 2020 2020 4344 2d52 4f4d 2033 3658
2f41 4b55 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0f00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0107
0003 0078 0096 00e3 0078 0000 0000 0000
0000 0002 0009 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0107 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

Enjoy !

-- 
 
 Alain DIDIERJEAN

	Ces mystères nous dépassent...
	...feignons d'en être l'organisateur
				  J C
