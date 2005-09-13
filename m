Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVIMCnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVIMCnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 22:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVIMCnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 22:43:43 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:2785 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932249AbVIMCnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 22:43:43 -0400
Message-ID: <43263CDC.1010604@comcast.net>
Date: Mon, 12 Sep 2005 22:43:40 -0400
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.13 BUG tg3.c:2805 = crash
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi Everybody,

My dual Opteron server recently crashed with this signature (thanks for
that serial console!).  When the crash occurred, I was moving the mouse
and using a scrollbar in KDE.  I cannot reproduce the problem.

Please cc: me as I am not subscribed to this mailing list.  Please let
me know if I need to supply other information, or if there are
experiments I should conduct to further isolate this problem.  I'd like
to help in any way possible.

Thanks!

Andy



- ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "drivers/net/tg3.c":2805
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in: af_packet radeon drm ext3 jbd usbserial nfsd exportfs
lp snd_pcm_oss snd_mixer_oss ipv6 snd_via82xx gameport snd_ac97_codec sn
d_pcm snd_timer snd_pa
ge_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
w83627hf eeprom i2c_sensor i2c_isa vmnet parport_pc parport vmmon
binfmt_misc e
dd usblp joydev sg st
sr_mod i2c_viapro i2c_core ohci_hcd ehci_hcd evdev dm_mod usbcore tg3
reiserfs aic7xxx sym53c8xx scsi_transport_spi sd_mod scsi_mod
Pid: 32068, comm: setiathome_4.02 Tainted: P      2.6.13
RIP: 0010:[<ffffffff880be9b6>] <ffffffff880be9b6>{:tg3:tg3_poll+294}
RSP: 0000:ffff81003feb7e68  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000001b6 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 000000002df3f0fe RDI: ffff81002df3f140
RBP: ffff81003b6fd8f8 R08: 0000000000000042 R09: ffff810014fbdec8
R10: ffff810014fbc000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8100141b5400 R14: ffff81003d69f380 R15: 00000000000001b6
FS:  00002aaaab7bd0a0(0000) GS:ffffffff804ed880(0063) knlGS:000000005570a300
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00002aaaaec8e000 CR3: 00000000297aa000 CR4: 00000000000006e0
Process setiathome_4.02 (pid: 32068, threadinfo ffff810014fbc000, task
ffff81002ad42a10)
Stack: 000000e800000206 ffff81003d69f3ec 000000003dc11012 00000001000000ce
       0000003f00010000 ffff81003d69f3cc ffff81003b74a000 ffff81003feb7f14
       ffff81003d69f000 0000000000000246
Call Trace: <IRQ> <ffffffff881107b7>{:ohci_hcd:ohci_irq+55}
<ffffffff802f67b0>{net_rx_action+176}
       <ffffffff8013a471>{__do_softirq+113}
<ffffffff8010ed87>{call_softirq+31}
       <ffffffff801106d5>{do_softirq+53} <ffffffff8011072f>{do_IRQ+79}
       <ffffffff8010e230>{ret_from_intr+0}  <EOI>

Code: 0f 0b a3 d8 05 0c 88 ff ff ff ff c2 f5 0a 89 d8 49 8b 56 58
RIP <ffffffff880be9b6>{:tg3:tg3_poll+294} RSP <ffff81003feb7e68>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


=====
amdtux:/usr/src/linux-2.6.13/scripts # ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux amdtux 2.6.13 #3 SMP Sat Sep 3 20:39:45 EDT 2005 x86_64 x86_64
x86_64 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.91.0.2
util-linux             2.12c
mount                  2.12c
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.8
quota-tools            3.11.
PPP                    2.4.2
isdn4k-utils           3.5
nfs-utils              1.0.6
Linux C Library        x  1 root root 1412174 Oct  1  2004
/lib64/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.7
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   030
Modules Loaded         radeon drm usbserial nfsd exportfs lp snd_pcm_oss
snd_mixer_oss snd_via82xx gameport snd_ac97_codec w83627hf snd_pcm ipv6
snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd
eeprom soundcore i2c_sensor i2c_isa vmnet parport_pc parport vmmon
binfmt_misc edd usblp joydev sg st sr_mod i2c_viapro i2c_core ehci_hcd
ohci_hcd evdev dm_mod usbcore tg3 reiserfs aic7xxx sym53c8xx
scsi_transport_spi sd_mod scsi_mod
=====


=====
amdtux:/usr/src/linux-2.6.13/scripts # cat /proc/version
Linux version 2.6.13 (root@amdtux) (gcc version 3.3.4 (pre 3.3.5
20040809)) #3 SMP Sat Sep 3 20:39:45 EDT 2005
=====

=====
amdtux:/usr/src/linux-2.6.13/scripts # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 10
cpu MHz         : 1804.155
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3616.73
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 10
cpu MHz         : 1804.155
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3608.45
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp
=====


=====
amdtux:/usr/src/linux-2.6.13/scripts # lspci -vvv
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP]
Host Bridge (rev 01)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [80] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4
        Capabilities: [c0] #08 [0060]
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #08 [8001]

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800 South] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: e8000000-f7ffffff
        Expansion ROM at 0000a000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 14)
        Subsystem: LSI Logic / Symbios Logic LSI53C876/E PCI to Dual
Channel SCSI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 16000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 161
        Region 0: I/O ports at b000 [size=1023M]
        Region 1: Memory at fb010000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at fb016000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 00010000 [disabled]

0000:00:07.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 14)
        Subsystem: LSI Logic / Symbios Logic LSI53C876/E PCI to Dual
Channel SCSI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 16000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 161
        Region 0: I/O ports at b400 [size=1023M]
        Region 1: Memory at fb011000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at fb012000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 00010000 [disabled]

0000:00:08.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10
[OHCI])
        Subsystem: Belkin Root Hub
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at fb013000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10
[OHCI])
        Subsystem: Belkin Root Hub
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 145
        Region 0: Memory at fb014000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if
20 [EHCI])
        Subsystem: Belkin Root Hub
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8500ns max), cache line size 10
        Interrupt: pin C routed to IRQ 153
        Region 0: Memory at fb015000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705
Gigabit Ethernet (rev 03)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 145
        Region 0: Memory at fb000000 (64-bit, non-prefetchable)
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
                Address: fffffdf6fffefffc  Data: effd

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
RAID Controller (rev 80)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin B routed to IRQ 177
        Region 0: I/O ports at b800
        Region 1: I/O ports at bc00 [size=4]
        Region 2: I/O ports at c000 [size=8]
        Region 3: I/O ports at c400 [size=4]
        Region 4: I/O ports at c800 [size=16]
        Region 5: I/O ports at cc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 177
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[K8T800 South]
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 185
        Region 0: I/O ports at e400
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280
[Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems: Unknown device 0140
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 145
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=f8000000]
        Region 1: I/O ports at a000 [size=256]
        Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc: Unknown device
5940 (rev 01)
        Subsystem: Diamond Multimedia Systems: Unknown device 0141
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at f0000000 (32-bit, prefetchable) [disabled]
        Region 1: Memory at f9010000 (32-bit, non-prefetchable)
[disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
=====

=====
Bootdata ok (command line is root=/dev/sda3 acpi=off console=tty0
console=ttyS1,115200n8 pci=routeirq selinux=0 splash=silent)
=====


- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDJjzcHl0iXDssISsRAhXKAJoCEwTAEAWt4GHgAVltei0CzaqETACfQeWz
n92rK96zBSus+D0I6q6Y5bg=
=YBHd
-----END PGP SIGNATURE-----
