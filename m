Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbTISOjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 10:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTISOjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 10:39:17 -0400
Received: from rdu168-183-242.nc.rr.com ([24.168.183.242]:50636 "EHLO
	salusa.ix.dyndns.org") by vger.kernel.org with ESMTP
	id S261581AbTISOjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 10:39:15 -0400
Subject: PCI/ACPI related boot hang with 2.6.0-test5-bk3 on KT266A mobo
From: Jeffrey Layton <jtlayton@poochiereds.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063982354.17540.173.camel@tesla.mmt.bellhowell.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 10:39:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to be having a problem booting my main home machine with the
2.6.0-test5 kernels. I'm able to boot it with the flags 'acpi=off',
'acpi=ht', or 'pci=noacpi', but without one of these, it hangs just
after outputting this line:

mice: PS/2 mouse device common for all mice

The problem is easily reproducable. It hung with the stock -test5 kernel
and with -test5-bk3. 2.4.22 doesn't seem to have this problem. I am
using the binary nvidia module, but the problem occurs before it gets
plugged in. When the hang occurs, the magic sysrq key doesn't respond,
so I don't have much info to go on.

The machine in question has a Epox 8KHA+ motherboard with 1G of memory.
It has a VIA KT266A chipset.

Here is lspci output:
jtlayton@tleilax:~% lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP]
00:0a.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
00:0a.1 Input device controller: Creative Labs SB Audigy MIDI/Game port
(rev 03)00:0a.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire
Port
00:0d.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet
10/100 model NC100 (rev 11)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4200] (rev a3)

Here is /proc/cpuinfo:

jtlayton@tleilax:~% cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2138.524
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
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4210.68

I'll happily provide more info or test patches for this if you can tell
me what you need. As I'm not a LKML subscriber, please reply to me
directly.

Thanks,
-- 
Jeffrey Layton <jtlayton@poochiereds.net>

