Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVASTDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVASTDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVASTDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:03:04 -0500
Received: from adicia.telenet-ops.be ([195.130.132.56]:45457 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261845AbVASS45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:56:57 -0500
From: Lennert Van Alboom <lennert.vanalboom@ugent.be>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: possible memleak in 2.6.11-rc1
Date: Wed, 19 Jan 2005 19:56:40 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2233650.U9hdKTl4ox";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501191956.48228.lennert.vanalboom@ugent.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2233650.U9hdKTl4ox
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[1.] One line summary of the problem:
Possible memleak in 2.6.11-rc1?

[2.] Full description of the problem/report:
I compiled a vanilla 2.6.11-rc1 kernel with the .config from my (working)=20
2.6.10 kernel; whenever I use it, my memory is slowly eaten. The "Active:"=
=20
part of /proc/meminfo goes up until my machine starts lagging, up to a poin=
t=20
where it is no longer usable. It doesn't seem to be application related:=20
first of all this doesn't happen with 2.6.10, even though no apps have been=
=20
updated, and the problem remains in runlevel 1 (195 megs active ram in=20
runlevel 1 after ~10 hours and going up, compared to 9 megs in normal=20
conditions). I applied the bk6 patches and the problem remains.

[3.] Keywords (i.e., modules, networking, kernel):
kernel, memleak

[4.] Kernel version (from /proc/version):
2.6.11-rc1-bk6

[5.] Output of Oops.. message (if applicable):
none

[6.] A small shell script or example program which triggers the problem (if=
=20
possible):
none (or rather: no need, always happens)

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux HamsterPower 2.6.11-rc1-bk6-HamsterKernel #1 Wed Jan 19 08:04:32 CET=
=20
2005 i686 AMD Athlon(tm) XP 2100+ unknown GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.19
reiser4progs           line
nfs-utils              1.0.7
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
/usr/src/linux-2.6.11-rc1-bk6/scripts/ver_linux: line 90: udevinfo: command=
=20
notfound
Modules Loaded         floppy sg sd_mod scsi_mod nfsd exportfs lockd sunrpc=
=20
snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k=
1=20
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc=
=20
snd_util_mem snd_hwdep snd soundcore af_packet 3c59x mii loop nls_iso8859_1=
5=20
nls_cp850 vfatfat w83781d i2c_viapro i2c_isa i2c_sensor i2c_core nvidia=20
ide_cd cdrom usblp ehci_hcd uhci_hcd usbcore rtc reiserfs

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 2100+
stepping        : 2
cpu MHz         : 1734.317
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmovpat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
bogomips        : 3407.87

[7.3.] Module information (from /proc/modules):
floppy 44240 0 - Live 0xe2857000
sg 25312 0 - Live 0xe17b1000
sd_mod 9680 0 - Live 0xe1778000
scsi_mod 55792 2 sg,sd_mod, Live 0xe1769000
nfsd 79688 9 - Live 0xe17c2000
exportfs 3776 1 nfsd, Live 0xe12b2000
lockd 49896 2 nfsd, Live 0xe177d000
sunrpc 101828 12 nfsd,lockd, Live 0xe178c000
snd_seq_oss 24768 0 - Live 0xe1761000
snd_seq_midi_event 3904 1 snd_seq_oss, Live 0xe129f000
snd_seq 37840 4 snd_seq_oss,snd_seq_midi_event, Live 0xe173a000
snd_pcm_oss 40672 0 - Live 0xe174a000
snd_mixer_oss 13952 1 snd_pcm_oss, Live 0xe1735000
snd_emu10k1 80708 1 - Live 0xe166f000
snd_rawmidi 14688 1 snd_emu10k1, Live 0xe1659000
snd_seq_device 4108 4 snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi, Live=20
0xe1656000
snd_ac97_codec 57088 1 snd_emu10k1, Live 0xe1699000
snd_pcm 62024 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec, Live 0xe1688000
snd_timer 16132 3 snd_seq,snd_emu10k1,snd_pcm, Live 0xe165e000
snd_page_alloc 4292 2 snd_emu10k1,snd_pcm, Live 0xe12af000
snd_util_mem 1408 1 snd_emu10k1, Live 0xe129d000
snd_hwdep 4704 1 snd_emu10k1, Live 0xe129a000
snd 32228 13=20
snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_s=
eq_device,snd_ac97_codec,snd_pcm,snd_timer,snd_hwdep,=20
Live 0xe1666000
soundcore 4384 1 snd, Live 0xe127b000
af_packet 12872 0 - Live 0xe12a1000
3c59x 28520 0 - Live 0xe12a7000
mii 2752 1 3c59x, Live 0xe1290000
loop 9544 0 - Live 0xe1296000
nls_iso8859_15 3392 1 - Live 0xe1284000
nls_cp850 3648 1 - Live 0xe127e000
vfat 8832 1 - Live 0xe1280000
fat 30240 1 vfat, Live 0xe1287000
w83781d 22760 0 - Live 0xe0efb000
i2c_viapro 4044 0 - Live 0xe0e2c000
i2c_isa 960 0 - Live 0xe0e2e000
i2c_sensor 1792 1 w83781d, Live 0xe0e1c000
i2c_core 12176 4 w83781d,i2c_viapro,i2c_isa,i2c_sensor, Live 0xe0e14000
nvidia 3207836 12 - Live 0xe12b4000
ide_cd 31300 0 - Live 0xe0e5f000
cdrom 31840 1 ide_cd, Live 0xe0e56000
usblp 8064 0 - Live 0xe0e19000
ehci_hcd 23240 0 - Live 0xe0e25000
uhci_hcd 23696 0 - Live 0xe0e1e000
usbcore 79928 4 usblp,ehci_hcd,uhci_hcd, Live 0xe0e34000
rtc 7928 0 - Live 0xe0e11000
reiserfs 206576 7 - Live 0xe0d08000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem):
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
0170-0177 : ide3
01f0-01f7 : ide2
0290-0297 : w83781d
0376-0376 : ide3
03c0-03df : vesafb
03f6-03f6 : ide2
0400-0407 : viapro-smbus
0cf8-0cff : PCI conf1
c400-c41f : 0000:00:10.0
  c400-c41f : uhci_hcd
