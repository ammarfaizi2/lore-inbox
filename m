Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTLCXjy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTLCXjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:39:54 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:31271 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262758AbTLCXhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:37:47 -0500
Subject: [OOPS]   2.4.23 USB ethernet oops
From: Harm Verhagen <h.verhagen@chello.nl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1070494662.6971.14.camel@node-d-8d2e.a2000.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Dec 2003 00:37:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting into 2.4.23 I saw the following oops going over my screen.

[1.] One line summary of the problem:
Booting 2.4.23 oopsed in usb ethernet.  (kaweth)

[2.]Full description of the problem/report:
During boot an oops went over my screen. Other than that the system
booted OK. (I'm writing this mail now with it)

I never saw this oops in previous kernels.
I did boot 2.4.23 before (once) without seeing any oops

[4.] Kernel version (from /proc/version):
Linux version 2.4.23 (root@node-d-8d2e.a2000.nl) (gcc version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #2 Sun Nov 30 00:32:10 CET 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

**** some dmesg output ****

ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ip_tables: (C) 2000-2002 Netfilter core team
hub.c: new USB device 00:09.0-2, assigned address 3
kaweth.c: Kawasaki Device Probe (Device number:3): 0x1485:0x0001:0x0208
kaweth.c: Device at cf15e600
kaweth.c: Descriptor length: 12 type: 1
kaweth.c: Resetting.
kaweth.c: kaweth_reset(cf044800)
kaweth.c: kaweth_control()
kaweth.c: kaweth_reset() returns 0.
kaweth.c: Firmware present in device.
kaweth.c: Reading kaweth configuration
kaweth.c: kaweth_control()
kaweth.c: Statistics collection: 13fbffff
kaweth.c: Multicast filter limit: 80
kaweth.c: MTU: 1514
kaweth.c: Read MAC address 00:e0:ed:05:46:4c
kaweth.c: Setting URB size to 1664
Unable to handle kernel paging request at virtual address 04000300
 printing eip:
d08a226e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d08a226e>]    Not tainted
EFLAGS: 00010202
eax: 04000300   ebx: cf044800   ecx: cf15e600   edx: 00000300
esi: 00000680   edi: cf8c5ec9   ebp: cf044ee1   esp: cf8c5e6c
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 74, stackpage=cf8c5000)
Stack: cf044800 00000680 d08a46c2 00000040 00000680 00000000 00000bb8
00000000 
       00000bb8 cf044800 cf044ee2 d08a3408 cf044800 00000680 000000e0
000000ed 
       00000005 00000046 0000004c c01512e5 cec9a480 20000203 cffd43d8
ffffffff 
Call Trace:    [<d08a46c2>] [<d08a3408>] [<c01512e5>] [<d08a6850>]
[<d08a6900>]
  [<d0838db6>] [<d08a6850>] [<d08a68e0>] [<d084ab80>] [<d0839215>]
[<d083b48d>]
  [<d083d041>] [<d083cbac>] [<d083d438>] [<d083d4c6>] [<d083d490>]
[<c01057ae>]
  [<d083d490>]

Code: c7 00 24 08 08 00 00 00 0f 00 d0 8d 43 38 81 ca 00 00 00 80 
 ip_tables: (C) 2000-2002 Netfilter core team
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]


********* decoded oops ****************
Unable to handle kernel paging request at virtual address 04000300
d08a226e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d08a226e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 04000300   ebx: cf044800   ecx: cf15e600   edx: 00000300
esi: 00000680   edi: cf8c5ec9   ebp: cf044ee1   esp: cf8c5e6c
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 74, stackpage=cf8c5000)
Stack: cf044800 00000680 d08a46c2 00000040 00000680 00000000 00000bb8
00000000 
       00000bb8 cf044800 cf044ee2 d08a3408 cf044800 00000680 000000e0
000000ed 
       00000005 00000046 0000004c c01512e5 cec9a480 20000203 cffd43d8
