Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTINEQA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 00:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbTINEQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 00:16:00 -0400
Received: from [202.157.162.250] ([202.157.162.250]:33155 "EHLO
	www.resolvo.com") by vger.kernel.org with ESMTP id S262291AbTINEPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 00:15:49 -0400
Message-ID: <002101c37a76$e1795260$0201a8c0@myserver>
From: "Wong Onn Chee" <onnchee@resolvo.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: dpt_i2o module not found while compiling kernel 2.4.22
Date: Sun, 14 Sep 2003 12:13:22 +0800
Organization: Resolvo Systems Pte Ltd
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
dpt_i2o module not found at make install while compiling kernel 2.4.22 with CONFIG_SCSI_DPT_I2O=y or CONFIG_SCSI_DPT_I2O=m


[2.] Full description of the problem/report:

When CONFIG_SCSI_DPT_I2O=y or CONFIG_SCSI_DPT_I2O=m is selected, an error as shown below is encountered

"Root device is (8, 8)
Boot sector 512 bytes.
Setup is 2527 bytes.
System is 1693 kB
warning: kernel is too big for standalone boot from floppy
sh -x ./install.sh 2.4.22 bzImage /tmp/linux-2.4.22/System.map ""
+ '[' -x /root/bin/installkernel ']'
+ '[' -x /sbin/installkernel ']'
+ exec /sbin/installkernel 2.4.22 bzImage /tmp/linux-2.4.22/System.map ''
No module dpt_i2o found for kernel 2.4.22
mkinitrd failed
make[1]: *** [install] Error 1
make[1]: Leaving directory `/tmp/linux-2.4.22/arch/i386/boot'
make: *** [install] Error 2"

This error occurs even when dpt_i2o is selected as "y" not as "m".


[3.] Keywords (i.e., modules, networking, kernel):

Adaptec I2O RAID support

[4.] Kernel version (from /proc/version):

2.4.22

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Nil as it cannot be installed

[6.] A small shell script or example program which triggers the
     problem (if possible)

make install

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux www.resolvo.com 2.4.22-rc2 #1 SMP Sat Aug 9 19:04:16 SGT 2003 i686 i686 i386 GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
quota-tools            3.06.
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.368
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 s
s ht tm
bogomips        : 4784.12

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.368
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 s
s ht tm
bogomips        : 4797.23

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.368
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 s
s ht tm
bogomips        : 4797.23

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.368
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 s
s ht tm
bogomips        : 4797.23

[7.3.] Module information (from /proc/modules):

Nil

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1100-111f : Intel Corp. 82801CA/CAM SMBus Controller
2000-201f : Intel Corp. 82801CA/CAM USB (Hub #1)
2020-203f : Intel Corp. 82801CA/CAM USB (Hub #2)
2040-205f : Intel Corp. 82801CA/CAM USB (Hub #3)
2060-206f : Intel Corp. 82801CA Ultra ATA Storage Controller
3000-3fff : PCI Bus #01
  3000-3fff : PCI Bus #02
    3000-303f : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper)
      3000-303f : e1000
    3040-307f : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (#2)
      3040-307f : e1000
4000-40ff : ATI Technologies Inc Rage XL

00000000-0009e3ff : System RAM
0009e400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3feeffff : System RAM
  00100000-003bd9e6 : Kernel code
  003bd9e7-0047e843 : Kernel data
3fef0000-3fefbfff : ACPI Tables
3fefc000-3fefffff : ACPI Non-volatile Storage
3ff00000-3ff7ffff : System RAM
3ff80000-3fffffff : reserved
40000000-400003ff : Intel Corp. 82801CA Ultra ATA Storage Controller
f8100000-f83fffff : PCI Bus #01
  f8100000-f8100fff : Intel Corp. 82870P2 P64H2 I/OxAPIC
  f8101000-f8101fff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#2)
  f8200000-f82fffff : PCI Bus #02
    f8200000-f821ffff : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper)
      f8200000-f821ffff : e1000
    f8220000-f823ffff : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (#2)
      f8220000-f823ffff : e1000
  f8300000-f83fffff : PCI Bus #03
    f8300000-f83fffff : Distributed Processing Technology SmartRAID V Controller
f8400000-f8400fff : ATI Technologies Inc Rage XL
f9000000-f9ffffff : ATI Technologies Inc Rage XL
fb000000-fdffffff : PCI Bus #01
  fb000000-fdffffff : PCI Bus #03
    fb000000-fbffffff : Distributed Processing Technology SmartRAID V Controller
    fc000000-fdffffff : Distributed Processing Technology SmartRAID V Controller
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
ff800000-ffbfffff : reserved
fff00000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp.: Unknown device 254c (rev 01)
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [1105]

00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting (rev 01)
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0) (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f8100000-f83fffff
        Prefetchable memory behind bridge: fb000000-fdffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at 2000 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at 2020 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at 2040 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: f8400000-f9ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 2060 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 1100 [size=32]

01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f8200000-f82fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=4
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 3580
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=48
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f8300000-f83fffff
        Prefetchable memory behind bridge: 00000000fb000000-00000000fdf00000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
        Capabilities: [50] PCI-X non-bridge device.
                Command: DPERE+ ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
02:03.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 54
        Region 0: Memory at f8200000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at 3000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

02:03.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 08
        Interrupt: pin B routed to IRQ 55
        Region 0: Memory at f8220000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at 3040 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

03:03.0 RAID bus controller: Distributed Processing Technology SmartRAID V Controller (rev 01)
        Subsystem: Distributed Processing Technology: Unknown device c034
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 30
        BIST result: 00
        Region 0: Memory at f8300000 (32-bit, non-prefetchable) [size=1M]
        Region 1: Memory at fb000000 (32-bit, prefetchable) [size=16M]
        Region 2: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at 00095000 [disabled] [size=32K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f9000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 4000 [size=256]
        Region 2: Memory at f8400000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ADAPTEC  Model: RAID-1           Rev: 3B05
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST336607LC       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: SUPER    Model: GEM318           Rev: 0
  Type:   Processor                        ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

Applied  patch-o-matic-20030107




