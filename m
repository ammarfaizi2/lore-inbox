Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSHVIwC>; Thu, 22 Aug 2002 04:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSHVIwC>; Thu, 22 Aug 2002 04:52:02 -0400
Received: from mailer.psp.ucl.ac.be ([130.104.83.246]:47027 "EHLO
	guppy.psp.ucl.ac.be") by vger.kernel.org with ESMTP
	id <S318539AbSHVIv7>; Thu, 22 Aug 2002 04:51:59 -0400
Mime-Version: 1.0
Message-Id: <p0510030eb98a4c160c61@[130.104.82.36]>
Date: Thu, 22 Aug 2002 10:56:00 +0200
To: linux-kernel@vger.kernel.org
From: Bernard Paris <Bernard.Paris@psp.ucl.ac.be>
Subject: PROBEM: kernel crashes
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] kernel crashes, most often while dumping to scsi tape.

[2.]
I've had several linux crashes with 3 different server machines running
RedHat 7.x, where I had compiled successive versions of the kernel.
99,9% of the time, the crashes appear while backing up with "dump".
When crashes appeared, the system was completely frozen; all I could do
was restart the machine with power off and on. There were generally no
error messages in the log files, but sometimes I found some hexa code on
the screen console.
Two weeks ago I've installed RedHat7.3 with kernel 2.4.18-3 (I didn't
recompile it, just use the one from redHat, as it is). I've made lot and
lot of backups and never seen any crash.  I was happy until this night,
because that time the system crash again. BUT, this time, I've found 
this pretty log:

Aug 21 23:43:23 PSPweb kernel: kernel BUG at page_alloc.c:117!
Aug 21 23:43:23 PSPweb kernel: invalid operand: 0000
Aug 21 23:43:23 PSPweb kernel: appletalk 3c59x iptable_filter 
ip_tables st usb-u
hci usbcore aic7xxx sd_mod sc
Aug 21 23:43:23 PSPweb kernel: CPU:    0
Aug 21 23:43:23 PSPweb kernel: EIP:    0010:[<c012f58f>]    Not tainted
Aug 21 23:43:23 PSPweb kernel: EFLAGS: 00010296
Aug 21 23:43:23 PSPweb kernel:
Aug 21 23:43:23 PSPweb kernel: EIP is at __free_pages_ok [kernel] 0x57
(2.4.18-3)
Aug 21 23:43:23 PSPweb kernel: eax: 00000020   ebx: c10c26e8   ecx:
00000001   edx: 00001c43
Aug 21 23:43:23 PSPweb kernel: esi: 00000000   edi: 00000000   ebp:
c40dd690   esp: c11c1f5c
Aug 21 23:43:23 PSPweb kernel: ds: 0018   es: 0018   ss: 0018
Aug 21 23:43:23 PSPweb kernel: Process kswapd (pid: 5, stackpage=c11c1000)
Aug 21 23:43:23 PSPweb kernel: Stack: c0227c02 00000075 c40dd690 c10c26e8
c0139 c13 c11c1f80 c011e8ce c11c1f80
Aug 21 23:43:23 PSPweb kernel:        c11c1f80 c10c26e8 c10c2704 c02cac5c
c40dd690 c012d2b0 c10c26e8 00000030
Aug 21 23:43:23 PSPweb kernel:        c10c26e8 c10c2704 c02cac5c 000000fa
c012e709 c11c0000 c02cac84 00000000
Aug 21 23:43:23 PSPweb kernel: Call Trace: [<c0139c13>]
try_to_free_buffers [kernel] 0x9f
Aug 21 23:43:23 PSPweb kernel: [<c011e8ce>] schedule_timeout [kernel] 0x82
Aug 21 23:43:23 PSPweb kernel: [<c012d2b0>] drop_page [kernel] 0x34
Aug 21 23:43:23 PSPweb kernel: [<c012e709>] refill_inactive_zone [kernel] 0x1e1
Aug 21 23:43:23 PSPweb kernel: [<c012efcd>] kswapd [kernel] 0x261
Aug 21 23:43:23 PSPweb kernel: [<c0105000>] stext [kernel] 0x0
Aug 21 23:43:23 PSPweb kernel: [<c0106e7a>] kernel_thread [kernel] 0x26
Aug 21 23:43:23 PSPweb kernel: [<c012ed6c>] kswapd [kernel] 0x0
Aug 21 23:43:23 PSPweb kernel:
Aug 21 23:43:23 PSPweb kernel:
Aug 21 23:43:24 PSPweb kernel: Code: 0f 0b 5f 5d 89 d8 2b 05 90 42 33 
c0 69 c0 c5 4e ec c4 c1 f8


