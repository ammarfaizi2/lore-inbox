Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTEENcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTEENcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:32:32 -0400
Received: from web14208.mail.yahoo.com ([216.136.173.72]:31245 "HELO
	web14208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262196AbTEENb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:31:59 -0400
Message-ID: <20030505134428.71292.qmail@web14208.mail.yahoo.com>
Date: Mon, 5 May 2003 06:44:28 -0700 (PDT)
From: Robert Kulagowski <rkulagow@rocketmail.com>
Subject: Kernel oops on Dell PowerEdge 600SC with 2.4.21-pre7
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Dell PowerEdge 600SC used as an encoder for running mythtv.  This
machine has 640MB of ECC RAM, P4@2.4Ghz.  The kernel is 2.4.21-pre7; I don't
see anything in the changelog to rc1 that indicates this may have been fixed,
but then again I'm not a kernel person.

Once this error occurs, it starts to occur on almost all subsequent process',
including during shutdown.

Please CC me on any responses; I'm not subscribed to the list, but am willing
to assist in tracking this down.

Thanks, Bob

START:

scripts/ver_linux:
Linux masterbackend 2.4.21-0.2mdk #1 Mon Apr 21 23:44:07 CEST 2003 i686
unknown unknown GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.32
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         sg st sr_mod sd_mod scsi_mod parport_pc lp parport
snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer snd-page-alloc
snd-util-mem snd-rawmidi snd-hwdep snd-seq-device snd-ac97-codec snd nfsd
af_packet ide-floppy ide-tape ide-cd cdrom floppy e1000 supermount tuner
tvaudio bttv i2c-algo-bit i2c-core videodev soundcore loop aes rtc ext3 jbd
lvm-mod

May  5 08:15:01 masterbackend kernel:  <1>Unable to handle kernel paging
request at virtual address 161b1d1d
May  5 08:15:01 masterbackend kernel:  printing eip:
May  5 08:15:01 masterbackend kernel: c013bdbe
May  5 08:15:01 masterbackend kernel: *pde = 00000000
May  5 08:15:01 masterbackend kernel: Oops: 0002
May  5 08:15:01 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1
 snd-pcm snd-timer snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep
snd-seq-device snd-ac97-codec snd nfsd af_packet ide-flop
py ide-tape ide-cd cdrom floppy e1000 supermount tuner tvaudio bttv
i2c-algo-bit i2c-core videodev soundcore loop aes rtc ext3
 jbd lvm-mod
May  5 08:15:01 masterbackend kernel: CPU:    0
May  5 08:15:01 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May  5 08:15:01 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May  5 08:15:01 masterbackend kernel: EFLAGS: 00010046
May  5 08:15:01 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May  5 08:15:01 masterbackend kernel: eax: 161b1d19   ebx: d15e0020   ecx:
00000018   edx: d8a7c020
May  5 08:15:01 masterbackend kernel: esi: c16ebdd4   edi: d15e09e0   ebp:
e0783d68   esp: e0783d60
May  5 08:15:01 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May  5 08:15:01 masterbackend kernel: Process wget (pid: 24029,
stackpage=e0783000)
May  5 08:15:01 masterbackend kernel: Stack: 00000202 d15e09e0 e0783d7c
c013b714 c16ebdd4 d15e09e0 d15e09e0 e0783d8c
May  5 08:15:01 masterbackend kernel:        c014588d c16ebdd4 d15e09e0
e0783db0 c0147762 d15e09e0 d15e09e0 00000001
May  5 08:15:01 masterbackend kernel:        c1573520 000001f0 c1573520
c03446ec e0783de4 c013c45d c1573520 000001f0
May  5 08:15:01 masterbackend kernel: Call Trace:
May  5 08:15:01 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May  5 08:15:01 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May  5 08:15:01 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May  5 08:15:01 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May  5 08:15:01 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May  5 08:15:01 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May  5 08:15:01 masterbackend kernel:  [balance_classzone+90/416]
balance_classzone+0x5a/0x1a0 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c013db7a>]
balance_classzone+0x5a/0x1a0 [kernel]
May  5 08:15:01 masterbackend kernel:  [__alloc_pages+406/656]
__alloc_pages+0x196/0x290 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c013de56>] __alloc_pages+0x196/0x290
[kernel]
May  5 08:15:01 masterbackend kernel:  [__get_free_pages+76/80]
__get_free_pages+0x4c/0x50 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c013df9c>]
__get_free_pages+0x4c/0x50 [kernel]
May  5 08:15:01 masterbackend kernel:  [__pollwait+54/160]
__pollwait+0x36/0xa0 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c0151dc6>] __pollwait+0x36/0xa0
[kernel]
May  5 08:15:01 masterbackend kernel:  [tcp_poll+48/368] tcp_poll+0x30/0x170
[kernel]
May  5 08:15:01 masterbackend kernel:  [<c02259f0>] tcp_poll+0x30/0x170
[kernel]
May  5 08:15:01 masterbackend kernel:  [sock_poll+28/32] sock_poll+0x1c/0x20
[kernel]
May  5 08:15:01 masterbackend kernel:  [<c0205acc>] sock_poll+0x1c/0x20
[kernel]
May  5 08:15:01 masterbackend kernel:  [do_select+505/528]
do_select+0x1f9/0x210 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c0152139>] do_select+0x1f9/0x210
[kernel]
May  5 08:15:01 masterbackend kernel:  [sys_select+827/1280]
sys_select+0x33b/0x500 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c01524bb>] sys_select+0x33b/0x500
[kernel]
May  5 08:15:01 masterbackend kernel:  [generic_file_write+55/80]
generic_file_write+0x37/0x50 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c0138957>]
generic_file_write+0x37/0x50 [kernel]
May  5 08:15:01 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-947039/96]
E jo
urnal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May  5 08:15:01 masterbackend kernel:  [<e9106ca1>] E
journal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May  5 08:15:01 masterbackend kernel:  [system_call+51/64]
system_call+0x33/0x40 [kernel]
May  5 08:15:01 masterbackend kernel:  [<c0109093>] system_call+0x33/0x40
[kernel]
May  5 08:15:01 masterbackend kernel:
May  5 08:15:01 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04

