Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWHTRER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWHTRER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWHTRER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:04:17 -0400
Received: from cumeil2.prima.com.ar ([200.42.0.157]:39692 "HELO
	cumeils.prima.com.ar") by vger.kernel.org with SMTP
	id S1750964AbWHTREQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:04:16 -0400
Message-ID: <20060820140414.42CA07F2.51A373BF@172.16.1.124>
From: <mjvranic@ciudad.com.ar>
Reply-To: <mjvranic@ciudad.com.ar>
To: <linux-kernel@vger.kernel.org>
Date: Sun, 20 Aug 2006 14:04:14 -0300
Subject: =?iso-8859-1?Q?PROBLEM:=20TEA5757=20radio=20support=20broken=20in=20bttv=200.9.16?=
X-Priority: 3
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
X-SenderIP: 200.122.49.242
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by alpha.home.local id k7KGsgqZ002047

[1.] PROBLEM: TEA5757 (VHXtreme) radio support broken from bttv 0.9.15 to 0.9.16

[2.] Full description-
 
I upgraded kernel from 2.6.12 (bttv 0.9.15) to 2.6.17 (bttv 0.9.16). Then, when I try to listen a station, I can only hear white noise, with some stations out frecuency.

Modules were loaded with this options:
	options bttv card=14 radio=1 tuner=17 pll=28 bttv_verbose=1 bttv_debug=1 irq_debug=1
	options tuner debug=1, 

This produces this kernel messages, when I try to listen a radio station with "radio" program.

With Kernel 2.6.12 (bttv 0.9.15, works ok):

For 96.05 station:
Aug 20 12:48:52 box kernel: tea5757_set_freq 1536
Aug 20 12:48:52 box kernel: bttv0: tea5757: write 0x2158

For 96.10 station:
Aug 20 12:48:58 box kernel: tea5757_set_freq 1537
Aug 20 12:48:58 box kernel: bttv0: tea5757: write 0x215D

...........
For 96.30 station:
Aug 20 12:49:00 box kernel: tea5757_set_freq 1540
Aug 20 12:49:00 box kernel: bttv0: tea5757: write 0x216C

*** There are steps of 0.8 wide writed in TEA5757 for every 0,5 mhz step in radio program.

With Kernel 2.6.17 (bttv 0.9.16, broken):

For 96.05 station:
Aug 20 13:17:08 box kernel: tea5757_set_freq 29472
Aug 20 13:17:08 box kernel: bttv0: tea5757: write 0x242F8

For 96.10 station:
Aug 20 13:19:09 box kernel: tea5757_set_freq 30272
Aug 20 13:19:09 box kernel: bttv0: tea5757: write 0x25298

*** There are steps of 800 wide writed in TEA5757 for every 0,5 mhz step in radio program.

For some reason, the information about necessary steps fot TEA5757 is multiplied by 1000.

[3.] Keywords: bttv, tvcard with radio support, TEA5757.

[4.] Kernel version (from /proc/version):

Linux version 2.6.17 (root@Knoppix) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #4 SMP PREEMPT Wed May 10 13:53:45 CEST 2006

[5.] Last version that works: Kernel 2.6.12 (bttv 0.9.15) works perfectly

[8.] Environment

[8.1] Output of the ver_linux script

Linux box 2.6.17 #4 SMP PREEMPT Wed May 10 13:53:45 CEST 2006 i686 GNU/Linux

Gnu C                  4.0.4
Gnu make               3.81
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39-WIP
jfsutils               1.1.8
reiserfsprogs          3.6.19
xfsprogs               2.7.16
pcmcia-cs              3.2.8
PPP                    2.4.4b1
nfs-utils              1.0.7
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.94
udev                   091
Modules Loaded         bttv video_buf firmware_class ir_common compat_ioctl32 i2c_algo_bit btcx_risc tveeprom videodev lp autofs4 ipv6 via drm amd_k7_agp af_packet dm_mod fuse yenta_socket rsrc_nonstatic pcmcia_core video container button battery ac unionfs sbp2 ohci1394 ieee1394 usb_storage ohci_hcd ext3 jbd snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx tuner snd_ac97_codec tvaudio snd_ac97_bus snd_pcm_oss 8250_pnp 8250 serial_core i2c_viapro via_ircc v4l2_common i2c_core snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd irda tsdev soundcore parport_pc parport crc_ccitt via_agp agpgart evdev shpchp pci_hotplug analog gameport via_rhine mii ehci_hcd uhci_hcd usbcore thermal processor fan reiserfs


[8.2] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm)
stepping        : 1
cpu MHz         : 1494.106
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow up ts
bogomips        : 2991.45


