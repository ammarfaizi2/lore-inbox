Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRC3Ms6>; Fri, 30 Mar 2001 07:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRC3Mst>; Fri, 30 Mar 2001 07:48:49 -0500
Received: from condor.solvo.ru ([195.201.44.91]:28164 "EHLO condor.solvo.ru")
	by vger.kernel.org with ESMTP id <S131369AbRC3Msg>;
	Fri, 30 Mar 2001 07:48:36 -0500
Date: Fri, 30 Mar 2001 16:47:41 +0400
From: leo@solvo.ru
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] 2.4.x and AMI MegaRAID 500 don't see partitions on disk
Message-ID: <20010330164741.A11865@solvo.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I also sent this mail to linux-scsi mailing list but got NO reply :(

Here is BUG report:

1. Linux kernels 2.4.x don't see partitions on my AMI MegaRAID 500 raid array.
2. I have server with MegaRAID 500 controller, 40LD BIOS v 3.11 with RAID5
   36Gb storage array. Kernels 2.4.[1, 2, 2-ac26, 3-pre8] detects my
   controller and disk normally as /dev/sda, but then it fails in
   'Partiotion check:' with message 'unknown partition table'. MSDOS
   partition support is included in the kernel. I made some quick debugging
   and saw that kernel reads zeroes from my scsi disk instead of reading
   partition table :(.
   Kernels 2.2.16 and 2.2.18, successfully reads partition table and then
   works well with megaraid. But i need 2.4 for correct SMP working.
3. drivers,scsi
4. 2.4.1, 2.4.2, 2.4.2-ac26, 2.4.3-pre8
5.
6.
7.1 
Linux invwms.invacorp 2.2.18 #2 Wed Mar 28 12:26:20 MSD 2001 i686 unknown
 
 Gnu C                  egcs-2.91.66
 Gnu make               3.78.1
 binutils               2.9.5.0.22
 util-linux             2.10f
 mount                  2.10f
 modutils               2.3.21
 e2fsprogs              1.18
 pcmcia-cs              3.1.8
 Linux C Library        2.1.3
 Dynamic linker (ldd)   2.1.3
 Procps                 2.0.6
 Net-tools              1.54
 Console-tools          0.3.3
 Sh-utils               2.0
 Modules Loaded         
7.2
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 999.785
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 psn mmx fxsr xmm
bogomips        : 1992.29
7.3
7.4
7.5
00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 set, cache line size 08

00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 08

00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
	Subsystem: Intel Corporation: Unknown device 4756
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 66 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc000000 (32-bit, prefetchable)
	Region 1: I/O ports at 5000
	Region 2: Memory at fb100000 (32-bit, non-prefetchable)
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation: Unknown device 1229
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 66 set, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fb101000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 5400
	Region 2: Memory at fb000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:08.0 RAID bus controller: American Megatrends Inc.: Unknown device 1960
	Subsystem: American Megatrends Inc.: Unknown device 0475
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fb320000 (32-bit, prefetchable)
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f)
	Subsystem: Relience Computer: Unknown device 0200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at 5440

01:04.0 SCSI storage controller: Adaptec 7899P
	Subsystem: Intel Corporation: Unknown device 00cf
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 min, 25 max, 72 set, cache line size 08
	Interrupt: pin A routed to IRQ 9
	BIST result: 00
	Region 0: I/O ports at 5800
	Region 1: Memory at fd000000 (64-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:04.1 SCSI storage controller: Adaptec 7899P
	Subsystem: Intel Corporation: Unknown device 00cf
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 min, 25 max, 72 set, cache line size 08
	Interrupt: pin B routed to IRQ 5
	BIST result: 00
	Region 0: I/O ports at 6000
	Region 1: Memory at fd001000 (64-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
7.6
Attached devices: 
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: ESG-SHV  Model: SCA HSBP M14     Rev: 0.01
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi0 Channel: 01 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID5 35000R Rev: l148
  Type:   Direct-Access                    ANSI SCSI revision: 02
7.7
Here is output from dmesg with 2.2.18 kernel:
megaraid: v1.11 (Aug 23, 2000)
megaraid: found 0x101e:0x1960:idx 0:bus 0:slot 8:func 0
scsi0 : Found a MegaRAID controller at 0xe0000000, IRQ: 9
megaraid: [l148:3.11] detected 1 logical drives
scsi0 : AMI MegaRAID l148 254 commands 16 targs 1 chans 40 luns
scsi : 1 host.
scsi0: scanning channel 1 for devices.
  Vendor: ESG-SHV   Model: SCA HSBP M14      Rev: 0.01
  Type:   Processor                          ANSI SCSI revision: 02
scsi0: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 35000R  Rev: l148
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 1, id 0, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 71680000 [35000 MB] [35.0 GB]
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 >

2.4.x kernels output the same but last 2 lines:
Partition check:
 unknown partition table
 
Please, help me.
-- 
Best regards,
Leo <leo@solvo.ru>
Solvo Ltd. 
St.Petersburg, Russia

----- End forwarded message -----

-- 
Best regards,
Leo <leo@solvo.ru>
Solvo Ltd. 
St.Petersburg, Russia
