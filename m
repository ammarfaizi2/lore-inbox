Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbTAGIWg>; Tue, 7 Jan 2003 03:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbTAGIWg>; Tue, 7 Jan 2003 03:22:36 -0500
Received: from m170.net195-132-235.noos.fr ([195.132.235.170]:14600 "EHLO
	loge2") by vger.kernel.org with ESMTP id <S267340AbTAGIWc>;
	Tue, 7 Jan 2003 03:22:32 -0500
From: Mathieu Roy <yeupou@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: Problem: USB with vt8233a southbrigde not recognized
X-PGP-Fingerprint: 6B60 6F7C 39D6 B03C 9024  CD52 365F 7FF7 2DA1 99B9
Date: 07 Jan 2003 09:31:24 +0100
Message-ID: <m31y3p2wf7.fsf@gnu.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get USB working on my VIA MS9107C+ mainboard. But it's
apparently not recognized, despite the fact that others features of
the mainboard seem ok.

With usbcore (etc) loaded (in fact, included in the kernel mainly), I
cannot insmod usb-uhci nor ehci-hcd nor uhci. 

The kernel is:
Linux version 2.4.21-pre2 (moa@dionysos) (gcc version 2.95.4 20011002 (Debian prerelease)) #7 mar jan 7 08:12:32 CET 2003


Error message I got is like:
Using /lib/modules/2.4.21-pre2/kernel/drivers/usb/usb-uhci.o
/lib/modules/2.4.21-pre2/kernel/drivers/usb/usb-uhci.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
You may find more information in syslog or the output from dmesg 

In syslog, I find something like:
Jan 7 09:08:22 dionysos kernel: usb-uhci.c: $Revision: 1.275 $ time 08:19:04 Jan 7 2003
Jan 7 09:08:22 dionysos kernel: usb-uhci.c: High bandwidth mode enabled
Jan 7 09:08:22 dionysos kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver

The distro is Debian GNU/Linux sarge (testing).

Here the result of script/sh_version:
Linux dionysos 2.4.21-pre2 #7 mar jan 7 08:12:32 CET 2003 i686 Intel(R) Pentium(R) 4 CPU 1.70GHz GenuineIntel GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.30-WIP
pcmcia-cs              3.1.33
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         af_packet vfat fat it87 eeprom i2c-proc
i2c-isa i2c-viapro cpuid sound radeon 8139too mii unix

/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1700.067
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3381.65

/proc/modules
piix                    6912   0 (unused)
af_packet              11656   1 (autoclean)
vfat                    9292   1 (autoclean)
fat                    29432   0 (autoclean) [vfat]
it87                    6728   0
eeprom                  3440   0
i2c-proc                6000   0 [it87 eeprom]
i2c-isa                 1164   0 (unused)
i2c-viapro              3860   0 (unused)
cpuid                    904   0 (unused)
sound                  52844   0 (unused)
radeon                 86912   0 (unused)
8139too                13736   1
mii                     2336   0 [8139too]
unix                   13640  79 (autoclean)


/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0025f7c6 : Kernel code
  0025f7c7-002f1d83 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : ATI Technologies Inc Radeon 7500 QW
    e0000000-e7ffffff : radeonfb
e8000000-ebffffff : VIA Technologies, Inc. VT8753 [P4X266 AGP]
ec000000-edffffff : PCI Bus #01
  ed000000-ed00ffff : ATI Technologies Inc Radeon 7500 QW
    ed000000-ed00ffff : radeonfb
ef000000-ef000fff : Tekram Technology Co.,Ltd. TRM-S1040
ef001000-ef0010ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  ef001000-ef0010ff : 8139too
ffff0000-ffffffff : reserved

/proc/ioports:

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
0290-0297 : it87
02f8-02ff : serial(set)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0500-0507 : viapro-smbus
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Radeon 7500 QW
d000-d0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d000-d0ff : 8139too
d400-d4ff : Tekram Technology Co.,Ltd. TRM-S1040
  d400-d47f : DC395x_TRM
d800-d83f : Ensoniq 5880 AudioPCI
  d800-d83f : es1371
dc00-dc0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  dc00-dc07 : ide0
  dc08-dc0f : ide1
e800-e8ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller

lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8753 [P4X266 AGP] (rev 01)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a75
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at ef001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
        Subsystem: Tekram Technology Co.,Ltd. TRM-S1040
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at ef000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Elitegroup Computer Systems: Unknown device 0a75
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 40)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a75
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon 7500 QW (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd: Unknown device 2025
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


/proc/scsi/scsi:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW2100S         Rev: 1.0K
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02


I also posted a similar message on via forums. Maybe they can give
usefull informations.
http://forums.viaarena.com/messageview.cfm?catid=28&threadid=29239


Am I missing something?


Regards,



-- 
Mathieu Roy
 
 << Profile  << http://savannah.gnu.org/users/yeupou <<
 >> Homepage >> http://yeupou.coleumes.org           >>
 << GPG Key  << http://stock.coleumes.org/gpg        <<
