Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTLJLLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 06:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTLJLLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 06:11:10 -0500
Received: from adsl-66-218-54-162.dslextreme.com ([66.218.54.162]:41203 "EHLO
	puchol.com") by vger.kernel.org with ESMTP id S263510AbTLJLKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 06:10:49 -0500
Date: Wed, 10 Dec 2003 03:11:51 -0800
From: Carlos Puchol <cpg@nospam.rocketmail.com.puchol.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test11 oops galore: visor sync, cd/dvd burning
Message-ID: <20031210111151.GA6104@rome.puchol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, i updated a fedora core 1 system with arjanv's kernel
and i keep on getting oopses.

[1.] One line summary of the problem:

multiple oops while transferring a file to a visor connected vis usb.

[2.] Full description of the problem/report:

several attempts to transfer a file into a visor-like device (a treo phone)
yield oopses with 2.6.0-test11. (i also got oopses with dvd+r burning).

it is possible that this is an operator error, where i don't have the right
settings or utilities for a 2.6.-series kernel (though the machine seems to
behave itself reasonably in other circumstance), or where my usb hardware
is not well supported or somesuch.

[3.] Keywords (i.e., modules, networking, kernel):

usb, kernel, visor.

[4.] Kernel version (from /proc/version):

[03:07:49](3)rome:/# cat /proc/version
Linux version 2.6.0-0.test11.1.100 (bhcompile@porky.devel.redhat.com) (gcc version 3.3.2 20031202 (Red Hat Linux 3.3.2-3)) #1 Mon Dec 8 11:17:41 EST 2003
[03:07:51](3)rome:/#

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Dec 10 02:49:22 rome kernel: hub 2-0:1.0: new USB device on port 1, assigned address 2
Dec 10 02:49:22 rome kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
Dec 10 02:49:22 rome kernel: drivers/usb/core/usb.c: registered new driver usbserial
Dec 10 02:49:22 rome kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Dec 10 02:49:22 rome kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
Dec 10 02:49:22 rome kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
Dec 10 02:49:22 rome kernel: usb 2-1: Handspring Visor / Palm OS: Number of ports: 2
Dec 10 02:49:22 rome kernel: usb 2-1: Handspring Visor / Palm OS: port 1, is for Generic use
Dec 10 02:49:22 rome kernel: usb 2-1: Handspring Visor / Palm OS: port 2, is for HotSync use
Dec 10 02:49:22 rome kernel: visor 2-1:1.0: Handspring Visor / Palm OS converter detected
Dec 10 02:49:22 rome kernel: usb 2-1: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Dec 10 02:49:22 rome kernel: usb 2-1: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Dec 10 02:49:22 rome kernel: drivers/usb/core/usb.c: registered new driver visor
Dec 10 02:49:22 rome kernel: drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
Dec 10 02:49:23 rome devlabel: devlabel service started/restarted
Dec 10 02:49:27 rome kernel: usb 2-1: USB disconnect, address 2
Dec 10 02:49:27 rome kernel: visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
Dec 10 02:49:27 rome kernel: visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
Dec 10 02:49:27 rome kernel: visor 2-1:1.0: device disconnected
Dec 10 02:49:28 rome devlabel: devlabel service started/restarted
Dec 10 02:49:28 rome kernel: updfstab: numerical sysctl 1 23 is obsolete.
Dec 10 02:49:28 rome modprobe: FATAL: Module ide_probe_mod not found.
Dec 10 02:49:28 rome modprobe: FATAL: Module ide_probe not found.
Dec 10 02:50:38 rome kernel: hub 2-0:1.0: new USB device on port 1, assigned address 3
Dec 10 02:50:38 rome kernel: usb 2-1: Handspring Visor / Palm OS: Number of ports: 2
Dec 10 02:50:38 rome kernel: usb 2-1: Handspring Visor / Palm OS: port 1, is for Generic use
Dec 10 02:50:38 rome kernel: usb 2-1: Handspring Visor / Palm OS: port 2, is for HotSync use
Dec 10 02:50:38 rome kernel: usbserial 2-1:1.0: Handspring Visor / Palm OS converter detected
Dec 10 02:50:38 rome kernel: usb 2-1: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Dec 10 02:50:38 rome kernel: usb 2-1: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Dec 10 02:50:38 rome usb.agent[4875]: missing kernel or user mode driver visor
Dec 10 02:50:39 rome devlabel: devlabel service started/restarted
Dec 10 02:50:43 rome kernel: usb 2-1: USB disconnect, address 3
Dec 10 02:50:43 rome kernel: usbserial 2-1:1.0: device disconnected
Dec 10 02:50:44 rome devlabel: devlabel service started/restarted
Dec 10 02:50:44 rome kernel: updfstab: numerical sysctl 1 23 is obsolete.
Dec 10 02:50:44 rome modprobe: FATAL: Module ide_probe_mod not found.
Dec 10 02:50:44 rome modprobe: FATAL: Module ide_probe not found.
Dec 10 02:51:13 rome kernel: visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
Dec 10 02:51:13 rome kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000024
Dec 10 02:51:13 rome kernel:  printing eip:
Dec 10 02:51:13 rome kernel: 0215ca47
Dec 10 02:51:13 rome kernel: *pde = 00000000
Dec 10 02:51:13 rome kernel: Oops: 0002 [#1]
Dec 10 02:51:13 rome kernel: CPU:    0
Dec 10 02:51:13 rome kernel: EIP:    0060:[<0215ca47>]    Not tainted
Dec 10 02:51:13 rome kernel: EFLAGS: 00010202
Dec 10 02:51:13 rome kernel: EIP is at simple_rmdir+0x1d/0x33
Dec 10 02:51:13 rome kernel: eax: 00000000   ebx: 20e31190   ecx: 20e31198   edx: ffffffd9
Dec 10 02:51:13 rome kernel: esi: 16036104   edi: 20b237d8   ebp: 20e31190   esp: 080b9d64
Dec 10 02:51:13 rome kernel: ds: 007b   es: 007b   ss: 0068
Dec 10 02:51:13 rome kernel: Process pilot-xfer (pid: 4863, threadinfo=080b8000 task=098a4ce0)
Dec 10 02:51:13 rome kernel: Stack: 1603616c 16036104 0216fd13 16036104 20e31190 07918714 20e31afc 07918714
Dec 10 02:51:13 rome kernel:        20e31190 00000000 0216fdec 20e31190 19a92748 022e0568 211ba1d0 0218f42c
Dec 10 02:51:14 rome kernel:        19a92748 19a92720 021d4cbd 19a92748 19a92720 229d1f74 19a92720 1f36544c
Dec 10 02:51:14 rome kernel: Call Trace:
Dec 10 02:51:14 rome kernel:  [<0216fd13>] remove_dir+0x4d/0x6c
Dec 10 02:51:14 rome kernel:  [<0216fdec>] sysfs_remove_dir+0xb8/0xc9
Dec 10 02:51:14 rome kernel:  [<0218f42c>] kobject_del+0x46/0x51
Dec 10 02:51:14 rome kernel:  [<021d4cbd>] device_del+0x74/0x8b
Dec 10 02:51:14 rome kernel:  [<021d4cdf>] device_unregister+0xb/0x16
Dec 10 02:51:14 rome kernel:  [<229ccd15>] destroy_serial+0xb9/0x164 [usbserial]
Dec 10 02:51:14 rome kernel:  [<0218f4c1>] kobject_cleanup+0x3c/0x54
Dec 10 02:51:14 rome kernel:  [<229cc320>] serial_close+0x69/0x7f [usbserial]
Dec 10 02:51:14 rome kernel:  [<021b927d>] release_dev+0x1be/0x4bd
Dec 10 02:51:14 rome kernel:  [<0213465e>] kmem_cache_free+0x1ea/0x224
Dec 10 02:51:14 rome kernel:  [<021b9861>] tty_release+0x9/0xd
Dec 10 02:51:14 rome kernel:  [<02145f2a>] __fput+0x37/0xcb
Dec 10 02:51:14 rome kernel:  [<02144d4b>] filp_close+0x59/0x62
Dec 10 02:51:14 rome kernel:  [<0211c36e>] put_files_struct+0x52/0xa9
Dec 10 02:51:14 rome kernel:  [<0211ccf1>] do_exit+0x158/0x290
Dec 10 02:51:14 rome kernel:  [<0211ceca>] sys_exit_group+0x0/0x11
Dec 10 02:51:14 rome kernel:  [<021238e7>] get_signal_to_deliver+0x2a1/0x2b0
Dec 10 02:51:14 rome kernel:  [<0210c303>] do_signal+0x4f/0xbc
Dec 10 02:51:14 rome kernel:  [<021348dd>] kfree+0x245/0x27f
Dec 10 02:51:14 rome kernel:  [<02153f11>] sys_select+0x45c/0x468
Dec 10 02:51:14 rome kernel:  [<02153f11>] sys_select+0x45c/0x468
Dec 10 02:51:14 rome kernel:  [<021530ec>] sys_ioctl+0x1f4/0x20c
Dec 10 02:51:14 rome kernel:  [<0210c397>] do_notify_resume+0x27/0x38
Dec 10 02:51:14 rome kernel:
Dec 10 02:51:14 rome kernel: Code: ff 48 24 53 56 e8 c5 ff ff ff ff 4e 24 31 d2 5b 5e 5b 89 d0

[6.] A small shell script or example program which triggers the
     problem (if possible)

as a user, i was doing this:

pilot-xfer --port /dev/usb/ttyUSB0 --install ~/.addresses/AddressDB.pdb

after issuing a chmod 0666 /dev/usb/ttyUSB0 as root.

[7.] Environment

fedora core 1, with kernel rpm from arjanv, 2.6.0-0.test11.1.100.

[7.1.] Software (add the output of the ver_linux script here)

Linux rome.gwtw.com 2.6.0-0.test11.1.100 #1 Mon Dec 8 11:17:41 EST 2003 i686 athlon i386 GNU/Linux
  
Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
module-init-tools      2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         visor usbserial ide_cd cdrom md5 ipv6 lp autofs e100 ohci1394 ieee1394 floppy parport_pc parport uhci_hcd usbcore thermal processor fan button battery asus_acpi ac ext3 jbd dm_mod

[7.2.] Processor information (from /proc/cpuinfo):

[03:01:13](3)rome:/# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2083.158
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4154.98

[7.3.] Module information (from /proc/modules):

[03:01:16](3)rome:/# cat /proc/modules
visor 14988 0 - Live 0x2298e000
usbserial 26736 3 visor, Live 0x229cc000
ide_cd 36484 0 - Live 0x22973000
cdrom 29856 1 ide_cd, Live 0x2297e000
md5 3840 1 - Live 0x2292f000
ipv6 211520 8 - Live 0x22a09000
lp 10308 0 - Live 0x22937000
autofs 14080 0 - Live 0x22932000
e100 53896 0 - Live 0x2295e000
ohci1394 30600 0 - Live 0x22955000
ieee1394 212780 1 ohci1394, Live 0x22997000
floppy 53972 0 - Live 0x22871000
parport_pc 24872 1 - Live 0x22848000
parport 38248 2 lp,parport_pc, Live 0x2291f000
uhci_hcd 27152 0 - Live 0x22869000
usbcore 94684 5 visor,usbserial,uhci_hcd, Live 0x2293c000
thermal 12816 0 - Live 0x22864000
processor 13860 1 thermal, Live 0x2285f000
fan 3980 0 - Live 0x22833000
button 6168 0 - Live 0x2282a000
battery 9484 0 - Live 0x22844000
asus_acpi 10136 0 - Live 0x22840000
ac 4876 0 - Live 0x2282d000
ext3 112552 4 - Live 0x22881000
jbd 50200 1 ext3, Live 0x22851000
dm_mod 35872 0 - Live 0x22836000
[03:01:36](3)rome:/#

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[03:01:36](3)rome:/# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d000-d03f : 0000:00:0a.0
  d000-d03f : e100
d400-d4ff : 0000:00:0e.0
d800-d81f : 0000:00:10.0
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.1
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:10.2
  e000-e01f : uhci_hcd
e400-e40f : 0000:00:11.1
  e400-e407 : ide0
  e408-e40f : ide1
[03:01:55](3)rome:/# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00261fff : Kernel code
  00262000-00313bff : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
  d8000000-dfffffff : 0000:01:00.1
e0000000-e3ffffff : 0000:00:00.0
e4000000-e40fffff : PCI Bus #01
  e4020000-e402ffff : 0000:01:00.0
  e4030000-e403ffff : 0000:01:00.1
e4100000-e411ffff : 0000:00:0a.0
  e4100000-e411ffff : e100
e4130000-e4130fff : 0000:00:0a.0
  e4130000-e4130fff : e100
e4131000-e4131fff : 0000:00:0b.0
e4132000-e4132fff : 0000:00:0b.1
e4133000-e41330ff : 0000:00:10.3
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
[03:02:02](3)rome:/#

[7.5.] PCI information ('lspci -vvv' as root)

[03:02:02](3)rome:/# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
        Subsystem: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=31 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e40fffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e4130000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d000 [size=64]
        Region 2: Memory at e4100000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
 
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
        Subsystem: STB Systems Inc: Unknown device 2636
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e4131000 (32-bit, prefetchable) [size=4K]
 
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
        Subsystem: STB Systems Inc: Unknown device 2636
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e4132000 (32-bit, prefetchable) [size=4K]
 
00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Soyo Computer, Inc: Unknown device a715
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+
 
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at e4133000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited R250 If [Radeon 9000 "Atlantis"]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at e4020000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] (Secondary) (rev 01)
        Subsystem: PC Partner Limited: Unknown device 7193
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled] [size=128M]
        Region 1: Memory at e4030000 (32-bit, non-prefetchable) [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
[03:02:27](3)rome:/#

[7.6.] SCSI information (from /proc/scsi/scsi)

[03:02:27](3)rome:/# cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory
[03:02:59](3)rome:/#

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

it is possible that this is a user error, since i am not sure

[X.] Other notes, patches, fixes, workarounds:

under 2.6.0-test4, i got this under similar visor-related circumstances:

Dec 10 01:03:22 rome kernel: Slab corruption: start=cd7fd8b4, expend=cd7fdab3, problemat=cd7fd8bc
Dec 10 01:03:22 rome kernel: Last user: [<c01fb618>](device_release+0x58/0x60)
Dec 10 01:03:22 rome kernel: Data: ********00 00 00 00 *******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
Dec 10 01:03:22 rome kernel: Next: 71 F0 2C .18 B6 1F C0 71 F0 2C .********************
Dec 10 01:03:22 rome kernel: slab error in check_poison_obj(): cache `size-512': object was modified after freeing
Dec 10 01:03:22 rome kernel: Call Trace:
Dec 10 01:03:22 rome kernel:  [<c013c588>] check_poison_obj+0x168/0x1b0
Dec 10 01:03:22 rome kernel:  [<c013dd93>] __kmalloc+0x153/0x1c0
Dec 10 01:03:22 rome kernel:  [<c024a3e7>] alloc_skb+0x47/0xe0
Dec 10 01:03:22 rome kernel:  [<c024a3e7>] alloc_skb+0x47/0xe0
Dec 10 01:03:22 rome kernel:  [<c0249c1d>] sock_alloc_send_pskb+0xbd/0x1c0
Dec 10 01:03:22 rome kernel:  [<c0249d4f>] sock_alloc_send_skb+0x2f/0x40
Dec 10 01:03:22 rome kernel:  [<c02a5aa6>] unix_stream_sendmsg+0x186/0x3c0
Dec 10 01:03:22 rome kernel:  [<c0246b02>] sock_sendmsg+0xc2/0xd0
Dec 10 01:03:22 rome kernel:  [<c0139df2>] buffered_rmqueue+0xb2/0x140
Dec 10 01:03:22 rome kernel:  [<c0111120>] convert_fxsr_to_user+0xc0/0x160
Dec 10 01:03:22 rome kernel:  [<c01a2266>] avc_has_perm+0x76/0x8c
Dec 10 01:03:22 rome kernel:  [<c0246edd>] sock_readv_writev+0x7d/0xb0
Dec 10 01:03:22 rome kernel:  [<c0246fbf>] sock_writev+0x4f/0x60
Dec 10 01:03:22 rome kernel:  [<c0152c6f>] do_readv_writev+0x25f/0x2c0
Dec 10 01:03:22 rome kernel:  [<c01114a4>] restore_i387_fxsave+0x84/0x90
Dec 10 01:03:22 rome kernel:  [<c011152a>] restore_i387+0x7a/0x80
Dec 10 01:03:22 rome kernel:  [<c0152d93>] vfs_writev+0x53/0x60
Dec 10 01:03:22 rome kernel:  [<c0152e52>] sys_writev+0x42/0x70
Dec 10 01:03:22 rome kernel:  [<c010a9bb>] syscall_call+0x7/0xb


i also notice that i get various oopses burning a dvd+r.
(sorry did not get the oops info - this one is not fun to reproduce,
since it seems to waste a dvd+r)
