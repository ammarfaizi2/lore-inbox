Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVCBLTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVCBLTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVCBLTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:19:14 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:8964 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S262265AbVCBLPq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:15:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problems with SCSI tape rewind / verify on 2.4.29
Date: Wed, 2 Mar 2005 11:15:42 -0000
Message-ID: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with SCSI tape rewind / verify on 2.4.29
Thread-Index: AcUfGSxOM6CrNRCoQLCZQZUw3qkbKA==
From: "Mark Yeatman" <myeatman@vale-housing.co.uk>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Never had to log a bug before, hope this is correctly done.

Thanks

Mark

Detail....

[1.] One line summary of the problem:    
SCSI tape drive is refusing to rewind after backup to allow verify and
causing illegal seek error

[2.] Full description of the problem/report:
On backup the tape drive is reporting the following error and failing
it's backups.

tar: /dev/st0: Warning: Cannot seek: Illegal seek

I have traced this back to failing at an upgrade of the kernel to 2.4.29
on Feb 8th. The backups have not worked since. Replacement Drives have
been tried and cables to no avail. I noticed in the the changelog that a
patch by Solar Designer to the Scsi tape return code had been made. 

Solar Designer:
  o Fix SCSI tape driver return code

The tape appears to back up correctly but will not verify.

[3.] Keywords (i.e., modules, networking, kernel):
Solar Designer, Tape, Scsi, 2.4.29

[4.] Kernel version (from /proc/version):
Linux version 2.4.29-vs1.2.10 (root@raptor) (gcc version 3.2.3) #1 SMP
Tue Feb 8 15:55:58 UTC 2005
 
[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)
     
tar cf /dev/st0 -W -P --exclude proc --exclude dev / 1>>
/var/log/backup.log 2>>/var/log/backup.log
 
 
[7.] Environment



[7.1.] Software (add the output of the ver_linux script here)

Linux raptor 2.4.29-vs1.2.10 #1 SMP Tue Feb 8 15:55:58 UTC 2005 i686
unknown unk
nown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
stepping        : 7
cpu MHz         : 3059.270
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6107.95

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
stepping        : 7
cpu MHz         : 3059.270
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6107.95


[7.3.] Module information (from /proc/modules):
No output from here.

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a800-a8ff : Adaptec ASC-29320 U320
b000-b0ff : Adaptec ASC-29320 U320
b400-b4ff : Adaptec ASC-29320 U320 (#2)
b800-b8ff : Adaptec ASC-29320 U320 (#2)
bc00-bc3f : PCI device 8086:1050 (Intel Corp.)
  bc00-bc3f : e100
c400-c41f : Intel Corp. 82801EB SMBus Controller
c800-c81f : Intel Corp. 82801EB USB
cc00-cc1f : Intel Corp. 82801EB USB
d000-d01f : Intel Corp. 82801EB USB
d400-d41f : Intel Corp. 82801EB USB
d800-d80f : Intel Corp. 82801EB Ultra ATA Storage Controller
dc00-dc03 : Intel Corp. 82801EB Ultra ATA Storage Controller
e000-e007 : Intel Corp. 82801EB Ultra ATA Storage Controller
e400-e403 : Intel Corp. 82801EB Ultra ATA Storage Controller
e800-e807 : Intel Corp. 82801EB Ultra ATA Storage Controller
ec00-ec07 : Intel Corp. 82865G Integrated Graphics Device
ffa0-ffaf : Intel Corp. 82801EB Ultra ATA Storage Controller

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca000-000d39ff : Extension ROM
000f0000-000fffff : System ROM
00100000-7ef2fbff : System RAM
  00100000-002b9f80 : Kernel code
  002b9f81-00354667 : Kernel data
7ef2fc00-7ef2ffff : ACPI Non-volatile Storage
7ef30000-7ef3ffff : ACPI Tables
7ef40000-7efeffff : ACPI Non-volatile Storage
7eff0000-7effffff : reserved
7f000000-7f0003ff : Intel Corp. 82801EB Ultra ATA Storage Controller
f0000000-f7ffffff : Intel Corp. 82865G Integrated Graphics Device
f8000000-fbffffff : Intel Corp. 82865G/PE/P Processor to I/O Controller
fecf0000-fecf0fff : reserved
fed20000-fed9ffff : reserved
ff8fb000-ff8fbfff : PCI device 8086:1050 (Intel Corp.)
  ff8fb000-ff8fbfff : e100
ff8fc000-ff8fdfff : Adaptec ASC-29320 U320
  ff8fc000-ff8fcfff : aic79xx
ff8fe000-ff8fffff : Adaptec ASC-29320 U320 (#2)
  ff8fe000-ff8fefff : aic79xx
ffa80000-ffafffff : Intel Corp. 82865G Integrated Graphics Device


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
        Subsystem: Intel Corp.: Unknown device 2570
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [0106]

00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2572 (rev
02) (pr
og-if 00 [VGA])
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ffa80000 (32-bit, non-prefetchable)
[size=512K]
        Region 2: I/O ports at ec00 [size=8]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02)
(prog-if 00 [U
HCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at c800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02)
(prog-if 00 [U
HCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at cc00 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02)
(prog-if 00 [U
HCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]

00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02)
(prog-if 00 [U
HCI])
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d400 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2)
(prog-if 00 [N
ormal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: ff600000-ff8fffff
        Prefetchable memory behind bridge: e6a00000-e6afffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)
(prog-if 8a [Ma
ster SecP PriP])
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]
        Region 5: Memory at 7f000000 (32-bit, non-prefetchable)
[disabled] [size
=1K]

00:1f.2 IDE interface: Intel Corp.: Unknown device 24d1 (rev 02)
(prog-if 8f [Ma
ster SecP SecO PriP PriO])
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=8]
        Region 1: I/O ports at e400 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at dc00 [size=4]
        Region 4: I/O ports at d800 [size=16]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
        Subsystem: Intel Corp.: Unknown device 4246
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at c400 [size=32]

01:03.1 SCSI storage controller: Adaptec ASC-29320 U320 (rev 03)
        Subsystem: Adaptec: Unknown device 0042
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 10
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at b800 [disabled] [size=256]
        Region 1: Memory at ff8fe000 (64-bit, non-prefetchable)
[size=8K]
        Region 3: I/O ports at b400 [disabled] [size=256]
        Expansion ROM at ff800000 [disabled] [size=512K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a0] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable
-
                Address: 0000000000000000  Data: 0000
        Capabilities: [94]
01:08.0 Ethernet controller: Intel Corp.: Unknown device 1050 (rev 01)
        Subsystem: Intel Corp.: Unknown device 302f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at ff8fb000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at bc00 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot
+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: C7438A           Rev: V312
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST336732LW       Rev: 0022
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST336732LW       Rev: 0022
  Type:   Direct-Access                    ANSI SCSI revision: 03


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

No workarounds as yet, however can we back out just the patch from Solar
Designer?
