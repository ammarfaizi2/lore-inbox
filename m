Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUEWXiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUEWXiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUEWXiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:38:25 -0400
Received: from mail01.powweb.com ([66.152.97.34]:12808 "EHLO mail01.powweb.com")
	by vger.kernel.org with ESMTP id S263743AbUEWXiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:38:06 -0400
From: Art <art@artstower.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel module "via-ircc" problem in 2.4.26 but not in 2.6.5
Date: Mon, 24 May 2004 01:37:58 +0200
User-Agent: KMail/1.6.2
Cc: art@artstower.com, dg1kjd@afthd.tu-darmstadt.de
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405240137.58055.art@artstower.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:
The module via-ircc prints error message on 2.4.25 and 2.4.26 kernels but not on 2.6.6-mm4 and vanilla 2.6.5.

[2.] Full description of the problem/report:
When I do "insmod via-ircc" I get:
--start--
Using /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irlap_open_R1698cb30
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irda_device_setup_Rd786063a
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irda_qos_bits_to_value_R448b8aaa
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irda_device_txqueue_empty_R548f6833
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol setup_dma_R01485953
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irda_device_set_media_busy_R51331c3a
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irda_init_max_qos_capabilies_R6b043eba
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irda_debug_R07c03e02
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol async_wrap_skb_R8738243f
/lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: /lib/modules/2.4.25-gentoo-r2/kernel/drivers/net/irda/via-ircc.o: unresolved symbol irlap_close_Rd8bd2ed6
--end--
I also get a similar error message with 2.4.26 but not with 2.6.6-mm4 and 2.6.5.

[3.] Keywords (i.e., modules, networking, kernel):
modules, irda, via-ircc

[4.] Kernel version (from /proc/version):
Linux version 2.4.25-gentoo-r2 (root@xmobile) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r5, ssp-3.3-7, pie-8.7.5.3)) #1 Sun May 23 21:37:29 CEST 2004

[5.] Output of Oops.. message (if applicable) with symbolic information resolved (see Documentation/oops-tracing.txt)
-

[6.] A small shell script or example program which triggers the problem (if possible)
insmod via-ircc

[7.] Environment
Gentoo Linux running 2.4.25-gentoo-r2 kernel.

[7.1.] Software (add the output of the ver_linux script here)
--start--
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux xmobile 2.4.25-gentoo-r2 #1 Sun May 23 21:37:29 CEST 2004 i686 Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz GenuineIntel GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35
jfsutils               1.1.5
xfsprogs               2.6.3
pcmcia-cs              3.2.7
PPP                    2.4.2
Linux C Library        2.3.3
head: `-1' option is obsolete; use `-n 1' since this will be removed in the future
Dynamic linker (ldd)   2.3.3
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nvidia mousedev usbmouse yenta_socket pcmcia_core ohci1394 ieee1394 via-rhine mii nls_iso8859-15 ntfs coda button fan battery ac thermal processor sr_mod sg ide-scsi scsi_mod hid uhci ehci-hcd usbcore
--end--

[7.2.] Processor information (from /proc/cpuinfo):
--start--
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
stepping        : 7
cpu MHz         : 1990.249
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
bogomips        : 3971.48
--end--

