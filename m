Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUIAVqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUIAVqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUIAVo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:44:27 -0400
Received: from ip-195-14-191-64.bnk.lt ([195.14.191.64]:43737 "EHLO
	mail.saulute.com") by vger.kernel.org with ESMTP id S267833AbUIAVEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:04:39 -0400
Date: Wed, 1 Sep 2004 23:56:53 +0300
From: Darjus Loktevic <admin@saulute.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: disk or filesystem problem!
Message-Id: <20040901235653.53de1e0b@saulute.saulute.com>
Organization: Enterprise of D. Loktevic
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When i copy 2Gig (actually 3files 2Gigs, but it not matters (i think)) file from RAID+SATA(ata_piix, reiserfs) to ATA(piix) the whole systep almost locks (i meen even if i try to write something in Mozilla or pure console (without any additional kernel modules (onoley that needed to boot linux properly) i have strange things. When i type "t" system gives me "ttttttttttt" or other length "t" even almost unstoppable "t".
I dont know who inform on this problem, because i havent compiled my kernel with debug and even if i dont know how to debug :(. I am using linux for a long time (6yrs), but never seen this.
So, i am using kernel 2.6.7 (SMP, intel prescot, Hyper threading enabled).
I am loadig initrd (cramfs) from /dev/hda3, (it does the job for loading my linux (it loads ata_piix,md,reiserfs), mounts root filesystem and continues from /dev/md0). I am trying to copy file from /dev/md0 to /dev/hda2.
I have 300 (ltsp) users and cannot do (backups) such things again, because my mobile will surely blow! ;)

output from ver_linux:
Linux saulute.saulute.com 2.6.7 #3 SMP Sun Aug 1 00:27:07 EEST 2004 i686 GNU/Linux

Gnu C                  -march=pentium4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq radeon ip6table_filter ip6_tables ipt_MARK ipt_MASQUERADE ipt_REDIRECT iptable_nat ip_conntrack iptable_filter cls_route cls_u32 cls_fw sch_sfq sch_htb af_packet lp parport usbcore snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ipv6 raid1 dm_mod hangcheck_timer mousedev piix ide_cd cdrom ide_disk ide_generic ide_core 8139too crc32 eepro100 mii rtc vfat fat isofs ext3 jbd sd_mod unix reiserfs quota_v2 raid0 md ata_piix libata scsi_mod

output from /proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 3121.353
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6176.76

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 3121.353
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6225.92

output from /proc/modules:
snd_seq_oss 24448 0 - Live 0xe0e17000
snd_seq_midi_event 3840 1 snd_seq_oss, Live 0xe0d61000
snd_seq 38160 4 snd_seq_oss,snd_seq_midi_event, Live 0xe0e0c000
radeon 112084 0 - Live 0xe0dcb000
ip6table_filter 1280 0 - Live 0xe0818000
ip6_tables 13824 1 ip6table_filter, Live 0xe0d99000
ipt_MARK 1152 11 - Live 0xe0d69000
ipt_MASQUERADE 2048 1 - Live 0xe0d6b000
ipt_REDIRECT 1152 1 - Live 0xe0d6d000
iptable_nat 15524 3 ipt_MASQUERADE,ipt_REDIRECT, Live 0xe0d71000
ip_conntrack 20356 3 ipt_MASQUERADE,ipt_REDIRECT,iptable_nat, Live 0xe0d63000
iptable_filter 1408 1 - Live 0xe0d4f000
cls_route 5760 0 - Live 0xe0d4c000
cls_u32 5508 1 - Live 0xe0d49000
cls_fw 3712 1 - Live 0xe0d33000
sch_sfq 3712 22 - Live 0xe0d31000
sch_htb 20224 2 - Live 0xe0d52000
af_packet 13064 4 - Live 0xe0d1e000
lp 6308 0 - Live 0xe0d1b000
parport 25928 1 lp, Live 0xe0d23000
usbcore 75360 0 - Live 0xe0d35000
snd_intel8x0 15112 0 - Live 0xe0cab000
snd_ac97_codec 51972 1 snd_intel8x0, Live 0xe0cb7000
snd_pcm_oss 38696 0 - Live 0xe0cc7000
snd_mixer_oss 13568 1 snd_pcm_oss, Live 0xe0cb2000
snd_pcm 63648 2 snd_intel8x0,snd_pcm_oss, Live 0xe0d06000
snd_timer 16004 2 snd_seq,snd_pcm, Live 0xe0c97000
snd_page_alloc 5512 2 snd_intel8x0,snd_pcm, Live 0xe0c8b000
snd_mpu401_uart 4096 1 snd_intel8x0, Live 0xe0c95000
snd_rawmidi 14144 1 snd_mpu401_uart, Live 0xe0c9d000
snd_seq_device 4232 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe0c92000
snd 32356 12 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe0ca2000
soundcore 4448 1 snd, Live 0xe0c8f000
ipv6 205536 24 - Live 0xe0cd2000
raid1 12800 1 - Live 0xe09f7000
dm_mod 28832 0 - Live 0xe09ba000
hangcheck_timer 1304 0 - Live 0xe09b8000
mousedev 5776 1 - Live 0xe09ab000
piix 6816 1 - Live 0xe0834000
ide_cd 33156 0 - Live 0xe09ed000
cdrom 31136 1 ide_cd, Live 0xe09c4000
ide_disk 12544 2 - Live 0xe09b3000
ide_generic 768 0 - Live 0xe09a5000
ide_core 93904 4 piix,ide_cd,ide_disk,ide_generic, Live 0xe09d5000
8139too 14464 0 - Live 0xe09ae000
crc32 3328 1 8139too, Live 0xe09a3000
eepro100 18700 0 - Live 0xe0999000
mii 2816 2 8139too,eepro100, Live 0xe0876000
rtc 8520 0 - Live 0xe099f000
vfat 9728 0 - Live 0xe081a000
fat 33312 1 vfat, Live 0xe086c000
isofs 26044 0 - Live 0xe0864000
ext3 93928 0 - Live 0xe0885000
jbd 48920 1 ext3, Live 0xe0878000
sd_mod 16128 8 - Live 0xe085f000
unix 19376 302 - Live 0xe0837000
reiserfs 210800 3 - Live 0xe08a0000
quota_v2 7680 0 - Live 0xe0823000
raid0 5888 2 - Live 0xe0820000
md 35016 5 raid1,raid0, Live 0xe0855000
ata_piix 3716 6 - Live 0xe081e000
libata 24964 1 ata_piix, Live 0xe0826000
scsi_mod 88772 2 sd_mod,libata, Live 0xe083e000

output from /proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0800-087f : 0000:00:1f.0
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d400-d4ff : 0000:02:0b.0
  d400-d4ff : 8139too
d800-d8ff : 0000:02:05.0
dc00-dc7f : 0000:02:03.0
df40-df5f : 0000:02:0a.0
  df40-df5f : eepro100
e800-e8ff : 0000:00:1f.5
ee80-eebf : 0000:00:1f.5
ef00-ef1f : 0000:00:1d.0
ef20-ef3f : 0000:00:1d.1
ef40-ef5f : 0000:00:1d.2
ef60-ef6f : 0000:00:1f.2
  ef60-ef6f : libata
ef80-ef9f : 0000:00:1d.3
efa0-efa7 : 0000:00:1f.2
  efa0-efa7 : libata
efa8-efab : 0000:00:1f.2
  efa8-efab : libata
efac-efaf : 0000:00:1f.2
  efac-efaf : libata
efe0-efe7 : 0000:00:1f.2
  efe0-efe7 : libata
fc00-fc0f : 0000:00:1f.1
  fc08-fc0f : ide1

output from /proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cd000-000cd7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ff2ffff : System RAM
  00100000-0027c279 : Kernel code
  0027c27a-002d5d7f : Kernel data
1ff30000-1ff3ffff : ACPI Tables
1ff40000-1ffeffff : ACPI Non-volatile Storage
1fff0000-1fffffff : reserved
20000000-200003ff : 0000:00:1f.1
d7e00000-f7dfffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.1
  e8000000-efffffff : 0000:01:00.0
f7eff000-f7efffff : 0000:02:0a.0
  f7eff000-f7efffff : eepro100
f8000000-fbffffff : 0000:00:00.0
fe500000-fe5fffff : PCI Bus #01
  fe5e0000-fe5effff : 0000:01:00.1
  fe5f0000-fe5fffff : 0000:01:00.0
fe900000-fe9fffff : 0000:02:0a.0
feaf8000-feafbfff : 0000:02:05.0
feaff400-feaff4ff : 0000:02:0b.0
  feaff400-feaff4ff : 8139too
feaff800-feafffff : 0000:02:03.0
febfb800-febfb8ff : 0000:00:1f.5
  febfb800-febfb8ff : Intel ICH5 - Controller
febfbc00-febfbdff : 0000:00:1f.5
  febfbc00-febfbdff : Intel ICH5 - AC'97
febffc00-febfffff : 0000:00:1d.7
ffb80000-ffffffff : reserved

output from lspci -vvv:
00:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe500000-fe5fffff
        Prefetchable memory behind bridge: d7e00000-f7dfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ef00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at ef20 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at ef40 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ef80 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe600000-feafffff
        Prefetchable memory behind bridge: f7e00000-f7efffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at efe0 [size=8]
        Region 1: I/O ports at efac [size=4]
        Region 2: I/O ports at efa0 [size=8]
        Region 3: I/O ports at efa8 [size=4]
        Region 4: I/O ports at ef60 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at e800 [size=256]
        Region 1: I/O ports at ee80 [size=64]
        Region 2: Memory at febfbc00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at febfb800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
        Subsystem: Info-Tek Corp.: Unknown device 0171
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 0x04 (16 bytes)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at fe5f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe5c0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
        Subsystem: Info-Tek Corp.: Unknown device 0170
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 0x04 (16 bytes)
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at fe5e0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns max), Cache Line Size: 0x04 (16 bytes)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at dc00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:05.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
        Subsystem: Asustek Computer, Inc. P4P800 Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), Cache Line Size: 0x04 (16 bytes)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at d800 [size=256]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=7 DScale=1 PME-
        Capabilities: [50] Vital Product Data

0000:02:0a.0 Ethernet controller: Intel Corp. 82tel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at f7eff000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at df40 [size=32]
        Region 2: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fe800000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at feaff400 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at feae0000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

output from /proc/scsi/scsi:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6Y160M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6Y160M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05

output from /proc/mdstats:
Personalities : [raid0] [raid1]
md2 : active raid1 sdb1[1] sda1[0]
      136448 blocks [2/2] [UU]

md1 : active raid0 sdb2[1] sda2[0]
      4016000 blocks 64k chunks

md0 : active raid0 sdb3[1] sda3[0]
      315869824 blocks 64k chunks

Sincerly,
Darjus Loktevic
Thanks for a greate job!
And many thanks to J. Garzik for his sata job!
