Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312409AbSDSNpj>; Fri, 19 Apr 2002 09:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSDSNpi>; Fri, 19 Apr 2002 09:45:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47763 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S312409AbSDSNpf>;
	Fri, 19 Apr 2002 09:45:35 -0400
Message-ID: <3CBEC67F.3000909@filez>
Date: Thu, 18 Apr 2002 15:13:35 +0200
From: "Dr. Death" <drd@homeworld.ath.cx>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.9+) Gecko/20020412
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A CD with errors (scratches etc.) blocks the whole system while reading
 damadged files
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
damaged part of the file !

My CDRom drive is a HP8100i  IDE CD Writer attached as HDD at the onbord 
IDE Controller



test case:

md5 "/cdrom/damaged file"



cat /proc/version output:

Linux version 2.4.4-4GB (root@Pentium.suse.de) (gcc version 2.95.3 
20010315 (SuSE)) #1 Wed May 16 00:37:55 GMT 2001



linux_ver output:

Linux filez 2.4.4-4GB #1 Wed May 16 00:37:55 GMT 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1343073 Mai 11  2001 
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         ppp_async ppp_generic nls_iso8859-1 snd-pcm-oss 
snd-pcm-plugin snd-mixer-oss snd-synth-emu8000 snd-synth-emux 
snd-seq-midi-emul snd-seq-virmidi snd-emux-mem snd-seq-midi 
snd-seq-midi-event snd-seq snd-card-sbawe isa-pnp snd-sb16-csp 
snd-sb16-dsp snd-pcm snd-mixer snd-opl3 snd-hwdep snd-timer 
snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore af_packet nfsd 
lp parport usbcore ne2k-pci 8390 hisax isdn loop_fish2 ide-scsi rtl8139 
reiserfs



cat /proc/cpuinfo output:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 7
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 0
cpu MHz         : 267.281
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 532.48



cat /proc/modules output:

