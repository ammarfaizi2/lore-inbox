Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWBBPMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWBBPMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWBBPM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:12:29 -0500
Received: from mail.bio.unipd.it ([147.162.3.2]:16278 "EHLO mail.bio.unipd.it")
	by vger.kernel.org with ESMTP id S1751109AbWBBPM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:12:29 -0500
Message-ID: <43E2217B.9050404@bio.unipd.it>
Date: Thu, 02 Feb 2006 16:12:59 +0100
From: "Fabio d'Alessi" <cars@bio.unipd.it>
Organization: Department of Biology, University of Padova - Italy.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG at lib/kernel_lock.c:199!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear sirs,
I have a problem with a dual athlon xp running fedora/4
with the 2.6.14-1 kernel. Hard locks. Please if anyone
knows a solution or workaround please contact me at
cars@bio.unipd.it. Many thanks and keep up the best
work.

fda


[1.] Machine lock

[2.] Server randomly locks up without any error
or message.

[3.] kernel

[4.] uname -r : 2.6.14-1.1656_FC4smp

[5.] in the last lockup I have found this only
line in /var/log/messages:
Feb  2 15:27:32 telethon kernel: kernel BUG at lib/kernel_lock.c:199!

[6.] not reproducible - random error

[7.]
[7.1] standard fedora 4 install - nothing new added, just the
drivers for the nv graphic board.


[7.2] /proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 2000+
stepping        : 2
cpu MHz         : 1666.855
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3340.03

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 2000+
stepping        : 2
cpu MHz         : 1666.855
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3333.75




[7.3]

cat /proc/modules

ipt_MASQUERADE 7745 1 - Live 0xf8dba000
iptable_nat 11717 1 - Live 0xf8db2000
ip_nat 22869 2 ipt_MASQUERADE,iptable_nat, Live 0xf8dca000
ip_conntrack 56861 3 ipt_MASQUERADE,iptable_nat,ip_nat, Live 0xf8e29000
nfnetlink 10585 2 ip_nat,ip_conntrack, Live 0xf8d97000
iptable_filter 7105 1 - Live 0xf8add000
ip_tables 25409 3 ipt_MASQUERADE,iptable_nat,iptable_filter, Live 0xf8e0f000
parport_pc 31877 0 - Live 0xf8e06000
lp 16905 0 - Live 0xf8da3000
parport 39561 2 parport_pc,lp, Live 0xf8dbf000
autofs4 23621 1 - Live 0xf8dab000
i2c_dev 13889 0 - Live 0xf8d92000
i2c_core 26177 1 i2c_dev, Live 0xf8d9b000
nfs 212264 1 - Live 0xf8dd1000
lockd 64329 2 nfs, Live 0xf8b4f000
nfs_acl 7873 1 nfs, Live 0xf8ada000
rfcomm 47193 0 - Live 0xf8b7a000
l2cap 34113 5 rfcomm, Live 0xf8b70000
bluetooth 57029 4 rfcomm,l2cap, Live 0xf8b61000
sunrpc 145917 4 nfs,lockd,nfs_acl, Live 0xf8d6d000
reiserfs 267061 2 - Live 0xf8b87000
dm_mod 61277 0 - Live 0xf8b2d000
nvidia 4095984 12 - Live 0xf8f31000
ipv6 270881 82 - Live 0xf8a07000
ohci_hcd 26849 0 - Live 0xf89a0000
ehci_hcd 38733 0 - Live 0xf89ac000
hw_random 9557 0 - Live 0xf8946000
snd_cmipci 36961 0 - Live 0xf8995000
gameport 19785 1 snd_cmipci, Live 0xf889d000
snd_seq_dummy 7749 0 - Live 0xf8937000
snd_seq_oss 36161 0 - Live 0xf898b000
snd_seq_midi_event 11073 1 snd_seq_oss, Live 0xf8929000
snd_seq 54993 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 
0xf896b000
snd_pcm_oss 54641 0 - Live 0xf897c000
snd_mixer_oss 21953 1 snd_pcm_oss, Live 0xf893f000
snd_pcm 91717 2 snd_cmipci,snd_pcm_oss, Live 0xf8953000
snd_page_alloc 14793 1 snd_pcm, Live 0xf8924000
snd_opl3_lib 14529 1 snd_cmipci, Live 0xf88f2000
snd_timer 28997 3 snd_seq,snd_pcm,snd_opl3_lib, Live 0xf892e000
snd_hwdep 13153 1 snd_opl3_lib, Live 0xf88ed000
snd_mpu401_uart 11713 1 snd_cmipci, Live 0xf883e000
snd_rawmidi 28897 1 snd_mpu401_uart, Live 0xf891b000
snd_seq_device 13005 5 
snd_seq_dummy,snd_seq_oss,snd_seq,snd_opl3_lib,snd_rawmidi, Live 0xf88a3000
snd 59045 12 
snd_cmipci,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xf88d0000
soundcore 13857 1 snd, Live 0xf884f000
3c59x 45801 0 - Live 0xf88e0000
mii 9281 1 3c59x, Live 0xf8842000
floppy 66053 0 - Live 0xf8878000
ext3 135241 1 - Live 0xf88f8000
jbd 61909 1 ext3, Live 0xf888c000
raid1 25153 1 - Live 0xf8847000
aic7xxx 154485 1 - Live 0xf88a9000
scsi_transport_spi 25153 1 aic7xxx, Live 0xf8828000
sd_mod 22721 2 - Live 0xf8830000
scsi_mod 140137 3 aic7xxx,scsi_transport_spi,sd_mod, Live 0xf8854000


