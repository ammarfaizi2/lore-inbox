Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292810AbSBVGPy>; Fri, 22 Feb 2002 01:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292811AbSBVGPp>; Fri, 22 Feb 2002 01:15:45 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:21759 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S292810AbSBVGPa>; Fri, 22 Feb 2002 01:15:30 -0500
Date: Thu, 21 Feb 2002 23:15:19 -0700
From: "James A. Lupo" <jalupo@attbi.com>
Message-Id: <200202220615.g1M6FJi5011845@home.attbi.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Compile of 8139too.c fails in kernel 2.4.18-rc3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

     Compile of 8139too.c fails in kernel 2.4.18-rc3


[2.] Full description of the problem/report:

     I applied patch-2.4.18-rc3 to kernel-source-2.4.17 and attempted
     to compile with RTL-8139 network card support enabled.  8139too.c
     failed to compile with the message:

gcc -D__KERNEL__ -I/mnt/syjet/src/kernel-source-2.4.18-rc3/include -Wall \
    -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
    -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 \
    -march=i686   -DKBUILD_BASENAME=8139too  -c -o 8139too.o 8139too.c
8139too.c: In function `rtl8139_init_one':
8139too.c:1014: structure has no member named `mii'
8139too.c:1020: structure has no member named `mii'
8139too.c:1021: structure has no member named `mii'
8139too.c:1025: structure has no member named `mii'
8139too.c: In function `rtl8139_open':
8139too.c:1282: structure has no member named `mii'
8139too.c:1282: structure has no member named `mii'
8139too.c: In function `rtl_check_media':
8139too.c:1315: structure has no member named `mii'
8139too.c:1321: structure has no member named `mii'
8139too.c: In function `rtl8139_thread_iter':
8139too.c:1513: structure has no member named `mii'
8139too.c:1516: structure has no member named `mii'
8139too.c:1517: structure has no member named `mii'
8139too.c:1524: structure has no member named `mii'
8139too.c: In function `rtl8139_weird_interrupt':
8139too.c:1977: structure has no member named `mii'
8139too.c:1978: structure has no member named `mii'
8139too.c:1979: structure has no member named `mii'
8139too.c: In function `netdev_ethtool_ioctl':
8139too.c:2242: structure has no member named `mii'
8139too.c:2255: structure has no member named `mii'
8139too.c:2261: structure has no member named `mii'
8139too.c:2266: structure has no member named `mii'
8139too.c: In function `netdev_ioctl':
8139too.c:2369: structure has no member named `mii'
8139too.c:2371: structure has no member named `mii'
make[3]: *** [8139too.o] Error 1
make[3]: Leaving directory `/mnt/syjet/src/kernel-source-2.4.18-rc3/drivers/net'make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/mnt/syjet/src/kernel-source-2.4.18-rc3/drivers/net'make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/mnt/syjet/src/kernel-source-2.4.18-rc3/drivers'
make: *** [_dir_drivers] Error 2

[3.] Keywords (i.e., modules, networking, kernel):

     kernel RTL-8139


[4.] Kernel version (from /proc/version):

     Linux version 2.4.18-pre9


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)


[6.] A small shell script or example program which triggers the
     problem (if possible)


[7.] Environment


[7.1.] Software (add the output of the ver_linux script here)

Linux egor.linux.home 2.4.18-pre9 #3 Thu Feb 7 20:45:32 MST 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         ad1816 sound soundcore


[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 3
model name	: Pentium II (Klamath)
stepping	: 3
cpu MHz		: 265.913
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips	: 530.84

       
[7.3.] Module information (from /proc/modules):

ad1816                  9088   1 (autoclean)
sound                  51596   1 (autoclean) [ad1816]
soundcore               3268   4 (autoclean) [sound]


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
01f0-01f7 : ide0
0213-0213 : isapnp read
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0500-050f : AD1816 Sound
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
f000-f0ff : Realtek Semiconductor Co., Ltd. RTL-8139
  f000-f0ff : 8139too
f480-f4ff : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  f480-f4ff : tulip
f800-f8ff : Adaptec AIC-7861
  f800-f8ff : aic7xxx
fc00-fcff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
ff80-ff9f : Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II]
ffa0-ffaf : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00232658 : Kernel code
  00232659-002a163f : Kernel data
fb000000-fbffffff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
ffbee000-ffbeefff : Adaptec AIC-7861
  ffbee000-ffbeefff : aic7xxx
ffbef000-ffbeffff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
fff7f800-fff7f8ff : Realtek Semiconductor Co., Ltd. RTL-8139
  fff7f800-fff7f8ff : 8139too
fff7fc00-fff7fc7f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  fff7fc00-fff7fc7f : tulip


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff80 [size=32]

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Addtron Technology Co, Inc.: Unknown device 1360
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 240 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at f000 [size=256]
	Region 1: Memory at fff7f800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 SCSI storage controller: Adaptec AIC-7861 (rev 03)
	Subsystem: Adaptec AHA-2940AU Single
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at f800 [disabled] [size=256]
	Region 1: Memory at ffbee000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
	Subsystem: Standard Microsystems Corp [SMC]: Unknown device 2007
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f480 [size=128]
	Region 1: Memory at fff7fc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:13.0 VGA compatible controller: ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB] (rev 9a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (2000ns min), cache line size 08
	Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at fc00 [size=256]
	Region 2: Memory at ffbef000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]


[7.6.] SCSI information (from /proc/scsi/scsi)

Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST410800N        Rev: 7101
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: HP       Model: C5110A           Rev: 3701
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SyQuest  Model: SyJet-S          Rev: 0111
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

     If I copy 8139too.c.org to 8139too.c and rerun "make bzImage",
     the compile completes and the kernel functions normally.



-- 
Jim
    ------------------- Optional Methods -----------------------
Dr James A. Lupo                          (303) 423-2652
9667 Independence Dr.                     jalupo@attbi.com
Westminster  CO  80021-6845               jalupo@regis.edu
