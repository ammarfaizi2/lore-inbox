Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTLTTvd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 14:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTLTTvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 14:51:33 -0500
Received: from wormhole.wms-hn.de ([141.7.87.2]:1499 "EHLO wormhole.wms-hn.de")
	by vger.kernel.org with ESMTP id S261188AbTLTTvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 14:51:18 -0500
Subject: Problem: Possible bug aha142x_cs
From: Tilo Lutz <TiloLutz@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071949907.1997.19.camel@tilo.rz.uni-karlsruhe.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 20 Dec 2003 20:51:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I hope I've included all needed information regarding to
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html.
Any idea how to fix this?

My PC-Card scsi-controller sin't working with 2.6.0 anymore.
If I plug in the pc-card, Adaptec SlimSCSI 1460B, I get a kernel error.
Keywords: modules, pcmcia, scsi
Kernel: 2.6.0
I use Suse 9.0 with updated util-linux and modutils.

error-message:
Dec 20 20:27:17 tilo cardmgr[2176]: socket 1: Adaptec APA-1460 SlimSCSI
Dec 20 20:27:17 tilo kernel: cs: memory probe 0xa0000000-0xa0ffffff:
clean.
Dec 20 20:27:18 tilo cardmgr[2176]: executing: 'modprobe -v aha152x_cs'
Dec 20 20:27:18 tilo cardmgr[2176]: + insmod
/lib/modules/2.6.0/kernel/drivers/scsi/pcmcia/aha152x_cs.ko
Dec 20 20:27:18 tilo kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 20 20:27:18 tilo kernel:  printing eip:
Dec 20 20:27:18 tilo kernel: c023e634
Dec 20 20:27:18 tilo kernel: *pde = 00000000
Dec 20 20:27:18 tilo kernel: Oops: 0002 [#1]
Dec 20 20:27:18 tilo kernel: CPU:    0
Dec 20 20:27:18 tilo kernel: EIP:    0060:[<c023e634>]    Not tainted
Dec 20 20:27:18 tilo kernel: EFLAGS: 00010286
Dec 20 20:27:18 tilo kernel: EIP is at scsi_register+0x44/0x70
Dec 20 20:27:18 tilo kernel: eax: d02939b8   ebx: d0293800   ecx:
00000000   edx: d92ee674
Dec 20 20:27:18 tilo kernel: esi: d92ee600   edi: c9235a4c   ebp:
0000002b   esp: c92357d0
Dec 20 20:27:18 tilo kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 20:27:18 tilo kernel: Process cardmgr (pid: 2176,
threadinfo=c9234000 task=d5e26cc0)
Dec 20 20:27:18 tilo kernel: Stack: d92ee600 00000334 00000000 c9235a24
d92e5a7b d92ee600 00000334 00002000
Dec 20 20:27:18 tilo kernel:        00000500 035f0340 caf26300 ca2acb80
c9235a04 ca2acb80 0000002b d92986c5
Dec 20 20:27:18 tilo kernel:        ca2acb80 00000286 c9235884 00000000
c9235a24 c9235a4c 0000002b d92e5531
Dec 20 20:27:18 tilo kernel: Call Trace:
Dec 20 20:27:18 tilo kernel:  [<d92e5a7b>] aha152x_probe_one+0x1b/0x430
[aha152x_cs]
Dec 20 20:27:18 tilo kernel:  [<d92986c5>] CardServices+0x165/0x35b
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92e5531>] aha152x_config_cs+0x351/0x3b0
[aha152x_cs]
Dec 20 20:27:18 tilo kernel:  [<d911be7b>]
xfs_trans_unlocked_item+0x3b/0x60 [xfs]
Dec 20 20:27:18 tilo kernel:  [<d91d580c>] yenta_set_mem_map+0x1bc/0x220
[yenta_socket]
Dec 20 20:27:18 tilo kernel:  [<c01101ca>] sys_ptrace+0x22a/0x700
Dec 20 20:27:18 tilo kernel:  [<d92900ba>] set_cis_map+0x3a/0x110
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92902c0>] read_cis_mem+0x130/0x1b0
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92905f9>] read_cis_cache+0x139/0x1c0
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d9291005>]
pcmcia_get_tuple_data+0x95/0xb0 [pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d9292330>] pcmcia_parse_tuple+0x90/0x170
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92924b3>] read_tuple+0xa3/0xb0
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d91d580c>] yenta_set_mem_map+0x1bc/0x220
[yenta_socket]
Dec 20 20:27:18 tilo kernel:  [<c011c81b>] __ioremap+0x9b/0x120
Dec 20 20:27:18 tilo kernel:  [<d92e573e>] aha152x_event+0x12e/0x140
[aha152x_cs]
Dec 20 20:27:18 tilo kernel:  [<d9292458>] read_tuple+0x48/0xb0
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92905f9>] read_cis_cache+0x139/0x1c0
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d9290ee6>]
pcmcia_get_next_tuple+0x256/0x2e0 [pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92925f3>]
pcmcia_validate_cis+0x133/0x220 [pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d9130dc9>] _xfs_imap_to_bmap+0x39/0x260
[xfs]
Dec 20 20:27:18 tilo kernel:  [<d911be7b>]
xfs_trans_unlocked_item+0x3b/0x60 [xfs]
Dec 20 20:27:18 tilo kernel:  [<d9131206>] xfs_iomap+0x216/0x530 [xfs]
Dec 20 20:27:18 tilo kernel:  [<d92971e8>]
pcmcia_register_client+0x268/0x290 [pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d91d580c>] yenta_set_mem_map+0x1bc/0x220
[yenta_socket]
Dec 20 20:27:18 tilo kernel:  [<d910af8e>]
xfs_log_release_iclog+0x1e/0x60 [xfs]
Dec 20 20:27:18 tilo kernel:  [<d929872f>] CardServices+0x1cf/0x35b
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92902c0>] read_cis_mem+0x130/0x1b0
[pcmcia_core]
Dec 20 20:27:18 tilo kernel:  [<d92e5111>] aha152x_attach+0x111/0x150
[aha152x_cs]
Dec 20 20:27:18 tilo kernel:  [<d92e5610>] aha152x_event+0x0/0x140
[aha152x_cs]
Dec 20 20:27:18 tilo kernel:  [<d91e7467>] get_pcmcia_driver+0x37/0x60
[ds]
Dec 20 20:27:18 tilo kernel:  [<d91e64aa>] bind_request+0x11a/0x230 [ds]
Dec 20 20:27:18 tilo kernel:  [<d91e6fc8>] ds_ioctl+0x478/0x6b0 [ds]
Dec 20 20:27:18 tilo kernel:  [<c0269a63>] sock_def_readable+0x53/0x80
Dec 20 20:27:18 tilo kernel:  [<c02cd7a3>]
unix_dgram_sendmsg+0x523/0x580
Dec 20 20:27:18 tilo kernel:  [<c026603e>] sock_sendmsg+0x9e/0xf0
Dec 20 20:27:18 tilo kernel:  [<c014cb50>] handle_mm_fault+0x160/0x1e0
Dec 20 20:27:18 tilo kernel:  [<c011c094>] do_page_fault+0x184/0x58a
Dec 20 20:27:18 tilo kernel:  [<c011dd01>] schedule+0x271/0x5f0
Dec 20 20:27:18 tilo kernel:  [<c011e1e2>] __wake_up_locked+0x22/0x30
Dec 20 20:27:18 tilo kernel:  [<c014ad1e>] zap_pte_range+0x15e/0x1a0
DeDec 20 20:27:18 tilo kernel:  [<c014ae1b>] unmap_page_range+0x4b/0x80
Dec 20 20:27:18 tilo kernel:  [<c014af3b>] unmap_vmas+0xeb/0x240
Dec 20 20:27:18 tilo kernel:  [<c014ea95>] unmap_region+0x95/0xe0
Dec 20 20:27:18 tilo kernel:  [<c014e978>] unmap_vma+0x48/0xa0
Dec 20 20:27:18 tilo kernel:  [<c014e9ef>] unmap_vma_list+0x1f/0x30
Dec 20 20:27:18 tilo kernel:  [<c014ee59>] do_munmap+0x169/0x1e0
Dec 20 20:27:18 tilo kernel:  [<d91e6b50>] ds_ioctl+0x0/0x6b0 [ds]
Dec 20 20:27:18 tilo kernel:  [<c016db36>] sys_ioctl+0x256/0x2e0
Dec 20 20:27:18 tilo kernel:  [<c014ef14>] sys_munmap+0x44/0x70
Dec 20 20:27:18 tilo kernel:  [<c010b4fb>] syscall_call+0x7/0xb
Dec 20 20:27:18 tilo kernel:
Dec 20 20:27:18 tilo kernel: Code: 89 01 89 d8 8b 74 24 0c 8b 5c 24 08
83 c4 10 c3 8b 46 04 c7
c 20 20:27:18 tilo kernel:  [<c014adab>] zap_pmd_range+0x4b/0x70

