Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284204AbRLYA7b>; Mon, 24 Dec 2001 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284240AbRLYA7W>; Mon, 24 Dec 2001 19:59:22 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:52133 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S284204AbRLYA7F>;
	Mon, 24 Dec 2001 19:59:05 -0500
Message-ID: <3C27CF50.1040500@candelatech.com>
Date: Mon, 24 Dec 2001 17:58:56 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tulip Mailing List <tulip@scyld.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Tulip + 3 4-port NICs problems...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still working on getting my 3 4-port DLINK NICs working.

I'm using the kernel's tulip driver (can't get pci-scan.o to load,
lots of unresolved symbols...)

I modified the tulip driver, changing MAX_UNITS to 24, TX-Queue to 64,
and RX-Queue to 128.

The driver now discovers all of the ports, but shows some IRQ problems with
some.  Also, when I do an ifconfig eth1 up, a **second** eth1 interface
shows up in 'ifconfig -a'.

I'm using a PCI riser card, so there could be a hardware problem...

I tried loading an un-modified de4x5 driver, but it only discovered
the first 8 ports...

Any ideas or suggestions will be welcomed!

(ifconfig -a, lspci -v, output found below)

Here's what I get when loading tulip the driver:

Dec 24 16:39:03 lanf1 kernel: Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
Dec 24 16:39:03 lanf1 kernel: tulip0:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip0:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth1: Digital DS21143 Tulip rev 65 at 0xcc00, 00:80:C8:B9:6B:54, IRQ 9.
Dec 24 16:39:03 lanf1 kernel: PCI: Enabling device 04:06.0 (0000 -> 0003)
Dec 24 16:39:03 lanf1 kernel: PCI: No IRQ known for interrupt pin A of device 04:06.0. Please try using pci=biosirq.
Dec 24 16:39:03 lanf1 kernel: PCI: Setting latency timer of device 04:06.0 to 64
Dec 24 16:39:03 lanf1 kernel: tulip1:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip1:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth2: Digital DS21143 Tulip rev 65 at 0xc400, 00:80:C8:B9:6B:53, IRQ 0.
Dec 24 16:39:03 lanf1 kernel: PCI: Enabling device 04:05.0 (0000 -> 0003)
Dec 24 16:39:03 lanf1 kernel: PCI: No IRQ known for interrupt pin A of device 04:05.0. Please try using pci=biosirq.
Dec 24 16:39:03 lanf1 kernel: PCI: Setting latency timer of device 04:05.0 to 64
Dec 24 16:39:03 lanf1 kernel: tulip2:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip2:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth3: Digital DS21143 Tulip rev 65 at 0xc080, 00:80:C8:B9:6B:52, IRQ 0.
Dec 24 16:39:03 lanf1 kernel: PCI: Enabling device 04:04.0 (0000 -> 0003)
Dec 24 16:39:03 lanf1 kernel: PCI: No IRQ known for interrupt pin A of device 04:04.0. Please try using pci=biosirq.
Dec 24 16:39:03 lanf1 kernel: PCI: Setting latency timer of device 04:04.0 to 64
Dec 24 16:39:03 lanf1 kernel: tulip3:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip3:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth4: Digital DS21143 Tulip rev 65 at 0xc000, 00:80:C8:B9:6B:51, IRQ 0.
Dec 24 16:39:03 lanf1 kernel: tulip4:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip4:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip4:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth5: Digital DS21143 Tulip rev 65 at 0xbc00, 00:80:C8:B9:6C:40, IRQ 11.
Dec 24 16:39:03 lanf1 kernel: tulip5:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip5:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip5:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth6: Digital DS21143 Tulip rev 65 at 0xb880, 00:80:C8:B9:6C:3F, IRQ 9.
Dec 24 16:39:03 lanf1 kernel: tulip6:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip6:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip6:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth7: Digital DS21143 Tulip rev 65 at 0xb800, 00:80:C8:B9:6C:3E, IRQ 10.
Dec 24 16:39:03 lanf1 kernel: tulip7:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip7:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip7:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth8: Digital DS21143 Tulip rev 65 at 0xb480, 00:80:C8:B9:6C:3D, IRQ 11.
Dec 24 16:39:03 lanf1 kernel: tulip8:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip8:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip8:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:03 lanf1 kernel: eth9: Digital DS21143 Tulip rev 65 at 0xac00, 00:80:C8:B9:6C:54, IRQ 10.
Dec 24 16:39:03 lanf1 kernel: tulip9:  EEPROM default media type Autosense.
Dec 24 16:39:03 lanf1 kernel: tulip9:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:03 lanf1 kernel: tulip9:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:04 lanf1 kernel: eth10: Digital DS21143 Tulip rev 65 at 0xa880, 00:80:C8:B9:6C:53, IRQ 11.
Dec 24 16:39:04 lanf1 kernel: tulip10:  EEPROM default media type Autosense.
Dec 24 16:39:04 lanf1 kernel: tulip10:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:04 lanf1 kernel: tulip10:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:04 lanf1 kernel: eth11: Digital DS21143 Tulip rev 65 at 0xa800, 00:80:C8:B9:6C:52, IRQ 11.
Dec 24 16:39:04 lanf1 kernel: tulip11:  EEPROM default media type Autosense.
Dec 24 16:39:04 lanf1 kernel: tulip11:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Dec 24 16:39:04 lanf1 kernel: tulip11:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Dec 24 16:39:04 lanf1 kernel: eth12: Digital DS21143 Tulip rev 65 at 0xa480, 00:80:C8:B9:6C:51, IRQ 9.


