Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269353AbUJRDZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269353AbUJRDZg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 23:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269361AbUJRDZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 23:25:36 -0400
Received: from relay.snowman.net ([66.92.160.56]:3079 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S269353AbUJRDYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 23:24:50 -0400
Date: Sun, 17 Oct 2004 23:25:11 -0400
From: Stephen Frost <sfrost@snowman.net>
To: LKML <linux-kernel@vger.kernel.org>,
       Vserver <vserver@list.linux-vserver.org>
Subject: PROBLEM: Oops in log_do_checkpoint, using vserver
Message-ID: <20041018032511.GY21419@ns.snowman.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Vserver <vserver@list.linux-vserver.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7J6vSZfnb9iabnHK"
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 23:12:07 up 260 days, 22:11, 11 users,  load average: 0.02, 0.07, 0.08
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7J6vSZfnb9iabnHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

  Getting repeated crashes (off and on) when using 2.6.8.1 and vserver
  1.9.2 (util-vserver 0.30.190).  Machine is located remotely, first
  time an oops was logged.  Appears to be in log_do_checkpoint under
  ext3.  Possibly vserver-related, seems to happen shortly after
  IO-intensive vserver is started (though not always, lasted a few days
  between the last two crashes).

  If any other information would be useful, please don't hesitate to ask.

Version:
Linux version 2.6.8.1-vs1.9.2kenobi.3 (sfrost@kenobi) (gcc version 3.3.4
(Debian 1:3.3.4-13)) #1 SMP Thu Sep 30 15:28:02 EDT 2004

Oops:
------------[ cut here ]------------
SMP=20
Modules linked in: ipt_REDIRECT ipt_REJECT iptable_nat iptable_mangle iptab=
le_filter ipt_state ipt_pkttype ipt_physdev ipt_multiport ipt_conntrack ipt=
_MARK ipt_LOG ip_conntrack ip_tables 8250 serial_core snd_intel8x0 s
nd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi =
snd_seq_device snd soundcore ehci_hcd uhci_hcd usbcore intel_agp agpgart ee=
prom lm85 i2c_sensor i2c_i801 i2c_dev i2c_core pcspkr
CPU:    1
EIP:    0060:[log_do_checkpoint+364/459]    Not tainted
EFLAGS: 00010286   (2.6.8.1-vs1.9.2kenobi.3)=20
EIP is at log_do_checkpoint+0x16c/0x1cb
eax: 0000006e   ebx: 00000000   ecx: c036ad04   edx: c036ad04
esi: 00000000   edi: 00000001   ebp: c932d83c   esp: e3a9fd0c
ds: 007b   es: 007b   ss: 0068
Process sendmail (pid: 9628, threadinfo=3De3a9e000 task=3De10c3770)
Stack: c03323c0 c031be9d c03301f7 00000169 c0335200 00294867 c1a87180 00000=
000=20
       00000000 e498574c c0476120 00000000 00000003 c180c0a0 c180cd60 c015a=
341=20
       dedcbf5c dedcbf5c dedcbf5c f314ae3c dedcbf5c c01a60ac f700f4e0 f314a=
e3c=20
Call Trace:
 [wake_up_buffer+23/83] wake_up_buffer+0x17/0x53
 [do_get_write_access+645/1583] do_get_write_access+0x285/0x62f
 [wake_up_buffer+23/83] wake_up_buffer+0x17/0x53
 [find_busiest_group+234/806] find_busiest_group+0xea/0x326
 [ext3_do_update_inode+517/1094] ext3_do_update_inode+0x205/0x446
 [radix_tree_delete+325/398] radix_tree_delete+0x145/0x18e
 [__log_wait_for_space+199/218] __log_wait_for_space+0xc7/0xda
 [start_this_handle+290/954] start_this_handle+0x122/0x3ba
 [find_get_pages+55/90] find_get_pages+0x37/0x5a
 [pagevec_lookup+46/56] pagevec_lookup+0x2e/0x38
 [truncate_inode_pages+289/696] truncate_inode_pages+0x121/0x2b8
 [journal_start+171/210] journal_start+0xab/0xd2
 [locks_delete_lock+139/221] locks_delete_lock+0x8b/0xdd
 [start_transaction+35/88] start_transaction+0x23/0x58
 [locks_remove_posix+239/268] locks_remove_posix+0xef/0x10c
 [ext3_delete_inode+0/230] ext3_delete_inode+0x0/0xe6
 [ext3_delete_inode+39/230] ext3_delete_inode+0x27/0xe6
 [ext3_delete_inode+0/230] ext3_delete_inode+0x0/0xe6
 [generic_delete_inode+147/316] generic_delete_inode+0x93/0x13c
 [iput+98/124] iput+0x62/0x7c
 [dput+231/403] dput+0xe7/0x193
 [__fput+179/260] __fput+0xb3/0x104
 [filp_close+89/134] filp_close+0x59/0x86
 [sys_close+94/113] sys_close+0x5e/0x71
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 0f 0b 69 01 f7 01 33 c0 eb b8 8d 44 24 1c 8d 54 24 24 89 44=20

---------------------------------------------

sfrost@kenobi:/home/sfrost/linux/linux-2.6.8.1> sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
 Linux kenobi 2.6.8.1-vs1.9.2kenobi.3 #1 SMP Thu Sep 30 15:28:02 EDT 2004 i=
686 GNU/Linux
 =20
  Gnu C                  3.3.4
  Gnu make               3.80
  binutils               2.15
  util-linux             2.12
  mount                  2.12
  module-init-tools      3.1-pre5
  e2fsprogs              1.35
  Linux C Library        2.3.2
  Dynamic linker (ldd)   2.3.2
  Procps                 3.2.3
  Net-tools              1.60
  Console-tools          0.2.3
  Sh-utils               5.2.1
  Modules Loaded         iptable_nat iptable_mangle iptable_filter ipt_stat=
e ipt_pkttype ipt_physdev ipt_multiport ipt_conntrack ipt_MARK ipt_LOG ip_c=
onntrack ip_tables 8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm snd=
_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd
  soundcore ehci_hcd uhci_hcd usbcore intel_agp agpgart eeprom lm85 i2c_sen=
sor i2c_i801 i2c_dev i2c_core pcspkr

---------------------------------------------
sfrost@kenobi:/home/sfrost/linux/linux-2.6.8.1> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2794.047
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5521.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2794.047
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5570.56

---------------------------------------------
sfrost@kenobi:/home/sfrost/linux/linux-2.6.8.1> cat /proc/modules
iptable_nat 21356 - - Live 0xf8964000
iptable_mangle 2088 - - Live 0xf892b000
iptable_filter 2120 - - Live 0xf8830000
ipt_state 1512 - - Live 0xf8926000
ipt_pkttype 1352 - - Live 0xf88e7000
ipt_physdev 1752 - - Live 0xf88e5000
ipt_multiport 1640 - - Live 0xf88c6000
ipt_conntrack 1992 - - Live 0xf88c4000
ipt_MARK 1672 - - Live 0xf8893000
ipt_LOG 5704 - - Live 0xf88c8000
ip_conntrack 29388 - - Live 0xf8931000
ip_tables 14336 - - Live 0xf88f2000
8250 28032 - - Live 0xf891e000
serial_core 19240 - - Live 0xf88df000
snd_intel8x0 28808 - - Live 0xf88e9000
snd_ac97_codec 63596 - - Live 0xf890d000
snd_pcm 80708 - - Live 0xf88f8000
snd_timer 20492 - - Live 0xf88cc000
snd_page_alloc 8784 - - Live 0xf8844000
snd_mpu401_uart 5896 - - Live 0xf888e000
snd_rawmidi 19524 - - Live 0xf88a4000
snd_seq_device 6320 - - Live 0xf888b000
snd 42756 - - Live 0xf88d3000
soundcore 6848 - - Live 0xf8857000
ehci_hcd 24524 - - Live 0xf889d000
uhci_hcd 28376 - - Live 0xf8895000
usbcore 100420 - - Live 0xf88aa000
intel_agp 18952 - - Live 0xf8864000
agpgart 27596 - - Live 0xf885c000
eeprom 6096 - - Live 0xf8848000
lm85 19884 - - Live 0xf884c000
i2c_sensor 2344 - - Live 0xf8834000
i2c_i801 6936 - - Live 0xf8841000
i2c_dev 7552 - - Live 0xf8838000
i2c_core 18184 - - Live 0xf883b000
pcspkr 3116 - - Live 0xf8832000

---------------------------------------------
sfrost@kenobi:/home/sfrost/linux/linux-2.6.8.1> cat /proc/ioports
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
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0800-087f : 0000:00:1f.0
0880-08bf : 0000:00:1f.0
0cf8-0cff : PCI conf1
ddc0-ddff : 0000:02:0c.0
  ddc0-ddff : e1000
de00-deff : 0000:02:00.0
eda0-edbf : 0000:00:1f.3
  eda0-edaf : i801-smbus
edc0-edff : 0000:00:1f.5
ee00-eeff : 0000:00:1f.5
fe00-fe07 : 0000:00:1f.2
  fe00-fe07 : libata
fe10-fe13 : 0000:00:1f.2
  fe10-fe13 : libata
fe20-fe27 : 0000:00:1f.2
  fe20-fe27 : libata
fe30-fe33 : 0000:00:1f.2
  fe30-fe33 : libata
fea0-feaf : 0000:00:1f.2
  fea0-feaf : libata
ff20-ff3f : 0000:00:1d.3
  ff20-ff3f : uhci_hcd
ff40-ff5f : 0000:00:1d.2
  ff40-ff5f : uhci_hcd
ff60-ff7f : 0000:00:1d.1
  ff60-ff7f : uhci_hcd
ff80-ff9f : 0000:00:1d.0
  ff80-ff9f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

---------------------------------------------
sfrost@kenobi:/home/sfrost/linux/linux-2.6.8.1> cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9800-000cbfff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ff73fff : System RAM
  00100000-00317026 : Kernel code
  00317027-00442eff : Kernel data
3ff74000-3ff75fff : ACPI Non-volatile Storage
3ff76000-3ff96fff : ACPI Tables
3ff97000-3fffffff : reserved
f0000000-f7ffffff : 0000:00:00.0
fd000000-fdffffff : 0000:02:00.0
fe9df000-fe9dffff : 0000:02:00.0
fe9e0000-fe9fffff : 0000:02:0c.0
  fe9e0000-fe9fffff : e1000
febff900-febff9ff : 0000:00:1f.5
  febff900-febff9ff : Intel ICH5 - Controller
febffa00-febffbff : 0000:00:1f.5
  febffa00-febffbff : Intel ICH5 - AC'97
febffc00-febfffff : 0000:00:1f.1
fec00000-fec0ffff : reserved
fecf0000-fecf0fff : reserved
fed20000-fed8ffff : reserved
fee00000-fee0ffff : reserved
ffa80800-ffa80bff : 0000:00:1d.7
  ffa80800-ffa80bff : ehci_hcd
ffb00000-ffffffff : reserved

---------------------------------------------
=3D=3D=3D# lspci -vvv=20
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
        Subsystem: Dell: Unknown device 0162
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=3D32 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- GART64-=
 HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
FW- Rate=3D<none>

0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (re=
v 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 161
        Region 4: I/O ports at ff80 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 185
        Region 4: I/O ports at ff60 [size=3D32]
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 177
        Region 4: I/O ports at ff40 [size=3D32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 161
        Region 4: I/O ports at ff20 [size=3D32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI =
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 0162
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 217
        Region 0: Memory at ffa80800 (32-bit, non-prefetchable) [size=3D1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,=
D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 =
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fd000000-feafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (re=
v 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 1=
00 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ffa0 [size=3D16]
        Region 5: Memory at febffc00 (32-bit, non-prefetchable) [size=3D1K]

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Stora=
ge Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at fe00 [size=3D8]
        Region 1: I/O ports at fe10 [size=3D4]
        Region 2: I/O ports at fe20 [size=3D8]
        Region 3: I/O ports at fe30 [size=3D4]
        Region 4: I/O ports at fea0 [size=3D16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (r=
ev 02)
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 169
        Region 4: I/O ports at eda0 [size=3D32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5=
R) AC'97 Audio Controller (rev 02)
        Subsystem: Dell: Unknown device 0162
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 169
        Region 0: I/O ports at ee00 [size=3D256]
        Region 1: I/O ports at edc0 [size=3D64]
        Region 2: Memory at febffa00 (32-bit, non-prefetchable) [size=3D512]
        Region 3: Memory at febff900 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,=
D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:00.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 2=
7) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
        Region 1: I/O ports at de00 [size=3D256]
        Region 2: Memory at fe9df000 (32-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at fea00000 [disabled] [size=3D128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Cont=
roller (rev 02)
        Subsystem: Dell: Unknown device 0156
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=3D128=
K]
        Region 2: I/O ports at ddc0 [size=3D64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=3D0 OST=3D0
                Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, =
DC=3Dsimple, DMMRBC=3D2, DMOST=3D0, DMCRS=3D1, RSCEM-
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
 Enable-
                Address: 0000000000000000  Data: 0000

---------------------------------------------

	Thanks,

		Stephen

--7J6vSZfnb9iabnHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBczeXrzgMPqB3kigRAkQrAJ9ggQqMK3IUI2xfH+8FJFJvEpV+xwCfUoGr
VuDtZ0UGph8xWXcts3HXgzA=
=bdai
-----END PGP SIGNATURE-----

--7J6vSZfnb9iabnHK--
