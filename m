Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbUL1R1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUL1R1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUL1R1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:27:14 -0500
Received: from web60307.mail.yahoo.com ([216.109.118.118]:57168 "HELO
	web60307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261196AbUL1RZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:25:56 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=E8UuOydZG/c8vjpadI1VxxGgCjWdmjMBJT/rp/8UCtph327vfj72bE/Rr9WYn41SbjszkIBRZRndYHeh8pDTCvij5CXKi69Q019FfBJT9fri68sRtYvBLLJKm8W1C71y6fXxu+0KBygprjW7NcKwF3JM0YLF+S9lLbvHmR8P9fQ=  ;
Message-ID: <20041228172554.38787.qmail@web60307.mail.yahoo.com>
Date: Tue, 28 Dec 2004 09:25:54 -0800 (PST)
From: John Way <wayjd@yahoo.com>
Subject: PROBLEM: Sym-2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. New SYM-2 mess. MKINITRD complains.

2. I'm having a problem with the new SYM-2 drivers
when using the newly released 2.6.10 kernel. I've
tried compiling it into the kernel, and again as
modules, but still the 'mkinitrd" says "No module
sym53c8xx found for kernel 2.6.10, aborting." My scsi
drives are NOT my boot drives, they're just extra
storage. Everything worked perfectly with the
2.6.10-rc2 patched kernel and below.

3. initrd, modules, kernel, compiling

4. cat /proc/version
Linux version 2.6.10-rc2
(root@ip-xx-xx-xxx-xxx.valornet.com) (gcc version
3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Sun Nov 28
21:09:34 CST 2004

5. N/A

6. mkinitrd /boot/initrd-2.6.10.img 2.6.10
   No module sym53c8xx found for kernel 2.6.10,
aborting.

7. Environment (How the rest of this helps is beyond
me, what follows is info from a lesser kernel that
likes my scsi drives!)
7.1 Linux ip-xx-xx-xxx-xxx.valornet.com 2.6.10-rc2 #1
Sun Nov 28 21:09:34 CST 2004 i686 i686 i386 GNU/Linux

Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nls_iso8859_1 ntfs radeon
parport_pc lp parport autofs4 sunrpc ipt_REJECT
ipt_state ip_conntrack iptable_filter ip_tables vfat
fat video button md5 ipv6 usblp uhci_hcd tuner tvaudio
msp3400 bttv video_buf i2c_algo_bit v4l2_common
btcx_risc videodev i2c_viapro i2c_core snd_via82xx
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer snd_page_alloc gameport snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore via_rhine mii
floppy ext3 jbd sym53c8xx scsi_transport_spi sd_mod
scsi_mod

7.2 cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 4
cpu MHz         : 2401.228
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx
fxsr sse sse2 ssht tm
bogomips        : 4751.36

7.3 cat /proc/modules
nls_iso8859_1 4224 1 - Live 0xe0b65000
ntfs 103024 1 - Live 0xe0be2000
radeon 126052 2 - Live 0xe0bc2000
parport_pc 40132 1 - Live 0xe0aca000
lp 11820 0 - Live 0xe0ac6000
parport 34632 2 parport_pc,lp, Live 0xe0b55000
autofs4 18436 0 - Live 0xe0a95000
sunrpc 139236 1 - Live 0xe0b7b000
ipt_REJECT 7040 1 - Live 0xe0a5d000
ipt_state 1920 1 - Live 0xe0a93000
ip_conntrack 43924 1 ipt_state, Live 0xe0aba000
iptable_filter 3712 1 - Live 0xe087e000
ip_tables 18176 3 ipt_REJECT,ipt_state,iptable_filter,
Live 0xe0aa6000
vfat 13312 6 - Live 0xe0a8e000
fat 39712 1 vfat, Live 0xe0a9b000
video 15492 0 - Live 0xe085b000
button 6672 0 - Live 0xe0a58000
md5 4224 1 - Live 0xe0a40000
ipv6 244480 10 - Live 0xe0ad5000
usblp 12288 0 - Live 0xe0a3c000
uhci_hcd 30992 0 - Live 0xe0a85000
tuner 20772 0 - Live 0xe0a4b000
tvaudio 21920 0 - Live 0xe0a44000
msp3400 25000 0 - Live 0xe0a2d000
bttv 146768 0 - Live 0xe0a60000
video_buf 20740 1 bttv, Live 0xe0a35000
i2c_algo_bit 9352 1 bttv, Live 0xe0a29000
v4l2_common 6144 1 bttv, Live 0xe0927000
btcx_risc 4872 1 bttv, Live 0xe08f1000
videodev 9728 1 bttv, Live 0xe0923000
i2c_viapro 7436 0 - Live 0xe087b000
i2c_core 22032 6
tuner,tvaudio,msp3400,bttv,i2c_algo_bit,i2c_viapro,
Live 0xe0948000
snd_via82xx 26144 2 - Live 0xe0970000
snd_ac97_codec 68064 1 snd_via82xx, Live 0xe09b1000
snd_pcm_oss 50724 0 - Live 0xe09a3000
snd_mixer_oss 18304 2 snd_pcm_oss, Live 0xe0942000
snd_pcm 90504 3
snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live
0xe098b000
snd_timer 24708 1 snd_pcm, Live 0xe092c000
snd_page_alloc 9604 2 snd_via82xx,snd_pcm, Live
0xe082d000
gameport 4480 1 snd_via82xx, Live 0xe0858000
snd_mpu401_uart 7424 1 snd_via82xx, Live 0xe0855000
snd_rawmidi 24096 1 snd_mpu401_uart, Live 0xe0874000
snd_seq_device 8332 1 snd_rawmidi, Live 0xe0831000
snd 51556 11
snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
Live 0xe0934000
soundcore 9696 2 snd, Live 0xe0851000
via_rhine 21252 0 - Live 0xe084a000
mii 4992 1 via_rhine, Live 0xe082a000
floppy 57680 0 - Live 0xe0913000
ext3 121864 1 - Live 0xe08f4000
jbd 56728 1 ext3, Live 0xe08c1000
sym53c8xx 74136 4 - Live 0xe0860000
scsi_transport_spi 13824 1 sym53c8xx, Live 0xe0825000
sd_mod 15888 8 - Live 0xe0820000
scsi_mod 81376 3 sym53c8xx,scsi_transport_spi,sd_mod,
Live 0xe0835000

7.4 cat /proc/ioports
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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0400-0407 : viapro-smbus
0778-077a : parport0
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0820-0823 : GPE0_BLK
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  a800-a8ff : 0000:01:00.0
d800-d8ff : 0000:00:12.0
  d800-d8ff : via-rhine
dc00-dc1f : 0000:00:11.2
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:11.3
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:11.4
  e400-e41f : uhci_hcd
e800-e8ff : 0000:00:09.0
  e800-e8ff : sym53c8xx
ec00-ecff : 0000:00:11.5
  ec00-ecff : VIA8233
fc00-fc0f : 0000:00:11.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000cc000-000cf7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002b9085 : Kernel code
  002b9086-00351bff : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
cfb00000-dfbfffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
dfcfe000-dfcfefff : 0000:00:08.0
  dfcfe000-dfcfefff : bttv0
dfcff000-dfcfffff : 0000:00:08.1
dfd00000-dfefffff : PCI Bus #01
  dfe80000-dfefffff : 0000:01:00.0
dffffe00-dffffeff : 0000:00:12.0
  dffffe00-dffffeff : via-rhine
dfffff00-dfffffff : 0000:00:09.0
  dfffff00-dfffffff : sym53c8xx
e0000000-efffffff : 0000:00:00.0
fff80000-ffffffff : reserved

7.5 lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8753
[P4X266 AGP] (rev 01)
        Subsystem: VIA Technologies, Inc.: Unknown
device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit,
prefetchable) [size=256M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+
ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+
GART64- 64bit- FW- Rate=x1
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633
[Apollo Pro266 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: dfd00000-dfefffff
        Prefetchable memory behind bridge:
cfb00000-dfbfffff
        Secondary status: 66Mhz- FastB2B- ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort-
>Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:08.0 Multimedia video controller: Brooktree
Corporation Bt878 Video Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV
Series
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dfcfe000 (32-bit,
prefetchable) [size=4K]

00:08.1 Multimedia controller: Brooktree Corporation
Bt878 Audio Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV
Series
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dfcff000 (32-bit,
prefetchable) [size=4K]

00:09.0 SCSI storage controller: LSI Logic / Symbios
Logic 53c810 (rev 23)
        Subsystem: LSI Logic / Symbios Logic
LSI53C810AE PCI to SCSI I/O Processor
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 16000ns max), Cache
Line Size 20
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at dfffff00 (32-bit,
non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI
to ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown
device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master
IDE (rev 06) (prog-if 8a[Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus
Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.2 USB Controller: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (rev 1b) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID)
USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin D routed to IRQ 4
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.3 USB Controller: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (rev 1b) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID)
USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin D routed to IRQ 4
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.4 USB Controller: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (rev 1b) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID)
USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin D routed to IRQ 4
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:11.5 Multimedia audio controller: VIA Technologies,
Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 30)
        Subsystem: VIA Technologies, Inc.: Unknown
device 4511
        Control: I/O+ Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 3
        Region 0: I/O ports at ec00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:12.0 Ethernet controller: VIA Technologies, Inc.
VT6102 [Rhine-II] (rev 70)
        Subsystem: VIA Technologies, Inc. VT6102
[Rhine II] Embeded Ethernet Controller on VT8235
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache
Line Size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at dffffe00 (32-bit,
non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

01:00.0 VGA compatible controller: ATI Technologies
Inc Radeon R100 QD [Radeon 7200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon AIW
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d0000000 (32-bit,
prefetchable) [size=128M]
        Region 1: I/O ports at a800 [size=256]
        Region 2: Memory at dfe80000 (32-bit,
non-prefetchable) [size=512K]
        Expansion ROM at dfe60000 [disabled]
[size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+
ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+
GART64- 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

7.6 cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST32151N         Rev: 0284
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST32151N         Rev: 0284
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST32151N         Rev: 0154
  Type:   Direct-Access                    ANSI SCSI
revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: ST32151N         Rev: 0284
  Type:   Direct-Access                    ANSI SCSI
revision: 02

7.7 N/A

X. Thank you all for your time and effort.



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250
