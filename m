Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUIPMut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUIPMut (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUIPMut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:50:49 -0400
Received: from NS-1.e-dict.net ([62.197.1.27]:12478 "EHLO e-dict.net")
	by vger.kernel.org with ESMTP id S267971AbUIPMsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:48:51 -0400
From: "Ingo Freund" <Ingo.Freund@e-dict.net>
To: <linux-kernel@vger.kernel.org>
Subject: memory allocation error messages in system log
Date: Thu, 16 Sep 2004 14:48:40 +0200
Message-ID: <NEBBILBHKLDLOMLDGKGNEEKDCIAA.Ingo.Freund@e-dict.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hope you guys can help, I cannot use any kernel 2.4 >23 without
the here described problem.

[1.] One line summary of the problem:
strange error messages concerning memory allocation

searching teh web for solutions to my problem I have already found
a thread in a mailing list but no solution was mentioned, also the
guys who talked about the error didn't answer to my direct mail.

[2.] Full description of the problem/report:
The machine is a database server without any other service except sshd
running. I do some tests on the ICP-Vortex GDT controller every 2 minutes.
by using
# cat /proc/scsi/gdt/2
but the output of cat stops without beeing completed.

This is what I see in the syslog file every time when I use the cat
command (the messages beginn after 3 days uptime):
--> /var/log/messages
kernel: __alloc_pages: 0-order allocation failed (gfp=0x21/0)


What do you propose to do for I can get the information I need for
longer than three days without reboot? This is a highly used database
server in production environment.


[3.] Keywords (i.e., modules, networking, kernel):
kernel, memory

[4.] Kernel version (from /proc/version):
Linux version 2.4.27 (root@widbrz01) (gcc version 3.3.1

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
none

[6.] A small shell script or example program which triggers the
     problem (if possible)
see 2.


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
output from
# sh /usr/src/linux-2.4.27/scripts/ver_linux

Linux widbrz01 2.4.27 #2 SMP Wed Sep 8 11:49:24 CEST 2004 i686 i686 i386 GNU/Lin
ux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.2
xfsprogs               2.5.6
PPP                    2.4.1
isdn4k-utils           3.3
Linux C Library        x    1 root     root      1461208 Sep 24  2003 /lib/i686/
libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.606
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm
bogomips        : 3971.48

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.606
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm
bogomips        : 3984.58

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.606
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm
bogomips        : 3984.58

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1993.606
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
tm
bogomips        : 3984.58

[7.3.] Module information (from /proc/modules):
no modules loaded

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d0bff : Extension ROM
000f0000-000fffff : System ROM
00100000-7fffafff : System RAM
  00100000-00330f50 : Kernel code
  00330f51-003e5763 : Kernel data
7fffb000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
ef800000-ef801fff : LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (#2)
f0000000-f00003ff : LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (#2)
f0800000-f0801fff : LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter
f1000000-f10003ff : LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter
f1800000-f183ffff : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (#2)
  f1800000-f183ffff : e1000
f2000000-f201ffff : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (#2)
  f2000000-f201ffff : e1000
f2800000-f283ffff : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper)
  f2800000-f283ffff : e1000
f3000000-f301ffff : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper)
  f3000000-f301ffff : e1000
f4000000-f4000fff : ServerWorks OSB4/CSB5 OHCI USB Controller
  f4000000-f4000fff : usb-ohci
f4800000-f481ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
f5000000-f5000fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
f5800000-f5ffffff : PCI Bus #01
  f5800000-f5803fff : ATI Technologies Inc Rage 128 Pro Ultra TF
f6000000-f6000fff : ServerWorks CNB20HE Host Bridge
f7000000-f7003fff : ICP Vortex Computersysteme GmbH GDT 8x43RZ
f7f00000-fbffffff : PCI Bus #01
  f8000000-fbffffff : ATI Technologies Inc Rage 128 Pro Ultra TF
fc000000-fdffffff : ServerWorks CNB20HE Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
        Subsystem: ServerWorks: Unknown device 0015
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at f6000000 (32-bit, non-prefetchable) [size=4K]

00:00.1 PCI bridge: ServerWorks CNB20LE Host Bridge (rev a2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f5800000-f5ffffff
        Prefetchable memory behind bridge: 00000000f7f00000-00000000fbf00000
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
        Capabilities: [80] AGP version 0.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=1 Cal=7 SBA- AGP+ GART64- 64bit- FW- Rate=x1

00:00.2 Host bridge: ServerWorks CMIC-GC Host Bridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b800 [size=64]
        Region 2: Memory at f4800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at f7ef0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 9800 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr+ DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr+ DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF (prog-if 00 [VGA])
        Subsystem: PC Partner Limited: Unknown device 7106
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at f5800000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at f7fe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:03.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT 8x43RZ
        Subsystem: ICP Vortex Computersysteme GmbH GDT 8x43RZ
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f7000000 (32-bit, prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=32K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

12:02.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp.: Unknown device 1012
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f3000000 (64-bit, non-prefetchable) [size=128K]
        Region 2: Memory at f2800000 (64-bit, non-prefetchable) [size=256K]
        Region 4: I/O ports at 9000 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=256K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4]      Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

12:02.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp.: Unknown device 1012
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at f2000000 (64-bit, non-prefetchable) [size=128K]
        Region 2: Memory at f1800000 (64-bit, non-prefetchable) [size=256K]
        Region 4: I/O ports at 8800 [size=64]
        Expansion ROM at f6e80000 [disabled] [size=256K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4]      Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

12:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4250ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 8400 [size=256]
        Region 1: Memory at f1000000 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at f0800000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at f6e70000 [disabled] [size=16K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

12:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4250ns min, 4500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 8000 [size=256]
        Region 1: Memory at f0000000 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at ef800000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at f6e60000 [disabled] [size=16K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
cat /proc/scsi/scsi
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ICP      Model: Host Drive  #00  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 01 Lun: 00
  Vendor: ICP      Model: Host Drive  #01  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: ICP      Model: Host Drive  #02  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: ICP      Model: Host Drive  #03  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  2118139904 2074345472 43794432        0 151343104 1742090240
Swap: 6407458816 48291840 6359166976
MemTotal:      2068496 kB
MemFree:         42768 kB
MemShared:           0 kB
Buffers:        147796 kB
Cached:        1694548 kB
SwapCached:       6712 kB
Active:         223620 kB
Inactive:      1709760 kB
HighTotal:     1179628 kB
HighFree:         2080 kB
LowTotal:       888868 kB
LowFree:         40688 kB
SwapTotal:     6257284 kB
SwapFree:      6210124 kB

# cat /proc/sys/kernel/shmmax
1069547520

# cat /proc/sys/kernel/shmall
1073741824

Please let me know if there are any informations you need.
Thanks in advance for your answer,
regards
ingo.
--
// ---------------------------------------------------------------------
// e-dict GmbH & Co. KG
// Ingo Freund
// Alter Steinweg 3
// D-20459 Hamburg/Germany                E-Mail: Ingo.Freund@e-dict.net
// ---------------------------------------------------------------------

