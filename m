Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWB1Dba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWB1Dba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWB1Dba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:31:30 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:16336 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S932223AbWB1Db3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:31:29 -0500
Message-ID: <4403C403.90303@lnxi.com>
Date: Mon, 27 Feb 2006 20:31:15 -0700
From: Lew Glendenning <lglendenning@lnxi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LD internal error while compiling 2.6.15 kernel
Content-Type: multipart/mixed;
 boundary="------------050001010209080507080303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050001010209080507080303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On an ASUS A8N-SLI with an AMD Athlon 64  X2 4400+, 4GB of PC3200 
memory, 2 300GB SATA drives, the command:

    lew@harlow:~/kernels/linux-2.6.15$ time make bzImage

succeeds, but the command:

   lew@harlow:~/kernels/linux-2.6.15/$  time make -j4 bzImage

Eventually produces :
  LD      net/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  ld: BFD 2.16.1 Debian GNU/Linux internal error, aborting at          
    ../../bfd/reloc.c line 444 in bfd_get_reloc_size

ld: Please report this bug.

-----------------------------
lew@harlow:~/kernels/linux-2.6.15/scripts$ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux harlow 2.6.15AMD64-SMP-2006-02-22 #4 SMP Thu Feb 23 09:06:53 MST 
2006 x86_64 GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre7
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.4
xfsprogs               2.6.28
PPP                    2.4.3
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   060
Modules Loaded         rfcomm l2cap bluetooth cpufreq_userspace 
cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand 
cpufreq_conservative nvidia video container button battery ac ipv6 nfs 
lockd sunrpc af_packet ide_cd analog gameport snd_mpu401 snd_mpu401_uart 
snd_rawmidi snd_seq_device floppy pcspkr tsdev sk98lin skge ohci1394 
shpchp pci_hotplug forcedeth amd74xx generic ide_core usbhid 
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss 
snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd ohci_hcd 
i2c_nforce2 i2c_core dm_mod sbp2 ieee1394 rtc psmouse mousedev 
parport_pc lp parport md_mod sr_mod cdrom sd_mod sata_sil sata_nv libata 
scsi_mod unix thermal processor fan


uname -a
Linux harlow 2.6.15AMD64-SMP-2006-02-22 #4 SMP Thu Feb 23 09:06:53 MST 
2006 x86_64 GNU/Linux

