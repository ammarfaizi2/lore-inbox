Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbRAFV1s>; Sat, 6 Jan 2001 16:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133116AbRAFV1k>; Sat, 6 Jan 2001 16:27:40 -0500
Received: from law2-f36.hotmail.com ([216.32.181.36]:37895 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131350AbRAFV1C>;
	Sat, 6 Jan 2001 16:27:02 -0500
X-Originating-IP: [65.26.126.5]
From: "Craig Freeze" <ello@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: SCSI hangs with aic7xxx in 2.4.0 SMP
Date: Sat, 06 Jan 2001 21:26:55 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F36Pf3L9BGTuAy0000c9e8@hotmail.com>
X-OriginalArrivalTime: 06 Jan 2001 21:26:55.0806 (UTC) FILETIME=[64E375E0:01C07827]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
SCSI hangs with aic7xxx in 2.4.0 SMP

[2.] Full description of the problem/report:
SCSI device errors and bus resets observed in 2.4.0 that do not occur in 
2.2.13.  Sysrq keys have no effect (ie hard reset required to recover)

[3.] Keywords (i.e., modules, networking, kernel):
aic7xxx 2.4.0 scsi SMP

[4.] Kernel version (from /proc/version):
Linux version 2.4.0 (root@bender) (gcc version egcs-2.91.66 19990314/Linux 
(egcs-1.1.2 release)) #1 SMP Fri Jan 5 15:04:52 CST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment
N/A

[7.1.] Software (add the output of the ver_linux script here)
Linux bender 2.4.0 #1 SMP Fri Jan 5 15:04:52 CST 2001 i586 unknown
Kernel modules         2.3.18
Gnu C                  egcs-2.91.66
Gnu Make               3.77
Binutils               2.9.1.0.25
Linux C Library        2.1.2
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.2
Mount                  2.10o
Net-tools              1.57
Kbd                    command
Sh-utils               1.16
Modules Loaded         iptable_filter ipt_MASQUERADE iptable_nat 
ip_conntrack ip_tables 3c509 isa-pnp 8139too

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 232.110
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 462.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 232.110
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 463.66

[7.3.] Module information (from /proc/modules):
iptable_filter          1856   0 (autoclean) (unused)
ipt_MASQUERADE          1472   1 (autoclean)
iptable_nat            13504   0 [ipt_MASQUERADE]
ip_conntrack           14496   1 [ipt_MASQUERADE iptable_nat]
ip_tables              11008   5 [iptable_filter ipt_MASQUERADE iptable_nat]
3c509                   7232   1
isa-pnp                28208   0 [3c509]
8139too                15488   1

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0213-0213 : isapnp read
0220-022f : 3c509 PnP
02f8-02ff : serial(auto)
03c0-03df : vga+
03e8-03ef : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
6400-64ff : Realtek Semiconductor Co., Ltd. RTL-8139
  6400-64ff : eth0
6800-68ff : Adaptec AHA-294x / AIC-7871
  6800-68fe : aic7xxx
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00209f9f : Kernel code
  00209fa0-0026395f : Kernel data
e0000000-e00000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e0000000-e00000ff : eth0
e0001000-e0001fff : Adaptec AHA-294x / AIC-7871
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] 
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton 
II] (prog-if 80 [Master])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 4: I/O ports at f000 [disabled] [size=16]

00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 
10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6400 [size=256]
        Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=256]