ffffffff 
Call Trace:    [<d08a46c2>] [<d08a3408>] [<c01512e5>] [<d08a6850>]
[<d08a6900>]
  [<d0838db6>] [<d08a6850>] [<d08a68e0>] [<d084ab80>] [<d0839215>]
[<d083b48d>]
  [<d083d041>] [<d083cbac>] [<d083d438>] [<d083d4c6>] [<d083d490>]
[<c01057ae>]
  [<d083d490>]
Code: c7 00 24 08 08 00 00 00 0f 00 d0 8d 43 38 81 ca 00 00 00 80 


>>EIP; d08a226e <[kaweth]kaweth_set_urb_size+5e/90>   <=====

>>ebx; cf044800 <_end+ecb7aa8/10499328>
>>ecx; cf15e600 <_end+edd18a8/10499328>
>>edi; cf8c5ec9 <_end+f539171/10499328>
>>ebp; cf044ee1 <_end+ecb8189/10499328>
>>esp; cf8c5e6c <_end+f539114/10499328>

Trace; d08a46c2 <[kaweth].rodata.end+8d7/17f5>
Trace; d08a3408 <[kaweth]kaweth_probe+338/550>
Trace; c01512e5 <get_new_inode+145/160>
Trace; d08a6850 <[kaweth]usb_klsi_table+230/2a8>
Trace; d08a6900 <[kaweth]kaweth_driver+20/37>
Trace; d0838db6 <[usbcore]usb_find_interface_driver+116/210>
Trace; d08a6850 <[kaweth]usb_klsi_table+230/2a8>
Trace; d08a68e0 <[kaweth]kaweth_driver+0/37>
Trace; d084ab80 <[usbcore]usb_driver_list+0/0>
Trace; d0839215 <[usbcore]usb_find_drivers+85/90>
Trace; d083b48d <[usbcore]usb_new_device+15d/1d0>
Trace; d083d041 <[usbcore]usb_hub_port_connect_change+161/280>
Trace; d083cbac <[usbcore]usb_hub_port_status+6c/a0>
Trace; d083d438 <[usbcore]usb_hub_events+2d8/330>
Trace; d083d4c6 <[usbcore]usb_hub_thread+36/c0>
Trace; d083d490 <[usbcore]usb_hub_thread+0/c0>
Trace; c01057ae <arch_kernel_thread+2e/40>
Trace; d083d490 <[usbcore]usb_hub_thread+0/c0>

Code;  d08a226e <[kaweth]kaweth_set_urb_size+5e/90>
00000000 <_EIP>:
Code;  d08a226e <[kaweth]kaweth_set_urb_size+5e/90>   <=====
   0:   c7 00 24 08 08 00         movl   $0x80824,(%eax)   <=====
Code;  d08a2274 <[kaweth]kaweth_set_urb_size+64/90>
   6:   00 00                     add    %al,(%eax)
Code;  d08a2276 <[kaweth]kaweth_set_urb_size+66/90>
   8:   0f 00 d0                  lldt   %ax
Code;  d08a2279 <[kaweth]kaweth_set_urb_size+69/90>
   b:   8d 43 38                  lea    0x38(%ebx),%eax
Code;  d08a227c <[kaweth]kaweth_set_urb_size+6c/90>
   e:   81 ca 00 00 00 80         or     $0x80000000,%edx

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux node-d-8d2e.a2000.nl 2.4.23 #2 Sun Nov 30 00:32:10 CET 2003 i686
athlon i386 GNU/Linux
  
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         es1371 ac97_codec nvidia ipt_MASQUERADE ipt_state
ipt_LOG ipt_REJECT ip_nat_ftp iptable_nat
ip_conntrack_irc ip_conntrack_ftp ip_conntrack parport_pc lp parport
iptable_filter ip_tables ide-scsi ide-cd cdrom kaweth ntfs usb-storage
sd_mod scsi_mod keybdev mousedev hid input usb-uhci ehci-hcd usbcore
3c59x 8139too

