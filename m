Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWIGTZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWIGTZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWIGTZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:25:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:27813 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750712AbWIGSub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:50:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=D5ezEFJDV61AXRnm6FJIKYNbOZ9a5cIPSqP2OrWWRK2DZrrWxqUhP9SUU81d4giU0oFmHyEUGKbtancQvEA47Ech/XmqxEankOhLk0elZ0R2o1fqe1Pp47Ea57lNnvZuuANxVZFDI8pUuJWwDuRP6ZIcoz4wFbOiXCAuarcHoaM=
Message-ID: <450069ED.8060201@gmail.com>
Date: Thu, 07 Sep 2006 20:50:21 +0200
From: Tim Okrongli <j6cubic@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Panics on AMD X2/NVidiaMCP55Ultra
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
I receive kernel panics while fscking my SATA HDD

[2.] Full description of the problem/report:
I'm in the process of upgrading to an AMD X2 (AM2) on an Abit KN9 Ultra 
mainboard (NVidia MCP55Ultra chipset). One of the partitions on my SATA 
hard drive appears to be damaged, so I run fsck on it. During the fsck 
the kernel panics.
The same thing happened with an Asus M2NPV-VM (MCP430) earlier.

[3.] Keywords (i.e., modules, networking, kernel):
I have no idea.