c800-c81f : 0000:00:10.1
  c800-c81f : uhci_hcd
cc00-cc1f : 0000:00:10.2
  cc00-cc1f : uhci_hcd
d000-d01f : 0000:00:07.0
  d000-d01f : EMU10K1
d400-d47f : 0000:00:06.0
  d400-d47f : 0000:00:06.0
d800-d80f : 0000:00:0c.0
  d800-d807 : ide0
  d808-d80f : ide1
dc00-dc03 : 0000:00:0c.0
e000-e007 : 0000:00:0c.0
e400-e403 : 0000:00:0c.0
  e402-e402 : ide0
e800-e807 : 0000:00:0c.0
  e800-e807 : ide0
ec00-ec07 : 0000:00:07.1
fc00-fc0f : 0000:00:11.1
  fc00-fc07 : ide2
  fc08-fc0f : ide3

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00279e5e : Kernel code
  00279e5f-002c433f : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
cdb00000-ddcfffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
    d0000000-d7ffffff : vesafb
  ddc80000-ddcfffff : 0000:01:00.0
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : 0000:01:00.0
    de000000-deffffff : nvidia
dfff0000-dfff3fff : 0000:00:07.2
dfff7000-dfff77ff : 0000:00:07.2
dfff7e00-dfff7eff : 0000:00:10.3
  dfff7e00-dfff7eff : ehci_hcd