note: the nvidia driver listed above as loaded module was _not_ loaded,
or had been loaded before the oops occurred ! The oops occurred when
booting, only after the oops nvidia gets loaded (when starting X)

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1800+
stepping        : 2
cpu MHz         : 1532.941
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3060.53

[7.3.] Module information (from /proc/modules):
[root@node-d-8d2e root]# cat /proc/modules
es1371                 29224   0 (autoclean)
ac97_codec             17064   0 (autoclean) [es1371]
nvidia               1764896  11 (autoclean)
ipt_MASQUERADE          2328   1 (autoclean)
ipt_state               1048   3 (autoclean)
ipt_LOG                 4248   8 (autoclean)
ipt_REJECT              4312   5 (autoclean)
ip_nat_ftp              3664   0 (unused)
iptable_nat            20568   2 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_irc        4080   0 (unused)
ip_conntrack_ftp        5168   1
ip_conntrack           28808   4 [ipt_MASQUERADE ipt_state ip_nat_ftp
iptable_nat ip_conntrack_irc ip_conntrack_ftp]
parport_pc             26728   1 (autoclean)
lp                      8096   0 (autoclean)
parport                35968   1 (autoclean) [parport_pc lp]
iptable_filter          2412   1 (autoclean)
ip_tables              15328   8 [ipt_MASQUERADE ipt_state ipt_LOG
ipt_REJECT iptable_nat iptable_filter]
ide-scsi               12016   0
ide-cd                 35392   0
cdrom                  33280   0 [ide-cd]
kaweth                 18712   0 (unused)
ntfs                   58432   1 (autoclean)
usb-storage            75072   0
sd_mod                 12556   0 (autoclean)
scsi_mod               99508   3 (autoclean) [ide-scsi usb-storage
sd_mod]
keybdev                 2912   0 (unused)
mousedev                5428   1
hid                    24452   0 (unused)
input                   5664   0 [keybdev mousedev hid]
usb-uhci               26092   0 (unused)
ehci-hcd               19944   0 (unused)
usbcore                78176   1 [kaweth usb-storage hid usb-uhci
ehci-hcd]
3c59x                  28752   1
8139too                16168   1

[ 7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
[root@node-d-8d2e root]# cat /proc/ioports
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
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a400-a41f : VIA Technologies, Inc. USB (#4)
  a400-a41f : usb-uhci
a800-a81f : VIA Technologies, Inc. USB (#3)
  a800-a81f : usb-uhci
b000-b00f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Master IDE
  b000-b007 : ide0
  b008-b00f : ide1
b400-b43f : Ensoniq 5880 AudioPCI
  b400-b43f : es1371
b800-b87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  b800-b87f : 00:0e.0
d000-d0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d000-d0ff : 8139too
d400-d41f : VIA Technologies, Inc. USB (#2)
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. USB
  d800-d81f : usb-uhci
[root@node-d-8d2e root]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-002a86fc : Kernel code
  002a86fd-00336187 : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
d4800000-d480007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
d5000000-d50000ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  d5000000-d50000ff : 8139too
d5800000-d58000ff : VIA Technologies, Inc. USB 2.0
  d5800000-d58000ff : ehci_hcd
d6000000-d75fffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation NV17 [GeForce4 MX 440]
d7700000-dfffffff : PCI Bus #01
  d7800000-d787ffff : nVidia Corporation NV17 [GeForce4 MX 440]
  d8000000-dfffffff : nVidia Corporation NV17 [GeForce4 MX 440]
e0000000-e7ffffff : VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
[root@node-d-8d2e root]# lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
        Subsystem: Asustek Computer, Inc. A7V333 Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP+ 64bit- FW+ Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d6000000-d75fffff
        Prefetchable memory behind bridge: d7700000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if
20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at d5800000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at d5000000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b800 [size=128]
        Region 1: Memory at d4800000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at b400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at b000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at a400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX
440] (rev a3) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2870
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d6000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d7800000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at d77e0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=31 SBA- AGP+ 64bit- FW+ Rate=x4









-- 
Harm Verhagen <h.verhagen@chello.nl>