scripts/ver_linux:
f some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux tilo 2.6.0 #1 Sat Dec 20 19:51:11 CET 2003 i686 i686 i386
GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
jfsutils               1.1.2
xfsprogs               2.5.6
pcmcia-cs              3.2.4
quota-tools            3.10-pre1.
PPP                    2.4.1
isdn4k-utils           3.3
Linux C Library        24 01:05 /lib/i686/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         sr_mod snd_mixer_oss tun parport_pc lp parport
md5 ipv6 thermal processor fan button snd_maestro3 snd_ac97_codec
snd_pcm snd_page_alloc snd_timer battery ac snd soundcore ds
yenta_socket pcmcia_core evdev hid raw1394 ohci1394 ieee1394 8139too mii
ide_cd cdrom uhci_hcd ohci_hcd ehci_hcd usbcore cryptoloop xfs

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 852.033
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1683.45

/proc/modules:
sr_mod 13860 0 - Live 0xd9286000
snd_mixer_oss 19840 1 - Live 0xd9280000
tun 7168 1 - Live 0xd91fc000
parport_pc 38316 1 - Live 0xd9269000
lp 9408 0 - Live 0xd9206000
parport 38248 2 parport_pc,lp, Live 0xd9275000
md5 3840 1 - Live 0xd9204000
ipv6 245184 17 - Live 0xd92b0000
thermal 10896 0 - Live 0xd922c000
processor 11684 1 thermal, Live 0xd9228000
fan 3084 0 - Live 0xd9202000
button 4760 0 - Live 0xd91ff000
snd_maestro3 23204 3 - Live 0xd9221000
snd_ac97_codec 55812 1 snd_maestro3, Live 0xd925a000
snd_pcm 102180 3 snd_maestro3, Live 0xd9240000
snd_page_alloc 10116 1 snd_pcm, Live 0xd91da000
snd_timer 25220 1 snd_pcm, Live 0xd9219000
battery 7948 0 - Live 0xd91f9000
ac 3724 0 - Live 0xd91f7000
snd 56836 7 snd_mixer_oss,snd_maestro3,snd_ac97_codec,snd_pcm,snd_timer,
Live 0xd920a000
soundcore 7232 2 snd, Live 0xd91de000
ds 11268 4 - Live 0xd91f3000
yenta_socket 14976 0 - Live 0xd91d5000
pcmcia_core 64608 2 ds,yenta_socket, Live 0xd91e2000
evdev 7808 1 - Live 0xd9017000
hid 32192 0 - Live 0xd90b1000
raw1394 26252 0 - Live 0xd91c7000
ohci1394 32264 0 - Live 0xd9057000
ieee1394 212268 2 raw1394,ohci1394, Live 0xd907c000
8139too 20736 0 - Live 0xd9075000
mii 4480 1 8139too, Live 0xd9054000
ide_cd 38660 1 - Live 0xd906a000
cdrom 34336 2 sr_mod,ide_cd, Live 0xd9060000
uhci_hcd 30608 0 - Live 0xd9031000
ohci_hcd 17408 0 - Live 0xd902b000
ehci_hcd 22660 0 - Live 0xd9024000
usbcore 99932 6 hid,uhci_hcd,ohci_hcd,ehci_hcd, Live 0xd903a000
cryptoloop 3328 0 - Live 0xd901a000
xfs 601144 1 - Live 0xd90ba000