[7.5]

cat /proc/iomem

00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cc7ff : Video ROM
000d0000-000d69ff : Adapter ROM
000d8000-000d87ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
   00100000-0031df91 : Kernel code
   0031df92-003e99a3 : Kernel data
50000000-5001ffff : 0000:00:09.0
50020000-5003ffff : 0000:00:09.1
ea000000-ecffffff : PCI Bus #02
   ea000000-ea0000ff : 0000:02:08.2
     ea000000-ea0000ff : ehci_hcd
   ea800000-ea800fff : 0000:02:08.1
     ea800000-ea800fff : ohci_hcd
   eb000000-eb000fff : 0000:02:08.0
     eb000000-eb000fff : ohci_hcd
   eb800000-eb80007f : 0000:02:06.0
   ec000000-ec00007f : 0000:02:05.0
ed000000-ed000fff : 0000:00:09.1
   ed000000-ed000fff : aic7xxx
ed800000-ed800fff : 0000:00:09.0
   ed800000-ed800fff : aic7xxx
ee000000-efcfffff : PCI Bus #01
   ee000000-eeffffff : 0000:01:05.0
     ee000000-eeffffff : nvidia
efd00000-efdfffff : PCI Bus #02
   efd00000-efd1ffff : 0000:02:05.0
   efd20000-efd3ffff : 0000:02:06.0
eff00000-fb7fffff : PCI Bus #01
   efff0000-efffffff : 0000:01:05.0
   f0000000-f7ffffff : 0000:01:05.0
fb800000-fb800fff : 0000:00:00.0
fc000000-fdffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

#cat /proc/ioports

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
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #02
   b000-b07f : 0000:02:06.0
     b000-b07f : 0000:02:06.0
   b400-b47f : 0000:02:05.0
     b400-b47f : 0000:02:05.0
   b800-b8ff : 0000:02:04.0
     b800-b8ff : CMI8738-MC6
d000-d0ff : 0000:00:09.1
d400-d4ff : 0000:00:09.0
d800-d80f : 0000:00:07.1
   d800-d807 : ide0
   d808-d80f : ide1
e800-e803 : 0000:00:00.0







[7.5] lspci -vvv





00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
         Region 1: Memory at fb800000 (32-bit, prefetchable) [size=4K]
         Region 2: I/O ports at e800 [disabled] [size=4]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
AGP Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: ee000000-efcfffff
         Prefetchable memory behind bridge: eff00000-fb7fffff
         Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
         Subsystem: ASUSTeK Computer Inc. A7M-D Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04) (prog-if 8a [Master SecP PriP])
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at d800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
         Subsystem: ASUSTeK Computer Inc. A7M-D Mainboard
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m 
(rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (10000ns min, 6250ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 145
         BIST result: 00
         Region 0: I/O ports at d400 [disabled] [size=256]
         Region 1: Memory at ed800000 (64-bit, non-prefetchable) [size=4K]
         [virtual] Expansion ROM at 50000000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m 
(rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (10000ns min, 6250ns max), Cache Line Size 08
         Interrupt: pin B routed to IRQ 153
         BIST result: 00
         Region 0: I/O ports at d000 [disabled] [size=256]
         Region 1: Memory at ed000000 (64-bit, non-prefetchable) [size=4K]
         [virtual] Expansion ROM at 50020000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 
04) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000b000-0000bfff
         Memory behind bridge: ea000000-ecffffff
         Prefetchable memory behind bridge: efd00000-efdfffff
         Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev b2) (prog-if 00 [VGA])
         Subsystem: ABIT Computer Corp.: Unknown device 6109
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 137
         Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at efff0000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4

02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
         Subsystem: ASUSTeK Computer Inc. CMI8738 6-channel audio controller
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (500ns min, 6000ns max)
         Interrupt: pin A routed to IRQ 145
         Region 0: I/O ports at b800 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 74)
         Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 153
         Region 0: I/O ports at b400 [size=128]
         Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=128]
         [virtual] Expansion ROM at efd00000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:06.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 145
         Region 0: I/O ports at b000 [size=128]
         Region 1: Memory at eb800000 (32-bit, non-prefetchable) [size=128]
         [virtual] Expansion ROM at efd20000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. PCI-USB2 (OHCI subsystem)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (250ns min, 10500ns max), Cache Line Size 08
         Interrupt: pin A routed to IRQ 161
         Region 0: Memory at eb000000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. PCI-USB2 (OHCI subsystem)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (250ns min, 10500ns max), Cache Line Size 08
         Interrupt: pin B routed to IRQ 137
         Region 0: Memory at ea800000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. PCI-USB2 (EHCI subsystem)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (4000ns min, 8500ns max), Cache Line Size 10
         Interrupt: pin C routed to IRQ 145
         Region 0: Memory at ea000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-






cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 06 Lun: 00
   Vendor: IBM      Model: DNES-309170W     Rev: SA30
   Type:   Direct-Access                    ANSI SCSI revision: 03



