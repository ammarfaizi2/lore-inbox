Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVCFRt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVCFRt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVCFRt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:49:58 -0500
Received: from web30909.mail.mud.yahoo.com ([68.142.200.162]:17546 "HELO
	web30909.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261444AbVCFRtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:49:32 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=SefcI93vIPXoYgbO2IPu7DYbjN0v/Zy2wURl6WdQic2KRjQ9Jkvthyg7F7fSJaG34eesZyLNCgt2BTnccXo9jcI/Z2pHezSbDzAThEK/MNr6kk5eU3zIZe06bFlMcOF9WlOkGQhROW4xiMYwdcBCPhXzl8E0zsRFaxJePd6YiTg=  ;
Message-ID: <20050306174932.56406.qmail@web30909.mail.mud.yahoo.com>
Date: Sun, 6 Mar 2005 09:49:32 -0800 (PST)
From: Lobiuc Andrei <alobiuc@yahoo.com>
Subject: PROBLEM: Radeon card displays incorrectly under the 2.6.11 version unless compiled with SMP support
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.Radeon card displays incorrectly under the 2.6.11
version unless compiled with SMP support.
2.After compiling and installing the 2.6.11 kernel
version, my ASUS Radeon 9200SE 128 MB graphic card
does not display correctly in plain VGA mode. The same
card has no problem with the 2.6.10 kernel.
Regarding radeonfb, dmesg reports:
"radeonfb_pci_register BEGIN
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 169
radeonfb (0000:01:00.0): Found 131072k of DDR 64 bits
wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12)
Memory=200.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 1 connectors
  * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 737, hEnd = 808, hTotal = 896
vStart = 401, vEnd = 404, vTotal = 417
h_total_disp = 0x59006f    hsync_strt_wid = 0x8802eb
v_total_disp = 0x18f01a0           vsync_strt_wid =
0x830190
pixclock = 38210
freq = 2617
freq = 2617, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 20936
ref_div = 12, ref_clk = 2700, output_freq = 20936
post div = 0x3
fb_div = 0x5d
ppll_div_3 = 0x3005d
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon Yd
radeonfb_pci_register END
kobject_register failed for radeonfb (-17)
 [<c01cf0c7>] kobject_register+0x57/0x60
 [<c0262707>] bus_add_driver+0x57/0xd0
 [<c0262d5f>] driver_register+0x2f/0x40
 [<c01db547>] pci_create_newid_file+0x27/0x30
 [<c01dba42>] pci_register_driver+0x62/0x80
 [<c05b3b40>] radeonfb_old_init+0x40/0x50
 [<c059c7fb>] do_initcalls+0x2b/0xc0
 [<c01002c0>] init+0x0/0x110
 [<c01002c0>] init+0x0/0x110
 [<c01002ef>] init+0x2f/0x110
 [<c010086c>] kernel_thread_helper+0x0/0x14
 [<c0100871>] kernel_thread_helper+0x5/0x14
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 169
[drm] Initialized radeon 1.14.0 20050125 on minor 0:
ATI Technologies Inc RV280[Radeon 9200 SE]"

and also

"[drm:radeon_cp_init] *ERROR* radeon_cp_init called
without lock held
[drm:drm_unlock] *ERROR* Process 4090 using kernel
context 0
"
Immediatly after the  GrUB boot prompt, several lines
of text scroll quickly down the screen, then the
display flickers for one second and when the text
comes back it looks huge, at a resolution that appears
to be 320x200 (if not lower). Also, it passes the
boundaries of the screen in all the directions.
In console mode (Ctrl-Alt-F1) the text becomes blurred
and with each line displayed, coloured pixels appear
randomly on the screen.
I tried several "vga=" modes but none seems to work.
I uselessly recompiled several times the kernel with
various graphic configurations.
I made sure that support for framebuffer devices (FB),
ATI Radeon display support (FB_RADEON and
FB_RADEON_OLD), framebuffer console support
(FRAMEBUFFER_CONSOLE), video mode selection support
(VIDEO_SELECT) are all compiled as built-in. 
Drivers for no other cards were built, except for the
first time when vga16fb and vesafb were built, making
yet no difference.
On the other hand, KDE looks fine at 1024x768@85Hz,
except for the OpenGL screensavers which crawls.

Accidentally, one of the compilings has been done with
SMP support enabled on my single-processor machine and
it turned out with this install of the kernel that the
graphic card works ok in such conditions, displaying
the text as it should.

3. radeonfb module; SMP

