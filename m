Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVF2TjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVF2TjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVF2TjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:39:18 -0400
Received: from mx.ticino.com ([195.190.166.60]:50695 "EHLO mail1.ticino.com")
	by vger.kernel.org with ESMTP id S262488AbVF2Td2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:33:28 -0400
Message-ID: <42C2F7B1.7070500@kotarkh.ch>
Date: Wed, 29 Jun 2005 21:34:09 +0200
From: nuage <nuage@kotarkh.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050616
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: new hardware problems: IRQ and ACPI (Toshiba Tecra S2-128)
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] One line summary of the problem:

When I call "halt", on my "Toshiba Tecra S2-128", the laptop won't
actualy shutdown power. I *guess* this is an IRQ or/and ACPI problem.



[2.] Full description of the problem/report:

Hello, I knew I would have some trouble to make an un-tested laptop
to work with GNU/Linux, but hope I recently reached enough skills to
try it. I am totaly new to this mailing list. I know about computers,
but not much about the Linux kernel at all.

Here is a summary of what is working and not working:
1-The GNU/Linux console with framebuffer is perfectly working.
2-The wired network is working only most of the time. But in some
conditions, like staring X seem to make it unstable.
3-Xorg is not working, almost all the time. Without changing anything
related to the driver or the modules, it sometimes work or don't work.
I could not figure out what is related to this.
4-"acpi_power_off" is not working either. At some random times of my
installs, it did happen to work. But at each time it worked, at the
next boot, it would not work.

I have made all the "cat" of this mail in the same boot session, just
in case. I don't know enough, but I fear some things about IRQ I don't
know about would behave differrently on one boot or another.

I am running with the latest gentoo kernel. Currently 2.6.11-gentoo-r11
I have tried the vanilla sources, but I could not make the framebuffer
to work with them. I can make other tries if this can help.


[3.] Keywords:

IRQ, ACPI, Xorg, acpi_power_off, DSDT



[4.] Kernel version (from /proc/version):

