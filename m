Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVKTHwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKTHwc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVKTHwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:52:32 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:26057 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S1750707AbVKTHwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:52:31 -0500
Date: Sat, 19 Nov 2005 23:52:33 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: unable to use dpkg 2.6.15-rc2
Message-ID: <20051120075233.GA20295@the-penguin.otak.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
X-Operating-System: Linux 2.6.15-rc1-mm1 on an i686
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is the second report of this error.

It's reproducible in 2.6.15-rc1, 2.6.15-rc1-mm1, 2.6.15-rc1-mm2 and
2.6.15-rc2.

It does not occur in 2.6.14.

Most easily triggered by "make clean" in the Linux source, for those of
you without access to dpkg. But both clean and dpkg will trigger it.

There are no oops.

I'm not sure what to report next, though If I were to guess it is a
interaction between XFS file system and SCSI. I've got another SCSI box
that is very similar that runs rc1, rc1-mm1 and rc1-mm2 just fine, the
only real difference being it has a ext3 file system instead.

The driver for the SCSI card (aic7xxx) did not appear change.=20
lspi says it's a Adaptec AIC-7892A U160/m (rev 2) card.

XFS looks like it's had extensive changes from 14 to 15-rc2.
There are many debugging options I could enable, but to be honest I'm not
sure what would be applicable in this circumstance.

Nothing in dmesg looks out of the ordinary.
Included  version info, cpuinfo, module info, driver info (/proc/ioports /p=
roc/iomem) pci info.

Questions, patches, flames are welcome.







If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux guillemot 2.6.15-rc2 #2 Sat Nov 19 22:33:39 PST 2005 i686 GNU/Linux
=20
Gnu C                  4.0.3
Gnu make               3.80
binutils               2.16.91
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.7.7
quota-tools            3.13.
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   074
Modules Loaded         radeon drm binfmt_misc lp thermal fan button process=
or ac battery ipv6 deflate zlib_deflate zlib_inflate twofish serpent aes_i5=
86 blowfish des sha256 sha1 md5 crypto_null mii radeonfb usbhid eth1394 snd=
_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul ohci1394 ie=
ee1394 sg st sr_mod cdrom snd_emu10k1 parport_pc snd_rawmidi snd_ac97_codec=
 snd_ac97_bus parport snd_util_mem via_agp skge sata_via libata agpgart snd=
_hwdep ehci_hcd uhci_hcd

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 10
model name	: AMD Athlon(TM) XP 2800+
stepping	: 0
cpu MHz		: 2071.500
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 4146.41