[root@masterbackend linux]# cat /proc/version
Linux version 2.4.21-0.2mdk (chmou@no.mandrakesoft.com) (gcc version 3.2.2
(Mandrake Linux 9.2 3.2.2-5mdk)) #1 Mon Apr 21 23:44:07 CEST 2003
[root@masterbackend linux]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.404
cache size      : 512 KB
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
bogomips        : 4784.12

[root@masterbackend linux]# cat /proc/modules
sg                     34604   0 (autoclean) (unused)
st                     29456   0 (autoclean) (unused)
sr_mod                 19256   0 (autoclean) (unused)
sd_mod                 13260   0 (autoclean) (unused)
scsi_mod              103476   4 (autoclean) [sg st sr_mod sd_mod]
parport_pc             25096   1 (autoclean)
lp                      8096   0 (autoclean)
parport                34176   1 (autoclean) [parport_pc lp]
snd-pcm-oss            43492   0 (unused)
snd-mixer-oss          14488   0 [snd-pcm-oss]
snd-emu10k1            69268   0
snd-pcm                77472   0 [snd-pcm-oss snd-emu10k1]
snd-timer              18376   0 [snd-pcm]
snd-page-alloc          7700   0 [snd-emu10k1 snd-pcm]
snd-util-mem            3008   0 [snd-emu10k1]
snd-rawmidi            17600   0 [snd-emu10k1]
snd-hwdep               6368   0 [snd-emu10k1]
snd-seq-device          5832   0 [snd-emu10k1 snd-rawmidi]
snd-ac97-codec         40160   0 [snd-emu10k1]
snd                    40868   0 [snd-pcm-oss snd-mixer-oss snd-emu10k1
snd-pcm snd-timer snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec]
nfsd                   74192   8 (autoclean)
af_packet              14984   1 (autoclean)
ide-floppy             15584   0 (autoclean)
ide-tape               48272   0 (autoclean)
ide-cd                 33796   0 (autoclean)
cdrom                  31616   0 (autoclean) [sr_mod ide-cd]
floppy                 55068   0
e1000                  57504   1 (autoclean)
supermount             15296   2 (autoclean)
tuner                  11744   2 (autoclean)
tvaudio                14780   0 (autoclean) (unused)
bttv                   81248   0
i2c-algo-bit            9064   2 [bttv]
i2c-core               21192   0 [tuner tvaudio bttv i2c-algo-bit]
videodev                7872   6 [bttv]
soundcore               6276   0 [snd bttv]
loop                   14100   0 (autoclean)
aes                    31808   0 (autoclean) [loop]
rtc                     8060   0 (autoclean)
ext3                   59468   3
jbd                    39100   3 [ext3]
lvm-mod                57464   5

