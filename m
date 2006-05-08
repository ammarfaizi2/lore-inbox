Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWEHQhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWEHQhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWEHQhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:37:33 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:63108 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932415AbWEHQhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:37:31 -0400
Message-ID: <445F743B.9090200@free.fr>
Date: Mon, 08 May 2006 18:39:23 +0200
From: Michalski Edmond <edmond.michalski@free.fr>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:out of memory when I execute xsane
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:  

When I execute Xsane program a popup erreur indicate "failure to start scanner: out of memory"

[2.] Full description of the problem/report:

When I execute Xsane program a popup erreur indicate "failure to start scanner: out of memory" with
the kernel version 2.6.16. It's necessary to remove and to load "sg" module then (rmmod + modprobe) to find scsi scanner again. 
when I execute the same program "xsane" with kernel 2.6.15, the problem doesn't appear.

[3.] Keywords (i.e., modules, networking, kernel):

sg module, kernel 2.6.16

[4.] Kernel version (from /proc/version):

Linux version 2.6.16-1.2108_FC4 (bhcompile@hs20-bc1-3.build.redhat.com) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 Thu May 4 23:52:01 EDT 2006

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)

xsane program

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
/usr/src/kernels/2.6.16-1.2108_FC4-i686/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux lns-bzn-27-82-248-40-153.adsl.proxad.net 2.6.16-1.2108_FC4 #1 Thu May 4 23:52:01 EDT 2006 i686 athlon i386 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.7
nfs-utils              1.0.7
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   071
Modules Loaded         sg ppdev parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables dm_mod video button battery ac ipv6 uhci_hcd ehci_hcd i2c_viapro i2c_core snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_bus snd_i2c snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via_rhine mii floppy sr_mod ext3 jbd sata_via libata sym53c8xx scsi_transport_spi atp870u sd_mod scsi_mod


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2600+
stepping        : 1
cpu MHz         : 2083.501
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 4172.32

[7.3.] Module information (from /proc/modules):

sg 34909 0 - Live 0xf8889000
ppdev 9157 0 - Live 0xf8b4b000
parport_pc 27181 1 - Live 0xf8b56000
lp 12929 0 - Live 0xf8b46000
parport 35977 3 ppdev,parport_pc,lp, Live 0xf8aff000
autofs4 19397 1 - Live 0xf8af9000
rfcomm 36821 0 - Live 0xf8b16000
l2cap 24641 5 rfcomm, Live 0xf8a31000
bluetooth 47397 4 rfcomm,l2cap, Live 0xf8b09000
sunrpc 145893 1 - Live 0xf8b21000
ipt_REJECT 5825 1 - Live 0xf8a19000
xt_state 2241 5 - Live 0xf8a14000
ip_conntrack 52473 1 xt_state, Live 0xf8a23000
nfnetlink 6489 1 ip_conntrack, Live 0xf89f2000
xt_tcpudp 3393 6 - Live 0xf89f5000
iptable_filter 3137 1 - Live 0xf8842000
ip_tables 12313 1 iptable_filter, Live 0xf89fd000
x_tables 12741 4 ipt_REJECT,xt_state,xt_tcpudp,ip_tables, Live 0xf89f8000
dm_mod 53973 0 - Live 0xf8a03000
video 15173 0 - Live 0xf89d8000
button 6609 0 - Live 0xf89ef000
battery 9413 0 - Live 0xf89b3000
ac 4933 0 - Live 0xf89be000
ipv6 249217 10 - Live 0xf8a39000
uhci_hcd 31825 0 - Live 0xf89e6000
ehci_hcd 31949 0 - Live 0xf89dd000
i2c_viapro 9045 0 - Live 0xf89af000
i2c_core 21697 1 i2c_viapro, Live 0xf89b7000
snd_ice1712 60293 1 - Live 0xf89c2000
snd_ice17xx_ak4xxx 4417 1 snd_ice1712, Live 0xf89ac000
snd_ak4xxx_adda 6337 2 snd_ice1712,snd_ice17xx_ak4xxx, Live 0xf8970000
snd_cs8427 9921 1 snd_ice1712, Live 0xf89a8000
snd_ac97_codec 88673 1 snd_ice1712, Live 0xf8959000
snd_seq_dummy 3781 0 - Live 0xf8887000
snd_seq_oss 30885 0 - Live 0xf893b000
snd_seq_midi_event 7233 1 snd_seq_oss, Live 0xf8855000
snd_seq 48909 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xf8996000
snd_pcm_oss 48625 0 - Live 0xf8989000
snd_mixer_oss 17473 2 snd_pcm_oss, Live 0xf8911000
snd_pcm 84293 3 snd_ice1712,snd_ac97_codec,snd_pcm_oss, Live 0xf8973000
snd_timer 24005 2 snd_seq,snd_pcm, Live 0xf8952000
snd_page_alloc 10569 1 snd_pcm, Live 0xf891e000
snd_ac97_bus 2497 1 snd_ac97_codec, Live 0xf8806000
snd_i2c 5441 2 snd_ice1712,snd_cs8427, Live 0xf8858000
snd_mpu401_uart 7873 1 snd_ice1712, Live 0xf890e000
snd_rawmidi 24801 1 snd_mpu401_uart, Live 0xf8933000
snd_seq_device 8909 4 snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi, Live 0xf88e8000
snd 51873 14 snd_ice1712,snd_ak4xxx_adda,snd_cs8427,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_i2c,snd_mpu401_uart,snd_rawm
idi,snd_seq_device, Live 0xf8944000
soundcore 9633 2 snd, Live 0xf8883000
via_rhine 24133 0 - Live 0xf8917000
mii 5697 1 via_rhine, Live 0xf8852000
floppy 63869 0 - Live 0xf8922000
sr_mod 17125 0 - Live 0xf887d000
ext3 128329 1 - Live 0xf88ed000
jbd 56789 1 ext3, Live 0xf88b8000
sata_via 8517 0 - Live 0xf8844000
libata 58705 1 sata_via, Live 0xf88a8000
sym53c8xx 75353 0 - Live 0xf8894000
scsi_transport_spi 22721 1 sym53c8xx, Live 0xf8831000
atp870u 32909 1 - Live 0xf8848000
sd_mod 18113 0 - Live 0xf8838000
scsi_mod 131660 7 sg,sr_mod,libata,sym53c8xx,scsi_transport_spi,atp870u,sd_mod, Live 0xf885b000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
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
0290-0297 : pnp 00:0e
0370-0375 : pnp 00:0e
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
7000-70ff : 0000:00:12.0
  7000-70ff : via-rhine
