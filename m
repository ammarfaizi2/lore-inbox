Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314984AbSENBiO>; Mon, 13 May 2002 21:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314987AbSENBiN>; Mon, 13 May 2002 21:38:13 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:39411 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S314984AbSENBiF>; Mon, 13 May 2002 21:38:05 -0400
Subject: PROBLEM: `modprobe agpgart` locks machine badly
From: Alex Brotman <atbrotman@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 13 May 2002 21:33:30 -0400
Message-Id: <1021340012.2672.4.camel@mycomp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not on the list and will need CC'ed.  Thanks.

1. 
`modprobe agpgart` locks machine badly 

2. 
When I try to insmod or modprobe agpgart my computer locks up very
badly.  I cannot even use another machine to remotely log in and it
stops responding to all network traffic.  I have tried many different
2.4.x versions and also many kernel configs, as well as trying
--try-unsupported. 

3. 
agpgart kernel lock 

4. 
Linux version 2.4.18 (root@mycomp) (gcc version 2.95.4 20011002 (Debian
prerelease)) #2 SMP Wed Apr 10 20:56:20 EDT 2002 

5. 
I dont have an oops but i do have a `strace insmod agpgart`, but there
doesn't seem to be much in it.  I will include it later. 

6. 
`modprobe agpgart` 

7.1 
If some fields are empty or look unusual you may have an old version. 
Compare to the current minimal requirements in Documentation/Changes. 

Linux mycomp 2.4.18 #2 SMP Wed Apr 10 20:56:20 EDT 2002 i686 unknown 

Gnu C                  2.95.4 
Gnu make               3.79.1 
util-linux             2.11n 
mount                  2.11n 
modutils               2.4.15 
e2fsprogs              1.27 
PPP                    2.4.1 
Linux C Library        2.2.5 
Dynamic linker (ldd)   2.2.5 
Procps                 2.0.7 
Net-tools              1.60 
Console-tools          0.2.3 
Sh-utils               2.0.11 
Modules Loaded         

7.2 
processor       : 0 
vendor_id       : GenuineIntel 
cpu family      : 6 
model           : 7 
model name      : Pentium III (Katmai) 
stepping        : 3 
cpu MHz         : 501.146 
cache size      : 512 KB 
fdiv_bug        : no 
hlt_bug         : no 
f00f_bug        : no 
coma_bug        : no 
fpu             : yes 
fpu_exception   : yes 
cpuid level     : 2 
wp              : yes 
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov 
pat pse36 mmx fxsr sse 
bogomips        : 999.42 

processor       : 1 
vendor_id       : GenuineIntel 
cpu family      : 6 
model           : 7 
model name      : Pentium III (Katmai) 
stepping        : 3 
cpu MHz         : 501.146 
cache size      : 512 KB 
fdiv_bug        : no 
hlt_bug         : no 
f00f_bug        : no 
coma_bug        : no 
fpu             : yes 
fpu_exception   : yes 
cpuid level     : 2 
wp              : yes 
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov 
pat pse36 mmx fxsr sse 
bogomips        : 999.42 

7.3 
N/A 

7.4 
ioports: 
-------------------------- 
0000-001f : dma1 
0020-003f : pic1 
0040-005f : timer 
0060-006f : keyboard 
0080-008f : dma page reg 
00a0-00bf : pic2 
00c0-00df : dma2 
00f0-00ff : fpu 
01f0-01f7 : ide0 
02f8-02ff : serial(set) 
03c0-03df : vga+ 
03e8-03ef : serial(set) 
03f6-03f6 : ide0 
03f8-03ff : serial(set) 
0cf8-0cff : PCI conf1 
1000-10ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 
  1000-10ff : aic7xxx 
1400-14ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2) 
  1400-14ff : aic7xxx 
1800-183f : Intel Corp. 82557 [Ethernet Pro 100] 
  1800-183f : eepro100 
1840-185f : Intel Corp. 82371AB PIIX4 USB 
  1840-185f : usb-uhci 
1860-186f : Intel Corp. 82371AB PIIX4 IDE 
  1860-1867 : ide0 
  1868-186f : ide1 
8000-803f : Intel Corp. 82371AB PIIX4 ACPI 
9000-9fff : PCI Bus #02 
  9000-903f : Ensoniq 5880 AudioPCI 
    9000-903f : es1371 