[4.] Kernel version (from /proc/version):
Linux version 2.6.15-gentoo-r5 (root@poseidon) (gcc version 3.4.4 
(Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 SMP Tue Feb 21 17:18:47 
UTC 2006
This also happens with a self-built 2.6.17 kernel, however I can't 
access it right now.

[5.] Most recent kernel version which did not have the bug:
unknown

[6.] Output of my system going down in flames (note: this was copied by 
hand, but there shuldn't be any typos)
invalid operand: 0000 [1] SMP
CPU 1
Modules linked in: forcedeth yealink floppy pcspkr eth1394 dm_mirror 
dm_mod pdc_adma sata_mv ata_piix ahci sata_qstor sata_vsc sata_uli 
sata_sis sata_sx4 sata_nv sata_svw sata_sil24 sata_sil sata_promise 
libata sbp2 ohci1394 ieee1394 sl811 ohci_hcd uhci_hcd usb_storage usbhid 
ehci_hcd usbcore
Pid: 0, comm: swapper Not tainted 2.6.15-gentoo-r5 #1
RIP: 0010:[<fffffffff80128f64>] [<ffffffff80128f64>]
RSP: 0018:ffff8100028bbdd0  EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff81004f0c29c0 RCX: ffff81003fd40870
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff81003fd40870
RBP: ffff81004f0c29c0 R08: ffff81005f100c18 R09: ffff81000251a8c0
R10: 0000000000000002 R11: ffffffff80169a39 R12: ffff81005b027cd0
R13: 0000000000000000 R14: 000000000000da00 R15: 0000000000002600
FS:  00002aaaaaf44dc0(0000) GS:ffffffff80478880(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 CR0: 000000008005003b
CR2: 000000000054c048 CR3: 0000000059cde000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffff8100028b4000, task ffff8100028aa080)
Stack: ffffffff80169a68 0000000000000200 ffffffff8026b40e ffff81005efc8d48
       0000000000000282 0000000000000001 ffffffff80269cdb 0000000000000000
       ffff81005b027cd0 ffff81005ef46240
Call Trace: <IRQ> [<ffffffff80169a68>] [<ffffffff8026b40e>] 
[<ffffffff80269cdb>]
       [<ffffffff8030d581>] [<ffffffff8030d87b>] [<ffffffff803129e9>]
       [<ffffffff8030d2a0>] [<ffffffff80309901>] [<ffffffff80131a04>]
       [<ffffffff8010eb4b>] [<ffffffff8011036a>] [<ffffffff80110334>]
       [<ffffffff8010ddf4>]  <EOI> [<ffffffff8010bc36>] [<ffffffff8010be37>]
       [<ffffffff8048fda1>]

Code: 07 3b 45 cc 7e 0c eb 05 3b 47 2c 7d 05 e8 f1 d8 ff ff 48 8b
RIP [<ffffffff80128f64>] RSP <ffff8100028bbdd0>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

[7.] A small shell script or example program which triggers the
     problem (if possible)
fsck -y /dev/sda2. Probably won't work for you, though.

[8.] Environment
Note that the following data was taken from a freshly booted system with 
the partitions in question being mounted, but not accessed beyond that. 
Also, an USB stick was present.

[8.1.] Software (add the output of the ver_linux script here)
The only runnable Linux in reach is the Gentoo 2006.0 Minimal Live CD, 
which apparently doesn't come with ver_linux.

[8.2.] Processor information (from /proc/cpuinfo):
processor    : 0
vendor_id    : AuthenticAMD
cpu family    : 15
model        : 75
model name    : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping    : 2
cpu MHz        : 2009.285
cache size    : 512 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 1
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy
bogomips    : 4022.12
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor    : 1
vendor_id    : AuthenticAMD
cpu family    : 15
model        : 75
model name    : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping    : 2
cpu MHz        : 2009.285
cache size    : 512 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 1
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy
bogomips    : 4017.89
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

[8.3.] Module information (from /proc/modules):
yealink 10368 0 - Live 0xffffffff880d8000
floppy 57512 0 - Live 0xffffffff880c8000
pcspkr 2184 0 - Live 0xffffffff880c6000
forcedeth 19588 0 - Live 0xffffffff880c0000
eth1394 16784 0 - Live 0xffffffff880ba000
dm_mirror 15744 0 - Live 0xffffffff880b5000
dm_mod 38864 1 dm_mirror, Live 0xffffffff880aa000
pdc_adma 7940 0 - Live 0xffffffff880a7000
sata_mv 15108 0 - Live 0xffffffff880a2000
ata_piix 8580 0 - Live 0xffffffff8809e000
ahci 10884 0 - Live 0xffffffff8809a000
sata_qstor 8196 0 - Live 0xffffffff88096000
sata_vsc 6916 0 - Live 0xffffffff88093000
sata_uli 6276 0 - Live 0xffffffff88090000
sata_sis 6788 0 - Live 0xffffffff8808d000
sata_sx4 11652 0 - Live 0xffffffff88089000
sata_nv 7684 2 - Live 0xffffffff88086000
sata_via 7428 0 - Live 0xffffffff88083000
sata_svw 6660 0 - Live 0xffffffff88080000
sata_sil24 9476 0 - Live 0xffffffff8807c000
sata_sil 8196 0 - Live 0xffffffff88078000
sata_promise 9732 0 - Live 0xffffffff88074000
libata 39696 15 
pdc_adma,sata_mv,ata_piix,ahci,sata_qstor,sata_vsc,sata_uli,sata_sis,sata_sx4,sata_nv,sata_via,sata_svw,sata_sil24,sata_sil,sata_promise, 
Live 0xffffffff88069000
sbp2 20100 0 - Live 0xffffffff88063000
ohci1394 27596 0 - Live 0xffffffff8805b000
ieee1394 64120 3 eth1394,sbp2,ohci1394, Live 0xffffffff8804a000
sl811_hcd 11008 0 - Live 0xffffffff88046000
ohci_hcd 16772 0 - Live 0xffffffff88040000
uhci_hcd 27168 0 - Live 0xffffffff88038000
usb_storage 56512 1 - Live 0xffffffff88029000
usbhid 30624 0 - Live 0xffffffff88020000
ehci_hcd 25608 0 - Live 0xffffffff88018000
usbcore 92328 8 
yealink,sl811_hcd,ohci_hcd,uhci_hcd,usb_storage,usbhid,ehci_hcd, Live 
0xffffffff88000000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
01f0-01f7 : ide0
03c0-03df : vesafb
03f6-03f6 : ide0
0960-0967 : 0000:00:05.1
  0960-0967 : sata_nv
0970-0977 : 0000:00:05.0
  0970-0977 : sata_nv
09e0-09e7 : 0000:00:05.1
  09e0-09e7 : sata_nv
09f0-09f7 : 0000:00:05.0
  09f0-09f7 : sata_nv
0b60-0b63 : 0000:00:05.1
  0b60-0b63 : sata_nv
0b70-0b73 : 0000:00:05.0
  0b70-0b73 : sata_nv
0be0-0be3 : 0000:00:05.1
  0be0-0be3 : sata_nv
0bf0-0bf3 : 0000:00:05.0
  0bf0-0bf3 : sata_nv
0cf8-0cff : PCI conf1
1000-107f : motherboard
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  101c-101c : PM2_CNT_BLK
  1020-1027 : GPE0_BLK
1080-10ff : motherboard
  1080-10ff : pnp 00:00
1400-147f : motherboard
  1400-147f : pnp 00:00
1480-14ff : motherboard
  14a0-14af : GPE1_BLK
1800-187f : motherboard
  1800-187f : pnp 00:00
1880-18ff : motherboard
  1880-18ff : pnp 00:00
1c00-1c3f : 0000:00:01.1
1c40-1c7f : 0000:00:01.1
5000-5fff : PCI Bus #06
  5c00-5cff : 0000:06:00.0
6000-6fff : PCI Bus #05
7000-7fff : PCI Bus #04
8000-8fff : PCI Bus #03
9000-9fff : PCI Bus #02
a000-afff : PCI Bus #01
b000-b007 : 0000:00:09.0
  b000-b007 : forcedeth
b400-b407 : 0000:00:08.0
  b400-b407 : forcedeth
b800-b80f : 0000:00:05.2
  b800-b80f : sata_nv
bc00-bc03 : 0000:00:05.2
  bc00-bc03 : sata_nv
c000-c007 : 0000:00:05.2
  c000-c007 : sata_nv
c400-c403 : 0000:00:05.2
  c400-c403 : sata_nv
c800-c807 : 0000:00:05.2
  c800-c807 : sata_nv
cc00-cc0f : 0000:00:05.1
  cc00-cc0f : sata_nv
e000-e00f : 0000:00:05.0
  e000-e00f : sata_nv
f400-f40f : 0000:00:04.0
  f400-f407 : ide0

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000f0000-000fffff : System ROM
00100000-5ffeffff : System RAM
  00100000-003772b2 : Kernel code
  003772b3-0042c4af : Kernel data
5fff0000-5fff2fff : ACPI Non-volatile Storage
5fff3000-5fffffff : ACPI Tables
e0000000-efffffff : PCI Bus #06
  e0000000-efffffff : 0000:06:00.0
    e0000000-e0ffffff : vesafb
f0000000-f3ffffff : reserved
fd400000-fd4fffff : PCI Bus #06
  fd400000-fd41ffff : 0000:06:00.0
  fd4e0000-fd4effff : 0000:06:00.1
  fd4f0000-fd4fffff : 0000:06:00.0
fd500000-fd5fffff : PCI Bus #05
fd600000-fd6fffff : PCI Bus #05
fd700000-fd7fffff : PCI Bus #04
fd800000-fd8fffff : PCI Bus #04
fd900000-fd9fffff : PCI Bus #03
fda00000-fdafffff : PCI Bus #03
fdb00000-fdbfffff : PCI Bus #02
fdc00000-fdcfffff : PCI Bus #02
fdd00000-fddfffff : PCI Bus #01
  fddf8000-fddfbfff : 0000:01:08.0
  fddff000-fddff7ff : 0000:01:08.0
    fddff000-fddff7ff : ohci1394
fde00000-fdefffff : PCI Bus #01
fe020000-fe023fff : 0000:00:06.1
fe025000-fe02500f : 0000:00:09.0
  fe025000-fe02500f : forcedeth
fe026000-fe0260ff : 0000:00:09.0
  fe026000-fe0260ff : forcedeth
fe027000-fe027fff : 0000:00:09.0
  fe027000-fe027fff : forcedeth
fe028000-fe02800f : 0000:00:08.0
  fe028000-fe02800f : forcedeth
fe029000-fe0290ff : 0000:00:08.0
  fe029000-fe0290ff : forcedeth
fe02a000-fe02afff : 0000:00:08.0
  fe02a000-fe02afff : forcedeth
fe02b000-fe02bfff : 0000:00:05.2
  fe02b000-fe02bfff : sata_nv
fe02c000-fe02cfff : 0000:00:05.1
  fe02c000-fe02cfff : sata_nv
fe02d000-fe02dfff : 0000:00:05.0
  fe02d000-fe02dfff : sata_nv
fe02e000-fe02e0ff : 0000:00:02.1
  fe02e000-fe02e0ff : ehci_hcd
fe02f000-fe02ffff : 0000:00:02.0
  fe02f000-fe02ffff : ohci_hcd
fec00000-ffffffff : reserved

[8.5.] PCI information ('lspci -vvv' as root)
00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a1)
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [44] HyperTransport: Slave or Primary Interface
        Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
        Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- 
<CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b-
        Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit 
DwFcInEn- LWO=16bit DwFcOutEn-
        Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
        Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit 
DwFcInEn- LWO=8bit DwFcOutEn-
        Revision ID: 1.03
        Link Frequency 0: 1.0GHz
        Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
        Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
        Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
        Link Frequency 1: 200MHz
        Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
        Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 
600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
        Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- 
CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
        Prefetchable memory behind bridge Upper: 00-00
        Bus Number: 00
    Capabilities: [e0] #00 [fee0]

00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a2)
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0

00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a2)
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin A routed to IRQ 5
    Region 4: I/O ports at 1c00 [size=64]
    Region 5: I/O ports at 1c40 [size=64]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.2 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:02.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1) 
