Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281201AbRKLBQH>; Sun, 11 Nov 2001 20:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281204AbRKLBP7>; Sun, 11 Nov 2001 20:15:59 -0500
Received: from mail.gmx.de ([213.165.64.20]:16273 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281201AbRKLBPp>;
	Sun, 11 Nov 2001 20:15:45 -0500
Date: Sat, 10 Nov 2001 15:37:44 +0100
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Couldn't umount swap because of oops
Message-ID: <20011110143744.GA874@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23.2i
X-Operating-System: Linux 2.4.14 i686
X-Editor: VIM - Vi IMproved 6.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Couldn't umount swap because of oops


[2.] Full description of the problem/report:

I got a kernel error when shutting down X. Because of that, swap
couldn't get umounted during shutdown of the machine.


[3.] Keywords:

X, swap


[4.] Kernel version (from /proc/version):

mahowi@marvin:~ > cat /proc/version
Linux version 2.4.14 (root@marvin) (gcc version 2.95.2 19991024
(release)) #2 Thu Nov 8 00:20:49 CET 2001


[5.] Output of Oops.. message:

ksymoops 2.4.0 on i686 2.4.14.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map (specified)

Warning (expand_objects): object /lib/modules/2.4.14/kernel/drivers/net/8139too.o for module 8139too has changed since load
Warning (expand_objects): object /lib/modules/2.4.14/kernel/drivers/scsi/ide-scsi.o for module ide-scsi has changed since load
Warning (expand_objects): object /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o for module aic7xxx has changed since load
Warning (expand_objects): object /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o for module scsi_mod has changed since load
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says c8d46c80, /lib/modules/2.4.14/kernel/net/packet/af_packet.o says c8d46a64.  Ignoring /lib/modules/2.4.14/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says c88ee0a0, /lib/modules/2.4.14/kernel/net/unix/unix.o says c88edcc0.  Ignoring /lib/modules/2.4.14/kernel/net/unix/unix.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_detect_complete  , aic7xxx says c882f5c4, /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o says c882ce84.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_no_probe  , aic7xxx says c882f5c0, /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o says c882ce80.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_periodic_otag  , aic7xxx says c882f5d0, /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o says c882ce90.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_verbose  , aic7xxx says c882f5c8, /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o says c882ce88.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says c8814824, /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o says c8812ffc.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says c8814850, /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o says c8813028.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says c881484c, /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o says c8813024.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says c8814854, /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o says c881302c.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says c8814820, /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o says c8812ff8.  Ignoring /lib/modules/2.4.14/kernel/drivers/scsi/scsi_mod.o entry
Nov 10 05:19:33 marvin kernel: invalid operand: 0000
Nov 10 05:19:33 marvin kernel: CPU:    0
Nov 10 05:19:33 marvin kernel: EIP:    0010:[__free_pages_ok+69/496]    Not tainted
Nov 10 05:19:33 marvin kernel: EFLAGS: 00013202
Nov 10 05:19:33 marvin kernel: eax: 00000009   ebx: c108e6c0   ecx: c108e6c0   edx: 00000000
Nov 10 05:19:33 marvin kernel: esi: c108e6c0   edi: 00000000   ebp: 085c4000   esp: c28efee8
Nov 10 05:19:33 marvin kernel: ds: 0018   es: 0018   ss: 0018
Nov 10 05:19:33 marvin kernel: Process X (pid: 5210, stackpage=c28ef000)
Nov 10 05:19:33 marvin kernel: Stack: c108e6c0 c108e6c0 00209000 085c4000 00209000 c0128e85 c023af20 c023af20 
Nov 10 05:19:33 marvin kernel:        c012726d c01286d3 00209000 c0128a4d 00209000 c023af20 c108e6c0 c0129059 
Nov 10 05:19:33 marvin kernel:        c108e6c0 0023c000 00206000 c300ff28 c011f5c6 00209000 c3236960 c495b960 
Nov 10 05:19:33 marvin kernel: Call Trace: [swap_free+37/44] [lru_cache_del+5/8] [page_cache_release+59/64] [delete_from_swap_cache+53/60] [free_swap_and_cache+105/136] 
Nov 10 05:19:33 marvin kernel: Code: 0f 0b 8b 43 18 a9 40 00 00 00 74 02 0f 0b 8b 43 18 a9 80 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000005 Before first symbol
   5:   a9 40 00 00 00            test   $0x40,%eax
Code;  0000000a Before first symbol
   a:   74 02                     je     e <_EIP+0xe> 0000000e Before first symbol
Code;  0000000c Before first symbol
   c:   0f 0b                     ud2a   
Code;  0000000e Before first symbol
   e:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000011 Before first symbol
  11:   a9 80 00 00 00            test   $0x80,%eax


15 warnings issued.  Results may not be reliable.


[7.] Environment
[7.1.] Software:


If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux marvin 2.4.14 #2 Thu Nov 8 00:20:49 CET 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10s
mount                  2.10s
modutils               2.4.6
e2fsprogs              1.19
reiserfsprogs          3.x.0k-pre10
PPP                    2.4.1
Linux C Library        x    1 root     root      1382179 Jan 19  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         af_packet parport_pc lp parport autofs4 serial isa-pnp unix 8139too ide-scsi aic7xxx scsi_mod


[7.2.] Processor information (from /proc/cpuinfo):

mahowi@marvin:~ > cat /proc/cpuinfo
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 6
model           : 2
model name      : 6x86MX 2.5x Core/Bus Clock
stepping        : 6
cpu MHz         : 167.048
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
bogomips        : 333.41


[7.3.] Module information (from /proc/modules):

mahowi@marvin:~ > cat /proc/modules
af_packet              11488   1 (autoclean)
parport_pc             21088   0 (autoclean)
parport                24128   0 (autoclean) [parport_pc]
autofs4                 8032   1 (autoclean)
unix                   13632  75 (autoclean)
8139too                13216   1
ide-scsi                7472   0
aic7xxx               104816   0 (unused)
scsi_mod               84064   2 [ide-scsi aic7xxx]


[7.4.] Loaded driver and hardware information (/proc/ioports,
       /proc/iomem)

mahowi@marvin:~ > cat /proc/ioports
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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0778-077a : parport0
0cf8-0cff : PCI conf1
6000-60ff : Adaptec AIC-7861
  6000-60ff : aic7xxx
6500-65ff : Realtek Semiconductor Co., Ltd. RTL-8139
  6500-65ff : 8139too
f000-f00f : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
  f000-f007 : ide0
  f008-f00f : ide1

mahowi@marvin:~ > cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001cded5 : Kernel code
  001cded6-001fd0f3 : Kernel data
e0000000-e1ffffff : nVidia Corporation Vanta [NV6]
e2000000-e2ffffff : nVidia Corporation Vanta [NV6]
e3000000-e3000fff : Adaptec AIC-7861
  e3000000-e3000fff : aic7xxx
e3001000-e30010ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e3001000-e30010ff : 8139too
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

mahowi@marvin:~ > su -c "lspci -vvv"
Password:
00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:08.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6000 [disabled] [size=256]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Allied Telesyn International: Unknown device 2503
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 6500 [size=256]
        Region 1: Memory at e3001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
        Subsystem: Creative Labs: Unknown device 1039
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

mahowi@marvin:~ > cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: TANDBERG Model:  TDC 3600        Rev: =08:
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: C.19
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: SCANNER  Model:                  Rev: 1.01
  Type:   Scanner                          ANSI SCSI revision: 01 CCS
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: CD-W54E          Rev: 1.1Y
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem:

mahowi@marvin:~ > cat /proc/filesystems
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
nodev   binfmt_misc
        ext2
        reiserfs
nodev   devpts
nodev   autofs

mahowi@marvin:~ > cat /proc/mounts
/dev/root / reiserfs rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda3 /usr reiserfs rw 0 0
/dev/hda5 /opt reiserfs rw 0 0
/dev/hda6 /var reiserfs rw 0 0
/dev/hda7 /usr/local reiserfs rw 0 0
/dev/hdb1 /var/spool reiserfs rw 0 0
/dev/hdb3 /home reiserfs rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
tmpfs /tmp tmpfs rw 0 0
automount(pid253) /misc autofs rw 0 0

mahowi@marvin:~ > cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/hdb2                       partition       131536  0       -1


[8.] Other notes:

XFree86 Version 4.0.2 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 18 December 2000
        If the server is older than 6-12 months, or if your card is
        newer than the above date, look for a newer version before
        reporting problems.  (See http://www.XFree86.Org/FAQ)
Operating System: SuSE Linux [ELF] SuSE

[...]

(II) Open APM successful
(II) Module ABI versions:
        XFree86 ANSI C Emulation: 0.1
        XFree86 Video Driver: 0.3
        XFree86 XInput driver : 0.1
        XFree86 Server Extension : 0.1
        XFree86 Font Renderer : 0.2
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        Module class: XFree86 Font Renderer
        ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 0.1.0
        ABI class: XFree86 Video Driver, version 0.3
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x80000058, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,7030 card 0000,0000 rev 02 class 06,00,00 hdr 00
(II) PCI: 00:07:0: chip 8086,7000 card 0000,0000 rev 01 class 06,01,00 hdr 80
(II) PCI: 00:07:1: chip 8086,7010 card 0000,0000 rev 00 class 01,01,80 hdr 00
(II) PCI: 00:08:0: chip 9004,6178 card 0000,0000 rev 01 class 01,00,00 hdr 00
(II) PCI: 00:09:0: chip 10ec,8139 card 1259,2503 rev 10 class 02,00,00 hdr 00
(II) PCI: 00:0a:0: chip 10de,002c card 1102,1039 rev 15 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 0.1.0
        ABI class: XFree86 Video Driver, version 0.3
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(II) Host-to-PCI bridge:
(II) PCI-to-ISA bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x00 (VGA_EN is cleared)
(II) Bus 0 I/O range:
        [0] -1  0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
        [0] -1  0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
        [0] -1  0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus -1: bridge is at (0:7:0), (0,-1,0), BCTRL: 0x00 (VGA_EN is cleared)
(II) Bus -1 I/O range:
(II) Bus -1 non-prefetchable memory range:
(II) Bus -1 prefetchable memory range:
(--) PCI:*(0:10:0) NVidia Riva Vanta rev 21, Mem @ 0xe2000000/24, 0xe0000000/25

[...]

(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        Module class: XFree86 Server Extension
        ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        Module class: XFree86 Font Renderer
        ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        Module class: XFree86 Font Renderer
        ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font Speedo
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        Module class: XFree86 Server Extension
        ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.1.8
        Module class: XFree86 Font Renderer
        ABI class: XFree86 Font Renderer, version 0.2
(II) Loading font FreeType
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "pex5"
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        Module class: XFree86 Server Extension
        ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension X3D-PEX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.13.0
        Module class: XFree86 Server Extension
        ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.so
(II) Module glx: vendor="NVIDIA Corporation"
        compiled for 4.0.2, module version = 1.0.1541
        Module class: XFree86 Server Extension
        ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension GLX
(II) LoadModule: "nvidia"
(II) Loading /usr/X11R6/lib/modules/drivers/nvidia_drv.o
(II) Module nvidia: vendor="NVIDIA Corporation"
        compiled for 4.0.2, module version = 1.0.1541
        Module class: XFree86 Video Driver
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        Module class: XFree86 XInput Driver
        ABI class: XFree86 XInput driver, version 0.1
(II) NVIDIA: NVIDIA driver for: RIVA TNT, RIVA TNT2, RIVA TNT2 Ultra,
        RIVA TNT2 Vanta, RIVA TNT2 M64, RIVA TNT2 0x002E, RIVA TNT2 0x002F,
        RIVA Aladdin TNT2, GeForce 256, GeForce DDR, Quadro, GeForce2 MX,
        GeForce2 MX 100/200, GeForce2 Go, GeForce2 MXR, GeForce2 GTS,
        GeForce2, GeForce2 Ultra, Quadro2 Pro, GeForce3, GeForce3, GeForce3,
        Quadro DCC
(II) Primary Device is: PCI 00:0a:0
(--) Chipset RIVA TNT2 Vanta found

[...]

(II) Module vgahw: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 0.1.0
        ABI class: XFree86 Video Driver, version 0.3
(**) NVIDIA(0): Depth 16, (--) framebuffer bpp 16
(==) NVIDIA(0): RGB weight 565
(==) NVIDIA(0): Default visual is TrueColor
(==) NVIDIA(0): Using gamma correction (1.0, 1.0, 1.0)
(**) NVIDIA(0): Option "NoLogo" "1"
(**) NVIDIA(0): Option "NvAGP" "0"
(**) NVIDIA(0): Option "IgnoreEDID" "1"
(**) NVIDIA(0): Use of AGP disabled per request
(**) NVIDIA(0): Ignoring EDIDs
(--) NVIDIA(0): Linear framebuffer at 0xE0000000
(--) NVIDIA(0): MMIO registers at 0xE2000000
(==) NVIDIA(0): Removed MMIO write-combining range (0xa0000,0x20000)
(==) NVIDIA(0): Removed MMIO write-combining range (0xa8000,0x8000)
(--) NVIDIA(0): VideoRAM: 32768 kBytes

[...]

(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        ABI class: XFree86 ANSI C Emulation, version 0.1
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 1.0.0
        ABI class: XFree86 Video Driver, version 0.3
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
        compiled for 4.0.2, module version = 0.1.0
        ABI class: XFree86 Video Driver, version 0.3
Symbol xf86PrintEDID from module /usr/X11R6/lib/modules/drivers/nvidia_drv.o is
unresolved!
Symbol xf86InterpretEDID from module /usr/X11R6/lib/modules/drivers/nvidia_drv.o is unresolved!
(II) do I need RAC?  No, I don't.

[...]

(==) NVIDIA(0): Write-combining range (0xe0000000,0x2000000)
(II) NVIDIA(0): Setting mode "1024x768"
(II) NVIDIA(0): Using XFree86 Acceleration Architecture (XAA)
        Screen to screen bit blits
        Solid filled rectangles
        Solid filled trapezoids
        8x8 mono pattern filled rectangles
        8x8 mono pattern filled trapezoids
        Indirect CPU to Screen color expansion
        Solid Lines
        Scanline Image Writes
        Offscreen Pixmaps
        Driver provided FillSolidRects replacement
        Driver provided FillSolidSpans replacement
        Driver provided FillMono8x8PatternRects replacement
        Driver provided ReadPixmap replacement
        Setting up tile and stipple cache:
                16 128x128 slots
                4 256x256 slots
(==) NVIDIA(0): Backing store disabled
(==) NVIDIA(0): Silken mouse enabled
(**) Option "dpms"
(**) NVIDIA(0): DPMS enabled
(II) Loading extension NV-GLX
(WW) NVIDIA(0): Option "OverridePolarity" is not used
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension RENDER
(II) [GLX]: Calling GlxExtensionInit
(II) [GLX]: associated 8 out of 8 GLX visuals


Bye,

Manfred
-- 
 /"\                        |  *  AIM: mahowi42  *  ICQ: 61597169  *
 \ /  ASCII ribbon campaign | PGP-Key available at Public Key Servers
  X   against HTML mail     | or "http://www.mahowi.de/pgp/mahowi.asc"
 / \  and postings          |  * RSA: 0xC05BC0F5 * DSS: 0x4613B5CA *