e800-e81f : Intel Corp. 82371AB PIIX4 ACPI 

iomem: 
------------- 
00000000-0009f7ff : System RAM 
0009f800-0009ffff : reserved 
000a0000-000bffff : Video RAM area 
000c0000-000c7fff : Video ROM 
000c9000-000ce7ff : Extension ROM 
000f0000-000fffff : System ROM 
00100000-1ffeffff : System RAM 
  00100000-002993c6 : Kernel code 
  002993c7-0032421f : Kernel data 
1fff0000-1ffffbff : ACPI Tables 
1ffffc00-1fffffff : ACPI Non-volatile Storage 
fa000000-fa0fffff : Intel Corp. 82557 [Ethernet Pro 100] 
fa100000-fa100fff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 
  fa100000-fa100fff : aic7xxx 
fa101000-fa101fff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2) 
  fa101000-fa101fff : aic7xxx 
fa102000-fa102fff : Intel Corp. 82557 [Ethernet Pro 100] 
  fa102000-fa102fff : eepro100 
fa200000-faffffff : PCI Bus #01 
  fa200000-fa203fff : Matrox Graphics, Inc. MGA G550 AGP 
  fa800000-faffffff : Matrox Graphics, Inc. MGA G550 AGP 
fc000000-fdffffff : PCI Bus #01 
  fc000000-fdffffff : Matrox Graphics, Inc. MGA G550 AGP 
fec00000-fec0ffff : reserved 
fee00000-fee00fff : reserved 
fffeac00-ffffffff : reserved 

7.500:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
(rev 03) 
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step 
ping- SERR+ FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort+ >SERR- <PERR- 
        Latency: 64 
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
[size=256M] 
        Capabilities: [a0] AGP version 1.0 
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2 
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none> 

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev
03) (prog- 
if 00 [Normal decode]) 
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Step 
ping- SERR+ FastB2B- 
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 128 
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64 
        I/O behind bridge: 0000f000-00000fff 
        Memory behind bridge: fa200000-faffffff 
        Prefetchable memory behind bridge: fc000000-fdffffff 
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+ 

00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02) 
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Step 
ping- SERR- FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 0 

00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if
80 [Maste 
r]) 
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step 
ping- SERR- FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 32 
        Region 4: I/O ports at 1860 [size=16] 

00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if
00 [UHCI 
]) 
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step 
ping- SERR- FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 32 
        Interrupt: pin D routed to IRQ 19 
        Region 4: I/O ports at 1840 [size=32] 

00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02) 
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Step 
ping- SERR- FastB2B- 
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Interrupt: pin ? routed to IRQ 9 

00:05.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx /
AIC-7895 (rev 
04) 
        Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD
AIC-7895B 
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Step 
ping- SERR+ FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 64 (2000ns min, 2000ns max) 
        Interrupt: pin A routed to IRQ 18 
        Region 0: I/O ports at 1000 [disabled] [size=256] 
        Region 1: Memory at fa100000 (32-bit, non-prefetchable)
[size=4K] 
        Expansion ROM at <unassigned> [disabled] [size=64K] 
        Capabilities: [dc] Power Management version 1 
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot 
-,D3cold-) 
                Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:05.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx /
AIC-7895 (rev 
04) 
        Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD
AIC-7895B 
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Step 
ping- SERR+ FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 64 (2000ns min, 2000ns max) 
        Interrupt: pin B routed to IRQ 18 
        Region 0: I/O ports at 1400 [disabled] [size=256] 
        Region 1: Memory at fa101000 (32-bit, non-prefetchable)
[size=4K] 
        Capabilities: [dc] Power Management version 1 
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot 
-,D3cold-)                Status: D0 PME-Enable- DSel=0 DScale=0 PME- 

00:06.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev
08) 
        Subsystem: Hewlett-Packard Company: Unknown device 10ca 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Step 
ping- SERR+ FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 66 (2000ns min, 14000ns max), cache line size 08 
        Interrupt: pin A routed to IRQ 19 
        Region 0: Memory at fa102000 (32-bit, non-prefetchable)
[size=4K] 
        Region 1: I/O ports at 1800 [size=64] 
        Region 2: Memory at fa000000 (32-bit, non-prefetchable)