4.Linux version 2.6.11 (harken@vsoft.thenet) (gcc
version 3.3.5 (Debian 1:3.3.5-8)) #1 SMP Sun Mar 6
18:27:01 EET 2005

7.
7.1 scripts/ver_linux
Linux vsoft.thenet 2.6.11 #1 SMP Sun Mar 6 18:27:01
EET 2005 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.2-pre1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   053
Modules Loaded         via_rhine ntfs

7.2 /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2800+
stepping        : 0
cpu MHz         : 2080.803
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmovpat pse36 mmx fxsr sse pni
syscall mmxext 3dnowext 3dnow
bogomips        : 4096.00

7.3 /proc/modules
via_rhine 20868 0 - Live 0xe1979000
ntfs 180752 1 - Live 0xe1943000

7.4 /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
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
4000-407f : motherboard
  4000-4003 : PM1a_EVT_BLK
  4004-4005 : PM1a_CNT_BLK
  4008-400b : PM_TMR
  4010-4015 : ACPI CPU throttle
  4020-4023 : GPE0_BLK
5000-500f : motherboard
a000-afff : PCI Bus #01
  a000-a0ff : 0000:01:00.0
    a000-a0ff : radeonfb
c800-c80f : 0000:00:0f.0
  c800-c807 : ide0
  c808-c80f : ide1
cc00-cc1f : 0000:00:10.0
  cc00-cc1f : uhci_hcd
d000-d01f : 0000:00:10.1
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:10.2
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:10.3
  d800-d81f : uhci_hcd
dc00-dcff : 0000:00:11.5
  dc00-dcff : VIA8237
e000-e0ff : 0000:00:12.0
  e000-e0ff : via-rhine

/proc/iomem

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-003f1a91 : Kernel code
  003f1a92-0051503f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-e7ffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
    d8000000-dfffffff : radeonfb
  e0000000-e7ffffff : 0000:01:00.1
e8000000-e9ffffff : PCI Bus #01
  e9000000-e900ffff : 0000:01:00.0
    e9000000-e900ffff : radeonfb
  e9010000-e901ffff : 0000:01:00.1
ea000000-ea0000ff : 0000:00:10.4
  ea000000-ea0000ff : ehci_hcd
ea001000-ea0010ff : 0000:00:12.0
  ea001000-ea0010ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

7.5. lspci -vvv
000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377
[KT400/KT600 AGP] Host Bridge (rev 80)
        Subsystem: VIA Technologies, Inc. VT8377
[KT400/KT600 AGP] Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d0000000 (32-bit,
prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+
ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+
GART64- 64bit- FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237
PCI Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge:
d8000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort-
>Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master
IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus
Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 20
        Region 4: I/O ports at c800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx
UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx
UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 21
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx
UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc.
VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. VT82xxxxx
UHCI USB 1.1 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc.
USB 2.0 (rev 86) (prog-if 20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin C routed to IRQ 21
        Region 0: Memory at ea000000 (32-bit,
non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237
ISA bridge [K8T800 South]
        Subsystem: VIA Technologies, Inc. VT8237 ISA
bridge [K8T800 South]
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:11.5 Multimedia audio controller: VIA
Technologies, Inc. VT8233/A/8235/8237 AC97 Audio
Controller (rev 60)
        Subsystem: Unknown device 1695:300c
        Control: I/O+ Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at dc00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:00:12.0 Ethernet controller: VIA Technologies,
Inc. VT6102 [Rhine-II] (rev78)
        Subsystem: VIA Technologies, Inc. VT6102
[Rhine II] Embeded Ethernet Controller on VT8235
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache
Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at ea001000 (32-bit,
non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:01:00.0 VGA compatible controller: ATI
Technologies Inc RV280 [Radeon 9200SE] (rev 01)
(prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown
device c008
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size:
0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d8000000 (32-bit,
prefetchable) [size=128M]
        Region 1: I/O ports at a000 [size=256]
        Region 2: Memory at e9000000 (32-bit,
non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+
ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+
GART64- 64bit- FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

0000:01:00.1 Display controller: ATI Technologies Inc
RV280 [Radeon 9200 SE] (Secondary) (rev 01)
        Subsystem: Asustek Computer, Inc.: Unknown
device c009
        Control: I/O- Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size:
0x08 (32 bytes)
        Region 0: Memory at e0000000 (32-bit,
prefetchable) [disabled] [size=128M]
        Region 1: Memory at e9010000 (32-bit,
non-prefetchable) [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

Thank you very much for your time!
Regards, Andrei Lobiuc


	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/
