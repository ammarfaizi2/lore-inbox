Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUB2EJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 23:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUB2EJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 23:09:45 -0500
Received: from server75.nt.webjanssen.de ([195.158.54.75]:29193 "EHLO
	mail.webjanssen.com") by vger.kernel.org with ESMTP id S261974AbUB2EJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 23:09:32 -0500
Message-ID: <40416621.5000706@gmx.net>
Date: Sun, 29 Feb 2004 05:10:09 +0100
From: Manuel Hartl <icecep@gmx.net>
Reply-To: icecep@gmx.net
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: linux 2.4 / 2.6 crash while disk i/o and video overlay on
 agp card
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i hope this gets to the right person...

keywords: overlay/video/agp/disk/io

i have got the following problem:

when using video overlay (watching dvbs-tv with kvdr or xawtv) and at the same same time
copying a file; the system completly freezes after 3 up to 10 seconds.

i have got a KT600 chipset. it only happens with an agp card (testet matrox g550 and
nvidia cards). with a pci card it does not occur..


testet with 2.4.23 and 2.6.0-test5 to 2.6.0-test11, 2.6.1, 2.6.2, 2.6.3 ..


ver_linux:
Linux media.efr.local 2.6.3 #3 Sat Feb 28 01:03:13 CET 2004 i686 athlon i386 GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
module-init-tools      2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
xfsprogs               2.5.6
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         dvb_ttpci ttpci_eeprom saa7146_vv saa7146 ves1x93 dvb_core
video_buf v4l2_common v4l1_compat videodev ipt_state ipt_MASQUERADE ipt_mark ipt_LOG
ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack iptable_filter ip_tables ppp_synctty
ppp_async ppp_generic slhc snd_pcm_oss snd_mixer_oss crc32 it87 i2c_sensor i2c_isa
i2c_core 8250_acpi 8250 serial_core lirc_dev snd_emux_synth snd_seq_virmidi
snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi snd_pcm snd_timer
snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd sk98lin sg
parport_pc parport ohci1394 ieee1394 hid uhci_hcd ehci_hcd usbcore rtc


/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2200+
stepping        : 0
cpu MHz         : 1800.924
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3547.13

lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge (rev
80)
         Subsystem: Asustek Computer, Inc.: Unknown device 807f
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [80] AGP version 3.5
                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64
bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<n
one>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000e000-0000dfff
         Memory behind bridge: f5f00000-f5efffff
         Prefetchable memory behind bridge: f8000000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)
         Subsystem: Asustek Computer, Inc.: Unknown device 80eb
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32 (5750ns min, 7750ns max), cache line size 08
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16K]
         Region 1: I/O ports at d800 [size=256]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data

00:0b.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
         Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32 (3750ns min, 9500ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at f4800000 (32-bit, non-prefetchable) [size=512]

00:0c.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03) (prog-if
00 [VGA])
         Subsystem: Guillemot Corporation: Unknown device 0001
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=32M]
         Region 1: Memory at f6000000 (32-bit, prefetchable) [size=32M]
         Region 2: I/O ports at d400 [size=256]
         Expansion ROM at f5ff0000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
         Subsystem: Creative Labs: Unknown device 2002
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at d000 [size=64]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
         Subsystem: Creative Labs SB Audigy MIDI/Game Port
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32
         Region 0: I/O ports at b800 [size=8]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10
[OHCI])
         Subsystem: Creative Labs SB Audigy FireWire Port
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 1000ns max), cache line size 08
         Interrupt: pin B routed to IRQ 17
         Region 0: Memory at f1800000 (32-bit, non-prefetchable) [size=2K]
         Region 1: Memory at f1000000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:0e.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
         Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32 (3750ns min, 9500ns max)
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at f0800000 (32-bit, non-prefetchable) [size=512]

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 20
         Region 0: I/O ports at b400 [size=8]
         Region 1: I/O ports at b000 [size=4]
         Region 2: I/O ports at a800 [size=8]
         Region 3: I/O ports at a400 [size=4]
         Region 4: I/O ports at a000 [size=16]
         Region 5: I/O ports at 9800 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev
06) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 20
         Region 4: I/O ports at 9400 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin A routed to IRQ 21
         Region 4: I/O ports at 9000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin A routed to IRQ 21
         Region 4: I/O ports at 8800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin B routed to IRQ 21
         Region 4: I/O ports at 8400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin B routed to IRQ 21
         Region 4: I/O ports at 8000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 32, cache line size 10
         Interrupt: pin C routed to IRQ 21
         Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
--
(manuel hartl / it services)
(web - http://www.hartl-it.de)