(prog-if 10 [OHCI])
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2) 
(prog-if 20 [EHCI])
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin B routed to IRQ 16
    Region 0: Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [44] Debug port
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1) (prog-if 8a 
[Master SecP PriP])
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Region 4: I/O ports at f400 [size=16]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin A routed to IRQ 19
    Region 0: I/O ports at 09f0 [size=8]
    Region 1: I/O ports at 0bf0 [size=4]
    Region 2: I/O ports at 0970 [size=8]
    Region 3: I/O ports at 0b70 [size=4]
    Region 4: I/O ports at e000 [size=16]
    Region 5: Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [cc] HyperTransport: MSI Mapping

00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin B routed to IRQ 20
    Region 0: I/O ports at 09e0 [size=8]
    Region 1: I/O ports at 0be0 [size=4]
    Region 2: I/O ports at 0960 [size=8]
    Region 3: I/O ports at 0b60 [size=4]
    Region 4: I/O ports at cc00 [size=16]
    Region 5: Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [cc] HyperTransport: MSI Mapping

00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin C routed to IRQ 16
    Region 0: I/O ports at c800 [size=8]
    Region 1: I/O ports at c400 [size=4]
    Region 2: I/O ports at c000 [size=8]
    Region 3: I/O ports at bc00 [size=4]
    Region 4: I/O ports at b800 [size=16]
    Region 5: Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [cc] HyperTransport: MSI Mapping

