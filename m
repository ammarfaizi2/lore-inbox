Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVI2GTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVI2GTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVI2GTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:19:49 -0400
Received: from fraserv1.smcc.de ([217.110.115.151]:58789 "EHLO
	fraserv1.smcc.de") by vger.kernel.org with ESMTP id S1751226AbVI2GTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:19:49 -0400
Message-ID: <433B876C.90706@smcc.de>
Date: Thu, 29 Sep 2005 08:19:24 +0200
From: =?UTF-8?B?VGhvbWFzIEx1w59uaWc=?= <lussnig@smcc.de>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: PROBLEM: Badness in kref_get at /home/inst/linux-2.6.13.2/lib/kref.c:32
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in the Bootup i got this ERROR Warning.

[17179574.472000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179574.700000] Badness in kref_get at 
/home/inst/linux-2.6.13.2/lib/kref.c:32
[17179574.700000]  [<c022569f>] kref_get+0x3f/0x50
[17179574.700000]  [<c0224bf7>] kobject_get+0x17/0x20
[17179574.700000]  [<c02248ae>] kobject_init+0x2e/0x50
[17179574.700000]  [<c0224a10>] kobject_register+0x20/0x80
[17179574.700000]  [<c013c9c2>] mod_sysfs_setup+0x62/0xd0
[17179574.700000]  [<c013df20>] load_module+0xa50/0xbf0
[17179574.700000]  [<c01575d3>] do_mmap_pgoff+0x5e3/0x820
[17179574.700000]  [<c013e161>] sys_init_module+0x71/0x240
[17179574.700000]  [<c0103197>] sysenter_past_esp+0x54/0x75
[17179575.676000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12)
[17179575.708000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 
12) *0, disabled.

This happens on 2 different Boards with 2 different CPU's

cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 44
model name      : AMD Sempron(tm) Processor 3000+
stepping        : 2
cpu MHz         : 1800.131
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt 
lm 3dnowext 3dnow pni lahf_lm
bogomips        : 3604.44


cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 1800+
stepping        : 1
cpu MHz         : 1500.125
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
bogomips        : 3004.00

./ver_linux
Linux susi 2.6.13.2.k7 #1 SMP Wed Sep 28 09:24:17 CEST 2005 i686 unknown 
unknown GNU/Linux
Gnu C                  4.0.1
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.38
reiserfsprogs          3.6.17
reiser4progs           line
pcmcia-cs              3.2.7
PPP                    2.4.2
isdn4k-utils           3.2p1
Linux C Library        > /opt/glibc/lib/libc.so.6
Dynamic linker (ldd)   2.3.90
Linux C++ Library      ..
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   062
re

