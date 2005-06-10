Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVFJNxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVFJNxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVFJNxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:53:12 -0400
Received: from h01.hostsharing.net ([212.42.230.152]:29863 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S262523AbVFJNwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:52:15 -0400
Message-ID: <42A99B03.7070908@newthinking.de>
Date: Fri, 10 Jun 2005 15:52:03 +0200
From: Alexander Scheibner <alexander.scheibner@newthinking.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: de-de, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug at fs/jbd/checkpoint.c:613
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020901000803060404080506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901000803060404080506
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

[1.] One line summary of the problem:
System got completely frozen

[2.] Full description of the problem/report:
- System got completely frozen, exept for the mouse pointer
- Switching to another screen via STR+ALT+Fx not working
- no service (ssh, samba, mail, ftp) was available any more
- syslog reportet Kernel bug (localhost kernel: kernel BUG at 
fs/jbd/checkpoint.c:613!)

[3.] Keywords (i.e., modules, networking, kernel):
system frozen, kernel bug

[4.] Kernel version (from /proc/version):
Linux version 2.6.8-2-686-smp (horms@tabatha.lab.ultramonkey.org) (gcc 
version 3.3.5 (Debian 1:3.3.5-12)) #1 SMP Thu May 19 17:27:55 JST 2005

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
/var/log/syslog snapshot directly before system died:
see attachment: syslog

[6.] A small shell script or example program which triggers the
      problem (if possible)
n/a

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux morpheus 2.6.8-2-686-smp #1 SMP Thu May 19 17:27:55 JST 2005 i686 
GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
PPP                    2.4.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         radeon parport_pc lp parport ipv6 eth1394 
sata_promise ohci1394 e1000 snd_intel8x0 snd_ac97_codec snd_pcm 
snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi 
snd_seq_device snd i810_audio ac97_codec soundcore ata_piix libata 
hw_random ehci_hcd uhci_hcd usbcore shpchp pciehp pci_hotplugintel_agp 
intel_mch_agp agpgart tsdev mousedev evdev capability commoncap sr_mod 
sd_mod sbp2 scsi_mod ieee1394 psmouse ide_cd cdrom genrtc ext3 jbd 
mbcache ide_generic piix ide_disk ide_core unix font vesafb cfbcopyarea 
cfbimgblt cfbfillrect

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 3000.253
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmovpat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni 
monitor ds_cpl cid
bogomips        : 5947.39

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 3000.253
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmovpat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni 
monitor ds_cpl cid
bogomips        : 5980.16


[7.3.] Module information (from /proc/modules):
radeon 132596 2 - Live 0xf8cc8000
parport_pc 37796 1 - Live 0xf8c32000
lp 11496 0 - Live 0xf8c0b000
parport 43272 2 parport_pc,lp, Live 0xf8c19000
ipv6 281764 34 - Live 0xf8c5c000
eth1394 22664 0 - Live 0xf8bf1000
sata_promise 10436 0 - Live 0xf8b51000
ohci1394 36804 0 - Live 0xf8b24000
e1000 86884 0 - Live 0xf8b9d000
snd_intel8x0 37452 0 - Live 0xf8b42000
snd_ac97_codec 70884 1 snd_intel8x0, Live 0xf8b70000
snd_pcm 102948 1 snd_intel8x0, Live 0xf8b55000
snd_timer 27492 1 snd_pcm, Live 0xf8b2e000
snd_page_alloc 12008 2 snd_intel8x0,snd_pcm, Live 0xf8af9000
gameport 5120 1 snd_intel8x0, Live 0xf8b05000
snd_mpu401_uart 8640 1 snd_intel8x0, Live 0xf8b01000
snd_rawmidi 26084 1 snd_mpu401_uart, Live 0xf8b1c000
snd_seq_device 8456 1 snd_rawmidi, Live 0xf8afd000
snd 59620 7 
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xf8b0c000
i810_audio 39860 0 - Live 0xf8ac0000
ac97_codec 19212 1 i810_audio, Live 0xf8a5e000
soundcore 10880 2 snd,i810_audio, Live 0xf8abc000
ata_piix 8388 2 - Live 0xf8a89000
libata 42116 2 sata_promise,ata_piix, Live 0xf8aeb000
hw_random 5844 0 - Live 0xf8a5b000
ehci_hcd 33188 0 - Live 0xf8ab2000
uhci_hcd 34096 0 - Live 0xf8aa8000
usbcore 122148 4 ehci_hcd,uhci_hcd, Live 0xf8acc000
shpchp 102860 0 - Live 0xf8a6e000
pciehp 99756 0 - Live 0xf8a8e000
pci_hotplug 35708 2 shpchp,pciehp, Live 0xf8a64000
intel_agp 23072 0 - Live 0xf8a34000
intel_mch_agp 10832 1 - Live 0xf8a30000
agpgart 35436 3 intel_agp,intel_mch_agp, Live 0xf8a3c000
tsdev 7616 0 - Live 0xf8a05000
mousedev 10736 2 - Live 0xf8a2c000
evdev 9824 0 - Live 0xf8a28000
capability 4744 0 - Live 0xf8a08000
commoncap 7552 1 capability, Live 0xf8829000
sr_mod 17764 0 - Live 0xf8a1d000
sd_mod 22144 4 - Live 0xf8a16000
sbp2 24968 0 - Live 0xf8a0e000
scsi_mod 127972 5 sata_promise,libata,sr_mod,sd_mod,sbp2, Live 0xf89c6000
ieee1394 113784 3 eth1394,ohci1394,sbp2, Live 0xf89e8000
psmouse 20616 0 - Live 0xf889a000
ide_cd 43232 0 - Live 0xf89ba000
cdrom 41148 2 sr_mod,ide_cd, Live 0xf89ae000
genrtc 10616 0 - Live 0xf882c000
ext3 129704 6 - Live 0xf883a000
jbd 70584 1 ext3, Live 0xf8885000
mbcache 10340 1 ext3, Live 0xf881f000
ide_generic 1632 0 - Live 0xf88bc000
piix 13824 1 - Live 0xf88a1000
ide_disk 19648 6 - Live 0xf885b000
ide_core 142556 4 ide_cd,ide_generic,piix,ide_disk, Live 0xf8861000
unix 31156 617 - Live 0xf8831000
font 8544 0 - Live 0xf8823000
vesafb 6880 0 - Live 0xf8816000
cfbcopyarea 4096 1 vesafb, Live 0xf881d000
cfbimgblt 3264 1 vesafb, Live 0xf881b000
cfbfillrect 4000 1 vesafb, Live 0xf8819000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0800-087f : 0000:00:1f.0
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
   b000-b0ff : 0000:01:00.0
c000-cfff : PCI Bus #02
   cf80-cf9f : 0000:02:01.0
     cf80-cf9f : e1000
d880-d8ff : 0000:03:04.0
   d880-d8ff : sata_promise
dc00-dc7f : 0000:03:03.0
df00-df3f : 0000:03:04.0
   df00-df3f : sata_promise
dfa0-dfaf : 0000:03:04.0
   dfa0-dfaf : sata_promise
e800-e8ff : 0000:00:1f.5
   e800-e8ff : Intel ICH5
ee80-eebf : 0000:00:1f.5
   ee80-eebf : Intel ICH5
eec0-eedf : 0000:00:1d.0
   eec0-eedf : uhci_hcd
ef00-ef1f : 0000:00:1d.1
   ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.2
   ef20-ef3f : uhci_hcd
ef40-ef5f : 0000:00:1d.3
   ef40-ef5f : uhci_hcd
ef90-ef9f : 0000:00:1f.2
   ef90-ef9f : libata
efa0-efa7 : 0000:00:1f.2
   efa0-efa7 : libata
efa8-efab : 0000:00:1f.2
   efa8-efab : libata
efac-efaf : 0000:00:1f.2
   efac-efaf : libata
efe0-efe7 : 0000:00:1f.2
   efe0-efe7 : libata
fc00-fc0f : 0000:00:1f.1
   fc00-fc07 : ide0
   fc08-fc0f : ide1

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-3ff2ffff : System RAM
   00100000-0029ff60 : Kernel code
   0029ff61-0036015f : Kernel data
3ff30000-3ff3ffff : ACPI Tables
3ff40000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
40000000-400003ff : 0000:00:1f.1
e7f00000-f7efffff : PCI Bus #01
   e8000000-efffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fe800000-fe8fffff : PCI Bus #01
   fe8f0000-fe8fffff : 0000:01:00.0
fe900000-fe9fffff : PCI Bus #02
   fe9e0000-fe9fffff : 0000:02:01.0
     fe9e0000-fe9fffff : e1000
feac0000-feadffff : 0000:03:04.0
   feac0000-feadffff : sata_promise
feafe000-feafefff : 0000:03:04.0
   feafe000-feafefff : sata_promise
feaff800-feafffff : 0000:03:03.0
   feaff800-feafffff : ohci1394
febff000-febff0ff : 0000:00:1f.5
   febff000-febff0ff : ich_audio MBBAR
febff400-febff5ff : 0000:00:1f.5
   febff400-febff5ff : ich_audio MMBAR
febff800-febffbff : 0000:00:1d.7
   febff800-febffbff : ehci_hcd
ffb80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
         Subsystem: Asustek Computer, Inc.: Unknown device 80f6
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-<MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [e4] #09 [2106]
         Capabilities: [a0] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x1

0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller 
(rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-<MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000b000-0000bfff
         Memory behind bridge: fe800000-fe8fffff
         Prefetchable memory behind bridge: e7f00000-f7efffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA 
Bridge (rev02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-<MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: fe900000-fe9fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 169
         Region 4: I/O ports at eec0 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 177
         Region 4: I/O ports at ef00 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 185
         Region 4: I/O ports at ef20 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 169
         Region 4: I/O ports at ef40 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 193
         Region 0: Memory at febff800 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort-<MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fea00000-feafffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge 
(rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra 
ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 185
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at fc00 [size=16]
         Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 
Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
         Subsystem: Asustek Computer, Inc.: Unknown device 80a6
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 185
         Region 0: I/O ports at efe0 [size=8]
         Region 1: I/O ports at efac [size=4]
         Region 2: I/O ports at efa0 [size=8]
         Region 3: I/O ports at efa8 [size=4]
         Region 4: I/O ports at ef90 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller 
(rev 02)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 201
         Region 4: I/O ports at 0400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER 
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 201
         Region 0: I/O ports at e800 [size=256]
         Region 1: I/O ports at ee80 [size=64]
         Region 2: Memory at febff400 (32-bit, non-prefetchable) [size=512]
         Region 3: Memory at febff000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon 
RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
         Subsystem: PC Partner Limited: Unknown device 7c28
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min), Cache Line Size: 0x04 (16 bytes)
         Interrupt: pin A routed to IRQ 169
         Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
         Region 1: I/O ports at b000 [size=256]
         Region 2: Memory at fe8f0000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at fe8c0000 [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x1
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet 
Controller (LOM)
         Subsystem: Asustek Computer, Inc.: Unknown device 80f7
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (63750ns min), Cache Line Size: 0x04 (16 bytes)
         Interrupt: pin A routed to IRQ 185
         Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at cf80 [size=32]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 808a
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns max), Cache Line Size: 0x04 (16 bytes)
         Interrupt: pin A routed to IRQ 209
         Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
         Region 1: I/O ports at dc00 [size=128]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 
(FastTrak 378/SATA 378) (rev 02)
         Subsystem: Asustek Computer, Inc. PC-DL Deluxe motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 0x91 
(580 bytes)
         Interrupt: pin A routed to IRQ 193
         Region 0: I/O ports at df00 [size=64]
         Region 1: I/O ports at dfa0 [size=16]
         Region 2: I/O ports at d880 [size=128]
         Region 3: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
   Vendor: ATA      Model: ST3300831AS      Rev: 3.02
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST3300831AS      Rev: 3.02
   Type:   Direct-Access                    ANSI SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
Kernel as provided from Debian sarge, no recompilation.
Package name: kernel-image-2.6.8-2-686-smp
[X.] Other notes, patches, fixes, workarounds:
Hope, that this is right for you
-- 
_________________________________________

newthinking IT Systems,
Inh. Alexander Scheibner

Alexander Scheibner
Schönhauser Allee 89
D-10439 Berlin


Tel:   +49-30-46065411
Fax:   +49-30-46065412
Mobil: +49-175-5262595
Mail:  alexander.scheibner@newthinking.de
_________________________________________

--------------020901000803060404080506
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Jun  9 18:33:38 localhost kernel: ------------[ cut here ]------------
Jun  9 18:33:38 localhost kernel: kernel BUG at fs/jbd/checkpoint.c:613!
Jun  9 18:33:38 localhost kernel: invalid operand: 0000 [#1]
Jun  9 18:33:38 localhost kernel: PREEMPT SMP
Jun  9 18:33:38 localhost kernel: Modules linked in: radeon parport_pc lp parport ipv6 eth1394 sata_promise ohci1394 e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device sndi810_audio ac97_codec soundcore ata_piix libata hw_random ehci_hcd uhci_hcd usbcore shpchp pciehp pci_hotplug intel_agp intel_mch_agp agpgart tsdev mousedev evdev capability commoncap sr_mod sd_mod sbp2 scsi_mod ieee1394 psmouse ide_cd cdrom genrtc ext3 jbd mbcache ide_generic piix ide_disk ide_core unix font vesafb cfbcopyarea cfbimgblt cfbfillrect
Jun  9 18:33:38 localhost kernel: CPU:    1
Jun  9 18:33:38 localhost kernel: EIP:    0060:[__crc_utf8_wctomb+5875415/6417782]    Not tainted
Jun  9 18:33:38 localhost kernel: EFLAGS: 00010282   (2.6.8-2-686-smp)
Jun  9 18:33:38 localhost kernel: EIP is at __journal_drop_transaction+0x350/0x3f7 [jbd]
Jun  9 18:33:38 localhost kernel: eax: 00000071   ebx: f0080080   ecx: c02dbfbc  edx: c02dbfbc
Jun  9 18:33:38 localhost kernel: esi: f7b3c400   edi: 00000000   ebp: f0080080  esp: f78c5da4
Jun  9 18:33:38 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jun  9 18:33:38 localhost kernel: Process kjournald (pid: 2202, threadinfo=f78c4000 task=f7784330)
Jun  9 18:33:38 localhost kernel: Stack: f8890160 f888f3c0 f8890f3c 00000265 f8890f8c 00000000 f78c4000 f888922c
Jun  9 18:33:38 localhost kernel:        f7b3c400 f0080080 00000003 00000829 00000282 f7b3c478 00000282 f7529028
Jun  9 18:33:38 localhost kernel:        f00800d4 f7b3c4c0 f78c4000 f00800b8 f7b3c414 00000000 00000000 00000000
Jun  9 18:33:38 localhost kernel: Call Trace:
Jun  9 18:33:38 localhost kernel:  [__crc_utf8_wctomb+5865763/6417782] journal_commit_transaction+0xb4c/0x1690 [jbd]
Jun  9 18:33:38 localhost kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jun  9 18:33:38 localhost kernel:  [update_wall_time+22/64] update_wall_time+0x16/0x40
Jun  9 18:33:38 localhost kernel:  [do_timer+192/208] do_timer+0xc0/0xd0
Jun  9 18:33:38 localhost kernel:  [load_balance_newidle+59/192] load_balance_newidle+0x3b/0xc0
Jun  9 18:33:38 localhost kernel:  [schedule+1207/2208] schedule+0x4b7/0x8a0
Jun  9 18:33:38 localhost kernel:  [del_timer_sync+154/224] del_timer_sync+0x9a/0xe0
Jun  9 18:33:38 localhost kernel:  [__crc_utf8_wctomb+5879161/6417782] kjournald+0xf2/0x2e0 [jbd]
Jun  9 18:33:38 localhost kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jun  9 18:33:38 localhost kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jun  9 18:33:38 localhost kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Jun  9 18:33:38 localhost kernel:  [__crc_utf8_wctomb+5878887/6417782] commit_timeout+0x0/0x10 [jbd]
Jun  9 18:33:38 localhost kernel:  [__crc_utf8_wctomb+5878919/6417782] kjournald+0x0/0x2e0 [jbd]
Jun  9 18:33:38 localhost kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jun  9 18:33:38 localhost kernel: Code: 0f 0b 65 02 3c 0f 89 f8 e9 6e fd ff ff 8d 76 00 c7 04 24 60
Jun  9 18:33:38 localhost kernel:  <6>note: kjournald[2202] exited with preempt_count 1
Jun  9 18:33:39 localhost postfix/smtpd[6090]: connect from unknown[192.168.7.11]
Jun  9 18:33:39 localhost postfix/smtpd[6090]: F16E4A3CA8: client=unknown[192.168.7.11]
Jun  9 18:33:39 localhost postfix/cleanup[6038]: F16E4A3CA8: message-id=<20050609162749.79E44611492@sls-eb15p8.dca2.superb.net>
Jun  9 18:33:39 localhost postfix/qmgr[2891]: F16E4A3CA8: from=<defourmusic-text@rtn121.sonymusicemail.com>, size=3665, nrcpt=1 (queue active)
Jun  9 18:33:40 localhost postfix/smtpd[6090]: disconnect from unknown[192.168.7.11]
Jun  9 18:33:41 localhost postfix/smtpd[6036]: connect from unknown[192.168.7.11]
Jun  9 18:33:41 localhost postfix/smtpd[6036]: 3F302A3CAC: client=unknown[192.168.7.11]
Jun  9 18:33:41 localhost postfix/cleanup[6097]: 3F302A3CAC: message-id=<20050609162749.CFA8D611494@sls-eb15p8.dca2.superb.net>
Jun  9 18:33:41 localhost postfix/qmgr[2891]: 3F302A3CAC: from=<ritaha@netscape.net>, size=4487, nrcpt=1 (queue active)
Jun  9 18:33:41 localhost cyrus/master[6106]: about to exec /usr/lib/cyrus/bin/lmtpd
Jun  9 18:33:41 localhost postfix/smtpd[6036]: disconnect from unknown[192.168.7.11]
Jun  9 18:33:46 localhost postfix/smtpd[6094]: connect from unknown[192.168.7.11]
Jun  9 18:33:46 localhost postfix/smtpd[6094]: 9E2E4A3CB0: client=unknown[192.168.7.11]
Jun  9 18:33:46 localhost postfix/cleanup[6038]: 9E2E4A3CB0: message-id=<42A86F55.5050606@k7.com>
Jun  9 18:33:46 localhost postfix/qmgr[2891]: 9E2E4A3CB0: from=<strom@k7.com>, size=1938, nrcpt=1 (queue active)
Jun  9 18:33:46 localhost postfix/smtpd[6094]: disconnect from unknown[192.168.7.11]
Jun  9 18:33:55 localhost postfix/smtpd[6090]: connect from unknown[192.168.7.11]
Jun  9 18:33:56 localhost postfix/smtpd[6090]: 1CE4FA3CB1: client=unknown[192.168.7.11]
Jun  9 18:33:56 localhost postfix/cleanup[6097]: 1CE4FA3CB1: message-id=<20050609155333.2E24FE681D@dd7.kasserver.com>
Jun  9 18:33:56 localhost postfix/qmgr[2891]: 1CE4FA3CB1: from=<wwwrun@vakant.net>, size=4400, nrcpt=1 (queue active)
Jun  9 18:33:56 localhost postfix/smtpd[6090]: disconnect from unknown[192.168.7.11]
Jun  9 18:34:01 localhost cyrus/master[6111]: about to exec /usr/lib/cyrus/bin/imapd
Jun  9 18:34:01 localhost cyrus/imap[6111]: executedJun  9 18:34:01 localhost cyrus/imapd[6111]: accepted connection
Jun  9 18:34:07 localhost cyrus/imapd[6111]: login: [192.168.7.111] juan plaintext


--------------020901000803060404080506--
