Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUDMCpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 22:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUDMCpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 22:45:40 -0400
Received: from jlefevre.net1.nerim.net ([80.65.226.245]:23684 "EHLO
	ay.vinc17.org") by vger.kernel.org with ESMTP id S263214AbUDMCpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 22:45:21 -0400
Date: Tue, 13 Apr 2004 04:45:17 +0200
From: Vincent Lefevre <vincent@vinc17.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG at tcp_input.c:2927
Message-ID: <20040413024517.GE3858@ay.vinc17.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer-Info: http://www.vinc17.org/mutt/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Crash; "kernel BUG at tcp_input.c:2927" written in the console.

[2.] Full description of the problem/report:

The machine didn't answer to ping. When I went to see what was wrong,
I saw the following in the console:

kernel BUG at tcp_input.c:2927!
invalid operand: 0000
[...]

(I didn't have the time to copy the following data, and unfortunately
I couldn't see these data in any log file after rebooting the machine.)

This was the first time such a problem occurred.

[3.] Keywords (i.e., modules, networking, kernel):

networking

[4.] Kernel version (from /proc/version):

Linux version 2.4.25 (root@greux.loria.fr) (gcc version 3.3.3 (Debian)) #1 SMP Fri Feb 20 14:51:57 CET 2004

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux greux.loria.fr 2.4.25 #1 SMP Fri Feb 20 14:51:57 CET 2004 i686 GNU/Linux
 
Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 731.026
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1458.17

[7.3.] Module information (from /proc/modules):

nothing

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-50ff : Adaptec AIC-7892P U160/m
5400-543f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  5400-543f : eepro100
6000-60ff : Intel Corp. 82801AA AC'97 Audio
6400-643f : Intel Corp. 82801AA AC'97 Audio
6440-645f : Intel Corp. 82801AA USB
  6440-645f : usb-uhci
6460-646f : Intel Corp. 82801AA IDE
  6460-6467 : ide0
  6468-646f : ide1
fc00-fc0f : Intel Corp. 82801AA SMBus

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000c9800-000cf5ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00336f80 : Kernel code
  00336f81-003f3483 : Kernel data
07ff0000-07ffffff : reserved
d4000000-d7ffffff : Intel Corp. 82840 840 (Carmel) Chipset Host Bridge (Hub A)
f9d00000-f9d00fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  f9d00000-f9d00fff : eepro100
f9e00000-f9efffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
f9f00000-f9f00fff : Adaptec AIC-7892P U160/m
  f9f00000-f9f00fff : aic7xxx
fa000000-fbffffff : PCI Bus #01
  fa000000-fbffffff : Matrox Graphics, Inc. MGA G400 AGP
fd700000-fdffffff : PCI Bus #01
  fd700000-fd703fff : Matrox Graphics, Inc. MGA G400 AGP
  fd800000-fdffffff : Matrox Graphics, Inc. MGA G400 AGP

[7.5.] PCI information ('lspci -vvv' as root)

pcilib: Cannot open /sys/bus/pci/devices
0000:00:00.0 Host bridge: Intel Corp. 82840 840 (Carmel) Chipset Host Bridge (Hub A) (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR+ <PERR+
	Latency: 0
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82840 840 (Carmel) Chipset AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fd700000-fdffffff
	Prefetchable memory behind bridge: fa000000-fbffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: f9d00000-f9ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corp. 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 6460 [size=16]

0000:00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp. 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at 6440 [size=32]

0000:00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
	Subsystem: Intel Corp. 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at fc00 [size=16]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device b197
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at 6000 [size=256]
	Region 1: I/O ports at 6400 [size=64]

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fa000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at fd700000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fd800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

0000:02:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Compaq Computer Corporation 82559 Fast Ethernet LOM with Alert on LAN*
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f9d00000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 5400 [size=64]
	Region 2: Memory at f9e00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:07.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device b1bc
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	BIST result: 00
	Region 0: I/O ports at 5000 [disabled] [size=256]
	Region 1: Memory at f9f00000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: COMPAQPC Model: MAJ3091MP        Rev: 1812
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/var/log/messages contains:

Apr 11 06:47:29 greux syslogd 1.4.1#14: restart.
Apr 11 07:17:19 greux -- MARK --
Apr 11 07:37:19 greux -- MARK --
Apr 11 07:57:19 greux -- MARK --
Apr 11 08:17:19 greux -- MARK --
Apr 11 08:37:19 greux -- MARK --
Apr 11 08:39:22 greux kernel: recvmsg bug: copied 7CCF6E4D seq 7CCF6EDC
Apr 11 08:39:22 greux last message repeated 90 times
Apr 11 08:39:22 greux kernel: CCF6EDC
Apr 11 08:39:22 greux kernel: recvmsg bug: copied 7CCF6E4D seq 7CCF6EDC
Apr 11 08:39:22 greux last message repeated 1336 times
Apr 11 08:39:22 greux kernel: CCF6EDC
Apr 11 08:39:22 greux kernel: recvmsg bug: copied 7CCF6E4D seq 7CCF6EDC
Apr 11 08:39:22 greux last message repeated 1455 times
Apr 11 08:39:22 greux kernel: CCF6EDC
[...]
Apr 11 08:45:15 greux kernel: recvmsg bug: copied 7CCF6E4D seq 7CCF6EDC
Apr 11 08:45:15 greux last message repeated 3787 times
Apr 11 08:45:15 greux kernel: CCF6EDC
Apr 11 08:45:15 greux kernel: recvmsg bug: copied 7CCF6E4D seq 7CCF6EDC
Apr 11 08:45:16 greux last message repeated 3399 times
Apr 11 08:45:16 greux kernel: CCF6EDC
Apr 11 08:45:16 greux kernel: recvmsg bug: copied 7CCF6E4D seq 7CCF6EDC
Apr 11 17:06:29 greux syslogd 1.4.1#14: restart.
Apr 11 17:06:29 greux kernel: klogd 1.4.1#14, log source = /proc/kmsg started.
Apr 11 17:06:29 greux kernel: Inspecting /boot/System.map-2.4.25
[...]

(I rebooted the machine at 17:06.)

I've just done some pings:

loria1:~> ping greux
PING greux.loria.fr (152.81.2.43) 56(84) bytes of data.
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=1 ttl=63 time=0.277 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=3 ttl=63 time=0.287 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=4 ttl=63 time=0.285 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=5 ttl=63 time=0.296 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=2 ttl=63 time=3876 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=9 ttl=63 time=0.282 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=10 ttl=63 time=0.287 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=11 ttl=63 time=0.280 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=12 ttl=63 time=0.351 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=6 ttl=63 time=6440 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=7 ttl=63 time=5441 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=8 ttl=63 time=4441 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=16 ttl=63 time=0.278 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=17 ttl=63 time=0.302 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=18 ttl=63 time=0.329 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=13 ttl=63 time=5019 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=14 ttl=63 time=4019 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=15 ttl=63 time=3020 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=23 ttl=63 time=0.284 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=19 ttl=63 time=4776 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=20 ttl=63 time=3776 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=21 ttl=63 time=2777 ms
64 bytes from greux.loria.fr (152.81.2.43): icmp_seq=22 ttl=63 time=1777 ms

--- greux.loria.fr ping statistics ---
25 packets transmitted, 23 received, 8% packet loss, time 24110ms
rtt min/avg/max/mdev = 0.277/1972.673/6440.864/2233.875 ms, pipe 7

It seems that there is still a network problem.