ppp_async               6480   0 (autoclean) (unused)
ppp_generic            14416   0 (autoclean) [ppp_async]
nls_iso8859-1           2880   1 (autoclean)
snd-pcm-oss            18816   1 (autoclean)
snd-pcm-plugin         15024   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           5120   0 (autoclean) [snd-pcm-oss]
snd-synth-emu8000      16176   0 (unused)
snd-synth-emux         26592   0 [snd-synth-emu8000]
snd-seq-midi-emul       4480   0 [snd-synth-emux]
snd-seq-virmidi         8496   0 [snd-synth-emux]
snd-emux-mem            1616   0 [snd-synth-emu8000 snd-synth-emux]
snd-seq-midi            3568   0 (unused)
snd-seq-midi-event      2992   0 [snd-seq-virmidi snd-seq-midi]
snd-seq                42656   0 [snd-synth-emux snd-seq-virmidi 
snd-seq-midi snd-seq-midi-event]
snd-card-sbawe          5536   1
isa-pnp                28176   0 [snd-card-sbawe]
snd-sb16-csp           15888   0 [snd-card-sbawe]
snd-sb16-dsp           15888   0 [snd-card-sbawe snd-sb16-csp]
snd-pcm                30560   0 [snd-pcm-oss snd-pcm-plugin snd-sb16-dsp]
snd-mixer              24224   0 [snd-mixer-oss snd-synth-emu8000 
snd-sb16-csp snd-sb16-dsp]
snd-opl3                4848   0 [snd-card-sbawe]
snd-hwdep               3376   0 [snd-sb16-csp snd-opl3]
snd-timer               8560   0 [snd-seq snd-pcm snd-opl3]
snd-mpu401-uart         2512   0 [snd-card-sbawe]
snd-rawmidi             9664   0 [snd-seq-midi snd-mpu401-uart]
snd-seq-device          4032   0 [snd-synth-emu8000 snd-synth-emux 
snd-seq-midi snd-seq snd-card-sbawe snd-rawmidi]
snd                    34032   1 [snd-pcm-oss snd-pcm-plugin 
snd-mixer-oss snd-synth-emu8000 snd-synth-emux snd-seq-virm
idi snd-emux-mem snd-seq-midi snd-seq-midi-event snd-seq snd-card-sbawe 
snd-sb16-csp snd-sb16-dsp snd-pcm snd-mixer snd-
opl3 snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3632   7 [snd]
af_packet              11648   2 (autoclean)
nfsd                   67280   4 (autoclean)
lp                      5392   0 (autoclean)
parport                24352   0 (autoclean) [lp]
usbcore                47120   0 (autoclean)
ne2k-pci                4640   1 (autoclean)
8390                    6240   0 (autoclean) [ne2k-pci]
hisax                 496192   1
isdn                  123056   2 [hisax]
loop_fish2              9280   0 (unused)
ide-scsi                7856   1
rtl8139                11520   1
reiserfs              156432   3




cat /proc/ioports output:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : Sound Blaster AWE32/64
0330-0331 : Sound Blaster AWE32/64 - MPU-401
0376-0376 : ide1
0388-038b : Sound Blaster AWE32/64 - FM
03c0-03df : vga+
03f6-03f6 : ide0
0620-0623 : Sound Blaster AWE32/64 - WaveTable
0a20-0a23 : Sound Blaster AWE32/64 - WaveTable
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : Sound Blaster AWE32/64 - WaveTable
4000-40ff : PCI device 1106:3040
c000-cfff : PCI Bus #01
d000-d00f : PCI device 1106:0571
  d000-d007 : ide0
  d008-d00f : ide1
d800-d8ff : PCI device 10ec:8139
  d800-d8ff : 8139too
dc00-dc1f : PCI device 1244:0a00
  dc00-dc1f : avm PCI
e000-e01f : PCI device 10ec:8029
  e000-e01f : ne2k-pci




cat /proc/iomem  output:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-002327d1 : Kernel code
  002327d2-0031bdcb : Kernel data
e0000000-e3ffffff : PCI device 1106:0598
e4000000-e40000ff : PCI device 10ec:8139
  e4000000-e40000ff : 8139too
e4001000-e400101f : PCI device 1244:0a00
ffff0000-ffffffff : reserved




lspci -vvv output:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
[Apollo VP] (rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at d000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Network controller: AVM Audiovisuelles MKTG & Computer System 
GmbH A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH 
FRITZ!Card ISDN Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e4001000 (32-bit, non-prefetchable) [size=32]
        Region 1: I/O ports at dc00 [size=32]

00:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at e000 [size=32]




cat /proc/scsi/scsi output:

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer+ 8100  Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02



/var/log/messages

Apr 18 15:06:18 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x03 00 00 00 40 00
Apr 18 15:06:20 filez kernel: hdd: irq timeout: status=0xd0 { Busy }
Apr 18 15:06:20 filez kernel: hdd: ATAPI reset complete
Apr 18 15:06:20 filez kernel: hdd: irq timeout: status=0x80 { Busy }
Apr 18 15:06:20 filez kernel: hdd: ATAPI reset complete
Apr 18 15:06:21 filez kernel: hdd: irq timeout: status=0x80 { Busy }
Apr 18 15:06:21 filez kernel: hdd: status error: status=0x08 { DataRequest }
Apr 18 15:06:21 filez kernel: hdd: drive not ready for command
Apr 18 15:06:21 filez kernel: SCSI cdrom error : host 0 channel 0 id 0 
lun 0 return code = 27000002
Apr 18 15:06:21 filez kernel:  I/O error: dev 0b:00, sector 5780
Apr 18 15:06:51 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:51 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:51 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:51 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:51 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:51 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:52 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:52 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:52 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:52 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:52 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:52 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:53 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:53 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:53 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:53 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:53 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:53 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:54 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:54 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:54 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:54 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:54 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:54 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:55 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:55 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:55 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:55 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:55 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:55 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:56 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:56 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:56 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:56 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:56 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:56 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:57 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x28 00 00 00 05 24 00 00 39 00
Apr 18 15:06:57 filez kernel: SCSI host 0 abort (pid 0) timed out - 
resetting
Apr 18 15:06:57 filez kernel: SCSI bus is being reset for host 0 channel 0.
Apr 18 15:06:59 filez kernel: scsi : aborting command due to timeout : 
pid 0, scsi0, channel 0, id 0, lun 0 0x03 00 00 00 40 00
Apr 18 15:06:59 filez kernel: hdd: irq timeout: status=0xd0 { Busy }
Apr 18 15:06:59 filez kernel: hdd: ATAPI reset complete
Apr 18 15:06:59 filez kernel: hdd: irq timeout: status=0x80 { Busy }
Apr 18 15:06:59 filez kernel: hdd: ATAPI reset complete





Have i forget something ? If yes just Mail me

Frederik Reiss





