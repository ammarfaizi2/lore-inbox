Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUAAX5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUAAX5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:57:20 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:12815 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261890AbUAAX5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:57:06 -0500
Message-ID: <3FF4B3E7.9050309@zwanebloem.nl>
Date: Fri, 02 Jan 2004 00:57:27 +0100
From: Tommy Faasen <tommy@zwanebloem.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org
Subject: BUG: 2.6.0 non fatal recoverable errors crash gcc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-zwanebloem-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not subscribed to this newsgroup, but i'll try to read the follow-up 
messages if any.

When my machine is doing big compiles like the kernel or mythtv , 
gcc/g++ crashes.
This happens after syslog tell me  that there is a recoverable error 
(see output below).
This happened several times but I don't know why and what I can do about 
it ..
The machine seems to be very stable, but it could be a hardware problem 
i guess.

I'm using a stock 2.6.0 kernel on a duron 1300 on a via kt133a chipset 
and has 640MB memory, extra information can be found below, if you need 
more information please let me know.


make[2]: *** [asf.o] Error 1
make[2]: Leaving directory `/mnt/diskb/newsan/mythtv-0.13/libs/libavformat'
make[1]: *** [sub-libavformat] Error 2
make[1]: Leaving directory `/mnt/diskb/newsan/mythtv-0.13/libs'
make: *** [sub-libs] Error 2
thuis:/mnt/diskb/newsan/mythtv-0.13#
Message from syslogd@thuis at Thu Jan  1 21:21:12 2004 ...
thuis kernel: MCE: The hardware reports a non fatal, correctable 
incident occurred on CPU 0.

Message from syslogd@thuis at Thu Jan  1 21:21:12 2004 ...
thuis kernel: Bank 0: a600000000000175

thuis:/mnt/diskb/newsan/mythtv-0.13# uname -a
Linux thuis 2.6.0-1-k7 #1 Mon Dec 29 17:23:22 CET 2003 i686 unknown
thuis:/mnt/diskb/newsan/mythtv-0.13# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
        Flags: bus master, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: da000000-dbffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel
        Capabilities: [68] Power Management version 2

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
        Subsystem: VIA Technologies, Inc.: Unknown device 4511
        Flags: medium devsel, IRQ 10
        I/O ports at cc00 [size=256]
        I/O ports at d000 [size=4]
        I/O ports at d400 [size=4]
        Capabilities: [c0] Power Management version 2

00:09.0 SCSI storage controller: Adaptec AHA-2940U2/W
        Subsystem: Adaptec: Unknown device a180
        Flags: bus master, medium devsel, latency 32, IRQ 11
        BIST result: 00
        I/O ports at d800 [disabled] [size=256]
        Memory at dd200000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:0a.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)
        Subsystem: Compaq Computer Corporation NC3120
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at dd204000 (32-bit, prefetchable) [size=4K]
        I/O ports at dc00 [size=32]
        Memory at dd000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at dd201000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at dd202000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

00:0c.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)
        Subsystem: Compaq Computer Corporation NC3120
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at dd203000 (32-bit, prefetchable) [size=4K]
        I/O ports at e000 [size=32]
        Memory at dd100000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 
15) (prog-if 00 [VGA])
        Subsystem: Unknown device 17f2:4010
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 12
        Memory at da000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