radeon 106080 0 - Live 0xe1bff000
drm 63188 1 radeon, Live 0xe1b96000
binfmt_misc 8712 1 - Live 0xe0b6d000
lp 9220 0 - Live 0xe0b69000
thermal 10568 0 - Live 0xe0b65000
fan 3204 0 - Live 0xe0a76000
button 4752 0 - Live 0xe0b46000
processor 14252 1 thermal, Live 0xe0b52000
ac 3268 0 - Live 0xe0a70000
battery 7428 0 - Live 0xe0a66000
ipv6 233408 14 - Live 0xe1bc5000
deflate 2816 0 - Live 0xe0a6e000
zlib_deflate 22744 1 deflate, Live 0xe0b59000
zlib_inflate 17536 1 deflate, Live 0xe0b4c000
twofish 44352 0 - Live 0xe0b10000
serpent 24576 0 - Live 0xe0b3f000
aes_i586 37760 0 - Live 0xe0b34000
blowfish 8832 0 - Live 0xe0b04000
des 16064 0 - Live 0xe0b0b000
sha256 10432 0 - Live 0xe0a72000
sha1 2368 0 - Live 0xe0a6c000
md5 3712 1 - Live 0xe09fe000
crypto_null 2112 0 - Live 0xe0a05000
mii 4608 0 - Live 0xe0a69000
radeonfb 83392 1 - Live 0xe0b1e000
usbhid 51488 0 - Live 0xe0a78000
eth1394 17096 0 - Live 0xe0a4f000
snd_emu10k1_synth 6016 0 - Live 0xe0810000
snd_emux_synth 32960 1 snd_emu10k1_synth, Live 0xe09d2000
snd_seq_virmidi 5312 1 snd_emux_synth, Live 0xe0813000
snd_seq_midi_emul 6272 1 snd_emux_synth, Live 0xe084a000
ohci1394 30452 0 - Live 0xe09b8000
ieee1394 286776 2 eth1394,ohci1394, Live 0xe0a07000
sg 27100 2 - Live 0xe086b000
st 37152 0 - Live 0xe09a3000
sr_mod 15076 0 - Live 0xe08a7000
cdrom 35936 1 sr_mod, Live 0xe08e6000
snd_emu10k1 106980 1 snd_emu10k1_synth, Live 0xe08f5000
parport_pc 36548 1 - Live 0xe08b4000
snd_rawmidi 19488 2 snd_seq_virmidi,snd_emu10k1, Live 0xe08a1000
snd_ac97_codec 87392 1 snd_emu10k1, Live 0xe08be000
snd_ac97_bus 1792 1 snd_ac97_codec, Live 0xe0869000
parport 32456 2 lp,parport_pc, Live 0xe0874000
snd_util_mem 3392 2 snd_emux_synth,snd_emu10k1, Live 0xe0855000
via_agp 7552 1 - Live 0xe0861000
skge 32848 0 - Live 0xe0857000
sata_via 5828 0 - Live 0xe0847000
libata 50828 1 sata_via, Live 0xe0825000
agpgart 27528 2 drm,via_agp, Live 0xe083f000
snd_hwdep 7008 2 snd_emux_synth,snd_emu10k1, Live 0xe0816000
ehci_hcd 43080 0 - Live 0xe0833000
uhci_hcd 29900 0 - Live 0xe081a000

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
0290-0297 : pnp 00:0c
02f8-02ff : serial
0370-0375 : pnp 00:0c
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
6800-68ff : 0000:00:13.0
7000-701f : 0000:00:10.3
  7000-701f : uhci_hcd
7400-741f : 0000:00:10.2
  7400-741f : uhci_hcd
7800-781f : 0000:00:10.1
  7800-781f : uhci_hcd
8000-801f : 0000:00:10.0
  8000-801f : uhci_hcd
8400-840f : 0000:00:0f.1
8800-88ff : 0000:00:0f.0
  8800-88ff : sata_via
9000-900f : 0000:00:0f.0
  9000-900f : sata_via
9400-9403 : 0000:00:0f.0
  9400-9403 : sata_via
9800-9807 : 0000:00:0f.0
  9800-9807 : sata_via
a000-a003 : 0000:00:0f.0
  a000-a003 : sata_via
a400-a407 : 0000:00:0f.0
  a400-a407 : sata_via
a800-a8ff : 0000:00:0d.0
  a800-a8ff : sym53c8xx
b000-b007 : 0000:00:0b.1
b400-b43f : 0000:00:0b.0
  b400-b43f : EMU10K1
b800-b8ff : 0000:00:09.0
  b800-b8ff : skge
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
e400-e47f : motherboard
  e400-e403 : PM1a_EVT_BLK
  e404-e405 : PM1a_CNT_BLK
  e408-e40b : PM_TMR
  e420-e423 : GPE0_BLK
e800-e81f : motherboard
  e800-e81f : pnp 00:01

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccfff : Video ROM
000d8000-000d81ff : Adapter ROM
000dc000-000e13ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1fffafff : System RAM
  00100000-0039fec6 : Kernel code
  0039fec7-0047db1f : Kernel data
1fffb000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
30000000-3001ffff : 0000:00:13.0
30020000-3002ffff : 0000:00:0d.0
bb000000-bb000fff : 0000:00:13.0
  bb000000-bb000fff : aic7xxx
bb800000-bb8000ff : 0000:00:10.4
  bb800000-bb8000ff : ehci_hcd
bc000000-bc000fff : 0000:00:0d.0
  bc000000-bc000fff : sym53c8xx
bc800000-bc8000ff : 0000:00:0d.0
  bc800000-bc8000ff : sym53c8xx
