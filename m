Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbTLHQ0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbTLHQ0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:26:18 -0500
Received: from mail.haigekassa.ee ([195.80.104.85]:33540 "EHLO pii.sf.lan")
	by vger.kernel.org with ESMTP id S265455AbTLHQW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:22:27 -0500
Message-ID: <1B6F32B230FFEF4B8EB705647BDB0AE8010EDB5F@mail.haigekassa.ee>
From: Rauno Tuul <rauno.tuul@haigekassa.ee>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Intel PRO/100 S Dual Port Server Adapter - second interface doesn
	't work since 2.4.21
Date: Mon, 8 Dec 2003 18:22:01 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3BDA7.693E1410"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3BDA7.693E1410
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,

I have a server running linux 2.4.20 and it has this wonderful ethernet
card:
http://www.intel.com/network/connectivity/products/pro100dport_adapter.htm
Motherboard is Intel S845WD1-E.

Everything worked well with 2.4.18, 2.4.20. But since 2.4.21 came out, I'm
unable to use newer kernel, because it can't use the second interface of
that card.

On boot with 2.4.21/22/23 I get this error:
"Bringing up interface eth1. failed to bring up eth1.
SIOCCSIFFLAGS: Device or resource busy."

Basically I can't give any address to the interface, or bring it up. It
doesn't matter which module I'm using. I tried almost every e100 driver and
also eepro100.
Problem is somewhere else... inside the kernel.

I attach 3 files:
System output with 2.4.20, then with 2.4.23 and also my kernel config.
The kernel config is exatly the same I used in 2.4.20.

Is there a solution or fix for my problem? I really need these 4 interfaces.

Regards,

 Rauno Tuul


------_=_NextPart_000_01C3BDA7.693E1410
Content-Type: text/plain;
	name="dualport_with_2.4.20.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dualport_with_2.4.20.txt"

#########
Linux delta 2.4.20 #7 Fri May 16 12:33:13 EEST 2003 i686 i686 i386 =
GNU/Linux
Mon Dec  8 17:43:06 EET 2003
=20
### begin ### ifconfig -a
=20
eth0      Link encap:Ethernet  HWaddr 00:02:B3:C7:F4:CD =20
          inet addr:1.1.1.1  Bcast:1.1.1.255  Mask:255.255.255.0
          inet6 addr: fe80::202:b3ff:fec7:f4cd/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:5053 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5068 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:435736 (425.5 Kb)  TX bytes:470545 (459.5 Kb)
          Interrupt:11 Base address:0xcf00 Memory:fc8ff000-fc8ff038=20

eth1      Link encap:Ethernet  HWaddr 00:02:B3:C7:F4:CE =20
          inet addr:2.2.2.2  Bcast:2.2.2.183  Mask:255.255.255.248
          inet6 addr: fe80::202:b3ff:fec7:f4ce/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:339 errors:0 dropped:0 overruns:0 frame:0
          TX packets:345 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:95813 (93.5 Kb)  TX bytes:135059 (131.8 Kb)
          Interrupt:9 Base address:0xce80 Memory:fc8fe000-fc8fe038=20

eth2      Link encap:Ethernet  HWaddr 00:07:E9:D4:F3:BE =20
          inet addr:3.3.3.3  Bcast:3.3.3.191  Mask:255.255.255.248
          inet6 addr: fe80::207:e9ff:fed4:f3be/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:310 errors:0 dropped:0 overruns:0 frame:0
          TX packets:295 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:114530 (111.8 Kb)  TX bytes:96600 (94.3 Kb)
          Interrupt:11 Base address:0xde80 Memory:feafe000-feafe038=20

eth3      Link encap:Ethernet  HWaddr 00:07:E9:D4:F3:C0 =20
          inet addr:4.4.4.4  Bcast:4.4.4.255  Mask:255.255.255.0
          inet6 addr: fe80::207:e9ff:fed4:f3c0/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:0 (0.0 b)  TX bytes:456 (456.0 b)
          Interrupt:3 Base address:0xdd80 Memory:feafd000-feafd038=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

sit0      Link encap:IPv6-in-IPv4 =20
          NOARP  MTU:1480  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

