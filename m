Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbRGRVRg>; Wed, 18 Jul 2001 17:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbRGRVR1>; Wed, 18 Jul 2001 17:17:27 -0400
Received: from Odin.AC.HMC.Edu ([134.173.32.75]:9605 "EHLO odin.ac.hmc.edu")
	by vger.kernel.org with ESMTP id <S267930AbRGRVRV>;
	Wed, 18 Jul 2001 17:17:21 -0400
Date: Wed, 18 Jul 2001 14:15:28 -0700 (PDT)
From: chahast+lkml@pangaea.dhs.org
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel 2.4.6 consintantly freezes
Message-ID: <Pine.LNX.4.21.0107181408300.803-100000@pangaea.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: me with any replies, as I am not subscribed to the LKML.

thanks,

--charles hastings
  chahast+lkml@pangaea.DHS.org
  http://pangaea.DHS.org/



[1.] One line summary of the problem:

Kernel 2.4.6 consistantly freezes after < 36 hours of usage.



[2.] Full description of the problem/report:

After anywhere between four and about 36 hours of use, my entire system 
freezes.  The sound card ends up stuck in a loop, playing either the last 
~.25s of audio repeatedly (like a skipping record) or a emitting a 
high-pitched tone.

Because of this symptom, I initially thought the problem was with the
es1371 driver.  It seems to happen more with xmms than mpg123, but just 
recently occured when neither program was running.

A serial console outputs nothing, and SysRq on that console doesn't work.
Power cycling is necessary to bring the system back up.



[3.] Keywords (i.e., modules, networking, kernel):

kernel, freeze, es1371, sound, multilink



[4.] Kernel version (from /proc/version):

Linux version 2.4.6 (root@pangaea) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #11 SMP Wed Jul 11 19:46:05 PDT 2001



[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

n/a

(Please let me know if there are other things I can do to obtain debugging
info.  It's very frustrating because I lose all useful info when I reboot.)



[6.] A small shell script or example program which triggers the
     problem (if possible)

n/a



[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux pangaea 2.4.6 #11 SMP Wed Jul 11 19:46:05 PDT 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.77
binutils               2.9.1.0.25
usage: fdformat [ -n ] device
mount                  2.9v
modutils               2.4.6
e2fsprogs              1.15
pcmcia-cs              3.1.25
Linux C Library        2.1.3
ldd: version 1.9.9
Procps                 2.0.2
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         es1371 ac97_codec smbfs ncpfs tvaudio bttv
i2c-algo-bit videodev tuner i2c-core ide-scsi sg sr_mod cdrom ne2k-pci 8390
ppp_async ppp_generic slhc



[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.916
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 799.53

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 1
cpu MHz         : 400.916
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 801.17



[7.3.] Module information (from /proc/modules):

es1371                 31952   0 (unused)
ac97_codec              8720   0 [es1371]
smbfs                  35760   0 (unused)
ncpfs                  31248   0 (unused)
tvaudio                 8688   1 (autoclean)
bttv                   58384   0 (unused)
i2c-algo-bit            7296   1 [bttv]
videodev                3648   2 [bttv]
tuner                   4672   1
i2c-core               12912   0 [tvaudio bttv i2c-algo-bit tuner]
ide-scsi                7808   0
sg                     22528   0 (unused)
sr_mod                 11984   0 (unused)
cdrom                  28384   0 [sr_mod]
ne2k-pci                5472   1
8390                    6800   0 [ne2k-pci]
ppp_async               6864   2
ppp_generic            21136   6 [ppp_async]
slhc                    4896   0 [ppp_generic]



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports

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
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
c000-cfff : PCI Bus #01
d000-d01f : Intel Corporation 82371AB PIIX4 USB
d400-d43f : Ensoniq ES1371 [AudioPCI-97]
  d400-d43f : es1371
d800-d807 : Siig Inc CyberSerial (2-port) 16550
  d800-d807 : serial(auto)
dc00-dc07 : Siig Inc CyberSerial (2-port) 16550
  dc00-dc07 : serial(auto)
e000-e01f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  e000-e01f : ne2k-pci
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-0020229b : Kernel code
  0020229c-00266cff : Kernel data
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e7ffffff : PCI Bus #01
  e5000000-e57fffff : Texas Instruments TVP4020 [Permedia 2]
  e5800000-e5ffffff : Texas Instruments TVP4020 [Permedia 2]
  e6000000-e601ffff : Texas Instruments TVP4020 [Permedia 2]
e8000000-e8000fff : Brooktree Corporation Bt848 TV with DMA push
  e8000000-e8000fff : bttv



[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03
)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 64 set
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=31 SBA+ AGP- 64bit- FW- Rate=21

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e7ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if
80)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at f000

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d000

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:08.0 Multimedia audio controller: Ensoniq ES1371 (rev 08)
        Subsystem: Unknown device 1274:1371
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 12 min, 128 max, 64 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2+ PME-
                Status: D2 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia video controller: Brooktree Corporation Bt848 (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 16 min, 40 max, 64 set
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at e8000000 (32-bit, prefetchable)

00:0a.0 Serial controller: Siig Inc: Unknown device 2030 (prog-if 02)
        Subsystem: Unknown device 131f:2030
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d800
        Region 1: I/O ports at dc00
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8029
        Subsystem: Unknown device 10ec:8029
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000

01:00.0 Display controller: Texas Instruments TVP4020 [Permedia 2] (rev 01)
        Subsystem: Unknown device 1092:0154
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 192 min, 192 max, 64 set
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e6000000 (32-bit, non-prefetchable)
        Region 1: Memory at e5800000 (32-bit, non-prefetchable)
        Region 2: Memory at e5000000 (32-bit, non-prefetchable)
        Capabilities: [40] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=1
                Command: RQ=31 SBA+ AGP- 64bit- FW- Rate=1



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: 23.D
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: RICOH    Model: CD-R/RW RW7040A  Rev: 1.1j
  Type:   CD-ROM                           ANSI SCSI revision: 02



[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Multilink PPP is enabled in the kernel, as is serial IRQ sharing.  I have a
multilink account and use it continuously.



[X.] Other notes, patches, fixes, workarounds:

n/a




