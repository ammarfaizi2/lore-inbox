Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSGFOH5>; Sat, 6 Jul 2002 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSGFOH4>; Sat, 6 Jul 2002 10:07:56 -0400
Received: from moutng0.kundenserver.de ([212.227.126.170]:15298 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315529AbSGFOHy> convert rfc822-to-8bit; Sat, 6 Jul 2002 10:07:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Christian =?iso-8859-15?q?Borntr=E4ger?= <linux@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1: NETDEV WATCHDOG: eth0: transmit timed out 
Date: Sat, 6 Jul 2002 15:10:29 +0100
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207061510.29594.linux@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I found some of these messages in the archive, but nothing really helped me.
I have to remove the 3c59x driver , because network restart is not enough to 
bring back life to my network connection.

I never saw this message with older kernels (<=2.4.18), but I moved to another 
place with another network, so I am not sure if it is related to some 
hardware problems or driver trouble.

The 3com shares the interrupt with some other cards on an KT133A-chipset. This 
happens unfrequent but mostly when I have high traffic.

Thanks in advance

Christian 


dmesg:
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0ed8 media 88a0 dma 000000a0.
  Flags; bus-master 1, dirty 57811(3) current 57827(3)
  Transmit list 1cb202c0 vs. dcb202c0.
  0: @dcb20200  length 8000002a status 0000002a
  1: @dcb20240  length 8000002a status 8000002a
  2: @dcb20280  length 8000002a status 8000002a
  3: @dcb202c0  length 8000002a status 0000002a
  4: @dcb20300  length 8000002a status 0000002a
  5: @dcb20340  length 8000002a status 0000002a
  6: @dcb20380  length 8000002a status 0000002a
  7: @dcb203c0  length 8000002a status 0000002a
  8: @dcb20400  length 8000002a status 0000002a
  9: @dcb20440  length 8000002a status 0000002a
  10: @dcb20480  length 8000002a status 0000002a
  11: @dcb204c0  length 8000002a status 0000002a
  12: @dcb20500  length 8000002a status 0000002a
  13: @dcb20540  length 8000002a status 0000002a
  14: @dcb20580  length 8000002a status 0000002a
  15: @dcb205c0  length 8000002a status 0000002a
eth0: Resetting the Tx ring pointer.



lspci:
[root@dyn295 borni]# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Flags: bus master, medium devsel, latency 8
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d5000000-d66fffff
        Prefetchable memory behind bridge: d7f00000-dfffffff
        Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 02)
        Subsystem: Askey Computer Corp.: Unknown device 3002
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at d7000000 (32-bit, prefetchable) [size=4K]

00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
02)
        Subsystem: Askey Computer Corp.: Unknown device 3002
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at d6800000 (32-bit, prefetchable) [size=4K]

00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Flags: bus master, slow devsel, latency 32, IRQ 5
        I/O ports at a400 [size=64]

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at a000 [size=128]
        Memory at d4800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 
02)
        Subsystem: Promise Technology, Inc. Ultra100
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 9800 [size=8]
        I/O ports at 9400 [size=4]
        I/O ports at 9000 [size=8]
        I/O ports at 8800 [size=4]
        I/O ports at 8400 [size=64]
        Memory at d4000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev 
a1) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. AGP-V7100 Pro
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at d5000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at d7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0


lsmod: 

Module                  Size  Used by    Not tainted
3c59x                  27184   1
es1370                 25708   1
soundcore               4036   4  [es1370]
af_packet              13416   1  (autoclean)
iptable_mangle          2168   0  (autoclean) (unused)
iptable_nat            14424   0  (autoclean) (unused)
ipt_LOG                 3416   2  (autoclean)
ipt_limit                888   2  (autoclean)
iptable_filter          1740   1  (autoclean)
ip_tables              11704   7  [iptable_mangle iptable_nat ipt_LOG 
ipt_limit iptable_filter]
usb-uhci               22860   0  (unused)
nls_iso8859-1           2876   3  (autoclean)
isofs                  26548   3  (autoclean)
inflate_fs             17892   0  (autoclean) [isofs]
loop                    9496   9  (autoclean)
nls_iso8859-15          3388   1  (autoclean)
nls_cp437               4380   1  (autoclean)
vfat                   10332   1  (autoclean)
fat                    32984   0  (autoclean) [vfat]
sr_mod                 15480   0  (autoclean)
cdrom                  28544   0  (autoclean) [sr_mod]
w83781d                19344   0  (unused)
i2c-proc                7152   0  [w83781d]
i2c-viapro              3920   0  (unused)
i2c-core               13540   0  [w83781d i2c-proc i2c-viapro]
ide-scsi                8784   0
scsi_mod               55316   2  [sr_mod ide-scsi]
keybdev                 2080   0  (unused)
mousedev                4244   1
hid                    15012   0  (unused)
usbmouse                2260   0  (unused)
usbcore                60576   1  [usb-uhci hid usbmouse]
input                   3584   0  [keybdev mousedev usbmouse]
ip_conntrack_ftp        3680   0  (unused)
ip_conntrack           14972   2  [iptable_nat ip_conntrack_ftp]
rtc                     6940   0  (autoclean)