bd000000-bd003fff : 0000:00:0b.2
bd800000-bd8007ff : 0000:00:0b.2
  bd800000-bd8007ff : ohci1394
be000000-be003fff : 0000:00:09.0
  be000000-be003fff : skge
be800000-bfefffff : PCI Bus #01
  be800000-be80ffff : 0000:01:00.1
  bf000000-bf00ffff : 0000:01:00.0
    bf000000-bf00ffff : radeonfb mmio
c0000000-efffffff : PCI Bus #01
  c0000000-cfffffff : 0000:01:00.1
  dffe0000-dfffffff : 0000:01:00.0
  e0000000-efffffff : 0000:01:00.0
    e0000000-efffffff : radeonfb framebuffer
f0000000-f7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] H=
ost Bridge (rev 80)
	Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if =
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: be800000-bfefffff
	Prefetchable memory behind bridge: c0000000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T =
[Marvell] (rev 12)
	Subsystem: ASUSTeK Computer Inc. P4P800/K8V Deluxe motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at be000000 (32-bit, non-prefetchable) [size=3D16K]
	Region 1: I/O ports at b800 [size=3D256]
	Capabilities: <available only to root>

0000:00:0b.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs SB Audigy 2 ZS (SB0350)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at b400 [size=3D64]
	Capabilities: <available only to root>

0000:00:0b.1 Input device controller: Creative Labs SB Audigy MIDI/Game por=
t (rev 04)
	Subsystem: Creative Labs SB Audigy MIDI/Game Port
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at b000 [size=3D8]
	Capabilities: <available only to root>

0000:00:0b.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (r=
ev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at bd800000 (32-bit, non-prefetchable) [size=3D2K]
	Region 1: Memory at bd000000 (32-bit, non-prefetchable) [size=3D16K]
	Capabilities: <available only to root>

0000:00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev=
 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a800 [size=3D256]
	Region 1: Memory at bc800000 (32-bit, non-prefetchable) [size=3D256]
	Region 2: Memory at bc000000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at 30020000 [disabled] [size=3D64K]

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RA=
ID Controller (rev 80)
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe/K8V-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at a400 [size=3D8]
	Region 1: I/O ports at a000 [size=3D4]
	Region 2: I/O ports at 9800 [size=3D8]
	Region 3: I/O ports at 9400 [size=3D4]
	Region 4: I/O ports at 9000 [size=3D16]
	Region 5: I/O ports at 8800 [size=3D256]
	Capabilities: <available only to root>

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B=
/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 14
	Region 4: I/O ports at 8400 [disabled] [size=3D16]
	Capabilities: <available only to root>

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 =
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 4: I/O ports at 8000 [size=3D32]
	Capabilities: <available only to root>

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 =
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 4: I/O ports at 7800 [size=3D32]
	Capabilities: <available only to root>

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 =
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 18
	Region 4: I/O ports at 7400 [size=3D32]
	Capabilities: <available only to root>

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 =
Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 18
	Region 4: I/O ports at 7000 [size=3D32]
	Capabilities: <available only to root>

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-=
if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at bb800000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: <available only to root>

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8=
T800/K8T890 South]
	Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:13.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	BIST result: 00
	Region 0: I/O ports at 6800 [disabled] [size=3D256]
	Region 1: Memory at bb000000 (64-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at 30000000 [disabled] [size=3D128K]
	Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AP [Rade=
on 9600] (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology: Unknown device 4022
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
	Region 1: I/O ports at d800 [size=3D256]
	Region 2: Memory at bf000000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at dffe0000 [disabled] [size=3D128K]
	Capabilities: <available only to root>

0000:01:00.1 Display controller: ATI Technologies Inc RV350 AP [Radeon 9600=
] (Secondary)
	Subsystem: Giga-byte Technology: Unknown device 4023
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=3D256M]
	Region 1: Memory at be800000 (32-bit, non-prefetchable) [size=3D64K]
	Capabilities: <available only to root>

--=20
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - -=20



--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDgCtBsgPkFxgrWYkRAug3AJ9Q+MDV/692dnXDzHd4NxIyDhYAIACbBgXo
/H39RXjT2sQX0YYhsGph8ew=
=l5sW
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
