Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSHBSHA>; Fri, 2 Aug 2002 14:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSHBSHA>; Fri, 2 Aug 2002 14:07:00 -0400
Received: from earth.willamette.edu ([158.104.100.101]:30090 "EHLO
	earth.willamette.edu") by vger.kernel.org with ESMTP
	id <S316322AbSHBSGx>; Fri, 2 Aug 2002 14:06:53 -0400
Message-ID: <3D4ACB04.5080102@willamette.edu>
Date: Fri, 02 Aug 2002 11:10:12 -0700
From: Salvador Peralta <speralta@willamette.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, bhcompile@daffy.perf.redhat.com,
       mspalti@willamette.edu
Subject: Problem: Assertion Failure in journal_commit_transaction
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1:  Assertion Failure in journal_commit_transaction
2:  8:02 AM PST, system lost all console and network i/o.  Error message 
on console included:  Assertion Failure in journal_commit_transaction
buffer_jdirty(bh).
3:  kernel
4:  Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc 
version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 
07:27:31 EDT 2002

5:
Aug  2 08:02:21 info-3 kernel: ------------[ cut here ]------------
Aug  2 08:02:21 info-3 kernel: kernel BUG at commit.c:535!
Aug  2 08:02:21 info-3 kernel: invalid operand: 0000
Aug  2 08:02:21 info-3 kernel: nls_iso8859-1 ide-cd cdrom vfat fat nfsd 
lockd sunrpc soundcore e1000 usb-ohci
Aug  2 08:02:21 info-3 kernel: CPU:    0
Aug  2 08:02:21 info-3 kernel: EIP:    0010:[<f88560e4>]    Tainted: P
Aug  2 08:02:21 info-3 kernel: EFLAGS: 00010286
Aug  2 08:02:21 info-3 kernel:
Aug  2 08:02:21 info-3 kernel: EIP is at journal_commit_transaction 
[jbd] 0xb04 (2.4.18-3smp)
Aug  2 08:02:21 info-3 kernel: eax: 0000001c   ebx: 0000000a   ecx: 
c02eee60   edx: 00003c59
Aug  2 08:02:21 info-3 kernel: esi: d7381c70   edi: f4b9bec0   ebp: 
f6c38000   esp: f6c39e78
Aug  2 08:02:21 info-3 kernel: ds: 0018   es: 0018   ss: 0018
Aug  2 08:02:21 info-3 kernel: Process kjournald (pid: 192, 
stackpage=f6c39000)
Aug  2 08:02:21 info-3 kernel: Stack: f885ceee 00000217 c91fc010 
00000000 00000f84 cd6a907c 00000000 d45c31e0
Aug  2 08:02:21 info-3 kernel:        d1e87190 00001f99 f7791a40 
f882ad2f f77f1a00 00000040 de4ffce0 f6e66860
Aug  2 08:02:21 info-3 kernel:        f6e666e0 f6e667a0 f6e66740 
f6e66260 f6e662c0 f6e669e0 f6e66980 f6e66140
Aug  2 08:02:21 info-3 kernel: Call Trace: [<f885ceee>] .rodata.str1.1 
[jbd] 0x26e
Aug  2 08:02:21 info-3 kernel: [<f882ad2f>] rw_intr [sd_mod] 0x20f
Aug  2 08:02:21 info-3 kernel: [<c0120f3b>] do_softirq [kernel] 0x7b
Aug  2 08:02:21 info-3 kernel: [<c010a77f>] do_IRQ [kernel] 0xdf
Aug  2 08:02:21 info-3 kernel: [<c011a612>] .text.lock.sched [kernel] 0x78
Aug  2 08:02:22 info-3 kernel: [<f88587d6>] kjournald [jbd] 0x136
Aug  2 08:02:22 info-3 kernel: [<f8858680>] commit_timeout [jbd] 0x0
Aug  2 08:02:22 info-3 kernel: [<c0107286>] kernel_thread [kernel] 0x26
Aug  2 08:02:22 info-3 kernel: [<f88586a0>] kjournald [jbd] 0x0
Aug  2 08:02:22 info-3 kernel:
Aug  2 08:02:22 info-3 kernel:
Aug  2 08:02:22 info-3 kernel: Code: 0f 0b 5a 59 6a 04 8b 44 24 18 50 56 
e8 4b f1 ff ff 8d 47 48
6:  Cannot duplicate problem:  Production environment.  Error occured 
while using networked application running jdk1.3.1_03 ( may be unreleated )
7.1  ver_linux Not included in Redhat kernel tools package.  Did not 
download source with original distribution. Version is redhat package 
kernel-smp-2.4.18-3

7.2  /proc/cpuinfo
processor 
: 0
vendor_id 
: GenuineIntel
cpu family	: 6
model 
	: 11
model name	: Intel(R) Pentium(R) III CPU family      1133MHz
stepping 
: 1
cpu MHz		: 1129.791
cache size	: 512 KB
fdiv_bug 
: no
hlt_bug 
	: no
f00f_bug 
: no
coma_bug 
: no
fpu 
	: yes
fpu_exception 
: yes
cpuid level	: 2
wp 
	: yes
flags 
	: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 
mmx fxsr sse
bogomips 
: 2254.43

processor 
: 1
vendor_id 
: GenuineIntel
cpu family	: 6
model 
	: 11
model name	: Intel(R) Pentium(R) III CPU family      1133MHz
stepping 
: 1
cpu MHz		: 1129.791
cache size	: 512 KB
fdiv_bug 
: no
hlt_bug 
	: no
f00f_bug 
: no
coma_bug 
: no
fpu 
	: yes
fpu_exception 
: yes
cpuid level	: 2
wp 
	: yes
flags 
	: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 
mmx fxsr sse
bogomips 
: 2254.43

7.3:  /proc/modules
e1000                  57508   1
usb-ohci               21600   0 (unused)
usbcore                77024   1 [usb-ohci]
ext3                   70752   4
jbd                    53632   4 [ext3]
aic7xxx               125440   5
sd_mod                 12896  10
scsi_mod              112272   2 [aic7xxx sd_mod]

7.4 /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ServerWorks CSB5 IDE Controller
   0170-0177 : ide1
01f0-01f7 : ServerWorks CSB5 IDE Controller
0376-0376 : ServerWorks CSB5 IDE Controller
   0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ServerWorks CSB5 IDE Controller
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b800-b8ff : ATI Technologies Inc Rage XL
d000-d0ff : Adaptec 7899P
d400-d41f : Intel Corp. 82544EI Gigabit Ethernet Controller
d800-d8ff : Adaptec 7899P (#2)
e800-e81f : Intel Corp. 82544EI Gigabit Ethernet Controller (#2)
ffa0-ffaf : ServerWorks CSB5 IDE Controller
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1
fff0-fff3 : ServerWorks CSB5 IDE Controller

7.4.1  /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000c9800-000ca7ff : Extension ROM
000ca800-000cfbff : Extension ROM
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-002342b0 : Kernel code
   002342b1-00306b3f : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe7fe000-fe7fefff : ServerWorks OSB4/CSB5 OHCI USB Controller
   fe7fe000-fe7fefff : usb-ohci
fe7ff000-fe7fffff : ATI Technologies Inc Rage XL
fe980000-fe99ffff : Intel Corp. 82544EI Gigabit Ethernet Controller
fe9a0000-fe9bffff : Intel Corp. 82544EI Gigabit Ethernet Controller
   fe9a0000-fe9bffff : e1000
fe9fe000-fe9fefff : Adaptec 7899P
   fe9fe000-fe9fefff : aic7xxx
fe9ff000-fe9fffff : Adaptec 7899P (#2)
   fe9ff000-fe9fffff : aic7xxx
feb80000-febbffff : Intel Corp. 82544EI Gigabit Ethernet Controller (#2)
febe0000-febfffff : Intel Corp. 82544EI Gigabit Ethernet Controller (#2)
   febe0000-febfffff : e1000
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved
7.5
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64, cache line size 08

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc Rage XL
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min), cache line size 04
         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: I/O ports at b800 [size=256]
         Region 2: Memory at fe7ff000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at fe7c0000 [disabled] [size=128K]
         Capabilities: [5c] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
         Subsystem: ServerWorks CSB5 South Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 
8a [Master SecP PriP])
         Subsystem: ServerWorks: Unknown device 0220
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 08
         Region 0: I/O ports at 01f0 [size=8]
         Region 1: I/O ports at 03f4
         Region 2: I/O ports at 0170 [size=8]
         Region 3: I/O ports at 0374
         Region 4: I/O ports at ffa0 [size=16]
         Region 5: I/O ports at fff0 [size=4]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05) 
(prog-if 10 [OHCI])
         Subsystem: ServerWorks OSB4/CSB5 USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (20000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at fe7fe000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: ServerWorks: Unknown device 0230
         Subsystem: ServerWorks: Unknown device 0230
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 10

01:02.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
         Subsystem: Adaptec AIC-7899P U160/m
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (10000ns min, 6250ns max), cache line size 04
         Interrupt: pin A routed to IRQ 29
         BIST result: 00
         Region 0: I/O ports at d000 [disabled] [size=256]
         Region 1: Memory at fe9fe000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at fe940000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
         Subsystem: Adaptec AIC-7899P U160/m
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (10000ns min, 6250ns max), cache line size 04
         Interrupt: pin B routed to IRQ 30
         BIST result: 00
         Region 0: I/O ports at d800 [disabled] [size=256]
         Region 1: Memory at fe9ff000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at fe9c0000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:04.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet 
Controller (rev 02)
         Subsystem: Intel Corp. PRO/1000 XT Server Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (63750ns min), cache line size 04
         Interrupt: pin A routed to IRQ 25
         Region 0: Memory at fe9a0000 (32-bit, non-prefetchable) [size=128K]
         Region 1: Memory at fe980000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at d400 [size=32]
         Expansion ROM at fe960000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device.
                 Command: DPERE- ERO+ RBC=0 OST=0
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

02:02.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet 
Controller (rev 02)
         Subsystem: QUANTA Computer Inc: Unknown device 891b
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (63750ns min), cache line size 04
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at febe0000 (32-bit, non-prefetchable) [size=128K]
         Region 1: Memory at feb80000 (32-bit, non-prefetchable) [size=256K]
         Region 2: I/O ports at e800 [size=32]
         Expansion ROM at feb40000 [disabled] [size=256K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device.
                 Command: DPERE- ERO+ RBC=0 OST=0
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
7.6
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: SEAGATE  Model: ST336706LC       Rev: 010A
   Type:   Direct-Access                    ANSI SCSI revision: 03
[root@info-3 src]#

-- 
Salvador Peralta                -o)
Systems Administrator           / \
Mark O. Hatfield Library       _\_v
Willamette University     ^^^^^^^^^^^^^

E-mail 	speralta@willamette.edu
Phone 
503.375.5332
Fax 
503.370.6141



