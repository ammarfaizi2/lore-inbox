Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131448AbQKAQJR>; Wed, 1 Nov 2000 11:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131462AbQKAQJI>; Wed, 1 Nov 2000 11:09:08 -0500
Received: from dm3cn8.bell.ca ([198.235.69.145]:57613 "HELO dm3cn8.bell.ca")
	by vger.kernel.org with SMTP id <S131448AbQKAQIz>;
	Wed, 1 Nov 2000 11:08:55 -0500
X-Server-Uuid: b85f21a3-cfd1-11d3-8401-00104bf46ab7
Message-ID: <3A00400D.4981E278@bell.ca>
Date: Wed, 01 Nov 2000 11:08:45 -0500
From: "Jean-Francois Patenaude" <jf.patenaude@bell.ca>
Organization: Bell Canada
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel panic while copying files
X-WSS-ID: 161E9F85169666-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:    

kernel panic while copying files


[2.] Full description of the problem/report:

When I copy a 450 MB file from one partition (/usr) to another (/tmp) I
get a kernel panic.  It happens everytime I copy that file.  The amount
of data copied before the kernel panic is not always the same.   These
two partitions use ext2fs.


[3.] Keywords (i.e., modules, networking, kernel):

xx


[4.] Kernel version (from /proc/version):

The problem happens with kernel 2.4.0-test{1,5,8,9}
and it doesn't happen with kernel 2.2.{14,17}

I would like to use newer kernels since I want to add XFS support (SGI's
filesystem).  Although I must specify that my problems are happening
even with kernel that have not had the XFS patch applied.


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

xx


[6.] A small shell script or example program which triggers the
     problem (if possible)

cp /usr/blah1 /tmp


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

THIS IS THE OUTPUT WHEN I BOOT THE "WORKING KERNEL" (2.2.17)

[root@csrc228 linux]# sh scripts/ver_linux 
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux csrc228 2.2.17 #1 Wed Nov 1 10:03:58 EST 2000 i686 unknown
Kernel modules         2.3.10-pre1
Gnu C                  egcs-2.91.66
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         
[root@csrc228 linux]# 


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 499.889
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr xmm
bogomips        : 996.15


[7.3.] Module information (from /proc/modules):

no modules loaded


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
2000-207f : sym53c8xx
2400-247f : sym53c8xx
4000-401f : Intel Speedo3 Ethernet
4020-403f : Intel Speedo3 Ethernet


[7.5.] PCI information ('lspci -vvv' as root)

00:0b.0 PCI Hot-plug controller: Compaq Computer Corporation: Unknown
device a0f7 (rev 04)
        Subsystem: Compaq Computer Corporation: Unknown device a2f8
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c6af0000 (32-bit, non-prefetchable)

00:0c.0 System peripheral: Compaq Computer Corporation: Unknown device
a0f0
        Subsystem: Compaq Computer Corporation: Unknown device b0f3
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 1800
        Region 1: Memory at c6ae0000 (32-bit, non-prefetchable)

00:0d.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 14)
        Subsystem: Compaq Computer Corporation Embedded Ultra Wide SCSI
Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 17 min, 64 max, 255 set, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 2000
        Region 1: Memory at c6ad0000 (32-bit, non-prefetchable)
        Region 2: Memory at c6ac0000 (32-bit, non-prefetchable)

00:0d.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 14)
        Subsystem: Compaq Computer Corporation Embedded Ultra Wide SCSI
Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 17 min, 64 max, 255 set, cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2400
        Region 1: Memory at c6ab0000 (32-bit, non-prefetchable)
        Region 2: Memory at c6aa0000 (32-bit, non-prefetchable)

00:0e.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
215IIC [Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 4756
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Region 0: Memory at c5000000 (32-bit, prefetchable)
        Region 1: I/O ports at 2800
        Region 2: Memory at c6a90000 (32-bit, non-prefetchable)
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:0f.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at 2c00

00:0f.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at 2c20

00:0f.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:10.0 Host bridge: Intel Corporation 450NX - 82451NX Memory & I/O
Controller (rev 03)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:12.0 Host bridge: Intel Corporation 450NX - 82454NX PCI Expander
Bridge (rev 04)
        Subsystem: Intel Corporation: Unknown device 84cb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set, cache line size 08

00:14.0 Host bridge: Intel Corporation 450NX - 82454NX PCI Expander
Bridge (rev 04)
        Subsystem: Intel Corporation: Unknown device 84cb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set, cache line size 08

04:01.0 PCI bridge: IBM IBM27-82351 (rev 07) (prog-if 00 [Normal
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 set, cache line size 08
        Bus: primary=04, secondary=05, subordinate=05, sec-latency=248
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: c6d00000-c6dfffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

04:02.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set, cache line size 08
        Bus: primary=04, secondary=06, subordinate=06, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: c6e00000-c6ffffff
        Prefetchable memory behind bridge:
00000000c6b00000-00000000c6b00000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:0b.0 PCI Hot-plug controller: Compaq Computer Corporation: Unknown
device a0f7 (rev 04)
        Subsystem: Compaq Computer Corporation: Unknown device a2f8
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c6cf0000 (32-bit, non-prefetchable)

05:00.0 Unknown mass storage controller: Compaq Computer Corporation
Smart-2/P RAID Controller (rev 04)
        Subsystem: Compaq Computer Corporation Smart Array Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 3000
        Region 1: Memory at c6df0000 (32-bit, non-prefetchable)

06:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 05)
        Subsystem: Compaq Computer Corporation NC3131
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at c6bf0000 (32-bit, prefetchable)
        Region 1: I/O ports at 4000
        Region 2: Memory at c6f00000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 05)
        Subsystem: Compaq Computer Corporation NC3131
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at c6be0000 (32-bit, prefetchable)
        Region 1: I/O ports at 4020
        Region 2: Memory at c6e00000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: QUANTUM  Model: DLT8000          Rev: 0119
  Type:   Sequential-Access                ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem

- The machine is a Compaq Proliant which has a RAID array (SMART2).

[root@csrc228 /proc]# free
             total       used       free     shared    buffers    
cached
Mem:       1296208     154624    1141584       8732     124276      
6228
-/+ buffers/cache:      24120    1272088
Swap:       526312          0     526312
[root@csrc228 /proc]# 


[X.] Other notes, patches, fixes, workarounds:




-- 
/\/\/\/\/\/\/\/
Jean-Francois Patenaude
MGR EXPERT. CTRE CLIENTS SERV. / DIR. CTRE EXP. SERVICE CLIENTS
700 DE LA GAUCHETIERE OUEST  RC-MEZ  MONTREAL (QUEBEC)  H3B 4L1
Tel: (514) 870-3190   Fax: (514) 391-8660   Pag: (514) 330-4479
/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/  jf.patenaude@bell.ca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