[8.3.] Module information (from /proc/modules):

bttv 164412 0 - Live 0xcf098000
video_buf 23556 1 bttv, Live 0xcedad000
firmware_class 11648 1 bttv, Live 0xced5e000
ir_common 27524 1 bttv, Live 0xceda5000
compat_ioctl32 5120 1 bttv, Live 0xced24000
i2c_algo_bit 12040 1 bttv, Live 0xced20000
btcx_risc 7944 1 bttv, Live 0xcec79000
tveeprom 16912 1 bttv, Live 0xced47000
videodev 11136 1 bttv, Live 0xced1c000
lp 13696 0 - Live 0xcef85000
autofs4 20740 1 - Live 0xcefd2000
ipv6 238336 8 - Live 0xcf05c000
via 44640 1 - Live 0xcef57000
drm 62228 2 via, Live 0xcf003000
amd_k7_agp 10380 0 - Live 0xceef5000
af_packet 23816 0 - Live 0xcef32000
dm_mod 48404 0 - Live 0xcefe2000
fuse 34952 0 - Live 0xcef75000
yenta_socket 25612 0 - Live 0xcef6d000
rsrc_nonstatic 14080 1 yenta_socket, Live 0xcef3f000
pcmcia_core 35992 2 yenta_socket,rsrc_nonstatic, Live 0xcef63000
video 17284 0 - Live 0xcef39000
container 7168 0 - Live 0xcef0e000
button 8848 0 - Live 0xcef0a000
battery 11524 0 - Live 0xceeee000
ac 7428 0 - Live 0xceef2000
unionfs 61728 0 - Live 0xcef46000
sbp2 22788 0 - Live 0xcef03000
ohci1394 33200 0 - Live 0xceef9000
ieee1394 285784 2 sbp2,ohci1394, Live 0xcef8b000
usb_storage 76480 0 - Live 0xceec5000
ohci_hcd 21636 0 - Live 0xcede6000
ext3 123016 1 - Live 0xcef12000
jbd 63008 1 ext3, Live 0xceedb000
snd_seq_dummy 6660 0 - Live 0xced56000
snd_seq_oss 31972 0 - Live 0xcee7b000
snd_seq_midi 10144 0 - Live 0xced83000
snd_seq_midi_event 9984 2 snd_seq_oss,snd_seq_midi, Live 0xced7f000
snd_seq 48332 6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event, Live 0xced98000
snd_via82xx 26136 1 - Live 0xced90000
tuner 52396 0 - Live 0xcedd0000
snd_ac97_codec 88352 1 snd_via82xx, Live 0xceded000
tvaudio 24860 0 - Live 0xced88000
snd_ac97_bus 6016 1 snd_ac97_codec, Live 0xced59000
snd_pcm_oss 38176 0 - Live 0xced74000
8250_pnp 12288 0 - Live 0xcec8c000
8250 24320 1 8250_pnp, Live 0xced4f000
serial_core 20480 1 8250, Live 0xcece5000
i2c_viapro 11284 0 - Live 0xcece1000
via_ircc 22036 0 - Live 0xced40000
v4l2_common 17408 2 bttv,tuner, Live 0xced3a000
i2c_core 20480 6 bttv,i2c_algo_bit,tveeprom,tuner,tvaudio,i2c_viapro, Live 0xced16000
snd_mixer_oss 17536 1 snd_pcm_oss, Live 0xced10000
snd_pcm 73220 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live 0xced27000
snd_timer 22148 2 snd_seq,snd_pcm, Live 0xced09000
snd_page_alloc 11272 2 snd_via82xx,snd_pcm, Live 0xcecca000
snd_mpu401_uart 9984 1 snd_via82xx, Live 0xcecc6000
snd_rawmidi 22560 2 snd_seq_midi,snd_mpu401_uart, Live 0xcecce000
snd_seq_device 10252 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi, Live 0xcec99000
snd 44768 13 snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xcecd5000
irda 116152 1 via_ircc, Live 0xceceb000
tsdev 9920 0 - Live 0xcec95000
soundcore 11104 1 snd, Live 0xcec7f000
parport_pc 38512 1 - Live 0xcecbb000
parport 33992 2 lp,parport_pc, Live 0xcecb1000
crc_ccitt 5888 1 irda, Live 0xcec7c000
via_agp 11648 1 - Live 0xcec69000
agpgart 29156 3 drm,amd_k7_agp,via_agp, Live 0xcec83000
evdev 11648 0 - Live 0xcec65000
shpchp 37032 0 - Live 0xcec6e000
pci_hotplug 28612 1 shpchp, Live 0xce840000
analog 13728 0 - Live 0xce879000
gameport 14728 2 snd_via82xx,analog, Live 0xce874000
via_rhine 23428 0 - Live 0xce86d000
mii 8448 1 via_rhine, Live 0xce82f000
ehci_hcd 32008 0 - Live 0xce848000
uhci_hcd 23308 0 - Live 0xce837000
usbcore 109084 5 usb_storage,ohci_hcd,ehci_hcd,uhci_hcd, Live 0xce851000
thermal 14472 0 - Live 0xce81e000
processor 25736 1 thermal, Live 0xce827000
fan 7300 0 - Live 0xce81b000
reiserfs 238704 1 - Live 0xceb81000