[7.3.] Module information (from /proc/modules):
--start--
nvidia               1965952   7 (autoclean)
mousedev                4340   1
usbmouse                2232   0 (unused)
yenta_socket           10880   0
pcmcia_core            46948   0 [yenta_socket]
ohci1394               25552   0 (unused)
ieee1394               47620   0 [ohci1394]
via-rhine              12944   1
mii                     2512   0 [via-rhine]
nls_iso8859-15          3356   4 (autoclean)
ntfs                   77388   4 (autoclean)
coda                   43524   0 (unused)
button                  2540   0 (unused)
fan                     1632   0 (unused)
battery                 5120   0 (unused)
ac                      1792   0 (unused)
thermal                 6276   0 (unused)
processor               8344   0 [thermal]
sr_mod                 13976   0 (unused)
sg                     28860   0 (unused)
ide-scsi               10192   0
scsi_mod               84160   3 [sr_mod sg ide-scsi]
hid                    21248   0 (unused)
uhci                   26188   0 (unused)
ehci-hcd               18948   0 (unused)
usbcore                63404   1 [usbmouse hid uhci ehci-hcd]
--end--

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
--start--(ioports)--
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
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
d000-d0ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  d000-d0ff : via-rhine
d400-d41f : VIA Technologies, Inc. USB (#3)
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. USB (#4)
  d800-d81f : usb-uhci
e000-e0ff : VIA Technologies, Inc. Intel 537 [AC97 Modem]
e400-e47f : VIA Technologies, Inc. IEEE 1394 Host Controller
e800-e81f : VIA Technologies, Inc. USB
  e800-e81f : usb-uhci
ec00-ec1f : VIA Technologies, Inc. USB (#2)
  ec00-ec1f : usb-uhci
fc00-fc0f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
  fc00-fc07 : ide0
  fc08-fc0f : ide1
--end--

--start--(iomem)
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d3fff : reserved
000f0000-000fffff : System ROM
00100000-27feffff : System RAM
  001a6000-00416241 : Kernel code
27ff0000-27ff7fff : ACPI Tables
27ff8000-27ffffff : ACPI Non-volatile Storage
28000000-28000fff : Texas Instruments PCI1410 PC card Cardbus Controller
28400000-287fffff : PCI CardBus #02
28800000-28bfffff : PCI CardBus #02
cdb00000-ddcfffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV17 [GeForce4 440 Go 64M]
    d0000000-d02fffff : vesafb
  ddc80000-ddcfffff : nVidia Corporation NV17 [GeForce4 440 Go 64M]
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV17 [GeForce4 440 Go 64M]
dffff000-dffff7ff : VIA Technologies, Inc. IEEE 1394 Host Controller
  dffff000-dffff7ff : ohci1394
dffffe00-dffffeff : VIA Technologies, Inc. VT6102 [Rhine-II]
  dffffe00-dffffeff : via-rhine
dfffff00-dfffffff : VIA Technologies, Inc. USB 2.0
  dfffff00-dfffffff : ehci_hcd
e0000000-e3ffffff : VIA Technologies, Inc. VT8753 [P4X266 AGP]
fff80000-ffffffff : reserved
--end--

[7.5.] PCI information ('lspci -vvv' as root)
--start--
pcilib: Cannot open /sys/bus/pci/devices
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8753 [P4X266 AGP] (rev 01)
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: cdb00000-ddcfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 0603
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at 28000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 28400000-287ff000 (prefetchable)
        Memory window 1: 28800000-28bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

0000:00:07.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c902
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at e800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 [UHCI])
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c902
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at ec00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device c902
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 20
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: Unknown device ff14:02c7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at e400 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 1203
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 30)
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 0403
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at 1000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 70)
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 1005
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 70)
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 0204
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 Go 64M] (rev a3) (prog-if 00 [VGA])
        Subsystem: TWINHEAD INTERNATIONAL Corp: Unknown device 030b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at ddc80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at dfee0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
--end--

[7.6.] SCSI information (from /proc/scsi/scsi)
Kernelparameter: hdc=ide-scsi
--start--
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QSI      Model: CDRW/DVD SBW-241 Rev: VK02
  Type:   CD-ROM                           ANSI SCSI revision: 02
--end--

[7.7.] Other information that might be relevant to the problem (please look in /proc and include all information that you think to be relevant):
-

[X.] Other notes, patches, fixes, workarounds:
I took the via-ircc.h and via-ircc.h from 2.6.6-mm4 and copied over the via-ircc.h and via-ircc.c from the vanilla 2.4.26 kernel, but insmod failed with a different error.
