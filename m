Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUDXUv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUDXUv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 16:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUDXUv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 16:51:27 -0400
Received: from [80.28.174.176] ([80.28.174.176]:58119 "HELO
	medusa.homeunix.net") by vger.kernel.org with SMTP id S262499AbUDXUvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 16:51:16 -0400
From: root@medusa.homeunix.net
Date: Sat, 24 Apr 2004 22:39:11 +0200
To: linux-kernel@vger.kernel.org
Subject: kernel: hdc: dma_timer_expiry: dma status == 0x20
Message-ID: <20040424203911.GA10054@sakroot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename=bug
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello i have troubles with port ide1 and my disc matrox 80gb, error dma



this is error:

Apr 22 13:03:02 MeDuSa kernel: hdc: dma_timer_expiry: dma status == 0x20
Apr 22 13:03:02 MeDuSa kernel: hdc: timeout waiting for DMA
Apr 22 13:03:02 MeDuSa kernel: hdc: timeout waiting for DMA
Apr 22 13:03:02 MeDuSa kernel: hdc: (__ide_dma_test_irq) called while
not waiting
Apr 22 13:03:02 MeDuSa kernel: hdc: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Apr 22 13:03:02 MeDuSa kernel: hdc: drive not ready for command
Apr 22 13:03:02 MeDuSa kernel: hdc: status timeout: status=0xd0 { Busy }
Apr 22 13:03:02 MeDuSa kernel: hdc: drive not ready for command
Apr 22 13:03:02 MeDuSa kernel: ide1: reset: success
Apr 24 20:25:48 MeDuSa kernel: hdc: dma_timer_expiry: dma status == 0x20
Apr 24 20:25:48 MeDuSa kernel: hdc: timeout waiting for DMA
Apr 24 20:25:48 MeDuSa kernel: hdc: timeout waiting for DMA
Apr 24 20:25:48 MeDuSa kernel: hdc: (__ide_dma_test_irq) called while
not waiting
Apr 24 20:25:48 MeDuSa kernel: hdc: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Apr 24 20:25:48 MeDuSa kernel: hdc: drive not ready for command
Apr 24 20:25:48 MeDuSa kernel: hdc: status timeout: status=0xd0 { Busy }
Apr 24 20:25:48 MeDuSa kernel: hdc: drive not ready for command
Apr 24 20:25:49 MeDuSa kernel: ide1: reset: success



info my system:

 cat /proc/version
 Linux version 2.4.24 (root@MeDuSa-C.sakroot.org) (gcc version 2.95.4
 20011002 (Debian prerelease)) #1 lun abr 19 00:17:19 CEST 2004
 


Linux MeDuSa.homeunix.net 2.4.24 #1 lun abr 19 00:17:19 CEST 2004 i586
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         ipt_multiport ipt_mac ipt_MASQUERADE iptable_nat
ip_conntrack iptable_filter ip_tables bsd_comp af_packet loop ide-cd
cdrom hostap_plx hostap hostap_crypt




cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 132.634
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 264.60





cat /proc/modules
ipt_multiport            632   2 (autoclean)
ipt_mac                  664   8 (autoclean)
ipt_MASQUERADE          1304   1 (autoclean)
iptable_nat            15672   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           17960   1 (autoclean) [ipt_MASQUERADE
iptable_nat]
iptable_filter          1668   1 (autoclean)
ip_tables              11096   7 [ipt_multiport ipt_mac ipt_MASQUERADE
iptable_nat iptable_filter]
bsd_comp                3992   0 (autoclean)
af_packet               8328   3 (autoclean)
loop                    8248   0 (autoclean)
ide-cd                 28512   0
cdrom                  27200   0 [ide-cd]
hostap_plx             43380   1
hostap                 65636   0 [hostap_plx]
hostap_crypt            1328   0 [hostap]





 cat /proc/ioports
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
 03c0-03df : vga+
 03f6-03f6 : ide0
 0cf8-0cff : PCI conf1
 6100-61ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   6100-61ff : 8139too
   6200-627f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
     6200-627f : 00:12.0
     6300-637f : Standard Microsystems Corp [SMC] SMC2602W EZConnect /
     Addtron AWA-100
     6400-643f : Standard Microsystems Corp [SMC] SMC2602W EZConnect /
     Addtron AWA-100
     6500-651f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
       6500-651f : ne2k-pci
       f000-f00f : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
         f000-f007 : ide0
	   f008-f00f : ide1



	    cat /proc/iomem
	    00000000-0009ffff : System RAM
	    000a0000-000bffff : Video RAM area
	    000c0000-000c7fff : Video ROM
	    000f0000-000fffff : System ROM
	    00100000-07ffffff : System RAM
	      00100000-002a7ce5 : Kernel code
	        002a7ce6-002fe487 : Kernel data
		e0000000-e00000ff : Realtek Semiconductor Co., Ltd.
		RTL-8139/8139C/8139C+
		  e0000000-e00000ff : 8139too
		  e0001000-e000107f : 3Com Corporation 3c900B-TPO
		  [Etherlink XL TPO]
		  e0002000-e0002fff : Standard Microsystems Corp [SMC]
		  SMC2602W EZConnect / Addtron AWA-100
		  ffff0000-ffffffff : reserved







lspci -vvv


										 
00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX [Triton VX] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6100 [size=256]
	Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
	Subsystem: 3Com Corporation 3C900B-TPO Etherlink XL TPO 10Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 12000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6200 [size=128]
	Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Network controller: Standard Microsystems Corp [SMC] SMC2602W EZConnect / Addtron AWA-100 (rev 02)
	Subsystem: Standard Microsystems Corp [SMC] SMC2602W EZConnect / Addtron AWA-100
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 1: I/O ports at 6300 [size=128]
	Region 2: Memory at e0002000 (32-bit, non-prefetchable) [size=4K]
	Region 3: I/O ports at 6400 [size=64]

00:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at 6500 [size=32]

hdparam -I /dev/hdc

/dev/hdc:

ATA device, with non-removable media
	Model Number:       Maxtor 6Y080L0                          
	Serial Number:      Y3LLPCHE            
	Firmware Revision:  YAR41BW0
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  160086528
	device size with M = 1024*1024:       78167 MBytes
	device size with M = 1000*1000:       81964 MBytes (81 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5 udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- below Vih
	Device num = 0 determined by the jumper
Checksum: correct

 cat /proc/ide/drivers
 ide-cdrom version 4.59-ac1
 ide-disk version 1.17
 ide-default version 0.9.newide




 cat /proc/ide/piix

 Controller: 0

                                 Intel PIIX3 Chipset.
				 --------------- Primary Channel ---------------- Secondary Channel -------------
				                  enabled                          enabled
						  --------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
						  DMA enabled:    yes              no              no                no
						  UDMA enabled:   no               no              no                no
						  UDMA enabled:   X                X               X                 X
						  UDMA
						  DMA
						  PIO





this is every info, if you have some troubles my mail is sakroot@medusa.homeunix.net

Thanksss¡¡¡