[size=1M] 
        Expansion ROM at <unassigned> [disabled] [size=1M] 
        Capabilities: [dc] Power Management version 2 
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot 
+,D3cold-) 
                Status: D0 PME-Enable- DSel=0 DScale=2 PME- 

00:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
(prog-i 
f 00 [Normal decode]) 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Step 
ping- SERR+ FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 57, cache line size 08 
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=52 
        I/O behind bridge: 00009000-00009fff 
        Memory behind bridge: fff00000-000fffff 
        Prefetchable memory behind bridge:
00000000fff00000-0000000000000000 
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B- 
        Capabilities: [dc] Power Management version 1 
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA
PME(D0-,D1-,D2-,D3h 
ot-,D3cold-) 
                Status: D0 PME-Enable- DSel=0 DScale=0 PME- 
                Bridge: PM- B3+ 

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP
(rev 01) ( 
prog-if 00 [VGA]) 
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR
32Mb 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step 
ping- SERR- FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort 
- <MAbort- >SERR- <PERR- 
        Latency: 128 (4000ns min, 8000ns max), cache line size 08 
        Interrupt: pin A routed to IRQ 16 
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M] 
        Region 1: Memory at fa200000 (32-bit, non-prefetchable)
[size=16K] 
        Region 2: Memory at fa800000 (32-bit, non-prefetchable)
[size=8M] 
        Expansion ROM at <unassigned> [disabled] [size=128K] 
        Capabilities: [dc] Power Management version 2 
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot 
-,D3cold-) 
                Status: D0 PME-Enable- DSel=0 DScale=0 PME- 
        Capabilities: [f0] AGP version 2.0 
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2 
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1 

02:02.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02) 
        Subsystem: Ensoniq: Unknown device 2003 
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step 
ping- SERR+ FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ 
<MAbort- >SERR- <PERR- 
        Latency: 96 (3000ns min, 32000ns max) 
        Interrupt: pin A routed to IRQ 18 
        Region 0: I/O ports at 9000 [size=64] 
        Capabilities: [dc] Power Management version 1 
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot 
-,D3cold-) 
                Status: D0 PME-Enable- DSel=0 DScale=0 PME- 


7.6 
Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00 
  Vendor: HP       Model: 9.10GB B 68-8C02 Rev:     
  Type:   Direct-Access                    ANSI SCSI revision: 02 

7.7 
Not sure what else woudl be needed 

