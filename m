Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318175AbSHFHVY>; Tue, 6 Aug 2002 03:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318340AbSHFHVX>; Tue, 6 Aug 2002 03:21:23 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:38021 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S318175AbSHFHVW> convert rfc822-to-8bit;
	Tue, 6 Aug 2002 03:21:22 -0400
From: Andris Pavenis <pavenis@latnet.lv>
To: tmus@get2net.dk
Subject: Re: i810 sound broken...
Date: Tue, 6 Aug 2002 10:24:49 +0300
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200208061024.49286.pavenis@latnet.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i810_audio works for me with 2.4.19-ac3 without problems (kernel was built
with gcc-3.1). Also no problems with loading i810 modules. I still had trouble
with modules before I upgraded modutils from 2.4.16 to 2.4.19

Only had to build lm_sensors with old gcc-2.95.3 otherwise their modules
load about 2 minutes (but still works after that)

Andris

bash-2.05a# uname -a
Linux hal 2.4.19-ac3 #2 Mon Aug 5 11:17:44 EEST 2002 i686 unknown
bash-2.05a# dmesg | sed 1q
Linux version 2.4.19-ac3 (root@hal) (gcc version 3.1) #2 Mon Aug 5 11:17:44 EEST 2002
bash-2.05a# lsmod
Module                  Size  Used by    Not tainted
w83781d                19224   0  (unused)
i2c-i801                4340   0  (unused)
i2c-i810                2348   0  (unused)
i810_audio             22600   1
ac97_codec             10920   0  [i810_audio]
nls_iso8859-1           2844   2  (autoclean)
nls_cp437               4348   2  (autoclean)
bash-2.05a# lspci -v
00:00.0 Host bridge: Intel Corp. 82810 GMCH [Graphics Memory Controller Hub] (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 801f
        Flags: bus master, fast devsel, latency 0

00:01.0 VGA compatible controller: Intel Corp. 82810 CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 801f
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Memory at e3800000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 1

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e3000000-e37fffff

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corp. 82801AA IDE
        Flags: bus master, medium devsel, latency 0
        [virtual] I/O ports at 01f0
        [virtual] I/O ports at 03f4
        [virtual] I/O ports at 0170
        [virtual] I/O ports at 0374
        I/O ports at b800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801AA USB
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at b400 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
        Subsystem: Intel Corp. 82801AA SMBus
        Flags: medium devsel, IRQ 5
        I/O ports at e800 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
        Subsystem: Analog Devices: Unknown device 1043
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]

01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at d800 [size=256]
        Memory at e3000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

