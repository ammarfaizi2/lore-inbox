Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269536AbRGaXot>; Tue, 31 Jul 2001 19:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269539AbRGaXok>; Tue, 31 Jul 2001 19:44:40 -0400
Received: from cs.wustl.edu ([128.252.165.15]:59086 "EHLO
	taumsauk.cs.wustl.edu") by vger.kernel.org with ESMTP
	id <S269536AbRGaXoY> convert rfc822-to-8bit; Tue, 31 Jul 2001 19:44:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15207.17026.200131.93642@samba.doc.wustl.edu>
Date: Tue, 31 Jul 2001 18:42:58 -0500
From: Krishnakumar B <kitty@cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel hang with 2.4.7-ac3
X-Mailer: VM 6.95 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I get the following kernel hang repeatably when using 2.4.7-ac3. I can
repeat it by switching to virtual console 2 (or any other than 7) and
pressing caps lock once or twice. It occured because I confused my caps
lock with control. The keyboard becomes inoperative and when I try to ssh
into this machine from another machine, I got the following output. I had
to manually write it down as using klogd to write didn't help. If I wait
for a few minutes (during the process of writing it down), I get the same
call trace again. The Stack Dumps are different between different boots but
the call trace is the same. I use a USB keyboard and a USB mouse.

-kitty.


Linux version 2.4.7-ac3 (root@samba) (gcc version 2.95.3 20010315 (release)) #2 SMP Mon Jul 30 14:16:15 CDT 2001

Ksymoops yields the following:

ksymoops 2.4.0 on i686 2.4.7-ac3.  Options used
     -v /u/scratch/downloads/kernel/linux-2.4.7-ac3/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-ac3/ (default)
     -m /boot/System.map-2.4.7-ac3 (specified)

Warning (compare_maps): mismatch on symbol mga_res_ctx  , mga says e095711c, /lib/modules/2.4.7-ac3/kernel/drivers/char/drm/mga.o says e095619c.  Ignoring /lib/modules/2.4.7-ac3/kernel/drivers/char/drm/mga.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says e0910834, /lib/modules/2.4.7-ac3/kernel/fs/lockd/lockd.o says e090fca0.  Ignoring /lib/modules/2.4.7-ac3/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says e0910830, /lib/modules/2.4.7-ac3/kernel/fs/lockd/lockd.o says e090fc9c.  Ignoring /lib/modules/2.4.7-ac3/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says e0910838, /lib/modules/2.4.7-ac3/kernel/fs/lockd/lockd.o says e090fca4.  Ignoring /lib/modules/2.4.7-ac3/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says e0903cc0, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e0903980.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says e0903cc4, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e0903984.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says e0903cc8, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e0903988.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says e0903cbc, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e090397c.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says e0903c9c, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e090395c.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says e0903c8c, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e090394c.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says e0903ca0, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e0903960.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says e0903c84, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e0903944.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says e0903c88, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e0903948.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says e0903c80, /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o says e0903940.  Ignoring /lib/modules/2.4.7-ac3/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says e088e2c0, /lib/modules/2.4.7-ac3/kernel/drivers/usb/usbcore.o says e088dde0.  Ignoring /lib/modules/2.4.7-ac3/kernel/drivers/usb/usbcore.o entry

wait_on_irq, CPU1:
irq: 1[1 0]
bh:  0[0 0]
Stack Dumps:
      c01f2012 c26cf000 c02a7a70 cac91620 c01632e2 c26cf000 coa78000
      c0163508 c26cf000 00000000 c26cf000 c369a000 c8156544 c015fc75
      c26cf000 00000004 c02a64e0 c02a64e0
Call Trace: [<c010848d>] [<c01632e2>] [<c0163508>] [<c015fc75>] [<c016045b>]
            [<c01338fd>] [<c013d797>] [<c0133b68>] [<c0132a21>] [<c013295a>]
            [<c0132c5e>] [<c0106ccb>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010848d <__global_cli+bd/124>
Trace; c01632e2 <n_tty_set_termios+6a/1d8>
Trace; c0163508 <n_tty_open+8c/a4>
Trace; c015fc75 <init_dev+2f5/420>
Trace; c016045b <tty_open+fb/36c>
Trace; c01338fd <get_chrfops+b1/150>
Trace; c013d797 <permission+7b/84>
Trace; c0133b68 <chrdev_open+64/8c>
Trace; c0132a21 <dentry_open+bd/13c>
Trace; c013295a <filp_open+52/5c>
Trace; c0132c5e <sys_open+36/cc>
Trace; c0106ccb <system_call+33/38>


16 warnings issued.  Results may not be reliable.

Environment:

Linux samba 2.4.7-ac3 #2 SMP Mon Jul 30 14:16:15 CDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.23
util-linux             2.10s
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         emu10k1 soundcore mga agpgart nfs lockd sunrpc
autofs4 3c59x ipchains mousedev keybdev hid input usb-uhci usbcore

samba> cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.970
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
bogomips        : 1854.66

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 930.970
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
bogomips        : 1861.22

samba> cat /proc/modules 
emu10k1                47616   1 (autoclean)
soundcore               3856   4 (autoclean) [emu10k1]
mga                    91696   1
agpgart                16576   3
nfs                    72032   3 (autoclean)
lockd                  48400   1 (autoclean) [nfs]
sunrpc                 64720   1 (autoclean) [nfs lockd]
autofs4                 8640   6 (autoclean)
3c59x                  25504   1 (autoclean)
ipchains               31680   0 (unused)
mousedev                3904   1
keybdev                 1600   0 (unused)
hid                    12512   0 (unused)
input                   3456   0 [mousedev keybdev hid]
usb-uhci               21664   0 (unused)
usbcore                49952   1 [hid usb-uhci]

samba> cat /proc/ioports 
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
dcd0-dcdf : Intel Corporation 82801AA SMBus
e000-efff : PCI Bus #02
  ec00-ec7f : 3Com Corporation 3c905C-TX [Fast Etherlink]
    ec00-ec7f : 02:0c.0
  ecd8-ecdf : Creative Labs SB Live!
  ece0-ecff : Creative Labs SB Live! EMU10000
    ece0-ecff : EMU10K1
ff80-ff9f : Intel Corporation 82801AA USB
  ff80-ff9f : usb-uhci
ffa0-ffaf : Intel Corporation 82801AA IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

samba> cat /proc/iomem 
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8800-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ff9bfff : System RAM
  00100000-001f0f61 : Kernel code
  001f0f62-00234b7f : Kernel data
1ff9c000-1fffffff : reserved
f0000000-f3ffffff : Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH)
f4000000-f5ffffff : PCI Bus #01
  f4000000-f5ffffff : Matrox Graphics, Inc. MGA G400 AGP
fa000000-fbffffff : PCI Bus #02
  fafffc00-fafffc7f : 3Com Corporation 3c905C-TX [Fast Etherlink]
fc000000-fdffffff : PCI Bus #01
  fc000000-fc7fffff : Matrox Graphics, Inc. MGA G400 AGP
  fcffc000-fcffffff : Matrox Graphics, Inc. MGA G400 AGP
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved

samba> sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 0095
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: f4000000-f5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corporation 82801AA IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation 82801AA USB
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
        Subsystem: Intel Corporation 82801AA SMBus

        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at dcd0 [size=16]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 0641
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 80000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=<none>

02:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 05)
        Subsystem: Creative Labs CT4790 SoundBlaster PCI512
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at ece0 [size=32]
        Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.1 Input device controller: Creative Labs SB Live! (rev 05)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at ecd8 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
        Subsystem: Dell Computer Corporation: Unknown device 0095
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ec00 [size=128]
        Region 1: Memory at fafffc00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at fb000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

samba> cat /proc/bus/usb/devices 
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=222/900 us (25%), #Int=  3, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=ff80
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=0039 Rev= 1.21
S:  Manufacturer=Microsoft
S:  Product=Microsoft IntelliMouse® Optical
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl= 10ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=1446 Rev= 1.10
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=001d Rev= 1.11
S:  Product=Microsoft Natural Keyboard Pro
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=82(I) Atr=03(Int.) MxPS=   3 Ivl= 10ms

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
