Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTE1AUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTE1AUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:20:16 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:27332 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S264459AbTE1AUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:20:04 -0400
Date: Tue, 27 May 2003 17:33:16 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: problem: 2.4.21-rc5 IDE problems
Message-ID: <Pine.LNX.4.33.0305271714120.27837-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The HPT366/374 driver looks much better in rc5- the machine actually boots
without errors.

However, after a few minutes of disk activity, the machine still dies.  
It seems to either hang, start spitting out random garbage on the console
and hang, or just loop with lost interrupt errors.  There's never an oops.

machine config:
SMP 2.4G Xeon, 2G memory
2 x Highpoint 1542 controllers, 4 disks each

May 27 15:46:18 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:46:18 nfs2 kernel:
May 27 15:46:18 nfs2 kernel: hdq: drive not ready for command
May 27 15:46:18 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:46:18 nfs2 kernel:
May 27 15:46:18 nfs2 kernel: hdq: drive not ready for command
May 27 15:46:18 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:46:18 nfs2 kernel:
May 27 15:46:18 nfs2 kernel: hdq: drive not ready for command
May 27 15:46:18 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:46:18 nfs2 kernel:    
May 27 15:46:18 nfs2 kernel: hdq: DMA disabled
May 27 15:46:18 nfs2 kernel: hdq: drive not ready for command
May 27 15:46:18 nfs2 kernel: ide8: reset: success
May 27 15:46:18 nfs2 kernel: hdq: multwrite_intr: status=0x00 { }
May 27 15:46:18 nfs2 kernel: 
May 27 15:46:18 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:46:18 nfs2 kernel: 
May 27 15:46:18 nfs2 kernel: hdq: drive not ready for command
May 27 15:46:18 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:46:18 nfs2 kernel: 
May 27 15:46:18 nfs2 kernel: hdq: drive not ready for command
May 27 15:46:18 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:46:18 nfs2 kernel: 
May 27 15:46:18 nfs2 kernel: hdq: drive not ready for command
May 27 15:46:18 nfs2 kernel: ide8: reset: success
May 27 15:46:28 nfs2 kernel: hdq: lost interrupt
May 27 15:46:38 nfs2 kernel: hdi: dma_timer_expiry: dma status == 0x21
May 27 15:46:38 nfs2 kernel: hdq: lost interrupt
May 27 15:46:48 nfs2 kernel: hdi: timeout waiting for DMA
May 27 15:46:48 nfs2 kernel: hdi: timeout waiting for DMA
May 27 15:46:48 nfs2 kernel: hdi: (__ide_dma_test_irq) called while not waiting
May 27 15:46:53 nfs2 kernel: hdi: status timeout: status=0xfc { Busy }
May 27 15:46:53 nfs2 kernel:  
May 27 15:46:53 nfs2 kernel: hdi: drive not ready for command 
May 27 15:46:53 nfs2 kernel: hdq: lost interrupt
May 27 15:46:53 nfs2 kernel: ide4: reset: master: error (0x0a?)
May 27 15:49:59 nfs2 kernel: hdi: status timeout: status=0xfc { Busy }
May 27 15:49:59 nfs2 kernel:  
May 27 15:49:59 nfs2 kernel: hdi: drive not ready for command 
May 27 15:49:59 nfs2 kernel: ide4: reset: master: error (0x0a?)
May 27 15:49:59 nfs2 kernel: blk: queue c0371ab0, I/O limit 4095Mb (mask 0xffffffff)
May 27 15:49:59 nfs2 kernel: end_request: I/O error, dev 38:01 (hdi), sector 152
May 27 15:49:59 nfs2 kernel: end_request: I/O error, dev 38:01 (hdi), sector 154
May 27 15:49:59 nfs2 kernel: hdq: lost interrupt
May 27 15:49:59 nfs2 last message repeated 16 times
May 27 15:49:59 nfs2 kernel: hdq: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: drive not ready for command
May 27 15:49:59 nfs2 kernel: hdq: lost interrupt
May 27 15:49:59 nfs2 kernel: hdq: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: drive not ready for command
May 27 15:49:59 nfs2 kernel: hdq: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: drive not ready for command
May 27 15:49:59 nfs2 kernel: hdq: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: drive not ready for command
May 27 15:49:59 nfs2 kernel: hdq: write_intr error1: nr_sectors=50, stat=0x00
May 27 15:49:59 nfs2 kernel: hdq: write_intr: status=0x00 { }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: drive not ready for command
May 27 15:49:59 nfs2 kernel: hdq: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: drive not ready for command
May 27 15:49:59 nfs2 kernel: hdq: status error: status=0x00 { }
May 27 15:49:59 nfs2 kernel:
May 27 15:49:59 nfs2 kernel: hdq: drive not ready for command
May 27 15:49:59 nfs2 kernel: ide8: reset: success
May 27 15:50:09 nfs2 kernel: hdq: lost interrupt





.config info:
#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_ISAPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA100=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_RZ1000=y


/proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2399.358
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 4784.12

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 7
cpu MHz		: 2399.358
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 4797.23


head -2 /proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
	Mem:  2118705152 51834880 2066870272        0  9859072 18931712



lspci -v:
00:00.0 Host bridge: Intel Corp.: Unknown device 254c (rev 01)
	Subsystem: Super Micro Computer Inc: Unknown device 3480
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] #09 [1105]

00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting (rev 01)
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0) (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc100000-fc2fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F0) (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
	I/O behind bridge: 00004000-00005fff
	Memory behind bridge: fc300000-fc3fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fc400000-fdffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 2060 [size=16]
	Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: fc200000-fc2fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
03:02.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
	Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at fc200000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:02.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
	Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 08
	Interrupt: pin B routed to IRQ 29
	Region 0: Memory at fc220000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 3040 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

04:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc300000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=48
	I/O behind bridge: 00004000-00004fff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Super Micro Computer Inc P4DP6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc301000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
04:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=04, secondary=06, subordinate=06, sec-latency=48
	I/O behind bridge: 00005000-00005fff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
05:02.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 100
	Region 0: I/O ports at 4810 [size=8]
	Region 1: I/O ports at 4804 [size=4]
	Region 2: I/O ports at 4808 [size=8]
	Region 3: I/O ports at 4800 [size=4]
	Region 4: I/O ports at 4000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:02.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 100
	Region 0: I/O ports at 4828 [size=8]
	Region 1: I/O ports at 481c [size=4]
	Region 2: I/O ports at 4820 [size=8]
	Region 3: I/O ports at 4818 [size=4]
	Region 4: I/O ports at 4400 [size=256]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:01.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 72
	Region 0: I/O ports at 5810 [size=8]
	Region 1: I/O ports at 5804 [size=4]
	Region 2: I/O ports at 5808 [size=8]
	Region 3: I/O ports at 5800 [size=4]
	Region 4: I/O ports at 5000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:01.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 72
	Region 0: I/O ports at 5828 [size=8]
	Region 1: I/O ports at 581c [size=4]
	Region 2: I/O ports at 5820 [size=8]
	Region 3: I/O ports at 5818 [size=4]
	Region 4: I/O ports at 5400 [size=256]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 6000 [size=256]
	Region 2: Memory at fc400000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



