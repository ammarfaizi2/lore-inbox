Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270375AbTGRVnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270409AbTGRVmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:42:18 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:22983
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S271799AbTGRVip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:38:45 -0400
Message-ID: <3F186C64.7020205@tupshin.com>
Date: Fri, 18 Jul 2003 14:53:40 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: spontaneous reboot with 2.6.0-test1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a spontaneous (and apparently random) reboot that happens 
every couple hours or so when running 2.6.0-test1. The reboot is 
instantaneous, goes straight to blank screen, followed immediately by 
bios startup screens. No error is visible or logged. The same machine is 
completely stable on 2.4.2x and on WinXP. I have run memtest overnight 
with no problems. The problem happens on either heavy or light load.

FWIW, I saw the same problems with earlier 2.5 kernels, but it wasn't 
untnil 2.5.75 or so that other things got stable enough for me to worry 
about this problem.

Can someone give me some pointers on the best way to track this 
down(e.g. which debug options in the kernel might be useful), or give me 
some guesses about what might be causing it if it's related to the 
hardware as shown by lspci -v below? Additional info: running debian 
sid, nfs mounting a number of partitions, gcc version 3.3.1 (from sid), 
and kernel compiled to target a K7 cpu as I'm running an Athlon XP.

-Thanks
-Tupshin

lscpi output:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: Asustek Computer, Inc. A7V333 Mainboard
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d7000000-d7efffff
        Prefetchable memory behind bridge: d7f00000-dfffffff
        Capabilities: [80] Power Management version 2
 
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 17
        I/O ports at b800 [size=256]
        Capabilities: [c0] Power Management version 2
 
00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2
 
00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Flags: bus master, medium devsel, latency 32, IRQ 16
        I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2
 
00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 
20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8080
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at d6800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
 
00:0f.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
        Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at a800 [size=256]
        Memory at d6000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
 
00:10.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24] 
(rev 02)
        Subsystem: IC Ensemble Inc: Unknown device d634
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at a400 [size=32]
        I/O ports at a000 [size=16]
        I/O ports at 9800 [size=16]
        I/O ports at 9400 [size=64]
        Capabilities: [80] Power Management version 1
 
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
 
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Flags: bus master, medium devsel, latency 32
        I/O ports at 9000 [size=16]
        Capabilities: [c0] Power Management version 2
 
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at 8800 [size=32]
        Capabilities: [80] Power Management version 2
 
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23) (prog-if 00 
[UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at 8400 [size=32]
        Capabilities: [80] Power Management version 2
 
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL 
[Radeon 8500 LE] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 8500
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, 
IRQ 16
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2


