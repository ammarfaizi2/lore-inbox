Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUARQpg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 11:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUARQpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 11:45:36 -0500
Received: from vsmtp1alice.tin.it ([212.216.176.141]:20916 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S262030AbUARQpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 11:45:25 -0500
Date: Sun, 18 Jan 2004 17:45:58 +0100
From: Francesco Piano <fr.piano@virgilio.it>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel 2.6.1 strange message
Message-Id: <20040118174558.182deae2.fr.piano@virgilio.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, sometimes running Kernel 2.6.1 I get this message on login:


Jan 18 12:14:28 knopy kernel: request_module: failed /sbin/modprobe -- char-major-4-64. error = 256
Jan 18 12:14:28 knopy modprobe: FATAL: Error running install command for serial
Jan 18 12:14:29 knopy last message repeated 6 times
Jan 18 12:14:29 knopy kernel: request_module: failed /sbin/modprobe -- char-major-188-8. error = 256
Jan 18 12:14:30 knopy /usr/sbin/cron[556]: (CRON) INFO (pidfile fd = 3)
Jan 18 12:14:30 knopy /usr/sbin/cron[557]: (CRON) STARTUP (fork ok)
Jan 18 12:14:30 knopy /usr/sbin/cron[557]: (CRON) INFO (Running @reboot jobs)
Jan 18 12:14:30 knopy /USR/SBIN/CRON[565]: (root) CMD (   if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck -R; fi)
Jan 18 12:14:45 knopy pppoe[177]: Timeout waiting for PADO packets
Jan 18 12:14:45 knopy kernel: Badness in local_bh_enable at kernel/softirq.c:121
Jan 18 12:14:45 knopy pppd[157]: Modem hangup
Jan 18 12:14:45 knopy pppd[157]: Connection terminated.
Jan 18 12:14:45 knopy kernel: Call Trace:
Jan 18 12:14:45 knopy kernel:  [<c0124f3d>] local_bh_enable+0x8d/0x90
Jan 18 12:14:45 knopy kernel:  [<e1a7ac12>] ppp_async_push+0xa2/0x1a0 [ppp_async]
Jan 18 12:14:45 knopy kernel:  [<c0167582>] __lookup_hash+0x72/0xe0
Jan 18 12:14:45 knopy kernel:  [<e1a7a4d1>] ppp_asynctty_wakeup+0x31/0x70 [ppp_async]
Jan 18 12:14:45 knopy kernel:  [<c0241679>] pty_unthrottle+0x59/0x60
Jan 18 12:14:45 knopy kernel:  [<c023dda8>] check_unthrottle+0x38/0x40
Jan 18 12:14:45 knopy kernel:  [<c023de53>] n_tty_flush_buffer+0x13/0x60
Jan 18 12:14:45 knopy kernel:  [<c0241a6d>] pty_flush_buffer+0x6d/0x70
Jan 18 12:14:45 knopy kernel:  [<c023a57d>] do_tty_hangup+0x43d/0x4a0
Jan 18 12:14:45 knopy kernel:  [<c023bb37>] release_dev+0x677/0x6d0
Jan 18 12:14:45 knopy kernel:  [<c014930b>] unmap_page_range+0x4b/0x80
Jan 18 12:14:45 knopy kernel:  [<c016fdd0>] dput+0x30/0x240
Jan 18 12:14:45 knopy kernel:  [<c023bf5a>] tty_release+0x2a/0x70
Jan 18 12:14:45 knopy kernel:  [<c0159aea>] __fput+0xba/0xd0
Jan 18 12:14:45 knopy kernel:  [<c0158159>] filp_close+0x59/0x90
Jan 18 12:14:45 knopy kernel:  [<c01226bc>] put_files_struct+0x6c/0xe0
Jan 18 12:14:45 knopy kernel:  [<c0123377>] do_exit+0x197/0x360
Jan 18 12:14:45 knopy kernel:  [<c012362b>] do_group_exit+0x7b/0xc0
Jan 18 12:14:45 knopy kernel:  [<c010b4db>] syscall_call+0x7/0xb

Output of ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux knopy 2.6.1 #3 Sat Jan 17 20:42:06 CET 2004 i686 GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11x
module-init-tools      3.0-pre5
e2fsprogs              1.34-WIP
jfsutils               1.1.2
xfsprogs               2.5.3
pcmcia-cs              3.2.2
quota-tools            3.10.
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nls_iso8859_1 ppp_deflate zlib_deflate bsd_comp nfsd exportfs ipt_ULOG ipt_pkttype ipt_TCPMSS ipt_length iptable_mangle ppp_async ppp_generic slhc via_rhine ipt_conntrack ipt_ttl ipt_dscp ipt_ecn ipt_tos ipt_mark ipt_TOS ipt_MASQUERADE ip_nat_amanda ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ipt_limit ipt_owner ipt_state ipt_REJECT ipt_mac ipt_multiport ip_queue ip_conntrack_irc ip_conntrack_amanda ip_conntrack_ftp ip_conntrack iptable_filter ip_tables ntfs emu10k1 sound ac97_codec soundcore rtc

Distro: Knoppix Debian GNU/Linux 3.3

knoppix@knopy:/usr/src/linux-2.6.0/scripts$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 1010.204
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

knoppix@knopy:/usr/src/linux-2.6.0/scripts$ cat /proc/modules
nls_iso8859_1 3520 - - Live 0xe5efc000
ppp_deflate 4576 - - Live 0xe1aac000
zlib_deflate 21560 - - Live 0xe1ab3000
bsd_comp 5216 - - Live 0xe1a9e000
nfsd 94320 - - Live 0xe1aba000
exportfs 4928 - - Live 0xe1a9b000
ipt_ULOG 5256 - - Live 0xe1a92000
ipt_pkttype 1056 - - Live 0xe1a8d000
ipt_TCPMSS 3328 - - Live 0xe1a80000
ipt_length 1120 - - Live 0xe1a89000
iptable_mangle 1888 - - Live 0xe198c000
ppp_async 9248 - - Live 0xe1a7a000
ppp_generic 23016 - - Live 0xe1a82000
slhc 6048 - - Live 0xe1a6d000
via_rhine 18376 - - Live 0xe1a74000
ipt_conntrack 1856 - - Live 0xe1a6b000
ipt_ttl 1312 - - Live 0xe1a69000
ipt_dscp 1120 - - Live 0xe1a67000
ipt_ecn 1568 - - Live 0xe1a65000
ipt_tos 1056 - - Live 0xe1a63000
ipt_mark 1120 - - Live 0xe1a61000
ipt_TOS 1728 - - Live 0xe1a5f000
ipt_MASQUERADE 2816 - - Live 0xe1a58000
ip_nat_amanda 2108 - - Live 0xe1a56000
ip_nat_snmp_basic 10564 - - Live 0xe1a5b000
ip_nat_irc 3216 - - Live 0xe1a3c000
ip_nat_ftp 3920 - - Live 0xe19d8000
iptable_nat 19428 - - Live 0xe1a3f000
ipt_limit 1696 - - Live 0xe1a31000
ipt_owner 2912 - - Live 0xe198e000
ipt_state 1248 - - Live 0xe19c4000
ipt_REJECT 5504 - - Live 0xe1a34000
ipt_mac 1344 - - Live 0xe19c2000
ipt_multiport 1440 - - Live 0xe19c0000
ip_queue 8500 - - Live 0xe19d4000
ip_conntrack_irc 70100 - - Live 0xe1a1e000
ip_conntrack_amanda 68580 - - Live 0xe1a0c000
ip_conntrack_ftp 70932 - - Live 0xe19f9000
ip_conntrack 27904 - - Live 0xe19f1000
iptable_filter 1888 - - Live 0xe197d000
ip_tables 14288 - - Live 0xe19c6000
ntfs 86484 - - Live 0xe19da000
emu10k1 81636 - - Live 0xe1996000
sound 75148 - - Live 0xe19ac000
ac97_codec 16960 - - Live 0xe1990000
soundcore 6432 - - Live 0xe1986000
rtc 10440 - - Live 0xe1982000

knoppix@knopy:/usr/src/linux-2.6.0/scripts$ cat /proc/ioports
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
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
9000-901f : 0000:00:1f.4
  9000-901f : uhci_hcd
9400-941f : 0000:00:1f.2
  9400-941f : uhci_hcd
9800-980f : 0000:00:1f.1
  9800-9807 : ide0
  9808-980f : ide1
a800-a8ff : 0000:02:0e.0
  a800-a8ff : via-rhine
b000-b0ff : 0000:02:0d.0
  b000-b0ff : 8139too
b400-b407 : 0000:02:0a.1
b800-b81f : 0000:02:0a.0
  b800-b81f : EMU10K1
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
e800-e80f : 0000:00:1f.3

knoppix@knopy:/usr/src/linux-2.6.0/scripts$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeafff : System RAM
  00100000-00353936 : Kernel code
  00353937-004368ff : Kernel data
1ffeb000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
ee000000-ee0000ff : 0000:02:0e.0
  ee000000-ee0000ff : via-rhine
ee800000-ee8000ff : 0000:02:0d.0
  ee800000-ee8000ff : 8139too
ef000000-efdfffff : PCI Bus #01
  ef000000-ef07ffff : 0000:01:00.0
eff00000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
    f0000000-f0ffffff : vesafb
f8000000-fbffffff : 0000:00:00.0
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

root@knopy:/usr/src/linux-2.6.0/scripts# lspci -vvv
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
(rev 04)
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+
>SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [88] #09 [e104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 04) (prog-if 00 [Normal
 decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ef000000-efdfffff
        Prefetchable memory behind bridge: eff00000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) (prog-if 00 [Normal dec
ode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000bfff
        Memory behind bridge: ee000000-eeffffff
        Prefetchable memory behind bridge: efe00000-efefffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SER
R+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 9800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8027
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at 9400 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
        Subsystem: Asustek Computer, Inc. TUSL2-C Mainboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at e800 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8027
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 23
        Region 4: I/O ports at 9000 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7200] (pro
g-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000/Radeon
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SER
R- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-
)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
        Subsystem: Creative Labs CT4620 SBLive!
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at b800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-
)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER
R- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort
- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at b400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-
)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 1                     0)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SER                     R- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort                     - >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at b000 [size=256]
        Region 1: Memory at ee800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3col                     d+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0e.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] (rev 86)
        Subsystem: VIA Technologies, Inc.: Unknown device 0105
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SER                     R- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort                     - >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at a800 [size=256]
        Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+                     )
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

root@knopy:/usr/src/linux-2.6.0/scripts# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: DV-W50D          Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: YAMAHA   Model: CRW2100E         Rev: 1.0N
  Type:   CD-ROM                           ANSI SCSI revision: 02

Thank to All Linux Developer

bye
-- 
Francesco Piano