7400-741f : 0000:00:10.3
  7400-741f : uhci_hcd
7800-781f : 0000:00:10.2
  7800-781f : uhci_hcd
8000-801f : 0000:00:10.1
  8000-801f : uhci_hcd
8400-841f : 0000:00:10.0
  8400-841f : uhci_hcd
8800-880f : 0000:00:0f.1
  8800-8807 : ide0
  8808-880f : ide1
9000-90ff : 0000:00:0f.0
  9000-90ff : sata_via
9400-940f : 0000:00:0f.0
  9400-940f : sata_via
9800-9803 : 0000:00:0f.0
  9800-9803 : sata_via
a000-a007 : 0000:00:0f.0
  a000-a007 : sata_via
a400-a403 : 0000:00:0f.0
  a400-a403 : sata_via
a800-a807 : 0000:00:0f.0
  a800-a807 : sata_via
b000-b03f : 0000:00:0d.0
  b000-b03f : atp870u
b400-b4ff : 0000:00:0c.0
  b400-b4ff : sym53c8xx
b800-b83f : 0000:00:0b.0
  b800-b83f : ICE1712
d000-d00f : 0000:00:0b.0
  d000-d00f : ICE1712
d400-d40f : 0000:00:0b.0
  d400-d40f : ICE1712
d800-d81f : 0000:00:0b.0
  d800-d81f : ICE1712
e400-e47f : motherboard
  e400-e403 : PM1a_EVT_BLK
  e404-e405 : PM1a_CNT_BLK
  e408-e40b : PM_TMR
  e420-e423 : GPE0_BLK
e800-e81f : motherboard
  e800-e81f : pnp 00:02
    e800-e807 : vt596_smbus

/proc/iomem:
00000000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000f0000-000fffff : System ROM
00100000-3fffafff : System RAM
  00100000-00317207 : Kernel code
  00317208-003d3ca3 : Kernel data
3fffb000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
f0800000-f08000ff : 0000:00:12.0
  f0800000-f08000ff : via-rhine
f1000000-f10000ff : 0000:00:10.4
  f1000000-f10000ff : ehci_hcd
f1800000-f18000ff : 0000:00:0c.0
  f1800000-f18000ff : sym53c8xx
f2000000-f3efffff : PCI Bus #01
  f2000000-f2ffffff : 0000:01:00.0
f3f00000-f7ffffff : PCI Bus #01
  f3fe0000-f3ffffff : 0000:01:00.0
  f4000000-f7ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
        Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8,x16
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f2000000-f3efffff
        Prefetchable memory behind bridge: f3f00000-f7ffffff
        Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)
        Subsystem: TERRATEC Electronic GmbH DMX 6fire 24/96
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at d800 [size=32]
        Region 1: I/O ports at d400 [size=16]
        Region 2: I/O ports at d000 [size=16]
        Region 3: I/O ports at b800 [size=64]
        Capabilities: [80] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at f1800000 (32-bit, non-prefetchable) [size=256]

00:0d.0 SCSI storage controller: Artop Electronic Corp AEC6712D SCSI (rev 01)
        Subsystem: Artop Electronic Corp AEC6712D SCSI
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at b000 [size=64]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 169
        Region 0: I/O ports at a800 [size=8]
        Region 1: I/O ports at a400 [size=4]
        Region 2: I/O ports at a000 [size=8]
        Region 3: I/O ports at 9800 [size=4]
        Region 4: I/O ports at 9400 [size=16]
        Region 5: I/O ports at 9000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 169
        Region 4: I/O ports at 8800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 201
        Region 4: I/O ports at 8400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 201
        Region 4: I/O ports at 8000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin B routed to IRQ 201
        Region 4: I/O ports at 7800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin B routed to IRQ 201
        Region 4: I/O ports at 7400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 10
        Interrupt: pin C routed to IRQ 201
        Region 0: Memory at f1000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80ed
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at 7000 [size=256]
        Region 1: Memory at f0800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2) (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 810b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at f3fe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>



[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: Color    Model: FlatbedScanner_9 Rev: 0113
  Type:   Scanner                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-3701TA Rev: 3615
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: YAMAHA   Model: CRW2100S         Rev: 1.0G
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3120026AS      Rev: 3.18
  Type:   Direct-Access                    ANSI SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

workarounds: to use the kernel 2.6.15



