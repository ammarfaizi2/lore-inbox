Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUEPJea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUEPJea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 05:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUEPJea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 05:34:30 -0400
Received: from 203-217-20-18.dyn.iinet.net.au ([203.217.20.18]:23026 "EHLO
	europa.rmlx.dyndns.org") by vger.kernel.org with ESMTP
	id S263413AbUEPJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 05:34:11 -0400
From: "roger@msn" <roger_seguin@msn.com>
Date: Sun, 16 May 2004 19:33:49 +0000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161933.50080."roger@msn">
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
Full deadlock after a few hours utilization of any 2.6 kernels

[2.] Full description of the problem/report:
The following has been happening with all 2.6 (Vanilia or Mandrake) kernels, 
except with 2.6.4rc1 which seemed to work fine (but rc2 had the same problem 
as the other releases).
1. Boot a 2.6 kernel
2. Wait a few hours (e.g. 5 hours)
3. Start surfing the Net intensively
4. A few minutes after, the browser (Netscape) will not be able to access the 
requested www html page, then after a few seconds a full deadlock will occur 
(machine not even been reachable (ping) from another machine on the Samba 
network), the only possibility left being switching the power off.

Note:
1. Surfing the Net just after booting doesn't end up in deadlock, you need to 
do it after the machine has been up for a few hours.
2. The deadlock occurs whether the kernel has been compiled with the 
preemptive feature or not
3. No deadlock at all with a 2.4 kernel

[3.] Keywords (i.e., modules, networking, kernel):
Kernel?

[4.] Kernel version (from /proc/version):
Currently 2.6.6
But same problem with all previous 2.6 kernels

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
No oops, no messages displayed

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux europa 2.6.6-1mdk #1 Fri May 14 05:00:50 UTC 2004 i686 unknown unknown 
GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
binutils               2.14.90.0.5
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.11a
e2fsprogs              1.34
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         ide-floppy ide-tape joydev sidewinder gameport sg st 
sr_mod sd_mod ide-scsi scsi_mod ide-cd cdrom floppy binfmt_misc autofs4 nfsd 
exportfs parport_pc lp parport ipt_TOS ipt_REJECT ipt_LOG ipt_state 
ip_nat_irc ip_nat_tftp ip_nat_ftp ip_conntrack_irc ip_conntrack_tftp 
ip_conntrack_ftp ipt_multiport ipt_conntrack iptable_filter iptable_mangle 
iptable_nat ip_conntrack ip_tables snd-seq-midi snd-emu10k1-synth 
snd-emux-synth snd-seq-virmidi snd-seq-midi-emul snd-seq-oss 
snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-rawmidi 
snd-pcm snd-timer snd-seq-device snd-ac97-codec snd-page-alloc snd-util-mem 
snd-hwdep snd soundcore ipv6 ppp_async ppp_generic slhc af_packet 8139too mii 
ohci1394 ieee1394 nls_iso8859-1 ntfs nls_cp437 msdos fat supermount nvidia 
usblp uhci-hcd usbcore rtc ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping        : 2
cpu MHz         : 1794.649
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3555.32

[7.3.] Module information (from /proc/modules):
cat /proc/modules
ide-floppy 19456 0 - Live 0xd2f9c000
ide-tape 36176 0 - Live 0xd2fd8000
joydev 10176 0 - Live 0xd2f88000
sidewinder 14464 0 - Live 0xd2f83000
gameport 4736 1 sidewinder, Live 0xd2f03000
sg 38428 0 - Live 0xd2fc2000
st 41244 0 - Live 0xd2f90000
sr_mod 18724 0 - Live 0xd2f7d000
sd_mod 22144 0 - Live 0xd2f1d000
ide-scsi 17156 0 - Live 0xd2f17000
scsi_mod 120780 5 sg,st,sr_mod,sd_mod,ide-scsi, Live 0xd2fa3000
ide-cd 42884 0 - Live 0xd2f71000
cdrom 39968 2 sr_mod,ide-cd, Live 0xd2f35000
floppy 60500 0 - Live 0xd2f25000
binfmt_misc 10248 1 - Live 0xd2eff000
autofs4 15104 2 - Live 0xd2ee2000
nfsd 194336 8 - Live 0xd2f40000
exportfs 6272 1 nfsd, Live 0xd2eec000
parport_pc 34752 1 - Live 0xd2f06000
lp 12488 0 - Live 0xd2ee7000
parport 40392 2 parport_pc,lp, Live 0xd2eef000
ipt_TOS 2688 12 - Live 0xd1d84000
ipt_REJECT 7296 4 - Live 0xd1dc1000
ipt_LOG 6528 6 - Live 0xd1db7000
ipt_state 2304 16 - Live 0xd1db1000
ip_nat_irc 4464 0 - Live 0xd1dac000
ip_nat_tftp 3696 0 - Live 0xd1d82000
ip_nat_ftp 5104 0 - Live 0xd1d73000
ip_conntrack_irc 71476 1 ip_nat_irc, Live 0xd1d99000
ip_conntrack_tftp 3860 0 - Live 0xd1d36000
ip_conntrack_ftp 72244 1 ip_nat_ftp, Live 0xd1d86000
ipt_multiport 2304 2 - Live 0xd1d80000
ipt_conntrack 2816 0 - Live 0xd1d38000
iptable_filter 3072 1 - Live 0xd199c000
iptable_mangle 3072 1 - Live 0xd1803000
iptable_nat 23980 3 ip_nat_irc,ip_nat_tftp,ip_nat_ftp, Live 0xd1d29000
ip_conntrack 34176 9 
ipt_state,ip_nat_irc,ip_nat_tftp,ip_nat_ftp,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp,ipt_conntrack,iptable_nat, 
Live 0xd1d76000
ip_tables 17152 9 
ipt_TOS,ipt_REJECT,ipt_LOG,ipt_state,ipt_multiport,ipt_conntrack,iptable_filter,iptable_mangle,iptable_nat, 
Live 0xd1d30000
snd-seq-midi 8608 0 - Live 0xd1b04000
snd-emu10k1-synth 7936 0 - Live 0xd1aa4000
snd-emux-synth 36736 1 snd-emu10k1-synth, Live 0xd1d60000
snd-seq-virmidi 7424 1 snd-emux-synth, Live 0xd1a35000
snd-seq-midi-emul 8448 1 snd-emux-synth, Live 0xd1a0f000
snd-seq-oss 32896 0 - Live 0xd1d56000
snd-seq-midi-event 7680 3 snd-seq-midi,snd-seq-virmidi,snd-seq-oss, Live 
0xd1a0c000
snd-seq 50704 8 
snd-seq-midi,snd-emux-synth,snd-seq-virmidi,snd-seq-midi-emul,snd-seq-oss,snd-seq-midi-event, 
Live 0xd1d48000
snd-pcm-oss 52644 0 - Live 0xd1d3a000
snd-mixer-oss 19584 2 snd-pcm-oss, Live 0xd1a9e000
snd-emu10k1 94852 2 snd-emu10k1-synth, Live 0xd1aa9000
snd-rawmidi 23840 3 snd-seq-midi,snd-seq-virmidi,snd-emu10k1, Live 0xd1a1d000
snd-pcm 93092 2 snd-pcm-oss,snd-emu10k1, Live 0xd1a39000
snd-timer 24580 2 snd-seq,snd-pcm, Live 0xd1a15000
snd-seq-device 8456 7 
snd-seq-midi,snd-emu10k1-synth,snd-emux-synth,snd-seq-oss,snd-seq,snd-emu10k1,snd-rawmidi, 
Live 0xd1998000
snd-ac97-codec 62724 1 snd-emu10k1, Live 0xd19ac000
snd-page-alloc 11652 2 snd-emu10k1,snd-pcm, Live 0xd1994000
snd-util-mem 4864 2 snd-emux-synth,snd-emu10k1, Live 0xd1991000
snd-hwdep 9376 2 snd-emux-synth,snd-emu10k1, Live 0xd198d000
snd 53220 16 
snd-seq-midi,snd-emux-synth,snd-seq-virmidi,snd-seq-oss,snd-seq-midi-event,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-emu10k1,snd-rawmidi,snd-pcm,snd-timer,snd-seq-device,snd-ac97-codec,snd-util-mem,snd-hwdep, 
Live 0xd199e000
soundcore 9952 2 snd, Live 0xd1989000
ipv6 239328 14 - Live 0xd1a51000
ppp_async 12160 0 - Live 0xd1961000
ppp_generic 29332 1 ppp_async, Live 0xd1980000
slhc 7552 1 ppp_generic, Live 0xd18dc000
af_packet 21128 0 - Live 0xd1979000
8139too 24960 0 - Live 0xd1971000
mii 5376 1 8139too, Live 0xd18df000
ohci1394 34948 0 - Live 0xd1967000
ieee1394 318776 1 ohci1394, Live 0xd19bd000
nls_iso8859-1 4352 3 - Live 0xd18c8000
ntfs 89932 3 - Live 0xd18e3000
nls_cp437 6016 1 - Live 0xd18c5000
msdos 9088 1 - Live 0xd1841000
fat 45888 1 msdos, Live 0xd1829000
supermount 38292 3 - Live 0xd1836000
nvidia 2074792 12 - Live 0xd1b0b000
usblp 12800 0 - Live 0xd1824000
uhci-hcd 30480 0 - Live 0xd180c000
usbcore 103644 4 usblp,uhci-hcd, Live 0xd1866000
rtc 11960 0 - Live 0xd1808000
ext3 121192 12 - Live 0xd1847000
jbd 56344 1 ext3, Live 0xd1815000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0800-087f : 0000:00:1f.0
0880-08bf : 0000:00:1f.0
0cf8-0cff : PCI conf1
dcd0-dcdf : 0000:00:1f.3
e800-e8ff : 0000:02:09.0
  e800-e8ff : 8139too
ecc0-ecdf : 0000:02:08.0
  ecc0-ecdf : EMU10K1
ecf0-ecf7 : 0000:02:08.1
ecf8-ecff : 0000:02:07.0
ff60-ff7f : 0000:00:1f.4
  ff60-ff7f : uhci_hcd
ff80-ff9f : 0000:00:1f.2
  ff80-ff9f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

cat /proc/iomem 
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000cc7ff : Video ROM
000cc800-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0ff76fff : System RAM
  00100000-002d63df : Kernel code
  002d63e0-003b7dff : Kernel data
0ff77000-0ff78fff : ACPI Non-volatile Storage
0ff79000-0fffffff : reserved
e8000000-efffffff : 0000:00:00.0
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
    f0000000-f0ffffff : vesafb
fc000000-fdffffff : PCI Bus #01
  fc000000-fcffffff : 0000:01:00.0
fe1e8000-fe1ebfff : 0000:02:0a.0
fe1ef000-fe1ef7ff : 0000:02:0a.0
  fe1ef000-fe1ef7ff : ohci1394
fe1efc00-fe1efcff : 0000:02:09.0
  fe1efc00-fe1efcff : 8139too
fe1f0000-fe1fffff : 0000:02:07.0
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
lspci -vvv
00:00.0 Host bridge: Intel Corp. 82850 850 (Tehama) Chipset Host Bridge (MCH) 
(rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 010c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4

00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 04) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 04) (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe100000-fe2fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) (prog-if 80 
[Master])
        Subsystem: Dell Computer Corporation: Unknown device 010c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04) (prog-if 
00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 010c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 010c
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at dcd0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04) (prog-if 
00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 010c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at ff60 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 
400] (rev b2) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 010f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at 80000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4

02:07.0 Communication controller: Conexant HCF 56k Data/Fax Modem (rev 08)
        Subsystem: GVC Corporation Dell Silver
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fe1f0000 (32-bit, non-prefetchable) [size=64K]
        Region 1: I/O ports at ecf8 [size=8]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs CT4780 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ecc0 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at ecf0 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: GVC Corporation: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at fe1efc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller 
(Link) (prog-if 10 [OHCI])
        Subsystem: Dell Computer Corporation: Unknown device 8010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 1000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fe1ef000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at fe1e8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
N/A

[X.] Other notes, patches, fixes, workarounds:
My system runs mandrake 9.2 on a Dell Dimension 8200
- P4 1.8 GHz, no hyperthreading
- 256 Rambus memory
- 2 IDE disks, all partitions are ext3 except for /boot which is ext2
- One swap partition on each of both disks with same swapping priority (swap 
simultaneously on both partitions)
- Ethernet Realtek 8139
- nvidia GeForce2 MX 400 64 MB, NVIDIA-Linux-x86-1.0-5336-pkg1.run driver

