Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265456AbTF1XLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbTF1XLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:11:21 -0400
Received: from host09.ipowerweb.com ([12.129.206.109]:50925 "EHLO
	host09.ipowerweb.com") by vger.kernel.org with ESMTP
	id S265460AbTF1XLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:11:02 -0400
Message-ID: <3EFE23A5.2000608@libero.it>
Date: Sun, 29 Jun 2003 01:24:21 +0200
From: "Luca T." <luca-t@libero.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /dev/random broken?
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host09.ipowerweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i am not sure if this is a kernel/module problem but so it seems to me.
My computer is an AMD 2000+ with an ABIT motherboard, my kernel version
is 2.4.21-0.13mdk (but i tried it with 2.4.21-0.18mdk too and it doesn't
work either).

If i give this command:
  dd if=/dev/zero of=./xxx bs=1024 count=100
it will work perfectly. But if i try to do the same reading from
/dev/random with this command:
  dd if=/dev/random of=./xxx bs=1024 count=100
it will just sit there and stare at me until i move the mouse... and
then the program will exit without any error message (i checked in
/var/log/messages too and there is no message there either about this).

Is this a bug? If yes... do you have any idea that would help me fix it?

Thank you,
     Luca

P.S.: I add here more info about my configuration:

[luca@ATH2000 luca]$ cat /proc/version
Linux version 2.4.21-0.13mdk (flepied@bi.mandrakesoft.com) (gcc version 
3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #1 Fri Mar 14 15:08:06 EST 2003

[luca@ATH2000 luca]$ cat /proc/modules
saa7113h                7776   0 (autoclean)
rivatv                 68156   0
i2c-algo-bit            9064   2 [rivatv]
i2c-core               21192   0 [saa7113h rivatv i2c-algo-bit]
appletalk              25700   1 (autoclean)
ipx                    21252   1 (autoclean)
parport_pc             25096   1 (autoclean)
lp                      8096   0 (autoclean)
parport                34176   1 (autoclean) [parport_pc lp]
agpgart                40896   3 (autoclean) [rivatv]
NVdriver             1149824  10 (autoclean)
nls_cp437               5148   2 (autoclean)
nls_iso8859-1           3516   2 (autoclean)
smbfs                  40144   2 (autoclean)
es1371                 29000   1
soundcore               6276   0 [es1371]
ac97_codec             12488   0 [es1371]
gameport                3316   0 [es1371]
nfsd                   74256   0 (autoclean)
af_packet              14952   0 (autoclean)
sr_mod                 16920   0 (autoclean)
floppy                 55132   0
8139too                17160   1 (autoclean)
mii                     3832   0 (autoclean) [8139too]
supermount             15296   3 (autoclean)
ide-cd                 33856   0
cdrom                  31648   0 [sr_mod ide-cd]
ide-scsi               11280   0
pwc                    45064   0
videodev                7872   3 [rivatv pwc]
usbmouse                2936   0 (unused)
keybdev                 2720   0 (unused)
mousedev                5268   0 (unused)
hid                    20900   0 (unused)
evdev                   5632   1
wacom                   7096   0 (unused)
input                   5664   0 [usbmouse keybdev mousedev hid evdev wacom]
printer                 8448   0 (unused)
usb-uhci               24652   0 (unused)
usbcore                72992   1 [pwc usbmouse hid wacom printer usb-uhci]
rtc                     8060   0 (autoclean)
reiserfs              175120   2
sd_mod                 11548   0 (unused)
ataraid                 6852   0 (unused)
scsi_mod               91796   3 [sr_mod ide-scsi sd_mod]

[luca@ATH2000 luca]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2000+
stepping        : 0
cpu MHz         : 1667.412
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3329.22


[luca@ATH2000 luca]$ cat /proc/ioports
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
02f8-02ff : serial(auto)
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   c000-c0ff : 8139too
c400-c43f : Ensoniq 5880 AudioPCI
   c400-c43f : es1371
c800-c80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
   c800-c807 : ide0
   c808-c80f : ide1
cc00-cc1f : VIA Technologies, Inc. USB
   cc00-cc1f : usb-uhci
d000-d01f : VIA Technologies, Inc. USB (#2)
   d000-d01f : usb-uhci
d400-d407 : Triones Technologies, Inc. HPT366/368/370/370A/372
d800-d803 : Triones Technologies, Inc. HPT366/368/370/370A/372
dc00-dc07 : Triones Technologies, Inc. HPT366/368/370/370A/372
   dc00-dc07 : ide3
e000-e003 : Triones Technologies, Inc. HPT366/368/370/370A/372
   e002-e002 : ide3
e400-e4ff : Triones Technologies, Inc. HPT366/368/370/370A/372
   e400-e407 : ide2
   e408-e40f : ide3
   e410-e4ff : HPT372

[luca@ATH2000 luca]$ cat /proc/ioports
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
02f8-02ff : serial(auto)
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   c000-c0ff : 8139too
c400-c43f : Ensoniq 5880 AudioPCI
   c400-c43f : es1371
c800-c80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
   c800-c807 : ide0
   c808-c80f : ide1
cc00-cc1f : VIA Technologies, Inc. USB
   cc00-cc1f : usb-uhci
d000-d01f : VIA Technologies, Inc. USB (#2)
   d000-d01f : usb-uhci
d400-d407 : Triones Technologies, Inc. HPT366/368/370/370A/372
d800-d803 : Triones Technologies, Inc. HPT366/368/370/370A/372
dc00-dc07 : Triones Technologies, Inc. HPT366/368/370/370A/372
   dc00-dc07 : ide3
e000-e003 : Triones Technologies, Inc. HPT366/368/370/370A/372
   e002-e002 : ide3
e400-e4ff : Triones Technologies, Inc. HPT366/368/370/370A/372
   e400-e407 : ide2
   e408-e40f : ide3
   e410-e4ff : HPT372
[luca@ATH2000 luca]$
[luca@ATH2000 luca]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cfdff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
   00100000-00260a36 : Kernel code
   00260a37-0037831f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, Inc. VT8367 [KT266]
d8000000-d9ffffff : PCI Bus #01
   d8000000-d9ffffff : nVidia Corporation NV5 [Riva TnT2]
     d8000000-d9ffffff : rivatv
da000000-dbffffff : PCI Bus #01
   da000000-daffffff : nVidia Corporation NV5 [Riva TnT2]
     da000000-daffffff : rivatv
dd000000-dd0000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   dd000000-dd0000ff : 8139too
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[root@ATH2000 luca]# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x2
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: da000000-dbffffff
         Prefetchable memory behind bridge: d8000000-d9ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Unex Technology Corp. ND010
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at c000 [size=256]
         Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at c400 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
         Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. VT8235 Bus Master 
ATA133/100/66/33 IDE
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at c800 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at cc00 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at d000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 RAID bus controller: Triones Technologies, Inc. 
HPT366/368/370/370A/372 (rev 05)
         Subsystem: Triones Technologies, Inc. HPT370A
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 120 (2000ns min, 2000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at d400 [size=8]
         Region 1: I/O ports at d800 [size=4]
         Region 2: I/O ports at dc00 [size=8]
         Region 3: I/O ports at e000 [size=4]
         Region 4: I/O ports at e400 [size=256]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA 
TNT2/TNT2 Pro] (rev 11) (prog-if 00 [VGA])
         Subsystem: Asustek Computer, Inc. AGP-V3800 SGRAM
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at da000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x2




