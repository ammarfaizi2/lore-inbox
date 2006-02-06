Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWBFTQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWBFTQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWBFTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:16:11 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:52958 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S932283AbWBFTQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:16:09 -0500
Message-ID: <43E798C5.2030803@hotpop.com>
Date: Mon, 06 Feb 2006 12:43:17 -0600
From: William Heimbigner <icxcnika@hotpop.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051213)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops: 0002 [#1] ("Unable to handle kernel NULL pointer dereference
 at virtual address 00000040")
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] Oops: 0002 [#1] ("Unable to handle kernel NULL pointer dereference 
at virtual address 00000040")

[2] The Oops is occuring during the init stage of things. It 
consistently happens after I get the message that it is starting cupsd 
(cups version 1.1.23-r7). I cannot say whether the problem is because of 
cups, because cups *appears* to load ok, and because running 
"/etc/init.d/cupsd restart" does *not* cause an oops.

[3] init, cupsd, modules

[4] Linux version 2.6.15-gentoo-r1_icxcnika (root@ICBuddyLinx) (gcc 
version 3.3.5-20050130 (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, 
pie-8.7.7.1)) #1 PREEMPT Sun Feb 5 17:59:16 CST 2006

[5] Unknown

[6] oops message

[   57.739172] Unable to handle kernel NULL pointer dereference at virtual address 00000040
[   57.739179]  printing eip:
[   57.739182] c0328c6d
[   57.739183] *pde = 00000000
[   57.739186] Oops: 0002 [#1]
[   57.742859] PREEMPT 
[   57.746490] Modules linked in: ohci_hcd 8139cp intelfb
[   57.750079] CPU:    0
[   57.750080] EIP:    0060:[<c0328c6d>]    Not tainted VLI
[   57.750082] EFLAGS: 00010292   (2.6.15-gentoo-r1_icxcnika) 
[   57.760267] EIP is at parport_claim_or_block+0xb/0x65
[   57.763733] eax: 00000000   ebx: 00000000   ecx: 00000000   edx: fffffff0
[   57.767305] esi: df70777c   edi: c15de280   ebp: c03129df   esp: de111ea8
[   57.770985] ds: 007b   es: 007b   ss: 0068
[   57.774660] Process parallel (pid: 9137, threadinfo=de110000 task=df667030)
[   57.774896] Stack: de111ed8 00000000 c0312a31 00000000 de110000 c15de280 dfc5c500 00000000 
[   57.778866]        c016c50e df70777c c15de280 de111ed8 00000000 c15de280 df70777c c016c42a 
[   57.782976]        00000001 c016224f df70777c c15de280 c15de280 de111f38 00000000 de110000 
[   57.787156] Call Trace:
[   57.795368]  [<c0312a31>] tipar_open+0x52/0x9a
[   57.799666]  [<c016c50e>] chrdev_open+0xe4/0x1c5
[   57.804032]  [<c016c42a>] chrdev_open+0x0/0x1c5
[   57.808368]  [<c016224f>] __dentry_open+0xdc/0x21d
[   57.812737]  [<c01624a8>] nameidata_to_filp+0x3a/0x50
[   57.817149]  [<c01623e4>] filp_open+0x54/0x56
[   57.821546]  [<c01626e0>] do_sys_open+0x4f/0xda
[   57.825951]  [<c0162872>] sys_close+0x66/0x94
[   57.830362]  [<c0102fb1>] syscall_call+0x7/0xb
[   57.834783] Code: eb ba 8b 07 89 44 24 08 8b 42 0c c7 04 24 5f 26 56 c0 89 44 24 04 e8 ca 8a df ff e9 34 ff ff ff 83 ec 08 89 5c 24 04 8b 5c 24 0c <c7> 43 40 02 00 00 00 89 1c 24 e8 0c fe ff ff 83 f8 f5 74 13 c7 


[7] Not possible; occurs during boot.
[8]
    [8.1] scripts/ver_linux output

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ICBuddyLinx 2.6.15-gentoo-r1_icxcnika #1 PREEMPT Sun Feb 5 17:59:16 CST 2006 i686 Intel(R) Celeron(R) CPU 2.66GHz GenuineIntel GNU/Linux
 
Gnu C                  3.3.5-20050130
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.25
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   079
Modules Loaded         i915 drm ohci_hcd 8139cp intelfb

    [8.2] /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Celeron(R) CPU 2.66GHz
stepping	: 4
cpu MHz		: 2667.118
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid xtpr
bogomips	: 5337.63


    [8.3] /proc/modules

i915 17536 1 - Live 0xe0850000
drm 64916 2 i915, Live 0xe085e000
ohci_hcd 18948 0 - Live 0xe0841000
8139cp 17408 0 - Live 0xe083b000
intelfb 35748 0 - Live 0xe0831000

    [8.4.1] /proc/ioports

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
0295-0296 : w83627hf
0376-0376 : ide1
03c0-03df : vga+
  03c0-03df : vesafb
03f6-03f6 : ide0
0400-047f : 0000:00:1f.0
0480-04bf : 0000:00:1f.0
0500-051f : 0000:00:1f.3
  0500-050f : i801_smbus
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c01f : 0000:01:09.0
    c000-c01f : snd_ca0106
  c400-c4ff : 0000:01:0c.0
    c400-c4ff : 8139too
d000-d01f : 0000:00:1d.1
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:1d.2
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:1d.0
  d800-d81f : uhci_hcd
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1

    [8.4.2] /proc/iomem

00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-004ec367 : Kernel code
  004ec368-00655c3f : Kernel data
1fef0000-1fef2fff : ACPI Non-volatile Storage
1fef3000-1fefffff : ACPI Tables
20000000-200fffff : PCI Bus #01
  20000000-2000ffff : 0000:01:0c.0
20100000-201003ff : 0000:00:1f.1
e0000000-e7ffffff : 0000:00:02.0
  e0000000-e00cffff : vesafb
e8000000-ebffffff : 0000:00:00.0
ec000000-edffffff : PCI Bus #01
  ed000000-ed0000ff : 0000:01:0c.0
    ed000000-ed0000ff : 8139too
ee000000-ee07ffff : 0000:00:02.0
ee080000-ee0803ff : 0000:00:1d.7
  ee080000-ee0803ff : ehci_hcd
fec00000-ffffffff : reserved

    [8.5] lspci -vvv as root output

00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 03)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5770
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5778
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5770
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 4: I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5770
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 145
	Region 4: I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5770
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 137
	Region 4: I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5770
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 161
	Region 0: Memory at ee080000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 82) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: 20000000-200fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5770
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 121
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 20100000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 5770
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 129
	Region 4: I/O ports at 0500 [size=32]

01:09.0 Multimedia audio controller: Creative Labs SB Audigy LS
	Subsystem: Creative Labs SB0410 SBLive! 24-bit
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 153
	Region 0: I/O ports at c000 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 577c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 161
	Region 0: I/O ports at c400 [size=256]
	Region 1: Memory at ed000000 (32-bit, non-prefetchable) [size=256]
	[virtual] Expansion ROM at 20000000 [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


    [8.6] /proc/scsi/scsi reports that there are no attached devices.


If you need anymore information, or for the kernel to be recompiled with 
frame pointers and / or debug info, etc etc etc, I would be happy to 
provide it. Please tell me how it all works out,
William Heimbigner
icxcnika@hotpop.com

