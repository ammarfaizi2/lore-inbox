Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUFCJWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUFCJWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 05:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUFCJWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 05:22:37 -0400
Received: from penpen.tenebreuse.org ([81.57.102.121]:25219 "EHLO
	turbigo-2-81-57-102-121.fbx.proxad.net") by vger.kernel.org with ESMTP
	id S261943AbUFCJWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 05:22:18 -0400
Date: Thu, 3 Jun 2004 11:22:17 +0200
From: Jean-Christophe Dubacq <jcdubacq1@free.fr>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: OHCI/UHCI modules => screen garbled in 2.6, hard freeze in 2.4
Message-ID: <20040603092216.GA18661@penpen.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I really do not know where to report this, so I will try to give as
  much information as possible, and am interested in whatever hints or
  contacts could be given to solve this.

2. Problem description:
When inserting the ohci module under 2.4 at bootup time, or uhci (maybe
ohci too, I did not test this) under 2.6, I get either a hard freeze
(under 2.4) as soon as my sound card is used, or a garbled screen (a
few pixels, according a seemingly random pattern, but always the same
pattern) a few seconds after inserting the USB hub controllers.

Moving away those modules, then inserting them later (once the boot
process is complete) worked fine under 2.6 (although I did not manage to
use my USB camera, but it certainly comes from devfs or else).
I think I remember it worked also under 2.4, but led to instability
(random freeze some time later).

My hardware: Motherboard P4B266A (as shown below), a promise IDE card,
onboard USB and sound card, Matrox G550 card.
My system: debian unstable.


I am quite ready to do any test, recompiling, or patching to debug this.

Please Cc replies to me as I am not subscribed to the list (I will if
deemed necessary)

3. Keywords: USB, modules

4. Kernel version: Linux version 2.4.25jcd (root@penpen) (version gcc
3.3.3 (Debian 20040401)) #1 ven avr 9 18:05:50 CEST 2004
(jcd added to debian patched kernel because compiled by me; otherwise
it is a debian-patched kernel)
When failing under 2.6, it is with a kernel as found in
kernel-image-2.6.6-1.deb

5. No oops. However, I can include the 2.6.6 bootup sequence syslog
Jun  2 17:11:10 penpen syslogd 1.4.1#14: restart.
Jun  2 17:11:10 penpen kernel: klogd 1.4.1#14, log source = /proc/kmsg
started.
Jun  2 17:11:10 penpen kernel: Inspecting /boot/System.map-2.6.6-1-686
Jun  2 17:11:10 penpen kernel: Loaded 26100 symbols from
/boot/System.map-2.6.6-1-686.
Jun  2 17:11:10 penpen kernel: Symbols match kernel version 2.6.6.
Jun  2 17:11:10 penpen kernel: No module symbols loaded - kernel modules
not enabled.
Jun  2 17:11:10 penpen kernel: 2003-12-10) initialised:
dm@uk.sistina.com
Jun  2 17:11:10 penpen kernel: kjournald starting.  Commit interval 5
seconds
Jun  2 17:11:10 penpen kernel: EXT3 FS on hdc2, internal journal
Jun  2 17:11:10 penpen kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Jun  2 17:11:10 penpen kernel: kjournald starting.  Commit interval 5
seconds
Jun  2 17:11:10 penpen kernel: EXT3 FS on hdd1, internal journal
Jun  2 17:11:10 penpen kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Jun  2 17:11:10 penpen kernel: kjournald starting.  Commit interval 5
seconds
Jun  2 17:11:10 penpen kernel: EXT3 FS on hda1, internal journal
Jun  2 17:11:10 penpen kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Jun  2 17:11:10 penpen kernel: kjournald starting.  Commit interval 5
seconds
Jun  2 17:11:10 penpen kernel: EXT3 FS on hdc1, internal journal
Jun  2 17:11:10 penpen kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Jun  2 17:11:10 penpen kernel: kjournald starting.  Commit interval 5
seconds
Jun  2 17:11:10 penpen kernel: EXT3 FS on hdb1, internal journal
Jun  2 17:11:10 penpen kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Jun  2 17:11:10 penpen kernel: agpgart: Detected an Intel i845 Chipset.
Jun  2 17:11:10 penpen kernel: agpgart: Maximum main memory to use for
agp memory: 941M
Jun  2 17:11:10 penpen kernel: agpgart: AGP aperture is 128M @
0xf0000000
Jun  2 17:11:10 penpen kernel: cpci_hotplug: CompactPCI Hot Plug Core
version: 0.2
Jun  2 17:11:10 penpen kernel: pci_hotplug: PCI Hot Plug PCI Core
version: 0.5
Jun  2 17:11:10 penpen kernel: pciehp: acpi_pciehprm:get_device PCI ROOT
HID fail=0x1001
Jun  2 17:11:10 penpen kernel: shpchp: acpi_shpchprm:get_device PCI ROOT
HID fail=0x1001
Jun  2 17:11:10 penpen kernel: pciehp: acpi_pciehprm:get_device PCI ROOT
HID fail=0x1001
Jun  2 17:11:10 penpen kernel: shpchp: acpi_shpchprm:get_device PCI ROOT
HID fail=0x1001
Jun  2 17:11:10 penpen kernel: hw_random: RNG not detected
Jun  2 17:11:10 penpen kernel: i8xx TCO timer: failed to reset NO_REBOOT
flag, reboot disabled by hardware
Jun  2 17:11:10 penpen kernel: Search for id:(ff ff) interleave(1)
type(1)
Jun  2 17:11:10 penpen last message repeated 2 times
[some more garbage]
Jun  2 17:11:10 penpen kernel: JEDEC: Found no ICH2 rom device at
location zero
Jun  2 17:11:10 penpen kernel: usbcore: registered new driver usbfs
Jun  2 17:11:10 penpen kernel: usbcore: registered new driver hub
Jun  2 17:11:10 penpen kernel: USB Universal Host Controller Interface
driver v2.2
Jun  2 17:11:10 penpen kernel: PCI: Found IRQ 10 for device 0000:00:1f.2
Jun  2 17:11:10 penpen kernel: uhci_hcd 0000:00:1f.2: Intel Corp.
82801BA/BAM USB (Hub #1)
Jun  2 17:11:10 penpen kernel: PCI: Setting latency timer of device
0000:00:1f.2 to 64
Jun  2 17:11:10 penpen kernel: uhci_hcd 0000:00:1f.2: irq 10, io base
00009400
Jun  2 17:11:10 penpen kernel: uhci_hcd 0000:00:1f.2: new USB bus
registered, assigned bus number 1
Jun  2 17:11:10 penpen kernel: hub 1-0:1.0: USB hub found
Jun  2 17:11:10 penpen kernel: hub 1-0:1.0: 2 ports detected
Jun  2 17:11:10 penpen kernel: PCI: Found IRQ 9 for device 0000:00:1f.4
Jun  2 17:11:10 penpen kernel: PCI: Sharing IRQ 9 with 0000:02:04.2
Jun  2 17:11:10 penpen kernel: uhci_hcd 0000:00:1f.4: Intel Corp.
82801BA/BAM USB (Hub #2)
Jun  2 17:11:10 penpen kernel: PCI: Setting latency timer of device
0000:00:1f.4 to 64
Jun  2 17:11:10 penpen kernel: uhci_hcd 0000:00:1f.4: irq 9, io base
00009000
Jun  2 17:11:10 penpen kernel: uhci_hcd 0000:00:1f.4: new USB bus
registered, assigned bus number 2
Jun  2 17:11:10 penpen kernel: hub 2-0:1.0: USB hub found
Jun  2 17:11:10 penpen kernel: hub 2-0:1.0: 2 ports detected
Jun  2 17:11:10 penpen kernel: usb 1-2: new full speed USB device using
address
2
Jun  2 17:11:10 penpen kernel: hub 1-2:1.0: USB hub found
Jun  2 17:11:10 penpen kernel: hub 1-2:1.0: 4 ports detected
Jun  2 17:11:10 penpen kernel: PCI: Found IRQ 11 for device 0000:01:00.0
Jun  2 17:11:10 penpen kernel: matroxfb: Matrox G550 detected
Jun  2 17:11:10 penpen kernel: matroxfb: MTRR's turned on
Jun  2 17:11:10 penpen kernel: matroxfb: 640x480x8bpp (virtual:
640x65536)
Jun  2 17:11:10 penpen kernel: matroxfb: framebuffer at 0xEE000000,
mapped to 0xf9a70000, size 33554432
Jun  2 17:11:10 penpen kernel: fb0: MATROX frame buffer device
Jun  2 17:11:10 penpen kernel: fb0: initializing hardware
Jun  2 17:11:10 penpen kernel: PCI: Found IRQ 11 for device 0000:02:03.0
Jun  2 17:11:10 penpen kernel: PCI: Sharing IRQ 11 with 0000:02:04.0
Jun  2 17:11:10 penpen kernel: PCI: Sharing IRQ 11 with 0000:02:0d.0
Jun  2 17:11:10 penpen kernel: unable to grab ports 0xd800-0xd8ff
Jun  2 17:11:10 penpen kernel: C-Media PCI: probe of 0000:02:03.0 failed
with error -16
Jun  2 17:11:10 penpen kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host
Controller (OHCI) Driver (PCI)
Jun  2 17:11:10 penpen kernel: ohci_hcd: block sizes: ed 64 td 64
Jun  2 17:11:10 penpen kernel: PCI: Enabling device 0000:02:04.0 (0014
-> 0016)
Jun  2 17:11:10 penpen kernel: PCI: Found IRQ 11 for device 0000:02:04.0
Jun  2 17:11:10 penpen kernel: PCI: Sharing IRQ 11 with 0000:02:03.0
Jun  2 17:11:10 penpen kernel: PCI: Sharing IRQ 11 with 0000:02:0d.0
Jun  2 17:11:10 penpen kernel: ohci_hcd 0000:02:04.0: NEC Corporation
USB
Jun  2 17:11:10 penpen kernel: ohci_hcd 0000:02:04.0: irq 11, pci mem
f8a82000
Jun  2 17:11:10 penpen kernel: ohci_hcd 0000:02:04.0: new USB bus
registered, assigned bus number 3
Jun  2 17:11:10 penpen kernel: hub 3-0:1.0: USB hub found
Jun  2 17:11:10 penpen kernel: hub 3-0:1.0: 3 ports detected
Jun  2 17:11:10 penpen kernel: PCI: Enabling device 0000:02:04.1 (0014
-> 0016)
Jun  2 17:11:10 penpen kernel: PCI: Found IRQ 9 for device 0000:02:04.1
Jun  2 17:11:10 penpen kernel: PCI: Sharing IRQ 9 with 0000:02:0a.0
Jun  2 17:11:10 penpen kernel: ohci_hcd 0000:02:04.1: NEC Corporation
USB (#2)
Jun  2 17:11:10 penpen kernel: ohci_hcd 0000:02:04.1: irq 9, pci mem
f8ad6000
Jun  2 17:11:10 penpen kernel: ohci_hcd 0000:02:04.1: new USB bus
registered, assigned bus number 4
Jun  2 17:11:10 penpen kernel: hub 4-0:1.0: USB hub found
Jun  2 17:11:10 penpen kernel: hub 4-0:1.0: 2 ports detected
Jun  2 17:11:10 penpen kernel: PCI: Enabling device 0000:02:04.2 (0014
-> 0016)
Jun  2 17:11:10 penpen kernel: PCI: Found IRQ 9 for device 0000:02:04.2
Jun  2 17:11:10 penpen kernel: PCI: Sharing IRQ 9 with 0000:00:1f.4
Jun  2 17:11:10 penpen kernel: ehci_hcd 0000:02:04.2: NEC Corporation
USB 2.0
Jun  2 17:11:10 penpen kernel: ehci_hcd 0000:02:04.2: irq 9, pci mem
f8ad8000
Jun  2 17:11:10 penpen kernel: ehci_hcd 0000:02:04.2: new USB bus
registered, assigned bus number 5
Jun  2 17:11:10 penpen kernel: ehci_hcd 0000:02:04.2: USB 2.0 enabled,
EHCI 0.95, driver 2003-Dec-29
Jun  2 17:11:10 penpen kernel: hub 5-0:1.0: USB hub found
Jun  2 17:11:10 penpen kernel: hub 5-0:1.0: 5 ports detected
Jun  2 17:11:10 penpen kernel: NET: Registered protocol family 17
Jun  2 17:11:10 penpen kernel: eth0: Setting full-duplex based on MII#1
link partner capability of 45e1.
Jun  2 17:11:10 penpen kernel: eth1: Setting full-duplex based on MII#1
link partner capability of 4061.

At this point, the last two lines are not displayed. Screen is garbled.

6. Shell-script to trigger... not applicable.

7. Environment
7.1. ver_linux output:
Linux penpen 2.4.25jcd #1 ven avr 9 18:05:50 CEST 2004 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         mga apm parport_pc lp parport ipt_TOS
ipt_MASQUERADE ipt_REJECT ipt_pkttype ipt_state ip_nat_irc ip_nat_ftp
ip_conntrack_irc ip_conntrack_ftp ipt_multiport ipt_conntrack
iptable_filter iptable_mangle iptable_nat ip_conntrack ip_tables
af_packet uhci usbcore sd_mod cmpci soundcore gameport agpgart tulip
crc32 ide-scsi scsi_mod ide-floppy rtc ext3 jbd ide-detect piix ide-disk
pdc202xx_new unix ide-core

7.2 cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1715.324
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3420.97

7.3 cat /proc/modules
mga                    89916   1
apm                     9452   1 (autoclean)
parport_pc             25512   1 (autoclean)
lp                      6688   0 (autoclean)
parport                23496   1 (autoclean) [parport_pc lp]
ipt_TOS                  920  12 (autoclean)
ipt_MASQUERADE          1400   1 (autoclean)
ipt_REJECT              3480   4 (autoclean)
ipt_pkttype              472   4 (autoclean)
ipt_state                504  17 (autoclean)
ip_nat_irc              2096   0 (unused)
ip_nat_ftp              2672   0 (unused)
ip_conntrack_irc        2992   1
ip_conntrack_ftp        3824   1
ipt_multiport            632  15 (autoclean)
ipt_conntrack            984   0 (autoclean)
iptable_filter          1644   1 (autoclean)
iptable_mangle          2072   1 (autoclean)
iptable_nat            15502   3 (autoclean) [ipt_MASQUERADE ip_nat_irc
ip_nat_ftp]
ip_conntrack           19556   2 (autoclean) [ipt_MASQUERADE ipt_state
ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ipt_conntrack
iptable_nat]
ip_tables              12416  12 [ipt_TOS ipt_MASQUERADE ipt_REJECT
ipt_pkttype ipt_state ipt_multiport ipt_conntrack iptable_filter
iptable_mangle iptable_nat]af_packet              12744   2 (autoclean)
uhci                   23548   0 (unused)
usbcore                58028   1 [uhci]
sd_mod                 11308   0 (unused)
cmpci                  26764   6
soundcore               3556   2 [cmpci]
gameport                1548   0 [cmpci]
agpgart                33024   3
tulip                  39776   2
crc32                   2880   0 [tulip]
ide-scsi                9232   0
scsi_mod               90944   2 [sd_mod ide-scsi]
ide-floppy             12316   0
rtc                     6504   0 (autoclean)
ext3                   59908   6 (autoclean)
jbd                    38436   6 (autoclean) [ext3]
ide-detect               288   0 (autoclean) (unused)
piix                    8136   1 (autoclean)
ide-disk               14528   7 (autoclean)
pdc202xx_new            7012   1 (autoclean)
unix                   14476 376 (autoclean)
ide-core              103132   7 (autoclean) [ide-scsi ide-floppy
ide-detect piix ide-disk pdc202xx_new]

7.4 cat /proc/ioports /proc/iomem
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
0200-0207 : cmpci GAME
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
9000-901f : Intel Corp. 82801BA/BAM USB (Hub #2)
  9000-901f : usb-uhci
9400-941f : Intel Corp. 82801BA/BAM USB (Hub #1)
  9400-941f : usb-uhci
9800-980f : Intel Corp. 82801BA IDE U100
  9800-9807 : ide0
  9808-980f : ide1
a400-a4ff : Lite-On Communications Inc LNE100TX (#2)
  a400-a4ff : tulip
a800-a8ff : Lite-On Communications Inc LNE100TX
  a800-a8ff : tulip
b000-b00f : Promise Technology, Inc. 20268
  b000-b007 : ide2
  b008-b00f : ide3
b400-b403 : Promise Technology, Inc. 20268
b800-b807 : Promise Technology, Inc. 20268
d000-d003 : Promise Technology, Inc. 20268
  d002-d002 : ide2
d400-d407 : Promise Technology, Inc. 20268
  d400-d407 : ide2
d800-d8ff : C-Media Electronics Inc CM8738
  d800-d8ff : cmpci
e800-e80f : Intel Corp. 82801BA/BAM SMBus
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffebfff : System RAM
  00100000-001ee8c3 : Kernel code
  001ee8c4-00253f43 : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
e9800000-e98000ff : Lite-On Communications Inc LNE100TX (#2)
  e9800000-e98000ff : tulip
ea000000-ea0000ff : Lite-On Communications Inc LNE100TX
  ea000000-ea0000ff : tulip
ea800000-ea803fff : Promise Technology, Inc. 20268
eb000000-eb0000ff : NEC Corporation USB 2.0
eb800000-eb800fff : NEC Corporation USB (#2)
ec000000-ec000fff : NEC Corporation USB
ec800000-eddfffff : PCI Bus #01
  ec800000-ecffffff : Matrox Graphics, Inc. MGA G550 AGP
  ed000000-ed003fff : Matrox Graphics, Inc. MGA G550 AGP
edf00000-efffffff : PCI Bus #01
  ee000000-efffffff : Matrox Graphics, Inc. MGA G550 AGP
f0000000-f7ffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

7.5 Output of lspci -vvv as root

0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
	Subsystem: Asustek Computer, Inc.: Unknown device 8070
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] #09 [9104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: ec800000-eddfffff
	Prefetchable memory behind bridge: edf00000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000dfff
	Memory behind bridge: e9800000-ec7fffff
	Prefetchable memory behind bridge: ede00000-edefffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 8028
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 9800 [size=16]

0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8028
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 9400 [size=32]

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
	Subsystem: Asustek Computer, Inc.: Unknown device 8028
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at e800 [size=16]

0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8028
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at 9000 [size=32]

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at ed000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at ec800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at edfe0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

0000:02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:04.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. PCI-USB2 (OHCI subsystem)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:04.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. PCI-USB2 (OHCI subsystem)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at eb800000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:04.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. PCI-USB2 (EHCI subsystem)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin C routed to IRQ 9
	Region 0: Memory at eb000000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at b800 [size=8]
	Region 3: I/O ports at b400 [size=4]
	Region 4: I/O ports at b000 [size=16]
	Region 5: Memory at ea800000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0c.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

0000:02:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at e9800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

7.6 SCSI information
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Memorex  Model: 24MAXX 1040      Rev: 5WS2
  Type:   CD-ROM                           ANSI SCSI revision: 02

