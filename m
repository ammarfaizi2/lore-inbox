Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVJEK6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVJEK6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVJEK6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:58:12 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:26466 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932593AbVJEK6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:58:11 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Periodical dump when loading/unloading qla-modules.
Date: Wed, 5 Oct 2005 12:58:02 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1541679.PL4syh2cpk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510051258.05996.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1541679.PL4syh2cpk
Content-Type: multipart/mixed;
  boundary="Boundary-01=_6G7QDr7KwL17HlO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_6G7QDr7KwL17HlO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The kernel dumps on me every so often after multiple loads and unloads of t=
he=20
qla2xxx and qla2300 modules. Sometimes it hangs the system completely,=20
sometimes I can recover by normal reboot procedure.

kernel BUG at mm/slab.c:1488!

Details attached.

=2D-=20
Regards,
Tais M. Hansen
OSD

--Boundary-01=_6G7QDr7KwL17HlO
Content-Type: text/plain;
  charset="us-ascii";
  name="kernel-bug-qla.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kernel-bug-qla.txt"

[1.] One line summary of the problem:

Periodical dump when loading/unloading qla-modules.


[2.] Full description of the problem/report:

The kernel dumps every so often after multiple loads and unloads of the qla2xxx and qla2300 modules.


[3.] Keywords (i.e., modules, networking, kernel):

qla fc


[4.] Kernel version (from /proc/version):

Linux version 2.6.13.3 (tmh@osd001a) (gcc version 3.3.4) #1 SMP Wed Oct 5 09:33:06 CEST 2005


[5.] Most recent kernel version which did not have the bug:

N/A