00:13.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at 6800 [size=256]
        Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: RZ26     (C) DEC Rev: T386
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: DEC      Model: RZ26     (C) DEC Rev: T386
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-4XCH   Rev: 1.23
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
Jan  5 16:34:12 bender kernel: (scsi0:0:3:0) Data overrun detected in 
Data-In phase, tag 9;
Jan  5 16:34:12 bender kernel:   Have seen Data Phase. Length=53248, 
NumSGs=13.
Jan  5 16:34:12 bender kernel:      sg[0] - Addr 0x42d5000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[1] - Addr 0x42d9000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[2] - Addr 0x42db000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[3] - Addr 0x42de000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[4] - Addr 0x42e1000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[5] - Addr 0x42e5000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[6] - Addr 0x42e8000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[7] - Addr 0x42eb000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[8] - Addr 0x42ab000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[9] - Addr 0x42ae000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[10] - Addr 0x42b1000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[11] - Addr 0x42b4000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[12] - Addr 0x612a000 : Length 4096
Jan  5 16:34:12 bender kernel: (scsi0:0:3:0) Data overrun detected in 
Data-In phase, tag 9;
Jan  5 16:34:12 bender kernel:   Have seen Data Phase. Length=53248, 
NumSGs=13.
Jan  5 16:34:12 bender kernel:      sg[0] - Addr 0x42d5000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[1] - Addr 0x42d9000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[2] - Addr 0x42db000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[3] - Addr 0x42de000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[4] - Addr 0x42e1000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[5] - Addr 0x42e5000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[6] - Addr 0x42e8000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[7] - Addr 0x42eb000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[8] - Addr 0x42ab000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[9] - Addr 0x42ae000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[10] - Addr 0x42b1000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[11] - Addr 0x42b4000 : Length 4096
Jan  5 16:34:12 bender kernel:      sg[12] - Addr 0x612a000 : Length 4096
Jan  5 16:34:15 bender kernel: (scsi0:0:2:0) Data overrun detected in 
Data-In phase, tag 5;
Jan  5 16:34:15 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 16:34:15 bender kernel:      sg[0] - Addr 0x5002000 : Length 4096
Jan  5 16:34:15 bender kernel:      sg[1] - Addr 0x4ffd000 : Length 4096
Jan  5 16:34:15 bender kernel: (scsi0:0:2:0) Data overrun detected in 
Data-In phase, tag 5;
Jan  5 16:34:15 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 16:34:15 bender kernel:      sg[0] - Addr 0x5002000 : Length 4096
Jan  5 16:34:15 bender kernel:      sg[1] - Addr 0x4ffd000 : Length 4096
Jan  5 16:34:15 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 16:34:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 16:34:15 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 16:34:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 16:34:16 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 16:34:16 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 16:34:19 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:19 bender kernel: (scsi0:0:2:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:19 bender kernel: (scsi0:0:3:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:19 bender kernel: (scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:19 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 9;
Jan  5 16:34:19 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 16:34:19 bender kernel:      sg[0] - Addr 0x740b000 : Length 4096
Jan  5 16:34:19 bender kernel:      sg[1] - Addr 0x740a000 : Length 4096
Jan  5 16:34:19 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 9;
Jan  5 16:34:19 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 16:34:19 bender kernel:      sg[0] - Addr 0x740b000 : Length 4096
Jan  5 16:34:19 bender kernel:      sg[1] - Addr 0x740a000 : Length 4096
Jan  5 16:34:21 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 16:34:21 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 16:34:21 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 16:34:21 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 16:34:21 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 16:34:21 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 16:34:23 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:23 bender kernel: (scsi0:0:2:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:23 bender kernel: (scsi0:0:3:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:23 bender kernel: (scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 16:34:23 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 6;
Jan  5 16:34:23 bender kernel:   Have seen Data Phase. Length=126976, 
NumSGs=31.
Jan  5 16:34:23 bender kernel:      sg[0] - Addr 0x5f1a000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[1] - Addr 0x6281000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[2] - Addr 0x7d82000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[3] - Addr 0x7e44000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[4] - Addr 0x64a8000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[5] - Addr 0x64a3000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[6] - Addr 0x64a2000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[7] - Addr 0x648b000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[8] - Addr 0x6489000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[9] - Addr 0x6473000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[10] - Addr 0x7a07000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[11] - Addr 0x7e2f000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[12] - Addr 0x7a27000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[13] - Addr 0x6bfb000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[14] - Addr 0x6bfa000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[15] - Addr 0x6bf9000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[16] - Addr 0x6bf8000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[17] - Addr 0x6c5f000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[18] - Addr 0x6c5e000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[19] - Addr 0x6c5d000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[20] - Addr 0x6c5c000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[21] - Addr 0x6c5b000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[22] - Addr 0x6c5a000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[23] - Addr 0x6c59000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[24] - Addr 0x6caa000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[25] - Addr 0x6ca9000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[26] - Addr 0x6ca8000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[27] - Addr 0x6ce7000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[28] - Addr 0x6ce6000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[29] - Addr 0x6ce5000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[30] - Addr 0x6ce4000 : Length 4096
Jan  5 16:34:23 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 6;
Jan  5 16:34:23 bender kernel:   Have seen Data Phase. Length=126976, 
NumSGs=31.
Jan  5 16:34:23 bender kernel:      sg[0] - Addr 0x5f1a000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[1] - Addr 0x6281000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[2] - Addr 0x7d82000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[3] - Addr 0x7e44000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[4] - Addr 0x64a8000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[5] - Addr 0x64a3000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[6] - Addr 0x64a2000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[7] - Addr 0x648b000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[8] - Addr 0x6489000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[9] - Addr 0x6473000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[10] - Addr 0x7a07000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[11] - Addr 0x7e2f000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[12] - Addr 0x7a27000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[13] - Addr 0x6bfb000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[14] - Addr 0x6bfa000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[15] - Addr 0x6bf9000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[16] - Addr 0x6bf8000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[17] - Addr 0x6c5f000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[18] - Addr 0x6c5e000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[19] - Addr 0x6c5d000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[20] - Addr 0x6c5c000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[21] - Addr 0x6c5b000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[22] - Addr 0x6c5a000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[23] - Addr 0x6c59000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[24] - Addr 0x6caa000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[25] - Addr 0x6ca9000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[26] - Addr 0x6ca8000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[27] - Addr 0x6ce7000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[28] - Addr 0x6ce6000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[29] - Addr 0x6ce5000 : Length 4096
Jan  5 16:34:23 bender kernel:      sg[30] - Addr 0x6ce4000 : Length 4096
Jan  5 16:34:24 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 6;
Jan  5 16:34:24 bender kernel:   Have seen Data Phase. Length=126976, 
NumSGs=31.
Jan  5 16:34:24 bender kernel:      sg[0] - Addr 0x5f1a000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[1] - Addr 0x6281000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[2] - Addr 0x7d82000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[3] - Addr 0x7e44000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[4] - Addr 0x64a8000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[5] - Addr 0x64a3000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[6] - Addr 0x64a2000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[7] - Addr 0x648b000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[8] - Addr 0x6489000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[9] - Addr 0x6473000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[10] - Addr 0x7a07000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[11] - Addr 0x7e2f000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[12] - Addr 0x7a27000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[13] - Addr 0x6bfb000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[14] - Addr 0x6bfa000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[15] - Addr 0x6bf9000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[16] - Addr 0x6bf8000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[17] - Addr 0x6c5f000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[18] - Addr 0x6c5e000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[19] - Addr 0x6c5d000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[20] - Addr 0x6c5c000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[21] - Addr 0x6c5b000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[22] - Addr 0x6c5a000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[23] - Addr 0x6c59000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[24] - Addr 0x6caa000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[25] - Addr 0x6ca9000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[26] - Addr 0x6ca8000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[27] - Addr 0x6ce7000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[28] - Addr 0x6ce6000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[29] - Addr 0x6ce5000 : Length 4096
Jan  5 16:34:24 bender kernel:      sg[30] - Addr 0x6ce4000 : Length 4096
Jan  5 16:34:24 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 16:34:24 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 16:34:24 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 16:34:24 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 16:34:25 bender kernel: SCSI host 0 reset (pid 0) timed out again -

[hang]

Jan  5 19:05:10 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 9;
Jan  5 19:05:10 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:05:10 bender kernel:      sg[0] - Addr 0x1381000 : Length 4096
Jan  5 19:05:10 bender kernel:      sg[1] - Addr 0x6480000 : Length 4096
Jan  5 19:05:10 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 9;
Jan  5 19:05:10 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:05:10 bender kernel:      sg[0] - Addr 0x1381000 : Length 4096
Jan  5 19:05:10 bender kernel:      sg[1] - Addr 0x6480000 : Length 4096
Jan  5 19:05:10 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:05:10 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:05:10 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:05:10 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:05:11 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:05:11 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:05:14 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:14:05 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 12;
Jan  5 19:14:05 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:14:05 bender kernel:      sg[0] - Addr 0x766e000 : Length 4096
Jan  5 19:14:05 bender kernel:      sg[1] - Addr 0x765e000 : Length 4096
Jan  5 19:14:05 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 12;
Jan  5 19:14:05 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:14:05 bender kernel:      sg[0] - Addr 0x766e000 : Length 4096
Jan  5 19:14:05 bender kernel:      sg[1] - Addr 0x765e000 : Length 4096
Jan  5 19:14:05 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:14:05 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:14:05 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:14:05 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:14:06 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:14:06 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:14:09 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:20:35 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 1;
Jan  5 19:20:35 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:20:35 bender kernel:      sg[0] - Addr 0x13d4000 : Length 4096
Jan  5 19:20:35 bender kernel:      sg[1] - Addr 0x6b06000 : Length 4096
Jan  5 19:20:35 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 1;
Jan  5 19:20:35 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:20:35 bender kernel:      sg[0] - Addr 0x13d4000 : Length 4096
Jan  5 19:20:35 bender kernel:      sg[1] - Addr 0x6b06000 : Length 4096
Jan  5 19:20:35 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:20:35 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:20:35 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:20:35 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:20:36 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:20:36 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:20:39 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:25:15 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 9;
Jan  5 19:25:15 bender kernel:   Have seen Data Phase. Length=12288, 
NumSGs=3.
Jan  5 19:25:15 bender kernel:      sg[0] - Addr 0x6461000 : Length 4096
Jan  5 19:25:15 bender kernel:      sg[1] - Addr 0x643c000 : Length 4096
Jan  5 19:25:15 bender kernel:      sg[2] - Addr 0x76de000 : Length 4096
Jan  5 19:25:15 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 9;
Jan  5 19:25:15 bender kernel:   Have seen Data Phase. Length=12288, 
NumSGs=3.
Jan  5 19:25:15 bender kernel:      sg[0] - Addr 0x6461000 : Length 4096
Jan  5 19:25:15 bender kernel:      sg[1] - Addr 0x643c000 : Length 4096
Jan  5 19:25:15 bender kernel:      sg[2] - Addr 0x76de000 : Length 4096
Jan  5 19:25:15 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:25:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:25:15 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:25:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:25:16 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:25:16 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:25:19 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:35:15 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 8;
Jan  5 19:35:15 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:35:15 bender kernel:      sg[0] - Addr 0x1283000 : Length 4096
Jan  5 19:35:15 bender kernel:      sg[1] - Addr 0x1281000 : Length 4096
Jan  5 19:35:15 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 8;
Jan  5 19:35:15 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:35:15 bender kernel:      sg[0] - Addr 0x1283000 : Length 4096
Jan  5 19:35:15 bender kernel:      sg[1] - Addr 0x1281000 : Length 4096
Jan  5 19:35:15 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:35:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:35:15 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:35:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:35:16 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:35:16 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:35:19 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:36:15 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 14;
Jan  5 19:36:15 bender kernel:   Have seen Data Phase. Length=12288, 
NumSGs=3.
Jan  5 19:36:15 bender kernel:      sg[0] - Addr 0x1283000 : Length 4096
Jan  5 19:36:15 bender kernel:      sg[1] - Addr 0x1281000 : Length 4096
Jan  5 19:36:15 bender kernel:      sg[2] - Addr 0x74e5000 : Length 4096
Jan  5 19:36:15 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-Out phase, tag 14;
Jan  5 19:36:15 bender kernel:   Have seen Data Phase. Length=12288, 
NumSGs=3.
Jan  5 19:36:15 bender kernel:      sg[0] - Addr 0x1283000 : Length 4096
Jan  5 19:36:15 bender kernel:      sg[1] - Addr 0x1281000 : Length 4096
Jan  5 19:36:15 bender kernel:      sg[2] - Addr 0x74e5000 : Length 4096
Jan  5 19:36:15 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:36:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:36:15 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:36:15 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:36:16 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:36:16 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:36:19 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:40:08 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 8;
Jan  5 19:40:08 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:40:08 bender kernel:      sg[0] - Addr 0x5676000 : Length 4096
Jan  5 19:40:08 bender kernel:      sg[1] - Addr 0x5675000 : Length 4096
Jan  5 19:40:10 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 8;
Jan  5 19:40:10 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:40:10 bender kernel:      sg[0] - Addr 0x5676000 : Length 4096
Jan  5 19:40:10 bender kernel:      sg[1] - Addr 0x5675000 : Length 4096
Jan  5 19:40:10 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:40:10 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:10 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:40:10 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:10 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:40:10 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:40:12 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:40:12 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 8;
Jan  5 19:40:12 bender kernel:   Have seen Data Phase. Length=12288, 
NumSGs=3.
Jan  5 19:40:12 bender kernel:      sg[0] - Addr 0x567d000 : Length 4096
Jan  5 19:40:12 bender kernel:      sg[1] - Addr 0x567c000 : Length 4096
Jan  5 19:40:12 bender kernel:      sg[2] - Addr 0x567b000 : Length 4096
Jan  5 19:40:12 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 8;
Jan  5 19:40:12 bender kernel:   Have seen Data Phase. Length=12288, 
NumSGs=3.
Jan  5 19:40:12 bender kernel:      sg[0] - Addr 0x567d000 : Length 4096
Jan  5 19:40:12 bender kernel:      sg[1] - Addr 0x567c000 : Length 4096
Jan  5 19:40:12 bender kernel:      sg[2] - Addr 0x567b000 : Length 4096
Jan  5 19:40:14 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 8;
Jan  5 19:40:14 bender kernel:   Have seen Data Phase. Length=12288, 
NumSGs=3.
Jan  5 19:40:14 bender kernel:      sg[0] - Addr 0x567d000 : Length 4096
Jan  5 19:40:14 bender kernel:      sg[1] - Addr 0x567c000 : Length 4096
Jan  5 19:40:14 bender kernel:      sg[2] - Addr 0x567b000 : Length 4096
Jan  5 19:40:14 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:40:14 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:14 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:40:14 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:14 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:40:14 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:40:16 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:40:17 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 14;
Jan  5 19:40:17 bender kernel:   Have seen Data Phase. Length=20480, 
NumSGs=5.
Jan  5 19:40:17 bender kernel:      sg[0] - Addr 0x568a000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[1] - Addr 0x5689000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[2] - Addr 0x5688000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[3] - Addr 0x5687000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[4] - Addr 0x5686000 : Length 4096
Jan  5 19:40:17 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 14;
Jan  5 19:40:17 bender kernel:   Have seen Data Phase. Length=20480, 
NumSGs=5.
Jan  5 19:40:17 bender kernel:      sg[0] - Addr 0x568a000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[1] - Addr 0x5689000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[2] - Addr 0x5688000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[3] - Addr 0x5687000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[4] - Addr 0x5686000 : Length 4096
Jan  5 19:40:17 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 14;
Jan  5 19:40:17 bender kernel:   Have seen Data Phase. Length=20480, 
NumSGs=5.
Jan  5 19:40:17 bender kernel:      sg[0] - Addr 0x568a000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[1] - Addr 0x5689000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[2] - Addr 0x5688000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[3] - Addr 0x5687000 : Length 4096
Jan  5 19:40:17 bender kernel:      sg[4] - Addr 0x5686000 : Length 4096
Jan  5 19:40:17 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:40:17 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:17 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:40:17 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:18 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:40:18 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:40:21 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:40:21 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 9;
Jan  5 19:40:21 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:40:21 bender kernel:      sg[0] - Addr 0x53ba000 : Length 4096
Jan  5 19:40:21 bender kernel:      sg[1] - Addr 0x53b9000 : Length 4096
Jan  5 19:40:21 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 9;
Jan  5 19:40:21 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:40:21 bender kernel:      sg[0] - Addr 0x53ba000 : Length 4096
Jan  5 19:40:21 bender kernel:      sg[1] - Addr 0x53b9000 : Length 4096
Jan  5 19:40:21 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:40:21 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:22 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:40:22 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:22 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:40:22 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:40:25 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:40:26 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 14;
Jan  5 19:40:26 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:40:26 bender kernel:      sg[0] - Addr 0x5387000 : Length 4096
Jan  5 19:40:26 bender kernel:      sg[1] - Addr 0x5386000 : Length 4096
Jan  5 19:40:26 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 14;
Jan  5 19:40:26 bender kernel:   Have seen Data Phase. Length=8192, 
NumSGs=2.
Jan  5 19:40:26 bender kernel:      sg[0] - Addr 0x5387000 : Length 4096
Jan  5 19:40:26 bender kernel:      sg[1] - Addr 0x5386000 : Length 4096
Jan  5 19:40:26 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:40:26 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:40:26 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder

[errors continue]

Jan  5 19:42:30 bender kernel:      sg[4] - Addr 0x4e8d000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[5] - Addr 0x4e8c000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[6] - Addr 0x4e8b000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[7] - Addr 0x4e8a000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[8] - Addr 0x4e89000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[9] - Addr 0x4e88000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[10] - Addr 0x4e87000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[11] - Addr 0x4e86000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[12] - Addr 0x4e85000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[13] - Addr 0x4e84000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[14] - Addr 0x4e83000 : Length 4096
Jan  5 19:42:30 bender kernel:      sg[15] - Addr 0x4e82000 : Length 4096
Jan  5 19:42:32 bender kernel: (scsi0:0:0:0) Data overrun detected in 
Data-In phase, tag 3;
Jan  5 19:42:32 bender kernel:   Have seen Data Phase. Length=65536, 
NumSGs=16.
Jan  5 19:42:32 bender kernel:      sg[0] - Addr 0x4e91000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[1] - Addr 0x4e90000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[2] - Addr 0x4e8f000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[3] - Addr 0x4e8e000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[4] - Addr 0x4e8d000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[5] - Addr 0x4e8c000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[6] - Addr 0x4e8b000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[7] - Addr 0x4e8a000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[8] - Addr 0x4e89000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[9] - Addr 0x4e88000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[10] - Addr 0x4e87000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[11] - Addr 0x4e86000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[12] - Addr 0x4e85000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[13] - Addr 0x4e84000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[14] - Addr 0x4e83000 : Length 4096
Jan  5 19:42:32 bender kernel:      sg[15] - Addr 0x4e82000 : Length 4096
Jan  5 19:42:32 bender kernel: scsi0 channel 0 : resetting for second half 
of retries.
Jan  5 19:42:32 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:42:32 bender kernel: SCSI host 0 channel 0 reset (pid 0) timed out 
- trying harder
Jan  5 19:42:32 bender kernel: SCSI bus is being reset for host 0 channel 0.
Jan  5 19:42:32 bender kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  5 19:42:32 bender kernel: probably an unrecoverable SCSI bus or device 
hang.
Jan  5 19:42:35 bender kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  5 19:42:35 bender kernel: (scsi0:0:1:0) Synchronous at 10.0 Mbyte/sec, 
offset 15.
Jan  6 04:40:35 bender kernel: (scsi0:0:1:0) Data overrun detected in 
Data-Out phase, tag 13;

[hang]

[X.] Other notes, patches, fixes, workarounds:
This system had 82 days of uptime under 2.2.13, with 3 (OLD!) IMBRAID disks 
attached as a raid0 md, and no scsi errors logged during that time.  After 
the first hang, i removed the raid drives but have hung since.

Please reply to me directly if you need more information.

ello@hotmail.com


#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M586MMX=y
# CONFIG_M686 is not set
# CONFIG_M686FXSR is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_TOSHIBA is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_LVM=m
CONFIG_LVM_PROC_FS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
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
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=m

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_AIC7XXX_RESET_DELAY=5
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
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
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
# CONFIG_VORTEX is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139TOO=m
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
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
CONFIG_SHAPER=m

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
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_PROC_FS=y
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
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
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
CONFIG_FB_CLGEN=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
# CONFIG_FBCON_VGA is not set
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