00:06.0 PCI bridge: nVidia Corporation Unknown device 0370 (rev a2) 
(prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
    I/O behind bridge: 0000a000-0000afff
    Memory behind bridge: fdd00000-fddfffff
    Prefetchable memory behind bridge: fde00000-fdefffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [b8] #0d [0000]
    Capabilities: [8c] HyperTransport: MSI Mapping

00:06.1 Audio device: nVidia Corporation MCP55 High Definition Audio 
(rev a2)
    Subsystem: ABIT Computer Corp. Unknown device 1c20
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (500ns min, 1250ns max)
    Interrupt: pin B routed to IRQ 10
    Region 0: Memory at fe020000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [6c] HyperTransport: MSI Mapping

00:08.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (250ns min, 5000ns max)
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at fe02a000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at b400 [size=8]
    Region 2: Memory at fe029000 (32-bit, non-prefetchable) [size=256]
    Region 3: Memory at fe028000 (32-bit, non-prefetchable) [size=16]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
    Capabilities: [70] MSI-X: Enable- Mask- TabSize=8
        Vector table: BAR=2 offset=00000000
        PBA: BAR=3 offset=00000000
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/3 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [6c] HyperTransport: MSI Mapping

00:09.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
    Subsystem: ABIT Computer Corp. Unknown device 1c24
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (250ns min, 5000ns max)
    Interrupt: pin A routed to IRQ 19
    Region 0: Memory at fe027000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at b000 [size=8]
    Region 2: Memory at fe026000 (32-bit, non-prefetchable) [size=256]
    Region 3: Memory at fe025000 (32-bit, non-prefetchable) [size=16]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
    Capabilities: [70] MSI-X: Enable- Mask- TabSize=8
        Vector table: BAR=2 offset=00000000
        PBA: BAR=3 offset=00000000
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/3 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [6c] HyperTransport: MSI Mapping

00:0b.0 PCI bridge: nVidia Corporation Unknown device 0374 (rev a2) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size 10
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 00009000-00009fff
    Memory behind bridge: fdc00000-fdcfffff
    Prefetchable memory behind bridge: 00000000fdb00000-00000000fdb00000
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] #0d [0000]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [60] HyperTransport: MSI Mapping
    Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <512ns, L1 <4us
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
        Link: Latency L0s <512ns, L1 <4us
        Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
        Slot: Number 0, PowerLimit 0.000000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
        Slot: AttnInd Off, PwrInd On, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [100] Virtual Channel

00:0c.0 PCI bridge: nVidia Corporation Unknown device 0374 (rev a2) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size 10
    Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
    I/O behind bridge: 00008000-00008fff
    Memory behind bridge: fda00000-fdafffff
    Prefetchable memory behind bridge: 00000000fd900000-00000000fd900000
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] #0d [0000]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [60] HyperTransport: MSI Mapping
    Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <512ns, L1 <4us
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
        Link: Latency L0s <512ns, L1 <4us
        Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
        Slot: Number 0, PowerLimit 0.000000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
        Slot: AttnInd Off, PwrInd On, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [100] Virtual Channel