[root@masterbackend linux]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0168-016f : PCI device 1166:0217 (ServerWorks)
0170-0177 : ide1
01e8-01ef : PCI device 1166:0217 (ServerWorks)
  01e8-01ef : ide2
01f0-01f7 : ide0
036c-036f : PCI device 1166:0217 (ServerWorks)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03ec-03ef : PCI device 1166:0217 (ServerWorks)
  03ee-03ee : ide2
03f6-03f6 : ide0
03f8-03ff : serial(auto)
08b0-08bf : ServerWorks CSB6 RAID/IDE Controller
  08b0-08b7 : ide0
  08b8-08bf : ide1
0900-090f : PCI device 1166:0217 (ServerWorks)
  0900-0907 : ide2
0cf8-0cff : PCI conf1
e800-e8ff : ATI Technologies Inc Rage XL
ec60-ec7f : Creative Labs SB Live! EMU10k1 (#2)
  ec60-ec7f : EMU10K1
ec90-ec97 : Creative Labs SB Live! MIDI/Game Port (#2)
ec98-ec9f : Creative Labs SB Live! MIDI/Game Port
eca0-ecbf : Creative Labs SB Live! EMU10k1
  eca0-ecbf : EMU10K1
ecc0-ecff : Intel Corp. 82540EM Gigabit Ethernet Controller
  ecc0-ecff : e1000

[root@masterbackend linux]# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-27feffff : System RAM
  00100000-00266230 : Kernel code
  00266231-0038441f : Kernel data
27ff0000-27ffebff : ACPI Tables
27ffec00-27ffefff : reserved
fd000000-fdffffff : ATI Technologies Inc Rage XL
  fd000000-fd7effff : vesafb
fe100000-fe11ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  fe100000-fe11ffff : e1000
fe120000-fe120fff : ServerWorks CSB6 OHCI USB Controller
fe121000-fe121fff : ATI Technologies Inc Rage XL
feb00000-feb00fff : Brooktree Corporation Bt878 Audio Capture (#2)
feb01000-feb01fff : Brooktree Corporation Bt878 Video Capture (#2)
  feb01000-feb01fff : bttv
feb02000-feb02fff : Brooktree Corporation Bt878 Audio Capture
feb03000-feb03fff : Brooktree Corporation Bt878 Video Capture
  feb03000-feb03fff : bttv
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

[root@masterbackend linux]# lspci -vvv
00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller
(rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 0134
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ecc0 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message
Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

00:03.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs: Unknown device 8065
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at eca0 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
0a)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at ec98 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at feb03000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev
11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver,
audio section)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at feb02000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs: Unknown device 8065
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 25
        Region 0: I/O ports at ec60 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
0a)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at ec90 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at feb01000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev
11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver,
audio section)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at feb00000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 0134
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 10
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at e800 [size=256]
        Region 2: Memory at fe121000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 IDE interface: ServerWorks: Unknown device 0217 (rev a0) (prog-if 87
[Master SecO PriP PriO])
        Subsystem: Dell Computer Corporation: Unknown device 0134
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 01e8 [size=8]
        Region 1: I/O ports at 03ec [size=4]
        Region 2: I/O ports at 0168 [size=8]
        Region 3: I/O ports at 036c [size=4]
        Region 4: I/O ports at 0900 [size=16]

00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev a0)
        Subsystem: ServerWorks: Unknown device 0201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0) (prog-if
8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device c134
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05)
(prog-if 10 [OHCI])
        Subsystem: ServerWorks: Unknown device 0220
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at fe120000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