/proc/ioports
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
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
2180-219f : 0000:00:07.3
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
8000-803f : 0000:00:07.3
f000-f0ff : 0000:00:08.0
  f000-f0ff : 8139too
f400-f4ff : 0000:00:06.1
f800-f8ff : 0000:00:06.0
  f800-f8ff : Allegro
fcd0-fcdf : 0000:00:07.1
  fcd0-fcd7 : ide0
fce0-fcff : 0000:00:07.2
  fce0-fcff : uhci_hcd

/proc/iomem
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-002e1b71 : Kernel code
  002e1b72-003afdff : Kernel data
17ff0000-17fffbff : ACPI Tables
17fffc00-17ffffff : ACPI Non-volatile Storage
18000000-18000fff : 0000:00:0a.0
  18000000-18000fff : yenta_socket
18001000-18001fff : 0000:00:0a.1
  18001000-18001fff : yenta_socket
18400000-187fffff : PCI CardBus #02
18800000-18bfffff : PCI CardBus #02
18c00000-18ffffff : PCI CardBus #06
19000000-193fffff : PCI CardBus #06
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
    f0000000-f07fffff : vesafb
f8000000-fbffffff : 0000:00:00.0
fedffc00-fedffcff : 0000:00:08.0
  fedffc00-fedffcff : 8139too