=20
### begin ### lspci
=20
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host =
Bridge (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [e4] #09 [a104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP =
Bridge (rev 11) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc700000-fc7fffff
	Prefetchable memory behind bridge: dc300000-dc3fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) =
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D03, sec-latency=3D32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: fc800000-feafffff
	Prefetchable memory behind bridge: dc400000-dc5fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if =
80 [Master])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=3D16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) =
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 3
	Region 4: I/O ports at ef40 [size=3D32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 12
	Region 4: I/O ports at efa0 [size=3D16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) =
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at ef80 [size=3D32]

02:09.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 =
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc800000-fc8fffff
	Prefetchable memory behind bridge: 00000000dc400000-00000000dc400000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

02:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp.: Unknown device 301a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at de80 [size=3D64]
	Region 2: Memory at fea80000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

02:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp.: Unknown device 301a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at dd80 [size=3D64]
	Region 2: Memory at fea40000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

02:0e.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at dff0 [size=3D8]
	Region 1: I/O ports at dfe4 [size=3D4]
	Region 2: I/O ports at dfa8 [size=3D8]
	Region 3: I/O ports at dfe0 [size=3D4]
	Region 4: I/O ports at df00 [size=3D64]
	Region 5: Memory at feaa0000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:0f.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev =
27) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: I/O ports at d800 [size=3D256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc8ff000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at cf00 [size=3D64]
	Region 2: Memory at fc8c0000 (32-bit, non-prefetchable) [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

03:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fc8fe000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at ce80 [size=3D64]
	Region 2: Memory at fc8a0000 (32-bit, non-prefetchable) [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

=20
### begin ### lsmod
=20
Module                  Size  Used by    Not tainted
ipt_limit               1560   2  (autoclean)
ipt_state               1048   7  (autoclean)
ipt_multiport           1176   7=20
ipt_MASQUERADE          2168   0  (unused)
ip_conntrack_irc        4144   0  (unused)
ip_conntrack_ftp        5328   1  (autoclean)
ip_nat_ftp              4112   0  (unused)
iptable_nat            19928   1  (autoclean) [ipt_MASQUERADE =
ip_nat_ftp]
ip_conntrack           27008   4  (autoclean) [ipt_state ipt_MASQUERADE =
ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp iptable_nat]
autofs                 13364   0  (autoclean) (unused)
e100                   63508   4=20
iptable_filter          2412   1  (autoclean)
ip_tables              15096   8  [ipt_limit ipt_state ipt_multiport =
ipt_MASQUERADE iptable_nat iptable_filter]
=20
### begin ### dmesg
=20
Linux version 2.4.20 (root@delta-dhcp) (gcc version 3.2 20020903 (Red =
Hat Linux 8.0 3.2-7)) #7 Fri May 16 12:33:13 EEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
 BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65472
zone(0): 4096 pages.
zone(1): 61376 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3Dlinux-2.4.20 ro root=3D7203 =
ide0=3D0x1f0,0x3f6 ide1=3D0x170,0x376 ide2=3D0xdff0,0xdfe6 =
ide3=3D0xdfa8,0xdfe2
ide_setup: ide0=3D0x1f0,0x3f6

ide_setup: ide1=3D0x170,0x376

ide_setup: ide2=3D0xdff0,0xdfe6

ide_setup: ide3=3D0xdfa8,0xdfe2

Initializing CPU#0
Detected 1794.233 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 256660k/261888k available (1231k kernel code, 4824k reserved, =
282k data, 252k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=3D3
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
ICH2: IDE controller on PCI bus 00 dev f9
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
PDC20267: IDE controller on PCI bus 02 dev 70
PCI: Found IRQ 9 for device 02:0e.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER =
Mode.
    ide2: BM-DMA at 0xdf00-0xdf07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdg:pio, hdh:pio
hdb: CD-224E, ATAPI CD/DVD-ROM drive
hde: WDC WD400BB-00DEA0, ATA DISK drive
hdg: WDC WD400BB-00DEA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xdff0-0xdff7,0xdfe6 on irq 9
ide3 at 0xdfa8-0xdfaf,0xdfe2 on irq 9
blk: queue c02e1c6c, I/O limit 4095Mb (mask 0xffffffff)
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D77545/16/63, =
UDMA(100)
blk: queue c02e1fb0, I/O limit 4095Mb (mask 0xffffffff)
hdg: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D77545/16/63, =
UDMA(100)
Partition check:
 hde: [PTBL] [4865/255/63] hde1 hde2 hde3
 hdg: [PTBL] [4865/255/63] hdg1 hdg2 hdg3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
 ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3
Drive 0 is 38166 Mb (33 / 0)=20
Drive 1 is 38166 Mb (34 / 0)=20
Raid1 array consists of 2 drives.=20
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 252k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ataraid(114,3), internal journal
Adding Swap: 313256k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ataraid(114,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
Intel(R) PRO/100 Network Driver - version 2.1.24-k1
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 S Dual Port Server Adapter
  Mem:0xfc8ff000  IRQ:11  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: selftest OK.
e100: eth1: Intel(R) PRO/100 S Dual Port Server Adapter
  Mem:0xfc8fe000  IRQ:9  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

PCI: Found IRQ 11 for device 02:0c.0
e100: selftest OK.
e100: eth2: Intel(R) 8255x-based Ethernet Adapter
  Mem:0xfeafe000  IRQ:11  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

PCI: Found IRQ 3 for device 02:0d.0
PCI: Sharing IRQ 3 with 00:1f.2
e100: selftest OK.
e100: eth3: Intel(R) 8255x-based Ethernet Adapter
  Mem:0xfeafd000  IRQ:3  Speed:0 Mbps  Dx:N/A
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: eth0 NIC Link is Up 100 Mbps Full duplex
e100: eth1 NIC Link is Up 100 Mbps Full duplex
e100: eth2 NIC Link is Up 100 Mbps Full duplex
e100: eth3 NIC Link is Up 100 Mbps Full duplex
eth0: no IPv6 routers present
ip_conntrack version 2.1 (2046 buckets, 16368 max) - 292 bytes per =
conntrack
eth1: no IPv6 routers present
eth2: no IPv6 routers present
eth3: no IPv6 routers present
=20
### begin ### cat /proc/interrupts
=20
           CPU0      =20
  0:     104567          XT-PIC  timer
  1:        399          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         13          XT-PIC  eth3
  8:          1          XT-PIC  rtc
  9:       3507          XT-PIC  ide2, ide3, eth1
 11:      10252          XT-PIC  eth0, eth2
 12:          0          XT-PIC  PS/2 Mouse
 14:          1          XT-PIC  ide0
NMI:          0=20
ERR:          0
=20
### begin ### cat /proc/ioports
=20
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #03
  ce80-cebf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    ce80-cebf : e100
  cf00-cf3f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    cf00-cf3f : e100
d800-d8ff : ATI Technologies Inc Rage XL
dd80-ddbf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  dd80-ddbf : e100
de80-debf : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  de80-debf : e100
df00-df3f : Promise Technology, Inc. 20267
  df00-df07 : ide2
  df08-df0f : ide3
  df10-df3f : PDC20267
dfa8-dfaf : Promise Technology, Inc. 20267
  dfa8-dfaf : ide3
dfe0-dfe3 : Promise Technology, Inc. 20267
  dfe2-dfe2 : ide3
dfe4-dfe7 : Promise Technology, Inc. 20267
  dfe6-dfe6 : ide2
dff0-dff7 : Promise Technology, Inc. 20267
  dff0-dff7 : ide2
ef40-ef5f : Intel Corp. 82801BA/BAM USB (Hub #1)
ef80-ef9f : Intel Corp. 82801BA/BAM USB (Hub #2)
efa0-efaf : Intel Corp. 82801BA/BAM SMBus
ffa0-ffaf : Intel Corp. 82801BA IDE U100
  ffa0-ffa7 : ide0
=20
### begin ### cat /proc/iomem
=20
00000000-0009bbff : System RAM
0009bc00-0009bfff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000d17ff : Extension ROM
000d1800-000d27ff : Extension ROM
000d2800-000d37ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffbffff : System RAM
  00100000-00233e80 : Kernel code
  00233e81-0027a7ff : Kernel data
0ffc0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
dc300000-dc3fffff : PCI Bus #01
dc400000-dc4fffff : PCI Bus #03
e0000000-efffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host =
Bridge
fc700000-fc7fffff : PCI Bus #01
fc800000-fc8fffff : PCI Bus #03
  fc8a0000-fc8bffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    fc8a0000-fc8bffff : e100
  fc8c0000-fc8dffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    fc8c0000-fc8dffff : e100
  fc8fe000-fc8fefff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    fc8fe000-fc8fefff : e100
  fc8ff000-fc8fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    fc8ff000-fc8fffff : e100
fd000000-fdffffff : ATI Technologies Inc Rage XL
fea40000-fea5ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  fea40000-fea5ffff : e100
fea80000-fea9ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fea80000-fea9ffff : e100
feaa0000-feabffff : Promise Technology, Inc. 20267
feafd000-feafdfff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  feafd000-feafdfff : e100
feafe000-feafefff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  feafe000-feafefff : e100
feaff000-feafffff : ATI Technologies Inc Rage XL
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved
=20
### begin ### /usr/src/linux/scripts/ver_linux
=20
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux delta 2.4.20 #7 Fri May 16 12:33:13 EEST 2003 i686 i686 i386 =
GNU/Linux
=20
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ipt_limit ipt_state ipt_multiport ipt_MASQUERADE =
ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp iptable_nat ip_conntrack =
autofs e100 iptable_filter ip_tables
=20
### begin ### cat /proc/version
=20
Linux version 2.4.20 (root@delta-dhcp) (gcc version 3.2 20020903 (Red =
Hat Linux 8.0 3.2-7)) #7 Fri May 16 12:33:13 EEST 2003
=20
### begin ### cat /proc/modules
=20
ipt_limit               1560   2 (autoclean)
ipt_state               1048   7 (autoclean)
ipt_multiport           1176   7
ipt_MASQUERADE          2168   0 (unused)
ip_conntrack_irc        4144   0 (unused)
ip_conntrack_ftp        5328   1 (autoclean)
ip_nat_ftp              4112   0 (unused)
iptable_nat            19928   1 (autoclean) [ipt_MASQUERADE =
ip_nat_ftp]
ip_conntrack           27008   4 (autoclean) [ipt_state ipt_MASQUERADE =
ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp iptable_nat]
autofs                 13364   0 (autoclean) (unused)
e100                   63508   4
iptable_filter          2412   1 (autoclean)
ip_tables              15096   8 [ipt_limit ipt_state ipt_multiport =
ipt_MASQUERADE iptable_nat iptable_filter]
=20
### begin ### cat /proc/interrupts
=20
           CPU0      =20
  0:     104580          XT-PIC  timer
  1:        399          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         13          XT-PIC  eth3
  8:          1          XT-PIC  rtc
  9:       3509          XT-PIC  ide2, ide3, eth1
 11:      10253          XT-PIC  eth0, eth2
 12:          0          XT-PIC  PS/2 Mouse
 14:          1          XT-PIC  ide0
NMI:          0=20
ERR:          0
=20

------_=_NextPart_000_01C3BDA7.693E1410
Content-Type: text/plain;
	name="dualport_with_2.4.23.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dualport_with_2.4.23.txt"

#########
Linux delta 2.4.23 #1 Sun Dec 7 16:36:11 EET 2003 i686 i686 i386 =
GNU/Linux
Mon Dec  8 17:50:36 EET 2003
=20
### begin ### ifconfig -a
=20
eth0      Link encap:Ethernet  HWaddr 00:02:B3:C7:F4:CD =20
          inet addr:1.1.1.1  Bcast:1.1.1.255  Mask:255.255.255.0
          inet6 addr: fe80::202:b3ff:fec7:f4cd/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:63 errors:0 dropped:0 overruns:0 frame:0
          TX packets:21 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:6154 (6.0 Kb)  TX bytes:1695 (1.6 Kb)
          Interrupt:11 Base address:0xcf00 Memory:fc8ff000-fc8ff038=20

eth1      Link encap:Ethernet  HWaddr 00:02:B3:C7:F4:CE =20
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:9 Base address:0xce80 Memory:fc8fe000-fc8fe038=20

eth2      Link encap:Ethernet  HWaddr 00:07:E9:D4:F3:BE =20
          inet addr:3.3.3.3  Bcast:3.3.3.191  Mask:255.255.255.248
          inet6 addr: fe80::207:e9ff:fed4:f3be/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 b)  TX bytes:546 (546.0 b)
          Interrupt:11 Base address:0xde80 Memory:feafe000-feafe038=20

eth3      Link encap:Ethernet  HWaddr 00:07:E9:D4:F3:C0 =20
          inet addr:4.4.4.4  Bcast:4.4.4.255  Mask:255.255.255.0
          inet6 addr: fe80::207:e9ff:fed4:f3c0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 b)  TX bytes:546 (546.0 b)
          Interrupt:3 Base address:0xdd80 Memory:feafd000-feafd038=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

sit0      Link encap:IPv6-in-IPv4 =20
          NOARP  MTU:1480  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

=20
### begin ### lspci
=20
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host =
Bridge (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [e4] #09 [a104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP =
Bridge (rev 11) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc700000-fc7fffff
	Prefetchable memory behind bridge: dc300000-dc3fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) =
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D03, sec-latency=3D32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: fc800000-feafffff
	Prefetchable memory behind bridge: dc400000-dc5fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if =
80 [Master])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=3D16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) =
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 3
	Region 4: I/O ports at ef40 [size=3D32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 12
	Region 4: I/O ports at efa0 [size=3D16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) =
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at ef80 [size=3D32]

02:09.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 =
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc800000-fc8fffff
	Prefetchable memory behind bridge: 00000000dc400000-00000000dc400000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

02:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp.: Unknown device 301a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at de80 [size=3D64]
	Region 2: Memory at fea80000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

02:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp.: Unknown device 301a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at dd80 [size=3D64]
	Region 2: Memory at fea40000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

02:0e.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at dff0 [size=3D8]
	Region 1: I/O ports at dfe4 [size=3D4]
	Region 2: I/O ports at dfa8 [size=3D8]
	Region 3: I/O ports at dfe0 [size=3D4]
	Region 4: I/O ports at df00 [size=3D64]
	Region 5: Memory at feaa0000 (32-bit, non-prefetchable) [size=3D128K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

02:0f.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev =
27) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 5744
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: I/O ports at d800 [size=3D256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

03:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc8ff000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at cf00 [size=3D64]
	Region 2: Memory at fc8c0000 (32-bit, non-prefetchable) [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

03:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fc8fe000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: I/O ports at ce80 [size=3D64]
	Region 2: Memory at fc8a0000 (32-bit, non-prefetchable) [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D2 PME-

=20
### begin ### lsmod
=20
Module                  Size  Used by    Not tainted
ipt_limit               1560   2  (autoclean)
ipt_state               1048   7  (autoclean)
ipt_multiport           1176   7=20
ipt_MASQUERADE          2296   0  (unused)
ip_conntrack_irc        4208   0  (unused)
ip_conntrack_ftp        5296   1  (autoclean)
ip_nat_ftp              3728   0  (unused)
iptable_nat            20952   1  (autoclean) [ipt_MASQUERADE =
ip_nat_ftp]
ip_conntrack           29288   4  (autoclean) [ipt_state ipt_MASQUERADE =
ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp iptable_nat]
autofs                 13364   0  (autoclean) (unused)
e100                   55044   3=20
iptable_filter          2412   1  (autoclean)
ip_tables              15776   8  [ipt_limit ipt_state ipt_multiport =
ipt_MASQUERADE iptable_nat iptable_filter]
=20
### begin ### dmesg
=20
Linux version 2.4.23 (root@delta) (gcc version 3.2 20020903 (Red Hat =
Linux 8.0 3.2-7)) #1 Sun Dec 7 16:36:11 EET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
 BIOS-e820: 000000000009bc00 - 000000000009c000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffc0000 (usable)
 BIOS-e820: 000000000ffc0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65472
zone(0): 4096 pages.
zone(1): 61376 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3Dlinux-2.4.23 ro root=3D7203 =
ide0=3D0x1f0,0x3f6 ide1=3D0x170,0x376 ide2=3D0xdff0,0xdfe6 =
ide3=3D0xdfa8,0xdfe2
ide_setup: ide0=3D0x1f0,0x3f6

ide_setup: ide1=3D0x170,0x376

ide_setup: ide2=3D0xdff0,0xdfe6

ide_setup: ide3=3D0xdfa8,0xdfe2

Initializing CPU#0
Detected 1794.235 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 256528k/261888k available (1315k kernel code, 4956k reserved, =
300k data, 284k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=3D3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
PDC20267: IDE controller at PCI slot 02:0e.0
PCI: Found IRQ 9 for device 02:0e.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: neither IDE port enabled (BIOS)
hdb: CD-224E, ATAPI CD/DVD-ROM drive
hde: WDC WD400BB-00DEA0, ATA DISK drive
hdg: WDC WD400BB-00DEA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xdff0-0xdff7,0xdfe6 on irq 9
ide3 at 0xdfa8-0xdfaf,0xdfe2 on irq 9 (shared with ide2)
hde: attached ide-disk driver.
hde: host protected area =3D> 1
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D77545/16/63
hdg: attached ide-disk driver.
hdg: host protected area =3D> 1
hdg: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=3D77545/16/63
Partition check:
 hde: [PTBL] [4865/255/63] hde1 hde2 hde3
 hdg: [PTBL] [4865/255/63] hdg1 hdg2 hdg3
 ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3
Drive 0 is 38166 Mb (33 / 0)=20
Drive 1 is 38166 Mb (34 / 0)=20
Raid1 array consists of 2 drives.=20
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 284k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on ataraid(114,3), internal journal
Adding Swap: 313256k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ataraid(114,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_tables: (C) 2000-2002 Netfilter core team
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

PCI: Found IRQ 11 for device 02:0c.0
e100: selftest OK.
e100: eth2: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

PCI: Found IRQ 3 for device 02:0d.0
PCI: Sharing IRQ 3 with 00:1f.2
e100: selftest OK.
e100: eth3: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: eth0 NIC Link is Up 100 Mbps Full duplex
e100: eth2 NIC Link is Up 100 Mbps Full duplex
e100: eth3 NIC Link is Up 100 Mbps Full duplex
eth0: no IPv6 routers present
eth2: no IPv6 routers present
eth3: no IPv6 routers present
ip_conntrack version 2.1 (2046 buckets, 16368 max) - 292 bytes per =
conntrack
=20
### begin ### cat /proc/interrupts
=20
           CPU0      =20
  0:       8846          XT-PIC  timer
  1:         93          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         13          XT-PIC  eth3
  8:          1          XT-PIC  rtc
  9:       4851          XT-PIC  ide2
 11:        102          XT-PIC  eth0, eth2
 12:          0          XT-PIC  PS/2 Mouse
 14:          1          XT-PIC  ide0
NMI:          0=20
ERR:          0
=20
### begin ### cat /proc/ioports
=20
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #03
  ce80-cebf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    ce80-cebf : e100
  cf00-cf3f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    cf00-cf3f : e100
d800-d8ff : ATI Technologies Inc Rage XL
dd80-ddbf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  dd80-ddbf : e100
de80-debf : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  de80-debf : e100
df00-df3f : Promise Technology, Inc. 20267
dfa8-dfaf : Promise Technology, Inc. 20267
  dfa8-dfaf : ide3
dfe0-dfe3 : Promise Technology, Inc. 20267
  dfe2-dfe2 : ide3
dfe4-dfe7 : Promise Technology, Inc. 20267
  dfe6-dfe6 : ide2
dff0-dff7 : Promise Technology, Inc. 20267
  dff0-dff7 : ide2
ef40-ef5f : Intel Corp. 82801BA/BAM USB (Hub #1)
ef80-ef9f : Intel Corp. 82801BA/BAM USB (Hub #2)
efa0-efaf : Intel Corp. 82801BA/BAM SMBus
ffa0-ffaf : Intel Corp. 82801BA IDE U100
  ffa0-ffa7 : ide0
=20
### begin ### cat /proc/iomem
=20
00000000-0009bbff : System RAM
0009bc00-0009bfff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000d17ff : Extension ROM
000d1800-000d27ff : Extension ROM
000d2800-000d37ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffbffff : System RAM
  00100000-00248d17 : Kernel code
  00248d18-00293fff : Kernel data
0ffc0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
dc300000-dc3fffff : PCI Bus #01
dc400000-dc4fffff : PCI Bus #03
e0000000-efffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host =
Bridge
fc700000-fc7fffff : PCI Bus #01
fc800000-fc8fffff : PCI Bus #03
  fc8a0000-fc8bffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    fc8a0000-fc8bffff : e100
  fc8c0000-fc8dffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    fc8c0000-fc8dffff : e100
  fc8fe000-fc8fefff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    fc8fe000-fc8fefff : e100
  fc8ff000-fc8fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    fc8ff000-fc8fffff : e100
fd000000-fdffffff : ATI Technologies Inc Rage XL
fea40000-fea5ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  fea40000-fea5ffff : e100
fea80000-fea9ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fea80000-fea9ffff : e100
feaa0000-feabffff : Promise Technology, Inc. 20267
feafd000-feafdfff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  feafd000-feafdfff : e100
feafe000-feafefff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  feafe000-feafefff : e100
feaff000-feafffff : ATI Technologies Inc Rage XL
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved
=20
### begin ### /usr/src/linux/scripts/ver_linux
=20
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux delta 2.4.23 #1 Sun Dec 7 16:36:11 EET 2003 i686 i686 i386 =
GNU/Linux
=20
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ipt_limit ipt_state ipt_multiport ipt_MASQUERADE =
ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp iptable_nat ip_conntrack =
autofs e100 iptable_filter ip_tables
=20
### begin ### cat /proc/version
=20
Linux version 2.4.23 (root@delta) (gcc version 3.2 20020903 (Red Hat =
Linux 8.0 3.2-7)) #1 Sun Dec 7 16:36:11 EET 2003
=20
### begin ### cat /proc/modules
=20
ipt_limit               1560   2 (autoclean)
ipt_state               1048   7 (autoclean)
ipt_multiport           1176   7
ipt_MASQUERADE          2296   0 (unused)
ip_conntrack_irc        4208   0 (unused)
ip_conntrack_ftp        5296   1 (autoclean)
ip_nat_ftp              3728   0 (unused)
iptable_nat            20952   1 (autoclean) [ipt_MASQUERADE =
ip_nat_ftp]
ip_conntrack           29288   4 (autoclean) [ipt_state ipt_MASQUERADE =
ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp iptable_nat]
autofs                 13364   0 (autoclean) (unused)
e100                   55044   3
iptable_filter          2412   1 (autoclean)
ip_tables              15776   8 [ipt_limit ipt_state ipt_multiport =
ipt_MASQUERADE iptable_nat iptable_filter]
=20
### begin ### cat /proc/interrupts
=20
           CPU0      =20
  0:       8904          XT-PIC  timer
  1:         93          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         13          XT-PIC  eth3
  8:          1          XT-PIC  rtc
  9:       5018          XT-PIC  ide2
 11:        102          XT-PIC  eth0, eth2
 12:          0          XT-PIC  PS/2 Mouse
 14:          1          XT-PIC  ide0
NMI:          0=20
ERR:          0
=20

------_=_NextPart_000_01C3BDA7.693E1410
Content-Type: text/plain;
	name="kernel_config.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernel_config.txt"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=3Dy
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_X86_HAS_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_F00F_WORKS_OK=3Dy
CONFIG_X86_MCE=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
# CONFIG_ISA is not set
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dy
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID5=3Dm
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
# CONFIG_IP_NF_MATCH_RECENT is not set
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
# CONFIG_IP_NF_ARP_MANGLE is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=3Dy

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dy
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=3Dm

#
# =20
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=3Dy
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=3Dy
CONFIG_WDC_ALI15X3=3Dy
CONFIG_BLK_DEV_AMD74XX=3Dy
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=3Dy
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CY82C693=3Dy
CONFIG_BLK_DEV_CS5530=3Dy
CONFIG_BLK_DEV_HPT34X=3Dy
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=3Dy
CONFIG_PDC202XX_BURST=3Dy
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_RZ1000=3Dy
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_SVWKS=3Dy
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=3Dy
CONFIG_BLK_DEV_SLC90E66=3Dy
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=3Dy
CONFIG_BLK_DEV_IDE_MODES=3Dy
CONFIG_BLK_DEV_ATARAID=3Dy
CONFIG_BLK_DEV_ATARAID_PDC=3Dy
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=3Dm
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=3Dm
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dy
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_SMB_NLS is not set
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
CONFIG_NLS_ISO8859_1=3Dy
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=3Dy
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=3Dy
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=3D0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

------_=_NextPart_000_01C3BDA7.693E1410--
