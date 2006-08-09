Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWHIS7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWHIS7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWHIS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:59:30 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:26005 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750941AbWHIS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:59:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hS8dSC5DDCnIxXOob8U2NZeG2e6rck+kEKRjRMUxl5XBkPXc0z8LmzB4qTG5EzN6nedgO+RPLgRMhE7iwGI+5T9pArAMJH0h9B5LV9tnOI1ucnbKnFDuCD/Kc2+a89R4Godi72gurmQY2/Uzhexwr0fJwm5sGI8W2mAH+qtlCX0=
Message-ID: <97c31bd80608091159h40db8bc2l891cab8ddf7165ef@mail.gmail.com>
Date: Wed, 9 Aug 2006 20:59:28 +0200
From: "Bartlomiej Celary" <bartlomiej.celary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: alsa driver problem (snd_via82xx)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having a problem with alsa driver. It is not a big issue, but a
significant drawback...
Ive used the form, so here it is.

[1.] One line summary of the problem:
While using snd_via82xx the PCM volume is not responding to changing
Master Volume.

[2.] Full description of the problem/report:
The issue is quite simple, but I am suspecting the driver to be the
cause (?). The
sound for my chip works perfectly fine, but somehow the PCM volume
works only for
DSP. The Master Volume works only for the remaining sources (Line in,
CD in). Ive tried
everything including looking in source code, but Im afraid I failed to
find a simple
fix... (posting on forum, googling... etc.).

[3.] Keywords (i.e., modules, networking, kernel):
modules, sound, volume channels