00:0d.0 PCI bridge: nVidia Corporation Unknown device 0378 (rev a2) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size 10
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 00007000-00007fff
    Memory behind bridge: fd800000-fd8fffff
    Prefetchable memory behind bridge: 00000000fd700000-00000000fd700000
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] #0d [0000]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [60] HyperTransport: MSI Mapping
    Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <512ns, L1 <4us
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
        Link: Latency L0s <512ns, L1 <4us
        Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
        Slot: Number 0, PowerLimit 0.000000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
        Slot: AttnInd Off, PwrInd On, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [100] Virtual Channel

00:0e.0 PCI bridge: nVidia Corporation Unknown device 0375 (rev a2) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size 10
    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
    I/O behind bridge: 00006000-00006fff
    Memory behind bridge: fd600000-fd6fffff
    Prefetchable memory behind bridge: 00000000fd500000-00000000fd500000
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [40] #0d [0000]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [60] HyperTransport: MSI Mapping
    Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <512ns, L1 <4us
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 256 bytes, MaxReadReq 512 bytes
        Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
        Link: Latency L0s <512ns, L1 <4us
        Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
        Link: Speed 2.5Gb/s, Width x1
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
        Slot: Number 0, PowerLimit 0.000000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
        Slot: AttnInd Off, PwrInd On, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [100] Virtual Channel

00:0f.0 PCI bridge: nVidia Corporation Unknown device 0377 (rev a2) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size 10
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
    I/O behind bridge: 00005000-00005fff
    Memory behind bridge: fd400000-fd4fffff
    Prefetchable memory behind bridge: 00000000e0000000-00000000eff00000
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
    Capabilities: [40] #0d [0000]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [60] HyperTransport: MSI Mapping
    Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Device: Supported: MaxPayload 256 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <512ns, L1 <4us
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
        Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
        Link: Latency L0s <512ns, L1 <4us
        Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
        Link: Speed 2.5Gb/s, Width x16
        Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
        Slot: Number 0, PowerLimit 0.000000
        Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
        Slot: AttnInd Off, PwrInd On, Power-
        Root: Correctable- Non-Fatal- Fatal- PME-
    Capabilities: [100] Virtual Channel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Capabilities: [80] HyperTransport: Host or Secondary Interface
        !!! Possibly incomplete decoding
        Command: WarmRst+ DblEnd-
        Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
        Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
        Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Capabilities: [f0] #0f [0010]

01:08.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
    Subsystem: ABIT Computer Corp. Unknown device 1c20
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (500ns min, 1000ns max), Cache Line Size 10
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at fddff000 (32-bit, non-prefetchable) [size=2K]
    Region 1: Memory at fddf8000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME+

06:00.0 VGA compatible controller: ATI Technologies Inc RV530 [Radeon 
X1600] (prog-if 00 [VGA])
    Subsystem: ASUSTeK Computer Inc. Unknown device 0170
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0, Cache Line Size 10
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
    Region 2: Memory at fd4f0000 (64-bit, non-prefetchable) [size=64K]
    Region 4: I/O ports at 5c00 [size=256]
    [virtual] Expansion ROM at fd400000 [disabled] [size=128K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Express Endpoint IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
        Device: Latency L0s <4us, L1 unlimited
        Device: AtnBtn- AtnInd- PwrInd-
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
        Link: Latency L0s <64ns, L1 <1us
        Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
        Link: Speed 2.5Gb/s, Width x16
    Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Address: 0000000000000000  Data: 0000

06:00.1 Display controller: ATI Technologies Inc RV530 [Radeon X1600] 
(Secondary)
    Subsystem: ASUSTeK Computer Inc. Unknown device 0171
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Region 0: Memory at fd4e0000 (64-bit, non-prefetchable) [disabled] 
[size=64K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Express Endpoint IRQ 0
        Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
        Device: Latency L0s <4us, L1 unlimited
        Device: AtnBtn- AtnInd- PwrInd-
        Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
        Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
        Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
        Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
        Link: Latency L0s <64ns, L1 <1us
        Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
        Link: Speed 2.5Gb/s, Width x16

[8.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3300622AS      Rev: 3.AA
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: Netac    Model: OnlyDisk         Rev: 1.12
  Type:   Direct-Access                    ANSI SCSI revision: 02


[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
None I can think of right now.

[X.] Other notes, patches, fixes, workarounds:
I suspect that there might be a hardware problem, maybe with the 
processor. I sent this in case it is a bug after all.
