Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264937AbRFUMXc>; Thu, 21 Jun 2001 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbRFUMXW>; Thu, 21 Jun 2001 08:23:22 -0400
Received: from linux.kappa.ro ([194.102.255.131]:40667 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S264937AbRFUMXD>;
	Thu, 21 Jun 2001 08:23:03 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Thu, 21 Jun 2001 15:24:14 +0300
From: Mircea Damian <dmircea@kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Failed to boot 2.4.6-pre5
Message-ID: <20010621152414.A27869@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:    
I can not start 2.4.6-pre5 on my machine.

[2.] Full description of the problem/report:
I've tried to upgrade from 2.4.5-pre1 to 2.4.6-pre5 but it failed the new
kernel failed to boot. It OOPS-es while it's starting. I managed to write
down some of the OOPS parameters.


[3.] Keywords (i.e., modules, networking, kernel):
kernel boot.

[4.] Kernel version (from /proc/version):
2.4.6-pre5

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

All information that I have not saved is replaced with zeroes. So I got
only the EIP, call trace and the Code:

ksymoops 2.3.4 on i686 2.4.5-pre1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.5-pre1/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Oops: 0001
CPU:    1
EIP:    0010:[<c0116f72>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000000
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: 00000000   esp: 00000000
ds: 0000   es: 0000   ss: 0000
Process swapper (pid: 0, stackpage=00000000)
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0116d8d>] [<c0107fe9>] [<c0105000>] [<c0106bd0>] [<c0105000>] [<c0105000>]
Code: 0f 0b 83 c4 0c 90 8b 43 08 85 c0 75 15 fb 8b 43 10 50 8b 43

>>EIP; c0116f72 <tasklet_hi_action+6a/ac>   <=====
Trace; c0116d8d <do_softirq+45/6c>
Trace; c0107fe9 <do_IRQ+9d/b0>
Trace; c0105000 <_stext+0/0>
Trace; c0106bd0 <ret_from_intr+0/7>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Code;  c0116f72 <tasklet_hi_action+6a/ac>
00000000 <_EIP>:
Code;  c0116f72 <tasklet_hi_action+6a/ac>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0116f74 <tasklet_hi_action+6c/ac>
   2:   83 c4 0c                  addl   $0xc,%esp
Code;  c0116f77 <tasklet_hi_action+6f/ac>
   5:   90                        nop    
Code;  c0116f78 <tasklet_hi_action+70/ac>
   6:   8b 43 08                  movl   0x8(%ebx),%eax
Code;  c0116f7b <tasklet_hi_action+73/ac>
   9:   85 c0                     testl  %eax,%eax
Code;  c0116f7d <tasklet_hi_action+75/ac>
   b:   75 15                     jne    22 <_EIP+0x22> c0116f94 <tasklet_hi_action+8c/ac>
Code;  c0116f7f <tasklet_hi_action+77/ac>
   d:   fb                        sti    
Code;  c0116f80 <tasklet_hi_action+78/ac>
   e:   8b 43 10                  movl   0x10(%ebx),%eax
Code;  c0116f83 <tasklet_hi_action+7b/ac>
  11:   50                        pushl  %eax
Code;  c0116f84 <tasklet_hi_action+7c/ac>
  12:   8b 43 00                  movl   0x0(%ebx),%eax

[6.] A small shell script or example program which triggers the
     problem (if possible)

N/A.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux cyrix 2.4.5-pre1 #1 Tue May 8 11:27:27 EEST 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.77
binutils               2.9.1.0.25
usage: fdformat [ -n ] device
mount                  2.9v
modutils               2.4.6
e2fsprogs              1.15
PPP                    2.4.0b1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.6
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 6
model           : 2
model name      : 6x86MX 2.5x Core/Bus Clock
stepping        : 7
cpu MHz         : 166.451
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
bogomips        : 331.77

[7.3.] Module information (from /proc/modules):
No modules are loaded.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0280-029f : eth0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
6400-641f : Intel Corporation 82371AB PIIX4 USB
6800-68ff : Realtek Semiconductor Co., Ltd. RTL-8139
  6800-68ff : 8139too
6c00-6c1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  6c00-6c1f : ne2k-pci
7000-70ff : Realtek Semiconductor Co., Ltd. RTL-8139 (#2)
  7000-70ff : 8139too
7400-741f : Realtek Semiconductor Co., Ltd. RTL-8029(AS) (#2)
  7400-741f : ne2k-pci
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0



00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-01ffffff : System RAM
  00100000-0021cd7f : Kernel code
  0021cd80-0027c73f : Kernel data
e0000000-e00000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e0000000-e00000ff : 8139too
e0001000-e00010ff : Realtek Semiconductor Co., Ltd. RTL-8139 (#2)
  e0001000-e00010ff : 8139too
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 set

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at f000

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at 6400

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8139 (rev 10)
	Subsystem: Unknown device 10ec:8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 min, 64 max, 64 set
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at 6800
	Region 1: Memory at e0000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8029
	Subsystem: Unknown device 10ec:8029
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 6c00

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8139 (rev 10)
	Subsystem: Unknown device 10bd:0320
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 min, 64 max, 64 set
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at 7000
	Region 1: Memory at e0001000 (32-bit, non-prefetchable)

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 8029
	Subsystem: Unknown device 10ec:8029
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 7400

[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

It seems to be something related to the latest changes in the do_softirq stuff.


-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