fffe9400-ffffffff : reserved

lspci -vvv:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 1040
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=x2

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f0000000-f7ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:06.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1
(rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 1049
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at f800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.1 Communication controller: ESS Technology ESS Modem (rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 1049
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at f400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcd0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at fce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Asustek Computer, Inc.: Unknown device 1045
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at f000 [size=256]
        Region 1: Memory at fedffc00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
        Subsystem: Asustek Computer, Inc.: Unknown device 1044
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 18000000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 18400000-187ff000 (prefetchable)
        Memory window 1: 18800000-18bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
        Subsystem: Asustek Computer, Inc.: Unknown device 1044
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at 18001000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 18c00000-18fff000 (prefetchable)
        Memory window 1: 19000000-193ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-MV (rev
11) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 1042
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f0000000 (32-bit, non-prefetchable)
[size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
   Capabilities: [80] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

/proc/scsi/scsi
Attached devices:



After pluging in the pc-card the following things have changed:

tilo:/usr/src/linux/scripts # ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux tilo 2.6.0 #1 Sat Dec 20 19:51:11 CET 2003 i686 i686 i386
GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
jfsutils               1.1.2
xfsprogs               2.5.6
pcmcia-cs              3.2.4
quota-tools            3.10-pre1.
PPP                    2.4.1
isdn4k-utils           3.3
Linux C Library        24 01:05 /lib/i686/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         aha152x_cs sr_mod snd_mixer_oss tun parport_pc lp
parport md5 ipv6 thermal processor fan button snd_maestro3
snd_ac97_codec snd_pcm snd_page_alloc snd_timer battery ac snd soundcore
ds yenta_socket pcmcia_core evdev hid raw1394 ohci1394 ieee1394 8139too
mii ide_cd cdrom uhci_hcd ohci_hcd ehci_hcd usbcore cryptoloop xfs
tilo:/usr/src/linux/scripts #

tilo:/usr/src/linux/scripts # cat /proc/modules
aha152x_cs 40276 1 - Live 0xd9298000
sr_mod 13860 0 - Live 0xd9286000
snd_mixer_oss 19840 1 - Live 0xd9280000
tun 7168 1 - Live 0xd91fc000
parport_pc 38316 1 - Live 0xd9269000
lp 9408 0 - Live 0xd9206000
parport 38248 2 parport_pc,lp, Live 0xd9275000
md5 3840 1 - Live 0xd9204000
ipv6 245184 17 - Live 0xd92b0000
thermal 10896 0 - Live 0xd922c000
processor 11684 1 thermal, Live 0xd9228000
fan 3084 0 - Live 0xd9202000
button 4760 0 - Live 0xd91ff000
snd_maestro3 23204 3 - Live 0xd9221000
snd_ac97_codec 55812 1 snd_maestro3, Live 0xd925a000
snd_pcm 102180 3 snd_maestro3, Live 0xd9240000
snd_page_alloc 10116 1 snd_pcm, Live 0xd91da000
snd_timer 25220 1 snd_pcm, Live 0xd9219000
battery 7948 0 - Live 0xd91f9000
ac 3724 0 - Live 0xd91f7000
snd 56836 7 snd_mixer_oss,snd_maestro3,snd_ac97_codec,snd_pcm,snd_timer,
Live 0xd920a000soundcore 7232 2 snd, Live 0xd91de000
ds 11268 3 aha152x_cs, Live 0xd91f3000
yenta_socket 14976 1 - Live 0xd91d5000
pcmcia_core 64608 3 aha152x_cs,ds,yenta_socket, Live 0xd91e2000
evdev 7808 1 - Live 0xd9017000
hid 32192 0 - Live 0xd90b1000
raw1394 26252 0 - Live 0xd91c7000
ohci1394 32264 0 - Live 0xd9057000
ieee1394 212268 2 raw1394,ohci1394, Live 0xd907c000
8139too 20736 0 - Live 0xd9075000
mii 4480 1 8139too, Live 0xd9054000
ide_cd 38660 0 - Live 0xd906a000
cdrom 34336 2 sr_mod,ide_cd, Live 0xd9060000
uhci_hcd 30608 0 - Live 0xd9031000
ohci_hcd 17408 0 - Live 0xd902b000
ehci_hcd 22660 0 - Live 0xd9024000
usbcore 99932 6 hid,uhci_hcd,ohci_hcd,ehci_hcd, Live 0xd903a000
cryptoloop 3328 0 - Live 0xd901a000
xfs 601144 1 - Live 0xd90ba000


Regards, Tilo