Here's what ifconfig -a looks like after eth1-8 has been set UP (notice the
repeated eth1-8 entries at the end of the listing)

[root@lanf1 root]# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:03:47:C2:A6:D2
           inet addr:192.168.1.55  Bcast:192.168.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:740 errors:0 dropped:0 overruns:0 frame:0
           TX packets:766 errors:0 dropped:0 overruns:0 carrier:0
           collisions:325
           RX bytes:95945 (93.6 Kb)  TX bytes:589324 (575.5 Kb)

eth1      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:54
           inet addr:172.1.1.210  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth2      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:53
           inet addr:172.1.1.211  Bcast:172.1.1.255  Mask:255.255.255.0
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth3      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:52
           inet addr:172.1.1.212  Bcast:172.1.1.255  Mask:255.255.255.0
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth4      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:51
           inet addr:172.1.1.213  Bcast:172.1.1.255  Mask:255.255.255.0
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth5      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:40
           inet addr:172.1.1.214  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth6      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:3F
           inet addr:172.1.1.215  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth7      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:3E
           inet addr:172.1.1.216  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth8      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:3D
           inet addr:172.1.1.217  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth9      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:54
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth10     Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:53
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth11     Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:52
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth12     Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:51
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth1      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:54
           inet addr:172.1.1.210  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth2      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:53
           inet addr:172.1.1.211  Bcast:172.1.1.255  Mask:255.255.255.0
           BROADCAST MULTICAST  MTU:1500  Metric:1

eth3      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:52
           inet addr:172.1.1.212  Bcast:172.1.1.255  Mask:255.255.255.0
           BROADCAST MULTICAST  MTU:1500  Metric:1

eth4      Link encap:Ethernet  HWaddr 00:80:C8:B9:6B:51
           inet addr:172.1.1.213  Bcast:172.1.1.255  Mask:255.255.255.0
           BROADCAST MULTICAST  MTU:1500  Metric:1

eth5      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:40
           inet addr:172.1.1.214  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth6      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:3F
           inet addr:172.1.1.215  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth7      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:3E
           inet addr:172.1.1.216  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

eth8      Link encap:Ethernet  HWaddr 00:80:C8:B9:6C:3D
           inet addr:172.1.1.217  Bcast:172.1.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:225 errors:0 dropped:0 overruns:0 frame:0
           TX packets:225 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0
           RX bytes:74276 (72.5 Kb)  TX bytes:74276 (72.5 Kb)

[root@lanf1 root]#


[root@lanf1 root]# lspci
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller]  (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 11)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 11)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 11)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 11)
00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 11)
00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 11)
00:1f.5 Multimedia audio controller: Intel Corporation 82801BA(M) AC'97 Audio (rev 11)
01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 03)
01:09.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:0a.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
03:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
03:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
03:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
03:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
04:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
04:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
04:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
04:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)