[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

kernel BUG at mm/slab.c:1488!
invalid operand: 0000 [#1]
SMP
Modules linked in: qla2300 qla2xxx sd_mod scsi_transport_fc scsi_mod iptable_filter ipt_LOG ipt_state ipt_conntrack ip_conntrack ip_tables tg3 firmware_class
CPU:    1
EIP:    0060:[<c014a011>]    Not tainted VLI
EFLAGS: 00010202   (2.6.13.3)
EIP is at kmem_cache_create+0x461/0x5e0
eax: 00000035   ebx: f79accf8   ecx: c03b8100   edx: 00000292
esi: f8d6d841   edi: f8d6d841   ebp: f79ac980   esp: d9175da0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1636, threadinfo=d9174000 task=f7d0a020)
Stack: c02d1220 f8d6d832 00000080 00002000 d9175dc8 f79ac9c0 0000000a c0000000
       ffffff80 00000080 00000080 f3ff8000 f8d81d20 f3ff8018 f8d462e0 f8d6236f
       f8d6d832 0000014c 00000000 00002000 00000000 00000000 00001c78 f3ff8000
Call Trace:
 [<f8d6236f>] scsi_setup_command_freelist+0x6f/0x100 [scsi_mod]
 [<f8d63742>] scsi_host_alloc+0x212/0x340 [scsi_mod]
 [<f8d2b57a>] qla2x00_probe_one+0x4a/0x860 [qla2xxx]
 [<c01190a0>] default_wake_function+0x0/0x20
 [<c012d982>] queue_work+0x52/0x70
 [<c012d770>] __call_usermodehelper+0x0/0x70
 [<c012d8ae>] call_usermodehelper_keys+0xce/0xe0
 [<c012d770>] __call_usermodehelper+0x0/0x70
 [<c01f8c8a>] pci_match_device+0x2a/0x100
 [<c01f8dbf>] __pci_device_probe+0x5f/0x70
 [<c01f8dff>] pci_device_probe+0x2f/0x50
 [<c023d0a8>] driver_probe_device+0x38/0xb0
 [<c023d1a0>] __driver_attach+0x0/0x60
 [<c023d1f0>] __driver_attach+0x50/0x60
 [<c023c689>] bus_for_each_dev+0x69/0x80
 [<c023d225>] driver_attach+0x25/0x30
 [<c023d1a0>] __driver_attach+0x0/0x60
 [<c023cbdd>] bus_add_driver+0x8d/0xe0
 [<c01f90cb>] pci_register_driver+0x7b/0xa0
 [<f8cf800f>] qla2300_init+0xf/0x11 [qla2300]
 [<c0139dc2>] sys_init_module+0x162/0x200
 [<c0102fc9>] syscall_call+0x7/0xb
Code: 74 ec e9 8d 01 00 00 8d 76 00 c7 04 24 20 12 2d c0 8b 4c 24 40 89 4c 24 04 e8 1c 38 fd ff f0 ff 05 ec 22 3c c0 0f 8e 47 19 00 00 <0f> 0b d0 05 14 08 2d c0 e9 6c ff ff ff 89 f6 8b 41 38 c7 04 24


[7.] A small shell script or example program which triggers the
     problem (if possible)

N/A

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

Linux osd001a 2.6.13.3 #1 SMP Wed Oct 5 09:33:06 CEST 2005 i686 unknown unknown GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   064
Modules Loaded         iptable_filter ipt_LOG ipt_state ipt_conntrack ip_conntrack ip_tables tg3 qla2300 qla2xxx firmware_class sd_mod scsi_transport_fc scsi_mod


[8.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.396
cache size      : 512 KB
physical id     : 3
siblings        : 2
core id         : 3
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4804.65

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2399.396
cache size      : 512 KB
physical id     : 3
siblings        : 2
core id         : 3
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4799.10


[8.3.] Module information (from /proc/modules):

iptable_filter 3328 1 - Live 0xf8d15000
ipt_LOG 7680 6 - Live 0xf8cfa000
ipt_state 2176 2 - Live 0xf8d01000
ipt_conntrack 2816 0 - Live 0xf8806000
ip_conntrack 45480 2 ipt_state,ipt_conntrack, Live 0xf8d55000
ip_tables 22272 4 iptable_filter,ipt_LOG,ipt_state,ipt_conntrack, Live 0xf8d1a000
tg3 104580 0 - Live 0xf8da7000
qla2300 124672 0 - Live 0xf8d87000
qla2xxx 117724 1 qla2300, Live 0xf8d69000
firmware_class 10496 1 qla2xxx, Live 0xf8cfd000
sd_mod 19200 0 - Live 0xf8d0c000
scsi_transport_fc 29952 1 qla2xxx, Live 0xf8d03000
scsi_mod 138984 3 qla2xxx,sd_mod,scsi_transport_fc, Live 0xf8d23000


[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0220-0223 : PM1b_EVT_BLK
0230-0233 : PM1a_CNT_BLK
03c0-03df : vga+
0408-040f : pnp 00:00
0900-0903 : PM1a_EVT_BLK
0910-0913 : PM1b_CNT_BLK
0920-0923 : PM_TMR
0930-0937 : pnp 00:00
0940-0947 : pnp 00:00
0cf8-0cff : PCI conf1
0f50-0f58 : pnp 00:00
1800-18ff : 0000:00:05.0
2000-200f : 0000:00:0f.1
2400-24ff : 0000:00:03.0
2800-28ff : 0000:00:04.0
  2800-28ff : cciss
2c00-2cff : 0000:00:05.2
3000-30ff : 0000:01:01.0
  3000-30ff : qla2300

$ cat /proc/iomem
00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3fff9fff : System RAM
  00100000-002bdda2 : Kernel code
  002bdda3-0037d9c7 : Kernel data
3fffa000-3fffffff : ACPI Tables
40000000-4001ffff : 0000:00:03.0
40020000-4002ffff : 0000:00:05.2
40030000-40033fff : 0000:00:04.0
40040000-4005ffff : 0000:01:01.0
40060000-4006ffff : 0000:01:02.0
40070000-4007ffff : 0000:04:02.0
f5df0000-f5df3fff : 0000:00:04.0
f5e70000-f5e70fff : 0000:00:0f.2
f5e80000-f5efffff : 0000:00:05.2
f5f50000-f5f51fff : 0000:00:05.2
f5f60000-f5f607ff : 0000:00:05.2
f5f70000-f5f701ff : 0000:00:05.0
f5f80000-f5fbffff : 0000:00:04.0
f5ff0000-f5ff0fff : 0000:00:03.0
f6000000-f6ffffff : 0000:00:03.0
f7ee0000-f7eeffff : 0000:01:02.0
  f7ee0000-f7eeffff : tg3
f7ef0000-f7ef0fff : 0000:01:01.0
  f7ef0000-f7ef0fff : qla2300
f7ff0000-f7ffffff : 0000:04:02.0
  f7ff0000-f7ffffff : tg3
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffc00000-ffffffff : reserved


[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Broadcom CMIC-LE Host Bridge (GC-LE chipset) (rev 31)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: Broadcom CMIC-LE Host Bridge (GC-LE chipset)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: Broadcom CMIC-LE Host Bridge (GC-LE chipset)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 001e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 10
        Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 2400 [size=256]
        Region 2: Memory at f5ff0000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 40000000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 RAID bus controller: Compaq Computer Corporation Smart Array 5i/532 (rev 01)
        Subsystem: Compaq Computer Corporation Smart Array 5i
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 71, cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f5f80000 (64-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports at 2800 [size=256]
        Region 3: Memory at f5df0000 (64-bit, prefetchable) [size=16K]
        Expansion ROM at 40030000 [disabled] [size=16K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [cc] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [dc] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=3
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
00:05.0 System peripheral: Compaq Computer Corporation Integrated Lights Out Controller (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device b206
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1800 [size=256]
        Region 1: Memory at f5f70000 (32-bit, non-prefetchable) [size=512]
        Capabilities: [f0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.2 System peripheral: Compaq Computer Corporation Integrated Lights Out  Processor (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device b206
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin B routed to IRQ 7
        Region 0: I/O ports at 2c00 [size=256]
        Region 1: Memory at f5f60000 (32-bit, non-prefetchable) [size=2K]
        Region 2: Memory at f5f50000 (32-bit, non-prefetchable) [size=8K]
        Region 3: Memory at f5e80000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at 40020000 [disabled] [size=64K]
        Capabilities: [f0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Broadcom CSB5 South Bridge (rev 93)
        Subsystem: Broadcom CSB5 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:0f.1 IDE interface: Broadcom CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP])
        Subsystem: Broadcom CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 2000 [size=16]

00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
        Subsystem: Broadcom OSB4/CSB5 OHCI USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f5e70000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: Broadcom CSB5 LPC bridge
        Subsystem: Broadcom: Unknown device 0230
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:11.0 Host bridge: Broadcom CIOB-X2 PCI-X I/O Bridge (rev 05)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:11.2 Host bridge: Broadcom CIOB-X2 PCI-X I/O Bridge (rev 05)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
01:01.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 0100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (16000ns min), cache line size 20
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 3000 [size=256]
        Region 1: Memory at f7ef0000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 40040000 [disabled] [size=128K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [4c] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=2
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [64] #06 [0080]

01:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
        Subsystem: Compaq Computer Corporation NC7781 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f7ee0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at 40060000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 00c0000000080118  Data: 0510

04:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
        Subsystem: Compaq Computer Corporation NC7781 Gigabit Server Adapter (PCI-X, 10,100,1000-T)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f7ff0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at 40070000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 12308a1500003300  Data: 596c



[8.6.] SCSI information (from /proc/scsi/scsi)

$ cat /proc/scsi/scsi
Attached devices:

--Boundary-01=_6G7QDr7KwL17HlO--

--nextPart1541679.PL4syh2cpk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBDQ7G9Lf7B7mQNLngRAl9AAKDBQ6d+48xWvfbCCd8O/ROyr7o/7ACcC47S
me4SjfyNNlnEqtwMvxZ8DVU=
=gR59
-----END PGP SIGNATURE-----

--nextPart1541679.PL4syh2cpk--