[4.] Kernel version (from /proc/version):
Linux version 2.6.17-gentoo-r4
(gcc version 3.4.6 (Gentoo 3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP PREEMPT

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux ubik 2.6.17-gentoo-r4 #1 SMP PREEMPT Sat Jul 29 15:47:33 CEST
2006 i686 Intel(R) Pentium(R) 4 CPU 2.00GHz GNU/Linux
Gnu C                  3.4.6
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.39
jfsutils               1.1.8
xfsprogs               2.7.11
nfs-utils              1.0.6
Linux C Library        so.6 .> libc
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087

Modules Loaded         nvidia agpgart snd_rtctimer snd_pcm_oss
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_via82xx
gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
snd_page_alloc joydev w83627hf hwmon_vid i2c_isa thermal processor fan
button tuner tvaudio bttv video_buf firmware_class ir_common
compat_ioctl32 i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core
videodev rtc usbhid ide_cd cdrom via_rhine ohci_hcd ehci_hcd uhci_hcd
usbcore

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 1994.891
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
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
bogomips        : 3993.69

[7.3.] Module information (from /proc/modules):
nvidia 4547796 8 - Live 0xe16ed000
agpgart 26828 1 nvidia, Live 0xe11f5000
snd_rtctimer 3340 1 - Live 0xe11ba000
snd_pcm_oss 34848 0 - Live 0xe11d7000
snd_mixer_oss 15232 1 snd_pcm_oss, Live 0xe1131000
snd_seq_oss 28032 0 - Live 0xe11cf000
snd_seq_midi_event 6528 1 snd_seq_oss, Live 0xe112e000
snd_seq 43984 5 snd_seq_oss,snd_seq_midi_event, Live 0xe11c3000
snd_via82xx 22424 4 - Live 0xe1136000
gameport 11784 1 snd_via82xx, Live 0xe10de000
snd_mpu401_uart 6656 1 snd_via82xx, Live 0xe10e5000
snd_rawmidi 18720 1 snd_mpu401_uart, Live 0xe1128000
snd_seq_device 6796 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe10e2000
snd_intel8x0 27036 0 - Live 0xe1120000
snd_ac97_codec 80160 2 snd_via82xx,snd_intel8x0, Live 0xe10f8000
snd_ac97_bus 2944 1 snd_ac97_codec, Live 0xe087e000
snd_pcm 69124 5 snd_pcm_oss,snd_via82xx,snd_intel8x0,snd_ac97_codec,
Live 0xe110e000
snd_timer 18948 3 snd_rtctimer,snd_seq,snd_pcm, Live 0xe108d000
snd 41956 20 snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_via82xx,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,
Live 0xe10ec000
soundcore 8032 1 snd, Live 0xe10d3000
snd_page_alloc 8072 3 snd_via82xx,snd_intel8x0,snd_pcm, Live 0xe1087000
joydev 8384 0 - Live 0xe10cf000
w83627hf 21904 0 - Live 0xe10d7000
hwmon_vid 3200 1 w83627hf, Live 0xe0838000
i2c_isa 4352 1 w83627hf, Live 0xe108a000
thermal 11656 0 - Live 0xe1068000
processor 21320 1 thermal, Live 0xe10a0000
fan 4356 0 - Live 0xe1084000
button 6032 0 - Live 0xe0862000
tuner 45868 0 - Live 0xe1093000
tvaudio 21148 0 - Live 0xe1077000
bttv 153076 0 - Live 0xe10a8000
video_buf 18820 1 bttv, Live 0xe107e000
firmware_class 8320 1 bttv, Live 0xe106c000
ir_common 24196 1 bttv, Live 0xe1070000
compat_ioctl32 2048 1 bttv, Live 0xe081a000
i2c_algo_bit 8328 1 bttv, Live 0xe085e000
v4l2_common 13824 2 tuner,bttv, Live 0xe1063000
btcx_risc 4616 1 bttv, Live 0xe082d000
tveeprom 13200 1 bttv, Live 0xe105e000
i2c_core 16384 8
nvidia,w83627hf,i2c_isa,tuner,tvaudio,bttv,i2c_algo_bit,tveeprom, Live
0xe0879000
videodev 7680 1 bttv, Live 0xe081e000
rtc 10804 1 snd_rtctimer, Live 0xe085a000
usbhid 28548 0 - Live 0xe1056000
ide_cd 33796 1 - Live 0xe086f000
cdrom 33824 1 ide_cd, Live 0xe0865000
via_rhine 18692 0 - Live 0xe0854000
ohci_hcd 17668 0 - Live 0xe0827000
ehci_hcd 25352 0 - Live 0xe0830000
uhci_hcd 19340 0 - Live 0xe0821000
usbcore 101248 5 usbhid,ohci_hcd,ehci_hcd,uhci_hcd, Live 0xe083a000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0295-0296 : w83627hf
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
  03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0820-0823 : GPE0_BLK
c000-c01f : 0000:00:10.0
  c000-c01f : uhci_hcd
c400-c41f : 0000:00:10.1
  c400-c41f : uhci_hcd
c800-c81f : 0000:00:10.2
  c800-c81f : uhci_hcd
cc00-cc1f : 0000:00:10.3
  cc00-cc1f : uhci_hcd
d000-d0ff : 0000:00:11.5
  d000-d0ff : VIA8237
d400-d4ff : 0000:00:12.0
  d400-d4ff : via-rhine
d800-d8ff : 0000:00:0f.0
dc00-dc0f : 0000:00:0f.0
e000-e003 : 0000:00:0f.0
e400-e407 : 0000:00:0f.0
e800-e803 : 0000:00:0f.0
ec00-ec07 : 0000:00:0f.0
fc00-fc0f : 0000:00:0f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cc7ff : Video ROM
000f0000-000fffff : System ROM
00100000-1ff2ffff : System RAM
  00100000-002c2607 : Kernel code
  002c2608-0036d953 : Kernel data
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
e9d00000-f9cfffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
    f0000000-f3ffffff : vesafb
f9dfe000-f9dfefff : 0000:00:0a.0
  f9dfe000-f9dfefff : bttv0
f9dff000-f9dfffff : 0000:00:0a.1
f9e00000-fbefffff : PCI Bus #01
  fa000000-faffffff : 0000:01:00.0
    fa000000-faffffff : nvidia
  fbef0000-fbefffff : 0000:01:00.0
fbfff800-fbfff8ff : 0000:00:10.4
  fbfff800-fbfff8ff : ehci_hcd
fbfffc00-fbfffcff : 0000:00:12.0
  fbfffc00-fbfffcff : via-rhine
fc000000-fdffffff : 0000:00:00.0
fffc0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation Unknown device 0258
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:00.1 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation Unknown device 1258
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.2 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation Unknown device 2258
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.3 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation Unknown device 3258
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.4 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation Unknown device 4258
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.7 Host bridge: VIA Technologies, Inc. PT880 Host Bridge
        Subsystem: ASRock Incorporation Unknown device 7258
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f9e00000-fbefffff
        Prefetchable memory behind bridge: e9d00000-f9cfffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f9dfe000 (32-bit, prefetchable) [size=4K]

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f9dff000 (32-bit, prefetchable) [size=4K]

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
RAID Controller (rev 80)
        Subsystem: ASRock Incorporation K7VT6 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at ec00 [size=8]
        Region 1: I/O ports at e800 [size=4]
        Region 2: I/O ports at e400 [size=8]
        Region 3: I/O ports at e000 [size=4]
        Region 4: I/O ports at dc00 [size=16]
        Region 5: I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: ASRock Incorporation K7VT2/K7VT6 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASRock Incorporation K7VT6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 17
        Region 4: I/O ports at c000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASRock Incorporation K7VT6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 17
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASRock Incorporation K7VT6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASRock Incorporation K7VT6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
(prog-if 20 [EHCI])
        Subsystem: ASRock Incorporation K7VT6 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 20
        Interrupt: pin C routed to IRQ 17
        Region 0: Memory at fbfff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
        Subsystem: ASRock Incorporation K7VT4 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASRock Incorporation K7VT6 motherboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 20
        Region 0: I/O ports at d000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
        Subsystem: ASRock Incorporation K7VT6 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at fbfffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev b2) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        [virtual] Expansion ROM at fbef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit-
FW- Rate=x4

[7.6.] SCSI information (from /proc/scsi/scsi)
	none
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
cat /proc/asound/devices
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer

cat /proc/asound/cards
 0 [V8237          ]: VIA8237 - VIA 8237
                      VIA 8237 with CMI9761 at 0xd000, irq 20

cat /proc/asound/pcm
00-01: VIA 8237 : VIA 8237 : playback 1 : capture 1
00-00: VIA 8237 : VIA 8237 : playback 4 : capture 1

cat /proc/asound/V8237/oss_mixer
VOLUME "Master" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "Master Mono" 0
VIDEO "Video" 0
RADIO "" 0
MONITOR "" 0

nothing else comes to my mind...

[X.] Other notes, patches, fixes, workarounds:


Thanks for looking into it!
-- 
B. Celary
