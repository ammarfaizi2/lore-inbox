Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbQLIFHg>; Sat, 9 Dec 2000 00:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQLIFH0>; Sat, 9 Dec 2000 00:07:26 -0500
Received: from pop.gmx.net ([194.221.183.20]:29563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129610AbQLIFHN>;
	Sat, 9 Dec 2000 00:07:13 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Sat, 9 Dec 2000 05:34:27 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10012081536440.11892-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10012081536440.11892-100000@coffee.psychology.mcmaster.ca>
Subject: Re: kernel bug with 2.4.0-test12pre7 at startup
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00120905342700.00877@nmb>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

if more / other information is needed let me know.
I'll try to go through the points as described  in 
/usr/src/linux/REPORTING-BUGS:

[1.] Bug reported on system startup.

[2.] no obvious problem detected besides this message
      besides apic errors on both CPUs.

[3.] kernel BUG at buffer.c:827!  - invalid operand: 0000  - CPU:    0

[4.] Linux version 2.4.0-test11 (root@nmb) (gcc version 2.95.2 19991024 
(release)) #1 SMP 

[5.] output on system startup:
---------------------------- snip  --------------------------------------
kernel BUG at buffer.c:827!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0134296>]
EFLAGS: 00010286
eax: 0000001c   ebx: c7e78d40   ecx: c0267668   edx: c0267668
esi: c1219768   edi: 00000202   ebp: c7e78d88   esp: c7ea1bd8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 7, stackpage=c7ea1000)
Stack: c02249c5 c0224cfa 0000033b c12b1780 c1296c00 c7e76800 c7e78d40 c016f059
       c7e78d40 00000001 c7e78d40 00000001 00000004 0000002c c016785c c02dbea8
       00000000 c7e78d40 c7e78d40 00000001 00000000 c7ea1c84 c01679d3 00000000
Call Trace: [<c02249c5>] [<c0224cfa>] [<c016f059>] [<c016785c>] [<c01679d3>] 
[<c0135674>] [<c012e823>]
       [<c0155517>] [<c0154dd8>] [<c0126623>] [<c012694b>] [<c0126880>] 
[<c013ba08>] [<c013c06d>] [<c014b0ad>]
       [<c014af10>] [<c0147cad>] [<c0126873>] [<c013c1ee>] [<c0215cad>] 
[<c013c49b>] [<c013c4b2>] [<c010954b>]
       [<c010abf7>] [<c0215cba>] [<c01070c5>] [<c0215cba>] [<c0109130>] 
[<c0215cba>]
Code: 0f 0b 83 c4 0c 90 8d 74 26 00 8d 5e 28 8d 46 2c 39 46 2c 74

------------------------- snap -------------------------------------------

[6.] happens at every system-startup

[7.] appears after that:

---------------- snip ---------------------------------
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 1024 buckets, 8Kbytes
<4>TCP: Hash tables configured (established 8192 bind 8192)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem).
<4>kernel BUG at buffer.c:827!

-----------------snap --------------------------------

[7.2] Processor information: /proc/cpuinfo :

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 200.458
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 399.77

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 200.458
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 400.59


[7.3] Module information: /proc/modules:

parport_pc             22864   1 (autoclean)
lp                      5168   1 (autoclean)
parport                29088   1 (autoclean) [parport_pc lp]
ppp_deflate            39616   0 (autoclean)
bsd_comp                4256   0 (autoclean)
ppp_async               6640   0 (autoclean)
ppp_generic            15552   0 (autoclean) [ppp_deflate bsd_comp ppp_async]
pnp                    50096   0
emu8k                  40128   0
opl3                   14496   0
sb                     35232   0
uart401                 8000   0 [sb]
midi                   30224   0 [pnp emu8k opl3 sb uart401]
soundbase             314480   0 [pnp emu8k opl3 sb uart401 midi]
sndshield              10336   0 [pnp emu8k opl3 sb uart401 midi soundbase]
ipv6                  147536  -1 (autoclean)
8139too                15712   1 (autoclean)
serial                 43152   0 (autoclean)


[7.4] Loaded driver information:
	- /proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0203-0203 : PnP read port
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : Sound Blaster 16
0376-0376 : ide1
0378-037a : parport0
0388-038b : OPL3/OPL2
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0620-0623 : sound driver (AWE32)
0778-077a : parport0
0a20-0a23 : sound driver (AWE32)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : sound driver (AWE32)
6000-60ff : Adaptec AIC-7880U
  6000-60fe : aic7xxx
6400-647f : Realtek Semiconductor Co., Ltd. RTL-8139
  6400-647f : eth0
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  f000-f007 : ide0
  f008-f00f : ide1

	- /proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cb7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00264767 : Kernel code
  00264768-0027a3df : Kernel data
e0000000-e07fffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
e0800000-e0803fff : Matrox Graphics, Inc. MGA 2064W [Millennium]
e0804000-e0804fff : Brooktree Corporation Bt878
e0805000-e0805fff : Brooktree Corporation Bt878
e0806000-e080607f : Realtek Semiconductor Co., Ltd. RTL-8139
  e0806000-e080607f : eth0
e0807000-e0807fff : Adaptec AIC-7880U
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5]  PCI information:

 lspci -vvv
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] 
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] 
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:08.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W 
[Millennium] (rev 01) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e0800000 (32-bit, non-prefetchable) [size=16K]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at e0804000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at e0805000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 6400 [size=128]
        Region 1: Memory at e0806000 (32-bit, non-prefetchable) [size=128]

00:0c.0 SCSI storage controller: Adaptec AIC-7880U
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at 6000 [size=256]
        Region 1: Memory at e0807000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

[7.6] SCSI information: /proc/scsi/scsi:


Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST15150N         Rev: 0022
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TEAC     Model: CD-R55S          Rev: 1.0L
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL_TM3200S Rev: 300X
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: E.03
  Type:   Direct-Access                    ANSI SCSI revision: 02


[7.7] a coredump was writen: /proc/kcore


[8.] output of sh ver_linux:

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux nmb 2.4.0-test11 #1 SMP Thu Dec 7 07:08:56 CET 2000 i586 unknown
Kernel modules         2.3.21
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4070534 Sep  5 18:07 
/lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         parport_pc lp parport ppp_deflate bsd_comp ppp_async 
ppp_generic pnp emu8k opl3 sb uart401 midi soundbase sndshield ipv6 8139too 
serial


[9.] there is nothing unusual besides KDE2.1 crashes more often than KDE2.0 . 
This may have other reason ;o).


=============================== END =========================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