---------------------------------------------------------------------------
[3.] kernel, scsi, crash

---------------------------------------------------------------------------
[4.] Kernel version (from /proc/version):
Linux version 2.4.18-3 (bhcompile@stripples.devel.redhat.com) (gcc 
version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu Apr 18 
07:31:07 EDT 2002

note: same problems encountered with previous kernel versions

[5.] none
[6.] none

---------------------------------------------------------------------------
[7.] Environment

[7.1.] Software (add the output of the ver_linux script here):

Linux PSPweb 2.4.18-3 #1 Thu Apr 18 07:31:07 EDT 2002 i586 unknown
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         appletalk 3c59x iptable_filter ip_tables st 
usb-uhci usbcore aic7xxx sd_mod scsi_mod

---------------------------------------------------------------------------
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 7
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 0
cpu MHz         : 267.276
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 532.48

---------------------------------------------------------------------------
[7.3.] Module information (from /proc/modules):
appletalk              23308  12
3c59x                  27432   1
iptable_filter          2624   1 (autoclean)
ip_tables              13536   1 [iptable_filter]
st                     28820   0 (unused)
usb-uhci               23492   0 (unused)
usbcore                71168   1 [usb-uhci]
aic7xxx               117248   9
sd_mod                 12896  18
scsi_mod              103872   3 [st aic7xxx sd_mod]

---------------------------------------------------------------------------
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5f00-5f1f : Intel Corp. 82371AB PIIX4 ACPI
6100-613f : Intel Corp. 82371AB PIIX4 ACPI
6400-64ff : Adaptec AIC-7881U
6800-687f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
   6800-687f : 00:0e.0
6900-691f : Intel Corp. 82371AB PIIX4 USB
   6900-691f : usb-uhci
f000-f00f : Intel Corp. 82371AB PIIX4 IDE
   f000-f007 : ide0
   f008-f00f : ide1

  /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
   00100000-0021a493 : Kernel code
   0021a494-002e00ff : Kernel data
e0000000-e3ffffff : S3 Inc. ViRGE/DX or /GX
e4000000-e400007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
e4001000-e4001fff : Adaptec AIC-7881U
   e4001000-e4001fff : aic7xxx
ffff0000-ffffffff : reserved

---------------------------------------------------------------------------
[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at 6900 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

00:0d.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) 
(prog-if 00 [VGA])
         Subsystem: S3 Inc. ViRGE/DX
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 0
         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
         Expansion ROM at <unassigned> [disabled] [size=64K]

00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX 
[Cyclone] (rev 24)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 6800 [size=128]
         Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 6400 [disabled] [size=256]
         Region 1: Memory at e4001000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=64K]

---------------------------------------------------------------------------
[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: IBM      Model: DDRS-34560W      Rev: S97B
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: IBM      Model: DDRS-34560W      Rev: S97B
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
   Vendor: IBM      Model: DDRS-34560W      Rev: S97B
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
   Vendor: IBM      Model: DDRS-34560W      Rev: S97B
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
   Vendor: HP       Model: C1537A           Rev: L708
   Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
   Vendor: TOSHIBA  Model: CD-ROM XM-6201TA Rev: 1030
   Type:   CD-ROM                           ANSI SCSI revision: 02

---------------------------------------------------------------------------
[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
---------------------------------------------------------------------------
[X.] Other notes, patches, fixes, workarounds:

Software uses:
- X is NOT running
- netatalk, samba, wu-ftp, apache, sshd, dhcpd
As you can see those machines are not new.  I don't remember to have
encountered those problems when kernel running was 2.0.36 two years ago on
exactly  same hardware.

A message has been posted on newsroup "linux.dev.kernel".


Thanks ,
Bernard Paris
UCL - Universite Catholique de Louvain
BELGIUM