# cat /proc/version
Linux version 2.6.11-gentoo-r11 (root@bird) (gcc version 3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #1 Wed Jun 29
11:57:40 CEST 2005
#



[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

(I saw none. Are they reported in dmesg ?)
# dmesg | grep ops
#



[6.] A small shell script or example program which triggers the
     problem (if possible)

Sorry, I guess this can only happen on this new hardware. But send me a patch
and the name of the kernel to try this on, and I will do it asap.



[7.] Environment



[7.1.] Software (add the output of the ver_linux script here)

# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bird 2.6.11-gentoo-r11 #1 Wed Jun 29 11:57:40 CEST 2005 i686 Intel(R) Pentium(R) M processor 1.73GHz GenuineIntel GNU/Linux

Gnu C                  3.3.5-20050130
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.37
reiserfsprogs          3.6.19
reiser4progs           line
pcmcia-cs              3.2.8
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   056
Modules Loaded         snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
snd soundcore snd_page_alloc nvidia sk98lin
#



[7.2.] Processor information (from /proc/cpuinfo):

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.73GHz
stepping        : 8
cpu MHz         : 1729.749
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
bogomips        : 3399.68
#



[7.3.] Module information (from /proc/modules):

# cat /proc/modules
snd_pcm_oss 49056 0 - Live 0xf8de7000
snd_mixer_oss 17920 1 snd_pcm_oss, Live 0xf8db8000
snd_seq_oss 32960 0 - Live 0xf8d74000
snd_seq_midi_event 6400 1 snd_seq_oss, Live 0xf88fc000
snd_seq 50960 4 snd_seq_oss,snd_seq_midi_event, Live 0xf8dc9000
snd_seq_device 6924 2 snd_seq_oss,snd_seq, Live 0xf88f2000
snd_intel8x0 29120 0 - Live 0xf8d7e000
snd_ac97_codec 75384 1 snd_intel8x0, Live 0xf8da4000
snd_pcm 84872 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xf8d8e000
snd_timer 22084 2 snd_seq,snd_pcm, Live 0xf88f5000
snd 48036 9 snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer, Live 0xf8d67000
soundcore 7648 1 snd, Live 0xf88ea000
snd_page_alloc 7684 2 snd_intel8x0,snd_pcm, Live 0xf88e7000
nvidia 3705796 0 - Live 0xf9095000
sk98lin 207000 1 - Live 0xf8c60000
#



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : libata
0376-0376 : ide1
03c0-03df : vga+
  03c0-03df : vesafb
1000-107f : motherboard
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1010-1015 : ACPI CPU throttle
  1020-1020 : PM2_CNT_BLK
  1028-102f : GPE0_BLK
1180-11bf : motherboard
1640-164f : motherboard
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci_hcd
1860-187f : 0000:00:1d.3
  1860-187f : uhci_hcd
1880-18bf : 0000:00:1e.2
  1880-18bf : Intel ICH
18f0-18ff : 0000:00:1f.2
  18f0-18ff : libata
1c00-1cff : 0000:00:1e.2
  1c00-1cff : Intel ICH
2000-207f : 0000:00:1e.3
20a0-20bf : 0000:00:1f.3
2400-24ff : 0000:00:1e.3
3000-3fff : PCI Bus #02
  3000-30ff : 0000:02:00.0
    3000-30ff : sk98lin
fe00-fe7f : motherboard
  fe00-fe7f : pnp 00:00
fe80-feff : motherboard
  fe80-feff : pnp 00:00
ff00-ff7f : motherboard
  ff00-ff7f : pnp 00:00
#
# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cf800-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-5fedffff : System RAM
  00100000-003c5ea3 : Kernel code
  003c5ea4-004ccf7f : Kernel data
5fee0000-5fee9fff : ACPI Tables
5feea000-5fefffff : ACPI Non-volatile Storage
5ff00000-5fffffff : reserved
80000000-800003ff : 0000:00:1d.7
  80000000-800003ff : ehci_hcd
80000400-800004ff : 0000:00:1e.2
  80000400-800004ff : Intel ICH
80000800-800009ff : 0000:00:1e.2
  80000800-800009ff : Intel ICH
90000000-afffffff : PCI Bus #01
  90000000-90ffffff : 0000:01:00.0
  a0000000-a3ffffff : 0000:01:00.0
    a0000000-a3ffffff : nvidia
b0000000-b3ffffff : PCI Bus #02
  b0000000-b0003fff : 0000:02:00.0
    b0000000-b0003fff : sk98lin
b4000000-b4003fff : 0000:06:04.2
b4004000-b4005fff : 0000:06:04.3
b4006000-b4006fff : 0000:06:02.0
b4007000-b4007fff : 0000:06:04.0
b4008000-b4008fff : 0000:06:04.1
b4009000-b40097ff : 0000:06:04.2
  b4009000-b40097ff : ohci1394
b4009800-b40098ff : 0000:06:04.4
b4009c00-b4009cff : 0000:06:04.4
b400a000-b400a0ff : 0000:06:04.4
c0000000-cfffffff : PCI Bus #01
  c0000000-c7ffffff : 0000:01:00.0
    c0000000-c3ffffff : vesafb
d0000000-d3ffffff : PCI Bus #02
e0000000-f0005fff : reserved
f0008000-f000bfff : reserved
fed20000-fed8ffff : reserved
ff000000-ffffffff : reserved
#



[7.5.] PCI information ('lspci -vvv' as root)

bird scripts # lspci -vvv
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 90000000-afffffff
        Prefetchable memory behind bridge: c0000000-cfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [a0] #10 [0141]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: b0000000-b3ffffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000d3f00000
        Expansion ROM at 00003000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at 1840 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at 1860 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 80000000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=06, subordinate=08, sec-latency=216
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: b4000000-b40fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] #0d [0000]

0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1c00
        Region 1: I/O ports at 1880 [size=64]
        Region 2: Memory at 80000800 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at 80000400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2400
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 80 [Master])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 18f0 [size=16]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 20a0 [size=32]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce Go 6600] (rev a2) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at a0000000 (32-bit, non-prefetchable)
        Region 1: Memory at c0000000 (64-bit, prefetchable) [size=128M]
        Region 3: Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] #10 [0001]

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit Ethernet Controller (rev 15)
        Subsystem: Toshiba America Info Systems Marvell 88E8053 Gigabit Ethernet Controller (Compal)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
        Latency: 0, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at b0000000 (64-bit, non-prefetchable)
        Region 2: I/O ports at 3000 [size=256]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] #10 [0011]

0000:06:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
        Subsystem: Intel Corporation: Unknown device 2741
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 6000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at b4006000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:06:04.0 CardBus bridge: Texas Instruments Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at b4007000 (32-bit, non-prefetchable)
        Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 00000000-00000000 (prefetchable)
        Memory window 1: 00000000-00000000 (prefetchable)
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA+ VGA- MAbort- >Reset+ 16bInt- PostWrite-
        16-bit legacy interface ports at 0001

0000:06:04.1 CardBus bridge: Texas Instruments Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at b4008000 (32-bit, non-prefetchable)
        Bus: primary=06, secondary=0b, subordinate=0e, sec-latency=176
        Memory window 0: fff00000-000ff000 (prefetchable)
        Memory window 1: 00000000-00000000 (prefetchable)
        I/O window 0: 0000f000-00000fff
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA+ VGA- MAbort- >Reset+ 16bInt- PostWrite-
        16-bit legacy interface ports at 0001

