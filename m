Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRHTT27>; Mon, 20 Aug 2001 15:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268924AbRHTT2k>; Mon, 20 Aug 2001 15:28:40 -0400
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:21144 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268916AbRHTT23>; Mon, 20 Aug 2001 15:28:29 -0400
Message-ID: <3B816617.F5C1CD24@wanadoo.fr>
Date: Mon, 20 Aug 2001 21:33:43 +0200
From: Pierre JUHEN <pierre.juhen@wanadoo.fr>
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: fr, French, en
MIME-Version: 1.0
To: mj@suse.cz, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net
Subject: PROBLEM : PCI hotplug crashes with 2.4.9
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] PCI hotplug crashes with 2.4.9

[2.] hotplug causes the system to crash with kernel 2.4.9 (same
configuration with 2.4.6 was OK). A manual run of
"/etc/rc.d/init.d/hotplug start" shows that the system crashes
immediatly when the system starts to scan the PCI devices. Only the
first line "pcimodules scanning 00:00.0" is displayed. No trace is
written in /var/log/messages.

[3.] PCI hotplug kernel
[4.] Linux version 2.4.9 (root@pierre.juhen) (gcc version 2.96 20000731
(Red Hat Linux 7.1 2.96-81)) #2 dim aoû 19 19:02:56 CEST 2001
[5.]
[6.] /etc/hotplug/pci.rc start
[7.]
[7.1] Software

Linux pierre.juhen 2.4.9 #2 dim aoû 19 19:02:56 CEST 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
pcmcia-cs              3.1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0


[7.2] Processor

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.914
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 799.53

[7.3] modules

pppoatm                 2832   1
ppp_generic            14816   3 [pppoatm]
slhc                    5024   0 [ppp_generic]
usb-uhci               21088   0 (unused)
speedtch               11568   3
snd-seq-midi            3600   0 (unused)
snd-seq-midi-event      3264   0 [snd-seq-midi]
snd-seq                41792   0 [snd-seq-midi snd-seq-midi-event]
snd-card-ens1371        2288   0
snd-ens1371             9664   0 [snd-card-ens1371]
snd-rawmidi            10080   0 [snd-seq-midi snd-ens1371]
snd-seq-device          4016   0 [snd-seq-midi snd-seq snd-rawmidi]
snd-pcm                31520   0 [snd-ens1371]
snd-timer               8560   0 [snd-seq snd-pcm]
snd-ac97-codec         25024   0 [snd-ens1371]
snd-mixer              24608   0 [snd-ens1371 snd-ac97-codec]
snd                    34896   1 [snd-seq-midi snd-seq-midi-event
snd-seq snd-card-ens1371 snd-ens1371 snd-rawmidi snd-seq-device snd-pcm
snd-timer snd-ac97-codec snd-mixer]
soundcore               4144   2 [snd]
3c509                   6224   1 (autoclean)
ipchains               35904   0 (unused)
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                    9424   1 (autoclean)
fat                    32320   0 (autoclean) [vfat]
usbcore                50272   1 [usb-uhci speedtch]

[7.4]  iomem / ioports

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-001fb813 : Kernel code
  001fb814-00257b7f : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d8000000-dbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
dc000000-deffffff : PCI Bus #01
  dc000000-dc003fff : Matrox Graphics, Inc. MGA G200 AGP
  dd000000-dd7fffff : Matrox Graphics, Inc. MGA G200 AGP
df000000-dfffffff : PCI Bus #01
  df000000-dfffffff : Matrox Graphics, Inc. MGA G200 AGP
e1000000-e1003fff : PCI device 104c:8020 (Texas Instruments)
e1004000-e1004fff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
  e1004000-e1004fff : aic7xxx
e1005000-e10057ff : PCI device 104c:8020 (Texas Instruments)
e1006000-e1006fff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
  e1006000-e1006fff : aic7xxx
ffff0000-ffffffff : reserved

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0280-028f : 3c509
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
e000-e01f : Intel Corporation 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e43f : Ensoniq ES1371 [AudioPCI-97]
  e400-e43f : Ensoniq AudioPCI
e800-e8ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
ec00-ecff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
f000-f00f : Intel Corporation 82371AB PIIX4 IDE

[7.5] PCI

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 32
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-deffffff
        Prefetchable memory behind bridge: df000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0f.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
(prog-if 10 [OHCI])
        Subsystem: Pinnacle Systems Inc.: Unknown device 000e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at e1005000 (32-bit, non-prefetchable)
[size=2K]
        Region 1: Memory at e1000000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V,
AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx /
AIC-7895 (rev 04)
        Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD
AIC-7895B
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [disabled] [size=256]
        Region 1: Memory at e1004000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at e0000000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx /
AIC-7895 (rev 04)
        Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD
AIC-7895B
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max)
        Interrupt: pin B routed to IRQ 15
        Region 0: I/O ports at ec00 [disabled] [size=256]
        Region 1: Memory at e1006000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at df000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at dc000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at dd000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

[7.6] SCSI

Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: MATSHITA Model: CD-R   CW-7502   Rev: 4.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDRS-34560W      Rev: S97B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7] hotplug version : hotplug-2001_04_24-1_7.x (binary RPM)

[8.] Workaround : rename /etc/hotplug/pci.rc for example with
/etc/hotplug/pci.not-rc. This disable PCI hotplug but keeps
USB hotplugging