8 
this is my strace output from `strace modprobe agpgart` 
------------------------------------------------------------- 
execve("/sbin/modprobe", ["modprobe", "agpgart"], [/* 14 vars */]) = 0 
uname({sys="Linux", node="mycomp", ...}) = 0 
brk(0)                                  = 0x805dd20 
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory) 
open("/etc/ld.so.cache", O_RDONLY)      = 3 
fstat64(3, {st_mode=S_IFREG|0644, st_size=38361, ...}) = 0 
old_mmap(NULL, 38361, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000 
close(3)                                = 0 
open("/lib/libc.so.6", O_RDONLY)        = 3 
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0H\222\1"...,
1024) = 102 
4 
fstat64(3, {st_mode=S_IFREG|0755, st_size=1153816, ...}) = 0 
old_mmap(NULL, 1166592, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x4001e000 
mprotect(0x40131000, 40192, PROT_NONE)  = 0 
old_mmap(0x40131000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x11 
3000) = 0x40131000 
old_mmap(0x40137000, 15616, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANON 
YMOUS, -1, 0) = 0x40137000 
close(3)                                = 0 
munmap(0x40014000, 38361)               = 0 
getuid32()                              = 0 
geteuid32()                             = 0 
uname({sys="Linux", node="mycomp", ...}) = 0 
brk(0)                                  = 0x805dd20 
brk(0x805dd40)                          = 0x805dd40 
brk(0x805e000)                          = 0x805e000 
brk(0x805f000)                          = 0x805f000 
brk(0x8060000)                          = 0x8060000 
brk(0x8061000)                          = 0x8061000 
brk(0x8062000)                          = 0x8062000 
open("/etc/modules.conf", O_RDONLY)     = 3 
fstat64(3, {st_mode=S_IFREG|0644, st_size=4454, ...}) = 0 
stat64("/etc/modules.conf", {st_mode=S_IFREG|0644, st_size=4454, ...}) =
0 
stat64("/etc/conf.modules", 0xbfffad9c) = -1 ENOENT (No such file or
directory) 
fstat64(3, {st_mode=S_IFREG|0644, st_size=4454, ...}) = 0 
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0 
x40014000 
read(3, "### This file is automatically g"..., 4096) = 4096 
brk(0x8063000)                          = 0x8063000 
read(3, "c/init.d/setserial modsave  > /d"..., 4096) = 358 
read(3, "", 4096)                       = 0 
close(3)                                = 0 
munmap(0x40014000, 4096)                = 0 
open("/lib/modules/2.4.18/modules.dep", O_RDONLY) = 3 
fstat64(3, {st_mode=S_IFREG|0644, st_size=108, ...}) = 0 
fstat64(3, {st_mode=S_IFREG|0644, st_size=108, ...}) = 0 
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0 
x40014000 
read(3, "/lib/modules/2.4.18/kernel/drive"..., 4096) = 108 
read(3, "", 4096)                       = 0 
close(3)                                = 0 
munmap(0x40014000, 4096)                = 0 
query_module(NULL, 0, NULL, 0)          = 0 
query_module(NULL, QM_MODULES, { /* 0 entries */ }, 0) = 0 
chdir("/var/log/ksymoops")              = 0 
time(NULL)                              = 1019615771 
open("/etc/localtime", O_RDONLY)        = 3 
fstat64(3, {st_mode=S_IFREG|0644, st_size=1267, ...}) = 0 
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0 
x40014000 
read(3, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0"...,
4096) = 126 
7 
close(3)                                = 0 
munmap(0x40014000, 4096)                = 0 
open("20020423.log", O_WRONLY|O_APPEND|O_CREAT, 0666) = 3 
fstat64(3, {st_mode=S_IFREG|0644, st_size=6070, ...}) = 0 
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0 
x40014000 
fstat64(3, {st_mode=S_IFREG|0644, st_size=6070, ...}) = 0 
_llseek(3, 6070, [6070], SEEK_SET)      = 0 
write(3, "20020423 223611 start modprobe a"..., 50) = 50 
fdatasync(3)                            = 0 
close(3)                                = 0 
munmap(0x40014000, 4096)                = 0 
open("/lib/modules/2.4.18/kernel/drivers/char/agp/agpgart.o", O_RDONLY)
= 3 
flock(3, LOCK_EX)                       = 0 
query_module(NULL, 0, NULL, 0)          = 0 
query_module(NULL, QM_MODULES, { /* 0 entries */ }, 0) = 0 
brk(0x8068000)                          = 0x8068000 
query_module(NULL, QM_SYMBOLS, 0x80628c0, 16384, 48653) = -1 ENOSPC (No
space le 
ft on device) 
brk(0x8074000)                          = 0x8074000 
query_module(NULL, QM_SYMBOLS, { /* 1294 entries */ }, 1294) = 0 
lseek(3, 0, SEEK_SET)                   = 0 
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"...,
52) = 52 
lseek(3, 33428, SEEK_SET)               = 33428 
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
840) = 840 
brk(0x807b000)                          = 0x807b000 
lseek(3, 64, SEEK_SET)                  = 64 
read(3, "\213T$\4\241\30\0\0\0\205\300u\0041\300\303\303\213@\20"...,
25824) = 2 
5824 
lseek(3, 34268, SEEK_SET)               = 34268 
read(3, "\5\0\0\0\1\17\0\0^\0\0\0\1\17\0\0\350\0\0\0\2\26\1\0\364"...,
14672) = 
14672 
lseek(3, 25888, SEEK_SET)               = 25888 
read(3, "\301\341\2\3518\20\0\0\301\341\2A\351D\20\0\0\301\341\2"...,
160) = 160 
lseek(3, 48940, SEEK_SET)               = 48940 
read(3, "\4\0\0\0\2\1\0\0\r\0\0\0\2\1\0\0\30\0\0\0\2\1\0\0$\0\0"...,
104) = 104 
lseek(3, 26048, SEEK_SET)               = 26048 
read(3, "/home/abrotman/kernel/linux/incl"..., 4128) = 4128 
lseek(3, 49044, SEEK_SET)               = 49044 
read(3, "\20\4\0\0\1\1\0\0\24\4\0\0\1\1\0\0\30\4\0\0\1\1\0\0\34"...,
528) = 528 
lseek(3, 30176, SEEK_SET)               = 30176 
read(3, "kernel_version=2.4.18\0using_chec"..., 288) = 288 
lseek(3, 30464, SEEK_SET)               = 30464 
read(3, ":\20\0\0\0\0\0\0E\20\0\0\10\0\0\0G\20\0\0\v\0\0\0U\20\0"...,
168) = 168 
lseek(3, 49572, SEEK_SET)               = 49572 
read(3, "\0\0\0\0\1\1\0\0\4\0\0\0\1\3\0\0\10\0\0\0\1\1\0\0\f\0\0"...,
336) = 336 
lseek(3, 30656, SEEK_SET)               = 30656 
read(3, "agp_free_memory_Rsmp_48653576\0\0\0"..., 320) = 320 
lseek(3, 30976, SEEK_SET)               = 30976 
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64)
= 64 
lseek(3, 49908, SEEK_SET)               = 49908 
read(3, "\0\0\0\0\1#\1\0\4\0\0\0\1\370\0\0\10\0\0\0\1\20\1\0\f\0"...,
128) = 128 
brk(0x807c000)                          = 0x807c000 
lseek(3, 31040, SEEK_SET)               = 31040 
read(3, "\0\0\0\0\0\0\0\0|\17\0\0\204\17\0\0\0\0\0\0\0\0\0\0\200"...,
2112) = 21 
12 
lseek(3, 50036, SEEK_SET)               = 50036 
read(3, "\0\0\0\0\1\350\0\0\4\0\0\0\1\371\0\0\10\0\0\0\1\1\0\0\f"...,
1136) = 11 
36 
lseek(3, 33152, SEEK_SET)               = 33152 
read(3, "\0GCC: (GNU) 2.95.4 20011002 (Deb"..., 96) = 96 
lseek(3, 33288, SEEK_SET)               = 33288 
read(3, "\0.symtab\0.strtab\0.shstrtab\0.rel."..., 137) = 137 
brk(0x807e000)                          = 0x807e000 
lseek(3, 51172, SEEK_SET)               = 51172 
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4784) = 478 
4 
brk(0x8080000)                          = 0x8080000 
lseek(3, 55956, SEEK_SET)               = 55956 
read(3, "\0agpgart_fe.c\0gcc2_compiled.\0__m"..., 6089) = 6089 
brk(0x8081000)                          = 0x8081000 
brk(0x8082000)                          = 0x8082000 
brk(0x8083000)                          = 0x8083000 
open("/proc/sys/kernel/tainted", O_RDWR) = 4 
close(4)                                = 0 
lstat64("/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0 
lstat64("/lib/modules", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0 
lstat64("/lib/modules/2.4.18", {st_mode=S_IFDIR|0755, st_size=4096,
...}) = 0 
lstat64("/lib/modules/2.4.18/kernel", {st_mode=S_IFDIR|0755,
st_size=4096, ...}) 
= 0 
lstat64("/lib/modules/2.4.18/kernel/drivers", {st_mode=S_IFDIR|0755,
st_size=409 
6, ...}) = 0 
lstat64("/lib/modules/2.4.18/kernel/drivers/char",
{st_mode=S_IFDIR|0755, st_siz 
e=4096, ...}) = 0 
lstat64("/lib/modules/2.4.18/kernel/drivers/char/agp",
{st_mode=S_IFDIR|0755, st 
_size=4096, ...}) = 0 
lstat64("/lib/modules/2.4.18/kernel/drivers/char/agp/agpgart.o",
{st_mode=S_IFRE 
G|0644, st_size=62045, ...}) = 0 
stat64("/lib/modules/2.4.18/kernel/drivers/char/agp/agpgart.o",
{st_mode=S_IFREG 
|0644, st_size=62045, ...}) = 0 
create_module("agpgart", 33504)         = 0xe084f000 
brk(0x808c000)                          = 0x808c000 
init_module("agpgart", 0x80825e0 
------------------------------------------------------------------- 


