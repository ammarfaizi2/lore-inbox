Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWCIXVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWCIXVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWCIXVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:21:34 -0500
Received: from valinor.lockfile.org ([195.149.74.78]:56448 "EHLO
	valinor.lockfile.org") by vger.kernel.org with ESMTP
	id S932097AbWCIXVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:21:32 -0500
Message-ID: <4410B86E.9060809@lockfile.org>
Date: Fri, 10 Mar 2006 00:21:18 +0100
From: Jason Brian Friedrich <mail@lockfile.org>
Reply-To: mail@lockfile.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7 Mnenhy/0.7.3.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Booting Kernel 2.6.15 let the machine freeze completely
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

##################################################
### Keywords
##################################################

ACPI, APIC, PCI, IO scheduler

##################################################
### Description
##################################################

I tried Kernel 2.6.15 in many different variations, from boot cds, 
live cds, (i.e. Gentoo 2006.0, Ubuntu Dapper) compiled one myself with 
several configurations, with RAMdisk and without. But everytime the 
same result.

With the parameters "noapic nolapic acpi=off" the systems freezes 
after the text line "Booting kernel......". When i use the parameters 
"noapic nolapic acpi=offpci=usepirqmask" i get a bit further in the 
booting process and get these lines before the system freezes completely:

io scheduler deadline registered
io scheduler cfq registered

A screenshot of this moment is available at 
http://lockfile.org/upload/dapper_error.jpg and was made when trying 
an Ubuntu Dapper live-CD. It is the same error messaage i receive with 
various other boot or live cds, even with the self-compiled kernel. 
The cds work absolutely fine on my two other system around. I also 
have the last available BIOS version on my system. Because of the 
"2.6.15 issue", i had to collect the output below from my running 
2.6.14 on Fedore Core 4.

##################################################
### System details
##################################################

Mainboard: MSI 865PE Neo2-PFS PE (MS-6728, BIOS version 6728V3.A)
CPU: Pentium 4 3 Ghz (HT)
RAM: Kingston 1024 MB DDR RAM
HDD: 1 x S-ATA  80 GB
      1 x P-ATA 120 GB
      1 x P-ATA 120 GB
DVD: 1 x LG DVD-RW
Graphic card: NVidia Geforce 6800 GT (AGP)

##################################################
### ver_linux output
##################################################

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux gondor.mittelerde 2.6.14-1.1656_FC4smp #1 SMP Thu Jan 5 22:24:06 
EST 2006 i686 i686 i386 GNU/Linux

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
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   071
Modules Loaded         parport_pc lp parport autofs4 dm_mod ipv6 
uhci_hcd ehci_hcd bt878 tuner tvaudio bttv video_buf i2c_algo_bit 
v4l2_common btcx_risc tveeprom videodev snd_bt87x i2c_i801 i2c_core 
emu10k1_gp gameport snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_seq_dummy 
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd_ac97_bus snd_page_alloc 
snd_util_mem snd_hwdep snd soundcore r8169 ext3 jbd ata_piix libata 
sd_mod scsi_mod

##################################################
### /proc/cpuinfo output
##################################################

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 3
cpu MHz		: 3000.628
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor 
ds_cpl cid
bogomips	: 6009.23

##################################################
### /proc/modules output
##################################################

parport_pc 31877 0 - Live 0xf8b49000
lp 16905 0 - Live 0xf8add000
parport 39561 2 parport_pc,lp, Live 0xf8b1a000
autofs4 23621 1 - Live 0xf8a99000
dm_mod 61277 0 - Live 0xf8b2d000
ipv6 270881 10 - Live 0xf8b6a000
uhci_hcd 36817 0 - Live 0xf8ac1000
ehci_hcd 38733 0 - Live 0xf8b0f000
bt878 14681 0 - Live 0xf8abc000
tuner 42997 0 - Live 0xf8acb000
tvaudio 27485 0 - Live 0xf8aab000
bttv 169713 1 bt878, Live 0xf8ae4000
video_buf 26053 1 bttv, Live 0xf8ab4000
i2c_algo_bit 13257 1 bttv, Live 0xf8aa6000
v4l2_common 9921 1 bttv, Live 0xf896a000
btcx_risc 9161 1 bttv, Live 0xf8a2c000
tveeprom 17617 1 bttv, Live 0xf8aa0000
videodev 13633 1 bttv, Live 0xf8a31000
snd_bt87x 18697 0 - Live 0xf8a51000
i2c_i801 13133 0 - Live 0xf88fe000
i2c_core 26177 6 tuner,tvaudio,bttv,i2c_algo_bit,tveeprom,i2c_i801, 
Live 0xf8a49000
emu10k1_gp 7873 0 - Live 0xf8915000
gameport 19785 2 emu10k1_gp, Live 0xf8a43000
snd_emu10k1_synth 11201 0 - Live 0xf8907000
snd_emux_synth 38977 1 snd_emu10k1_synth, Live 0xf8a38000
snd_seq_virmidi 11457 1 snd_emux_synth, Live 0xf8903000
snd_seq_midi_emul 10945 1 snd_emux_synth, Live 0xf88ad000
snd_emu10k1 117733 1 snd_emu10k1_synth, Live 0xf89a9000
snd_rawmidi 28897 2 snd_seq_virmidi,snd_emu10k1, Live 0xf8950000
snd_ac97_codec 92605 1 snd_emu10k1, Live 0xf896e000
snd_seq_dummy 7749 0 - Live 0xf88b1000
snd_seq_oss 36161 0 - Live 0xf890b000
snd_seq_midi_event 11073 2 snd_seq_virmidi,snd_seq_oss, Live 0xf8816000
snd_seq 54993 8 
snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, 
Live 0xf8941000
snd_seq_device 13005 7 
snd_emu10k1_synth,snd_emux_synth,snd_emu10k1,snd_rawmidi,snd_seq_dummy,snd_seq_oss,snd_seq, 
Live 0xf88cd000
snd_pcm_oss 54641 0 - Live 0xf8932000
snd_mixer_oss 21953 1 snd_pcm_oss, Live 0xf88b5000
snd_pcm 91717 4 snd_bt87x,snd_emu10k1,snd_ac97_codec,snd_pcm_oss, Live 
0xf891a000
snd_timer 28997 3 snd_emu10k1,snd_seq,snd_pcm, Live 0xf88f5000
snd_ac97_bus 6465 1 snd_ac97_codec, Live 0xf88aa000
snd_page_alloc 14793 3 snd_bt87x,snd_emu10k1,snd_pcm, Live 0xf8894000
snd_util_mem 8897 2 snd_emux_synth,snd_emu10k1, Live 0xf8826000
snd_hwdep 13153 2 snd_emux_synth,snd_emu10k1, Live 0xf888f000
snd 59045 14 
snd_bt87x,snd_emux_synth,snd_seq_virmidi,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_hwdep, 
Live 0xf88bd000
soundcore 13857 1 snd, Live 0xf882c000
r8169 33097 0 - Live 0xf8885000
ext3 135241 3 - Live 0xf88d2000
jbd 61909 1 ext3, Live 0xf8899000
ata_piix 13509 3 - Live 0xf8821000
libata 51533 1 ata_piix, Live 0xf8831000
sd_mod 22721 4 - Live 0xf881a000
scsi_mod 140137 2 libata,sd_mod, Live 0xf8861000

##################################################
### /proc/ioports output
##################################################

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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-043f : 0000:00:1f.0
0800-087f : 0000:00:1f.0
0c00-0c1f : 0000:00:1f.3
   0c00-0c0f : i801-smbus
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #02
   b400-b4ff : 0000:02:06.0
     b400-b4ff : r8169
   b800-b81f : 0000:02:02.0
     b800-b81f : EMU10K1
   bc00-bc07 : 0000:02:02.1
     bc00-bc07 : emu10k1-gp
cc00-cc1f : 0000:00:1d.0
   cc00-cc1f : uhci_hcd
d000-d01f : 0000:00:1d.1
   d000-d01f : uhci_hcd
d400-d41f : 0000:00:1d.2
   d400-d41f : uhci_hcd
d800-d81f : 0000:00:1d.3
   d800-d81f : uhci_hcd
dc00-dc0f : 0000:00:1f.2
   dc00-dc0f : libata
e000-e003 : 0000:00:1f.2
   e000-e003 : libata
e400-e407 : 0000:00:1f.2
   e400-e407 : libata
e800-e803 : 0000:00:1f.2
   e800-e803 : libata
ec00-ec07 : 0000:00:1f.2
   ec00-ec07 : libata
fc00-fc0f : 0000:00:1f.1
   fc00-fc07 : ide0
   fc08-fc0f : ide1

##################################################
### /proc/iomem output
##################################################

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000d0000-000da013 : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-0031df91 : Kernel code
   0031df92-003e99a3 : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
50000000-500003ff : 0000:00:1f.1
cfe00000-efdfffff : PCI Bus #01
   d0000000-dfffffff : 0000:01:00.0
efe00000-efefffff : PCI Bus #02
   efe00000-efe1ffff : 0000:02:06.0
   efefe000-efefefff : 0000:02:03.0
     efefe000-efefefff : bttv0
   efeff000-efefffff : 0000:02:03.1
     efeff000-efefffff : Bt87x audio
f0000000-f7ffffff : 0000:00:00.0
fa900000-fe9fffff : PCI Bus #01
   fc000000-fcffffff : 0000:01:00.0
   fd000000-fdffffff : 0000:01:00.0
   fe9e0000-fe9fffff : 0000:01:00.0
fea00000-feafffff : PCI Bus #02
   feafff00-feafffff : 0000:02:06.0
     feafff00-feafffff : r8169
febffc00-febfffff : 0000:00:1d.7
   febffc00-febfffff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff00000-ffffffff : reserved

##################################################
### lspci -vvv output
##################################################

00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7280
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] Vendor Specific Information
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- 
FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP 
Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fa900000-fe9fffff
	Prefetchable memory behind bridge: cfe00000-efdfffff
	Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at cc00 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 7
	Region 4: I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at d800 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: efe00000-efefffff
	Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC 
Interface Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA 
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ec00 [size=8]
	Region 1: I/O ports at e800 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at dc00 [size=16]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus 
Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 0c00 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 
0047 (rev a1) (prog-if 00 [VGA])
	Subsystem: eVga.com. Corp.: Unknown device e387
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at fe9e0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 07)
	Subsystem: Creative Labs SBLive! 5.1 Model SB0100
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at bc00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at efefe000 (32-bit, prefetchable) [size=4K]

02:03.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at efeff000 (32-bit, prefetchable) [size=4K]

02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 728c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max), Cache Line Size 20
	Interrupt: pin A routed to IRQ 6
	Region 0: I/O ports at b400 [size=256]
	Region 1: Memory at feafff00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at efe00000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

##################################################
### /proc/swcsi/scsi output
##################################################

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD1200JS-00M Rev: 02.0
   Type:   Direct-Access                    ANSI SCSI revision: 05