0000:06:04.2 FireWire (IEEE 1394): Texas Instruments Texas Instruments OHCI Compliant IEEE 1394 Host Controller (prog-if 10 [OHCI])
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at b4009000 (32-bit, non-prefetchable)
        Region 1: Memory at b4000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:06:04.3 Unknown mass storage controller: Texas Instruments Texas Instruments PCIxx21 Integrated FlashMedia Controller
        Subsystem: Toshiba America Info Systems: Unknown device ff01
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 57 (1750ns min, 1000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at b4004000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:06:04.4 Class 0805: Texas Instruments Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD)
        Subsystem: Toshiba America Info Systems: Unknown device ff01
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 57 (1750ns min, 1000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at b400a000 (32-bit, non-prefetchable)
        Region 1: Memory at b4009c00 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at b4009800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
#



[7.6.] SCSI information (from /proc/scsi/scsi)

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA MK8025GA Rev: KA02
  Type:   Direct-Access                    ANSI SCSI revision: 05
#



[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Here is one test that may be revealant:
starting X and watching the ACPI messages of dmesg:

# X &> x.out.txt
Message from syslogd@bird at Wed Jun 29 15:28:13 2005 ...
bird kernel: Disabling IRQ #10
- ----------here network stoped to work
#dmesg > dmesg.txt
#halt
- ----------[...everything else is halting fine]
acpi_power_off called
- ----------the laptop is still on, I reboot it manualy.
#cat dmesg.txt
oad:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
irq 10: nobody cared!
 [<c01362da>] __report_bad_irq+0x2a/0xa0
 [<c0135c00>] handle_IRQ_event+0x30/0x70
 [<c01363e0>] note_interrupt+0x70/0xb0
 [<c0135d85>] __do_IRQ+0x145/0x160
 [<c0104d77>] do_IRQ+0x47/0x70
 =======================
 [<c010333e>] common_interrupt+0x1a/0x20
 [<c011babe>] __do_softirq+0x2e/0x90
 [<c0104e81>] do_softirq+0x41/0x50
 =======================
 [<c011bbe5>] irq_exit+0x35/0x40
 [<c0104d7e>] do_IRQ+0x4e/0x70
 [<c010333e>] common_interrupt+0x1a/0x20
 [<f92b007b>] _nv000166rm+0x1f3/0x314 [nvidia]
 [<c018dd76>] proc_kill_inodes+0x16/0xf0
 [<c018e2af>] remove_proc_entry+0x8f/0x150
 [<c0136196>] free_irq+0xb6/0x130
 [<f92b73b2>] nv_kern_close+0xb3/0x130 [nvidia]
 [<c01584ae>] __fput+0x17e/0x190
 [<c0156909>] filp_close+0x59/0x90
 [<c01569ab>] sys_close+0x6b/0xa0
 [<c01031cf>] syscall_call+0x7/0xb
handlers:
[<c0311220>] (ohci_irq_handler+0x0/0x7e0)
[<c0323590>] (usb_hcd_irq+0x0/0x70)
[<c0323590>] (usb_hcd_irq+0x0/0x70)
[<f8c67c80>] (SkY2Isr+0x0/0x270 [sk98lin])
Disabling IRQ #10
NVRM: rm_init_adapter(0) failed
# cat x.out.txt
_XSERVTransSocketOpenCOTSServer: Unable to open socket for inet6
_XSERVTransOpen: transport open failed for inet6/bird:0
_XSERVTransMakeAllCOTSServerListeners: failed to open listener for inet6

X Window System Version 6.8.2
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: Linux 2.6.11-gentoo-r3 i686 [ELF]
Current Operating System: Linux bird 2.6.11-gentoo-r11 #1 Wed Jun 29 11:57:40 CEST 2005 i686
Build Date: 10 June 2005
        Before reporting problems, check http://wiki.X.Org
        to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Wed Jun 29 15:28:08 2005
(==) Using config file: "/etc/X11/xorg.conf"
Using vt 7
NVIDIA: could not open the device file /dev/nvidia0 (Input/output error).
(EE) NVIDIA(0): The NVIDIA kernel module does not appear to be receiving
(EE) NVIDIA(0):      interrupts generated by the NVIDIA graphics device.
(EE) NVIDIA(0):      Please see the FREQUENTLY ASKED QUESTIONS section in the
(EE) NVIDIA(0):      README for additional information.
(EE) NVIDIA(0): Failed to initialize the NVIDIA graphics device!
(EE) NVIDIA(0):  *** Aborting ***

Fatal server error:
AddScreen/ScreenInit failed for driver 0


Please consult the The X.Org Foundation support
         at http://wiki.X.Org
 for help.
Please also check the log file at "/var/log/Xorg.0.log" for additional information.
#


[X.] Other notes, patches, fixes, workarounds:

Note: This kernel has been patched with:
1-My own "fixed" DSDT, as an attempt to make it work.
http://www.kotarkh.ch/linux/dsdt-before-fix.dsl
http://www.kotarkh.ch/linux/dsdt-after-fix.dsl
2-The latest dsk9elin module. Network would not work without it.
http://syskonnect.com/syskonnect/support/driver/htm/sk9elin.htm

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCwvewFm6LaI1U0NERAjgPAKDQHbc7Riphp3XwtSTMPgrUx+6G2gCgx2XP
SwJE/hLdVfSvnFdNnNmBU/k=
=rEGR
-----END PGP SIGNATURE-----
