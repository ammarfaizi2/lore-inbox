Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSIHReq>; Sun, 8 Sep 2002 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSIHReq>; Sun, 8 Sep 2002 13:34:46 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:8350 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317351AbSIHRen>; Sun, 8 Sep 2002 13:34:43 -0400
Date: Sun, 8 Sep 2002 13:39:41 -0400
From: Ludwig <ludwig@superdeluxe.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Compile error drm/tdfx
Message-Id: <20020908133941.785563e3.ludwig@superdeluxe.com>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:  
  
Compile error

[2.] Full description of the problem/report:

make[4]: Entering directory `/usr/src/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/src/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=tdfx_drv  -c -o tdfx_drv.o tdfx_drv.c
In file included from tdfx_drv.c:108:
drm_memory.h: In function `tdfx_ioremap_agp':
drm_memory.h:327: warning: unused variable `i'
drm_memory.h:327: warning: unused variable `err'
drm_memory.h:326: warning: unused variable `flags'
drm_memory.h:325: warning: unused variable `agpmem'
drm_memory.h:324: warning: unused variable `area'
drm_memory.h:323: warning: unused variable `pt'
In file included from tdfx_drv.c:110:
drm_vm.h: In function `tdfx_mmap':
drm_vm.h:382: structure has no member named `agp'
drm_vm.h:383: structure has no member named `agp'
drm_vm.h:424: structure has no member named `agp'
drm_vm.h:426: structure has no member named `agp'
make[4]: *** [tdfx_drv.o] Error 1
make[4]: Leaving directory `/usr/src/drivers/char/drm'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/drivers/char/drm'
make[2]: *** [_subdir_drm] Error 2
make[2]: Leaving directory `/usr/src/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/drivers'
make: *** [_dir_drivers] Error 2

[3.] Keywords (i.e., modules, networking, kernel):

drm, tdfx

[4.] Kernel version (from /proc/version):

Linux version 2.4.19-ben0 (root@suspectdevice) (gcc version 2.95.4 20011002 (Debian prerelease)) #5 Mon Aug 19 06:56:20 EDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux suspectdevice.dyndns.org 2.4.19-ben0 #5 Mon Aug 19 06:56:20 EDT 2002 ppc unknown unknown GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12
Modules Loaded         bsd_comp macserial slip hfs

[7.2.] Processor information (from /proc/cpuinfo):

cpu             : 740/750
temperature     : 43-45 C (uncalibrated)
clock           : 195MHz
revision        : 2.2 (pvr 0008 0202)
bogomips        : 548.86
machine         : Power Macintosh
motherboard     : AAPL,???? MacRISC
detected as     : 16 (Unknown PowerSurge)
pmac flags      : 00000000
L2 cache        : 512K unified
memory          : 176MB
pmac-generation : OldWorld

[7.3.] Module information (from /proc/modules):

bsd_comp                4512   0 (autoclean)
macserial              38868   2 (autoclean)
slip                   10352   2 (autoclean)
hfs                    79788   1 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

00000000-007fffff : /bandit
  00001000-000010ff : 3Dfx Interactive, Inc. Voodoo 3
  00001400-0000140f : Artop Electronic Corp ATP850UF
    00001400-00001407 : ide2
    00001408-0000140f : ide3
  00001410-00001413 : Artop Electronic Corp ATP850UF
    00001412-00001412 : ide3
  00001420-00001427 : Artop Electronic Corp ATP850UF
    00001420-00001427 : ide3
  00001430-00001433 : Artop Electronic Corp ATP850UF
    00001432-00001432 : ide2
  00001440-00001447 : Artop Electronic Corp ATP850UF
    00001440-00001447 : ide2

80000000-9fffffff : /bandit
  80800000-808fffff : PCI Bus #01
    80800000-80800fff : OPTi Inc. 82C861
      80800000-80800fff : usb-ohci
  82000000-83ffffff : 3Dfx Interactive, Inc. Voodoo 3
  90000000-91ffffff : 3Dfx Interactive, Inc. Voodoo 3
    90b00000-91efffff : offb
f3000000-f3ffffff : /bandit
  f3000000-f301ffff : Apple Computer Inc. Grand Central I/O
    f3008200-f30082ff : mace (mace tx dma)
    f3008300-f30083ff : mace (mace tx dma)
    f3008400-f30084ff : ch-a (tx dma)
    f3008500-f30085ff : ch-a (rx dma)
    f3008600-f30086ff : ch-b (tx dma)
    f3008700-f30087ff : ch-b (rx dma)
    f3011000-f3011fff : mace (mace)
    f3013000-f301301f : ch-b
    f3013020-f301303f : ch-a
    f3016000-f3017fff : via-cuda
f8000000-f80007ff : hammerhead

[7.5.] PCI information ('lspci -vvv' as root)

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin ? routed to IRQ 22

00:0d.0 SCSI storage controller: Artop Electronic Corp ATP850UF (rev 03)
        Subsystem: Artop Electronic Corp ATP850UF
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at 1440 [size=8]
        Region 1: I/O ports at 1430 [size=4]
        Region 2: I/O ports at 1420 [size=8]
        Region 3: I/O ports at 1410 [size=4]
        Region 4: I/O ports at 1400 [size=16]
        Expansion ROM at 80920000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo 3
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at 82000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at 90000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at 1000 [size=256]
        Expansion ROM at 80900000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00000fff
        Memory behind bridge: 80800000-808fffff
        Prefetchable memory behind bridge: 80800000-807fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32, cache line size 08
        Interrupt: pin ? routed to IRQ 22
        Region 0: Memory at f3000000 (32-bit, non-prefetchable) [size=128K]

01:02.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 25
        Region 0: Memory at 80800000 (32-bit, non-prefetchable) [size=4K]

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL SE2.1S  Rev: PJ09
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: HP       Model: C1533A           Rev: 9503
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: MATSHITA Model: CD-ROM CR-506    Rev: 8S05
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: J.03
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