[8.4.] Loaded driver and hardware information 

cat /proc/ioports
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0400-047f : 0000:00:11.0
  0400-0403 : PM1a_EVT_BLK
  0404-0405 : PM1a_CNT_BLK
  0408-040b : PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-0423 : GPE0_BLK
5000-500f : 0000:00:11.0
  5000-500f : motherboard
    5000-500f : pnp 00:02
      5000-5007 : vt596_smbus
d000-d01f : 0000:00:10.0
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:10.1
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:10.2
  d800-d81f : uhci_hcd
dc00-dc0f : 0000:00:11.1
  dc00-dc07 : ide0
  dc08-dc0f : ide1
e000-e0ff : 0000:00:11.5
  e000-e0ff : VIA8233
e800-e8ff : 0000:00:12.0
  e800-e8ff : via-rhine


cat /proc/iomem
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7dff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-0032c7b8 : Kernel code
  0032c7b9-003f6737 : Kernel data
0dff0000-0dff2fff : ACPI Non-volatile Storage
0dff3000-0dffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e7ffffff : PCI Bus #01
  e4000000-e7ffffff : 0000:01:00.0
    e4000000-e5ffffff : vesafb
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : 0000:01:00.0
  e9000000-e900ffff : 0000:01:00.0
ea000000-ea000fff : 0000:00:08.0
  ea000000-ea000fff : bttv0
ea001000-ea0010ff : 0000:00:10.3
  ea001000-ea0010ff : ehci_hcd
ea002000-ea0020ff : 0000:00:12.0
  ea002000-ea0020ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[8.5.] PCI information ('lspci -vvv' as root)

lspci -vvv
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400/A] Chipset Host Bridge
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8118
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: e4000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at ea000000 (32-bit, prefetchable) [size=4K]

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 17
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 17
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin D routed to IRQ 17
        Region 0: Memory at ea001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard rev. 1.01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe motherboard (ADI AD1980 codec [SoundMAX])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 20
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80ff
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at ea002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8378 [S3 UniChrome] Integrated Video (rev 01) (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 8118
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at e9000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

[X.] Other notes, patches, fixes, workarounds:

I solved this problem modifing bttv-driver.c in this way:
Line 1614 : 	tea5757_set_freq(btv,btv->freq);
replaced by: 	tea5757_set_freq(btv,btv->freq/1000);

Line 1923:	tea5757_set_freq(btv,btv->freq);
replaced by: 	tea5757_set_freq(btv,btv->freq/1000);

Thanks, 

Marcelo Vranic

