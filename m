Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292522AbSCMG5o>; Wed, 13 Mar 2002 01:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292529AbSCMG50>; Wed, 13 Mar 2002 01:57:26 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:57102 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292522AbSCMG5T>; Wed, 13 Mar 2002 01:57:19 -0500
From: "Todd E. Johnson" <tejohnson@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1 boot
Date: Wed, 13 Mar 2002 01:56:36 -0500
Message-ID: <002001c1ca5c$38a39090$021e1eac@areas3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Information as follows:

[1.] One line summary of the problem:  

Kernel Panic on 2.5.6 and 2.5.7-pre1 boot

[2.] Full description of the problem/report:

After a simple build of 2.5.6, and/or 2.5.7-pre1, when I reboot my
machine, I am greeted by
a kernel panic moments after the IDE controller is recognized.

[3.] Keywords (i.e., modules, networking, kernel):

2.5.6
2.5.7-pre1

[4.] Kernel version (from /proc/version):

Currently running 2.4.18

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[Please note, I'm not able to build ksmoops. The compiler error included
after my signature]
     
Unable to handle kernel NULL pointer dereference at virtual address
00000010
 printing eip:
c0136972
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0136972>]    Not tainted
EFLAGS: 00010286
eax: d0020000   ebx: 0000000e   ecx: 00000008   edx: 00000000
esi: 00000008   edi: 00002012   ebp: 00000000   esp: cf7e1d80
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, threadinfo=cf7e0000 task=cf77c040)
Stack: 00001000 00002012 00000000 cf5ba400 c012ae15 c0136f6f 00000000
00002012
       00001000 cf5ba400 cf5ab000 d00313ec c0137170 00000000 00002012
00001000
       cf5ba400 c01951a3 00000000 00002012 00001000 00000400 00000000
cf5ba6fc
Call Trace: [<c012ae15>] [<c0136f6f>] [<c0137170>] [<c01951a3>]
[<c01129bb>]
   [<c01361b0>] [<c0187936>] [<c01881f3>] [<c019efa2>] [<c013be1c>]
[<c013aa82>]

   [<c01885ca>] [<c01880cc>] [<c013ac4e>] [<c014b626>] [<c014b8de>]
[<c014b744>]

   [<c014bd02>] [<c0105269>] [<c0105078>] [<c010569c>]

Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 25 ff ff 00 00 89 44
 <0>Kernel panic: Attempted to kill init!



[6.] A small shell script or example program which triggers the
     problem (if possible)
     
N/A

[7.] Environment

N/A

[7.1.] Software (add the output of the ver_linux script here)

Linux stormtrooper 2.4.18 #3 SMP Thu Mar 7 20:25:57 EST 2002 i586
unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 501.366
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 969.93

[7.3.] Module information (from /proc/modules):

N/A

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

Using ReiserFS on my entire disk.
System is a BioStar M5SAF (No Serial port, PCI expansion slots, or PS/2
style connectors).
USB keyboard.


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d8000000 (32-bit, non-prefetchable)
[size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE
Controller (A,B step)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 4000 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 01)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 0900
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at dd901000 (32-bit, non-prefetchable)
[size=4K]
	Expansion ROM at dc000000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
(prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] 7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at dd902000 (32-bit, non-prefetchable)
[size=4K]

00:01.3 Multimedia audio controller: Silicon Integrated Systems [SiS]
SiS PCI Audio Accelerator (rev 01)
	Subsystem: Silicon Integrated Systems [SiS] SiS PCI Audio
Accelerator
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin B routed to IRQ 12
	Region 0: I/O ports at e000 [size=256]
	Region 1: Memory at dd900000 (32-bit, non-prefetchable)
[size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: dd800000-dd8fffff
	Prefetchable memory behind bridge: dd000000-dd7fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306
3D-AGP (rev a3) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI
Accelerator+3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min)
	Region 0: Memory at dd000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at dd800000 (32-bit, non-prefetchable)
[size=64K]
	Region 2: I/O ports at d000 [size=128]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
       

[X.] Other notes, patches, fixes, workarounds:

N/A


Questions?  Give me yell!

     Regards,

Todd E. Johnson
tejohnson@yahoo.com


<ksmoops build
error>**************************************************************

...
cc io.o ksyms.o ksymoops.o map.o misc.o object.o oops.o re.o symbol.o
-Dlinux -Wa
ll -Wno-conversion -Waggregate-return -Wstrict-prototypes
-Wmissing-prototypes  -D
DEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
-DDEF_OBJECTS=\"/lib/modul
es/*r/\" -DDEF_MAP=\"/usr/src/linux/System.map\" -Wl,-Bstatic -lbfd
-liberty -Wl,-
Bdynamic -o ksymoops
/usr/lib/libbfd.a(merge.o): In function `merge_strings':
merge.o(.text+0xa0f): undefined reference to `htab_create'
merge.o(.text+0xa37): undefined reference to `htab_create'
merge.o(.text+0xacd): undefined reference to `htab_find_slot_with_hash'
merge.o(.text+0xb25): undefined reference to `htab_find_slot_with_hash'
merge.o(.text+0xb8d): undefined reference to `htab_delete'
merge.o(.text+0xba2): undefined reference to `htab_delete'
collect2: ld returned 1 exit status
make: *** [ksymoops] Error 1


Binutils is in the regular location:

Ex:

/usr/lib/libbfd-2.11.90.0.19.so
/usr/lib/libbfd.a
/usr/lib/libbfd.la
/usr/lib/libbfd.so

I'm using Slackware 8, with the 2.4.18 kernel successfully on this
host...

</ksmoops build
error>*************************************************************


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