cat /proc/version
Linux version 2.6.15AMD64-SMP-2006-02-22 (lew@lew-glendenning) (gcc 
version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #4 SMP Thu 
Feb 23 09:06:53 MST 2006

lew@harlow:~/kernels/linux-2.6.15/scripts$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2211.345
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext 
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4427.25
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2211.345
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext 
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4422.99
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

lew@harlow:~/kernels/linux-2.6.15/scripts$ cat /proc/modules
rfcomm 39456 0 - Live 0xffffffff887e0000
l2cap 27264 5 rfcomm, Live 0xffffffff887d8000
bluetooth 51844 4 rfcomm,l2cap, Live 0xffffffff887ca000
cpufreq_userspace 8928 0 - Live 0xffffffff887c6000
cpufreq_stats 7236 0 - Live 0xffffffff887c3000
freq_table 6336 1 cpufreq_stats, Live 0xffffffff887c0000
cpufreq_powersave 3328 0 - Live 0xffffffff887be000
cpufreq_ondemand 9128 0 - Live 0xffffffff887ba000
cpufreq_conservative 10344 0 - Live 0xffffffff887b6000
nvidia 4858996 12 - Live 0xffffffff88312000
video 18824 0 - Live 0xffffffff8830c000
container 6272 0 - Live 0xffffffff88309000
button 8864 0 - Live 0xffffffff88305000
battery 11784 0 - Live 0xffffffff88301000
ac 6792 0 - Live 0xffffffff882fe000
ipv6 267264 14 - Live 0xffffffff882bb000
nfs 201792 4 - Live 0xffffffff88288000
lockd 64528 2 nfs, Live 0xffffffff88277000
sunrpc 156600 3 nfs,lockd, Live 0xffffffff8824f000
af_packet 25356 2 - Live 0xffffffff88247000
ide_cd 41888 0 - Live 0xffffffff8823b000
analog 11872 0 - Live 0xffffffff88237000
gameport 17808 1 analog, Live 0xffffffff88231000
snd_mpu401 9480 0 - Live 0xffffffff8822d000
snd_mpu401_uart 9472 1 snd_mpu401, Live 0xffffffff88229000
snd_rawmidi 28704 1 snd_mpu401_uart, Live 0xffffffff88220000
snd_seq_device 10896 1 snd_rawmidi, Live 0xffffffff8821c000
floppy 68616 0 - Live 0xffffffff8820a000
pcspkr 3592 0 - Live 0xffffffff8817e000
tsdev 9856 0 - Live 0xffffffff88206000
sk98lin 151016 0 - Live 0xffffffff881e0000
skge 39696 0 - Live 0xffffffff881d5000
ohci1394 34508 0 - Live 0xffffffff881cb000
shpchp 45984 0 - Live 0xffffffff881be000
pci_hotplug 29712 1 shpchp, Live 0xffffffff881b5000
forcedeth 25860 0 - Live 0xffffffff881ad000
amd74xx 16304 0 [permanent], Live 0xffffffff881a8000
generic 6660 0 [permanent], Live 0xffffffff881a5000
ide_core 143992 3 ide_cd,amd74xx,generic, Live 0xffffffff88180000
usbhid 36000 0 - Live 0xffffffff88174000
snd_intel8x0 36008 1 - Live 0xffffffff8816a000
snd_ac97_codec 102972 1 snd_intel8x0, Live 0xffffffff8814f000
snd_ac97_bus 3968 1 snd_ac97_codec, Live 0xffffffff88092000
snd_pcm_oss 53024 0 - Live 0xffffffff88141000
snd_mixer_oss 18688 1 snd_pcm_oss, Live 0xffffffff8813b000
snd_pcm 94344 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 
0xffffffff88122000
snd_timer 26376 1 snd_pcm, Live 0xffffffff8811a000
snd 61408 12 
snd_mpu401,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, 
Live 0xffffffff8810a000
soundcore 12192 1 snd, Live 0xffffffff88106000
snd_page_alloc 12432 2 snd_intel8x0,snd_pcm, Live 0xffffffff88101000
ehci_hcd 33288 0 - Live 0xffffffff880f7000
ohci_hcd 21636 0 - Live 0xffffffff880f0000
i2c_nforce2 8832 0 - Live 0xffffffff880ec000
i2c_core 24192 1 i2c_nforce2, Live 0xffffffff880e5000
dm_mod 56392 0 - Live 0xffffffff880d6000
sbp2 26116 0 - Live 0xffffffff880ce000
ieee1394 101880 2 ohci1394,sbp2, Live 0xffffffff880b4000
rtc 15736 0 - Live 0xffffffff880af000
psmouse 37252 0 - Live 0xffffffff880a4000
mousedev 13856 2 - Live 0xffffffff8809f000
parport_pc 38640 1 - Live 0xffffffff88094000
lp 14272 0 - Live 0xffffffff8808d000
parport 40460 2 parport_pc,lp, Live 0xffffffff88082000
md_mod 69752 0 - Live 0xffffffff8806f000
sr_mod 18084 0 - Live 0xffffffff88069000
cdrom 37560 2 ide_cd,sr_mod, Live 0xffffffff8805e000
sd_mod 19840 7 - Live 0xffffffff88058000
sata_sil 12036 0 - Live 0xffffffff88054000
sata_nv 11908 5 - Live 0xffffffff88050000
libata 58648 2 sata_sil,sata_nv, Live 0xffffffff88040000
scsi_mod 148344 4 sbp2,sr_mod,sd_mod,libata, Live 0xffffffff8801a000
unix 32024 492 - Live 0xffffffff88011000
thermal 16524 0 - Live 0xffffffff8800b000
processor 27816 1 thermal, Live 0xffffffff88003000
fan 6408 0 - Live 0xffffffff88000000

lew@harlow:~/kernels/linux-2.6.15/scripts$ cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf1ff : Video ROM
000f0000-000fffff : System ROM
00100000-bffeffff : System RAM
  00100000-002c2bd7 : Kernel code
  002c2bd8-0037ee97 : Kernel data
bfff0000-bfff2fff : ACPI Non-volatile Storage
bfff3000-bfffffff : ACPI Tables
c0000000-cfffffff : PCI Bus #01
  c0000000-cfffffff : 0000:01:00.0
d0000000-d2ffffff : PCI Bus #01
  d0000000-d0ffffff : 0000:01:00.0
    d0000000-d0ffffff : nvidia
  d1000000-d1ffffff : 0000:01:00.0
  d2000000-d201ffff : 0000:01:00.0
d3000000-d4ffffff : PCI Bus #05
  d4000000-d4003fff : 0000:05:0b.0
  d4004000-d4007fff : 0000:05:0c.0
    d4004000-d4007fff : skge
  d4008000-d40083ff : 0000:05:0a.0
    d4008000-d40083ff : sata_sil
  d4009000-d40097ff : 0000:05:0b.0
    d4009000-d40097ff : ohci1394
d5000000-d5000fff : 0000:00:0a.0
  d5000000-d5000fff : forcedeth
d5001000-d5001fff : 0000:00:08.0
  d5001000-d5001fff : sata_nv
d5002000-d5002fff : 0000:00:07.0
  d5002000-d5002fff : sata_nv
d5003000-d5003fff : 0000:00:04.0
  d5003000-d5003fff : NVidia CK804
d5004000-d5004fff : 0000:00:02.0
  d5004000-d5004fff : ohci_hcd
d5100000-d51fffff : PCI Bus #05
  d5100000-d517ffff : 0000:05:0a.0
  d5180000-d519ffff : 0000:05:0c.0
e0000000-efffffff : reserved
feb00000-feb000ff : 0000:00:02.1
  feb00000-feb000ff : ehci_hcd
fec00000-ffffffff : reserved
100000000-13fffffff : System RAM

root@harlow:/home/lew/kernels/linux-2.6.15/scripts# lspci -vvv
0000:00:00.0 Memory controller: nVidia Corporation: Unknown device 005e 
(rev a3)
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [44] #08 [01e0]
        Capabilities: [e0] #08 [a801]

0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 0050 (rev a3)
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:01.1 SMBus: nVidia Corporation: Unknown device 0052 (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e400 [size=32]
        Region 4: I/O ports at 4c00 [size=64]
        Region 5: I/O ports at 4c40 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 005a 
(rev a2) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at d5004000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation: Unknown device 005b 
(rev a3) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 20
        Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] #0a [2098]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Multimedia audio controller: nVidia Corporation: Unknown 
device 0059 (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 812a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at d5003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 IDE interface: nVidia Corporation: Unknown device 0053 (rev 
f2) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 IDE interface: nVidia Corporation: Unknown device 0054 (rev 
f3) (prog-if 85 [Master SecO PriO])
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 09f0 [size=8]
        Region 1: I/O ports at 0bf0 [size=4]
        Region 2: I/O ports at 0970 [size=8]
        Region 3: I/O ports at 0b70 [size=4]
        Region 4: I/O ports at d800 [size=16]
        Region 5: Memory at d5002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 IDE interface: nVidia Corporation: Unknown device 0055 (rev 
f3) (prog-if 85 [Master SecO PriO])
        Subsystem: Asustek Computer, Inc.: Unknown device 815a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 09e0 [size=8]
        Region 1: I/O ports at 0be0 [size=4]
        Region 2: I/O ports at 0960 [size=8]
        Region 3: I/O ports at 0b60 [size=4]
        Region 4: I/O ports at c400 [size=16]
        Region 5: Memory at d5001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 PCI bridge: nVidia Corporation: Unknown device 005c (rev 
a2) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
        I/O behind bridge: 00009000-0000afff
        Memory behind bridge: d3000000-d4ffffff
        Prefetchable memory behind bridge: d5100000-d51fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:0a.0 Bridge: nVidia Corporation: Unknown device 0057 (rev a3)
        Subsystem: Asustek Computer, Inc.: Unknown device 8141
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b000 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev 
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:0c.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev 
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:0d.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev 
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev 
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d0000000-d2ffffff
        Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown 
device 0140 (rev a2) (prog-if 00 [VGA])
        Subsystem: Unknown device 1682:2191
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Region 3: Memory at d1000000 (64-bit, non-prefetchable) [size=16M]
        Expansion ROM at d2000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] #10 [0001]

0000:05:0a.0 RAID bus controller: Silicon Image, Inc. (formerly CMD 
Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8167
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 9000 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9c00 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Region 5: Memory at d4008000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at d5100000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at d4009000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:05:0c.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
        Subsystem: Asustek Computer, Inc.: Unknown device 811a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5750ns min, 7750ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at d4004000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at a400 [size=256]
        Expansion ROM at d5180000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data

lew@harlow:~/kernels/linux-2.6.15/scripts$ cat /proc/scsi/scsi
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD3000JD-00K Rev: 08.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD3000JD-00K Rev: 08.0
  Type:   Direct-Access                    ANSI SCSI revision: 05






I just installed this system last week, did a dist-upgrade.



Lew Glendenning


--------------050001010209080507080303
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15
# Mon Feb 27 19:42:12 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_CPUSETS=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_LBD=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_BKL is not set
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=12
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_KEXEC=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPUFreq processor drivers
#
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_ACPI_CPUFREQ is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
# CONFIG_UNORDERED_IO is not set
CONFIG_PCIEPORTBUS=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_DEBUG=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_NETBIOS_NS is not set
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_PPTP is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
# CONFIG_IP_NF_MATCH_DCCP is not set
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_CONNMARK=m
# CONFIG_IP_NF_MATCH_CONNBYTES is not set
CONFIG_IP_NF_MATCH_HASHLIMIT=m
# CONFIG_IP_NF_MATCH_STRING is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_TARGET_NFQUEUE is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
# CONFIG_IP_NF_TARGET_TTL is not set
CONFIG_IP_NF_TARGET_CONNMARK=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
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
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=3
# CONFIG_MTD_PARTITIONS is not set
CONFIG_MTD_CONCAT=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_AMDSTD_RETRY=3
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SC520CDP is not set
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_CK804XROM=m
# CONFIG_MTD_PCI is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLKMTD is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=m
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_MV is not set
CONFIG_SCSI_SATA_NV=m
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
# CONFIG_ULI526X is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
CONFIG_FORCEDETH=y
# CONFIG_DGRS is not set
CONFIG_EEPRO100=y
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=y
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
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
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

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
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=m
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_N_HDLC=m
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
CONFIG_STALDRV=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

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
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
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
CONFIG_INFINIBAND=y
# CONFIG_INFINIBAND_USER_MAD is not set
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_MTHCA=y
CONFIG_INFINIBAND_MTHCA_DEBUG=y
CONFIG_INFINIBAND_IPOIB=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
# CONFIG_INFINIBAND_SRP is not set

#
# SN Devices
#

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_JFFS2_FS is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
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
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KPROBES=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_INIT_DEBUG is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_SECLVL is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_AES_X86_64 is not set
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

--------------050001010209080507080303--