[root@lanf1 root]# lspci -v
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
         Subsystem: Intel Corporation: Unknown device 4532
         Flags: bus master, fast devsel, latency 0
         Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller]  (rev 02) (prog-if 00 [VGA])
         Subsystem: Intel Corporation: Unknown device 4532
         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
         Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
         Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 11) (prog-if 00 [Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=04, sec-latency=32
         I/O behind bridge: 0000a000-0000dfff
         Memory behind bridge: fef00000-ff8fffff
         Prefetchable memory behind bridge: f6700000-f6afffff

00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 11)
         Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 11) (prog-if 80 [Master])
         Subsystem: Intel Corporation: Unknown device 4532
         Flags: bus master, medium devsel, latency 0
         I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 11) (prog-if 00 [UHCI])
         Subsystem: Intel Corporation: Unknown device 4532
         Flags: bus master, medium devsel, latency 0, IRQ 11
         I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 11)
         Subsystem: Intel Corporation: Unknown device 4532
         Flags: medium devsel, IRQ 9
         I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 11) (prog-if 00 [UHCI])
         Subsystem: Intel Corporation: Unknown device 4532
         Flags: bus master, medium devsel, latency 0, IRQ 10
         I/O ports at ef80 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801BA(M) AC'97 Audio (rev 11)
         Subsystem: Intel Corporation: Unknown device 4656
         Flags: bus master, medium devsel, latency 0, IRQ 9
         I/O ports at e800 [size=256]
         I/O ports at ef00 [size=64]


01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 03)
         Subsystem: Intel Corporation: Unknown device 3013
         Flags: bus master, medium devsel, latency 32, IRQ 11
         Memory at ff8ff000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at df00 [size=64]
         Capabilities: [dc] Power Management version 2

01:09.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
         Flags: bus master, medium devsel, latency 32
         Bus: primary=01, secondary=04, subordinate=04, sec-latency=32
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: ff500000-ff7fffff
         Prefetchable memory behind bridge: 00000000f6900000-00000000f6900000
         Capabilities: [dc] Power Management version 1

01:0a.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
         Flags: bus master, medium devsel, latency 32
         Bus: primary=01, secondary=03, subordinate=03, sec-latency=32
         I/O behind bridge: 0000b000-0000bfff
         Memory behind bridge: ff200000-ff4fffff
         Prefetchable memory behind bridge: 00000000f6800000-00000000f6800000
         Capabilities: [dc] Power Management version 1

01:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
         Flags: bus master, medium devsel, latency 32
         Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000a000-0000afff
         Memory behind bridge: fef00000-ff1fffff
         Prefetchable memory behind bridge: 00000000f6700000-00000000f6700000
         Capabilities: [dc] Power Management version 1

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 9
         I/O ports at a480 [size=128]
         Memory at ff1ff000 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff0c0000 [disabled] [size=256K]

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at a800 [size=128]
         Memory at ff1ff400 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff100000 [disabled] [size=256K]

02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at a880 [size=128]
         Memory at ff1ff800 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff140000 [disabled] [size=256K]

02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at ac00 [size=128]
         Memory at ff1ffc00 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff180000 [disabled] [size=256K]

03:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at b480 [size=128]
         Memory at ff4ff000 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff3c0000 [disabled] [size=256K]

03:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at b800 [size=128]
         Memory at ff4ff400 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff400000 [disabled] [size=256K]

03:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 9
         I/O ports at b880 [size=128]
         Memory at ff4ff800 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff440000 [disabled] [size=256K]

03:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at bc00 [size=128]
         Memory at ff4ffc00 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff480000 [disabled] [size=256K]

04:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 64
         I/O ports at c000 [size=128]
         Memory at ff500000 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at <unassigned> [disabled] [size=256K]

04:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 64
         I/O ports at c080 [size=128]
         Memory at ff500400 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at <unassigned> [disabled] [size=256K]

04:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 64
         I/O ports at c400 [size=128]
         Memory at ff500800 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at <unassigned> [disabled] [size=256K]

04:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
         Subsystem: D-Link System Inc: Unknown device 1112
         Flags: bus master, medium devsel, latency 32, IRQ 9
         I/O ports at cc00 [size=128]
         Memory at ff7ffc00 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ff780000 [disabled] [size=256K]



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