dfff7f80-dfff7fff : 0000:00:06.0
dfffc000-dfffffff : 0000:00:0c.0
e0000000-e7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root):
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans-=20
64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- =
=46W-=20
Rate=3Dx4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 A=
GP]=20
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: cdb00000-ddcfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:06.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev=
=20
78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Managem=
ent=20
NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d400 [size=3D128]
        Region 1: Memory at dfff7f80 (32-bit, non-prefetchable) [size=3D128]
        Expansion ROM at dffc0000 [disabled] [size=3D128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

00:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
        Subsystem: Creative Labs SB0090 Audigy Player/OEM
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=3D32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (re=
v=20
03)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at ec00 [size=3D8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (prog-i=
f=20
10[OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at dfff7000 (32-bit, non-prefetchable) [size=3D2K]
        Region 1: Memory at dfff0000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20276 (MBFastTrak1=
33=20
Lite) (rev 01) (prog-if 85)
        Subsystem: Promise Technology, Inc. MBFastTrak133 Lite (tm) Control=
ler=20
(RAID mode)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-=20
<TAbort-<MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at e800 [size=3D8]
        Region 1: I/O ports at e400 [size=3D4]
        Region 2: I/O ports at e000 [size=3D8]
        Region 3: I/O ports at dc00 [size=3D4]
        Region 4: I/O ports at d800 [size=3D16]
        Region 5: Memory at dfffc000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at c400 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at c800 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 21
        Region 4: I/O ports at cc00 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20=
=20
[EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at dfff7e00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.=20
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8=
a=20
[Master SecP PriP])
        Subsystem: VIA Technologies, Inc.=20
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at fc00 [size=3D16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 420=
0]=20
(rev a3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=3D16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
        Region 2: Memory at ddc80000 (32-bit, prefetchable) [size=3D512K]
        Expansion ROM at dfee0000 [disabled] [size=3D128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans-=20
64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit-=
 FW-=20
Rate=3Dx4


[7.6.] SCSI information (from /proc/scsi/scsi):
none

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
/proc/devices:
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
 14 sound
 21 sg
 29 fb
116 alsa
128 ptm
136 pts
180 usb
195 nvidia
254 devfs

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  7 loop
  8 sd
 33 ide2
 34 ide3
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd

/proc/dma:
 4: cascade

/proc/fb:
0 VESA VGA

/proc/interrupts:
           CPU0
  0:    2150774    IO-APIC-edge  timer
  1:       5785    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
 12:     110604    IO-APIC-edge  i8042
 14:      21945    IO-APIC-edge  ide2
 15:       2565    IO-APIC-edge  ide3
 16:     152804   IO-APIC-level  nvidia
 17:       4189   IO-APIC-level  eth0
 18:          0   IO-APIC-level  EMU10K1
 19:       4430   IO-APIC-level  ide0
 21:        146   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd, ehci_hcd
NMI:          0
LOC:    2150800
ERR:          0
MIS:          0

/proc/mtrr:
reg00: base=3D0x00000000 (   0MB), size=3D 512MB: write-back, count=3D1
reg01: base=3D0xd0000000 (3328MB), size=3D 128MB: write-combining, count=3D1
reg02: base=3D0xe0000000 (3584MB), size=3D 128MB: write-combining, count=3D1

=2E.. I can't see anything useful in there, but that's mostprobably just me.


[X.] Other notes, patches, fixes, workarounds:
My kernel config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11-rc1-bk6
# Wed Jan 19 08:00:57 2005
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_LOCK_KERNEL=3Dy

#
# General setup
#
CONFIG_LOCALVERSION=3D"-HamsterKernel"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=3D17
CONFIG_HOTPLUG=3Dy
CONFIG_KOBJECT_UEVENT=3Dy
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=3Dy
# CONFIG_KALLSYMS is not set
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=3Dy
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_HPET_TIMER=3Dy
# CONFIG_SMP is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
CONFIG_EDD=3Dy
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=3Dy
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D32000
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dy
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_OFFBOARD=3Dy
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy
CONFIG_PDC202XX_FORCE=3Dy
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dm
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=3Dm
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=3Dy
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_IPRANGE=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
# CONFIG_IP_NF_MATCH_MARK is not set
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CLK_JIFFIES=3Dy
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dm
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_VORTEX=3Dm
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
CONFIG_LP_CONSOLE=3Dy
CONFIG_PPDEV=3Dm
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dm
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=3Dy
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_CHARDEV=3Dm

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCF=3Dm
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=3Dm
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=3Dm
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=3Dm
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=3Dm
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=3Dy
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=3Dm
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=3Dm
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy
# CONFIG_USB_OTG is not set
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_UHCI_HCD=3Dm
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dm

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be neede=
d;=20
see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_RW_DETECT=3Dy
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dm
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_DEVFS_FS=3Dy
CONFIG_DEVFS_MOUNT=3Dy
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dm
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dm
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES_586=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_CRC32C=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dm
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy



Hope I didn't add too much crap or forgot too much needed info here. :)
I'm not subscribed to the list, so I'd be most grateful if anyone who repli=
es=20
could be so kind as to put my address in CC.=20

Thanks,

Lennert

--nextPart2233650.U9hdKTl4ox
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB7q1wo6KaR1afCnARAnKqAKCXKWvNMe9aWgDZy4vq0qyzne66oQCgq0rm
gYU9vRch8MlHisV5nsM7BVc=
=OW6u
-----END PGP SIGNATURE-----

--nextPart2233650.U9hdKTl4ox--
