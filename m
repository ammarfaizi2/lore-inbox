Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUILIc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUILIc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 04:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUILIc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 04:32:29 -0400
Received: from ihme.org ([212.226.113.138]:18838 "EHLO ihme.org")
	by vger.kernel.org with ESMTP id S268189AbUILIbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 04:31:38 -0400
Date: Sun, 12 Sep 2004 11:31:37 +0300 (EEST)
From: Miika Pekkarinen <miipekk@ihme.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel crash (2.4.27)
Message-ID: <Pine.LNX.4.58.0409121126180.15228@ihme.ihme.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We had 2.4.25-grsec kernel which crashed after about 201 days of
uptime. After that we compiled 2.4.27 kernel with grsecurity and that
kernel crashed very soon. Uptime was less than a day.
Unfortunately kernel was not compiled with frame pointers. Now we have
frame pointers enabled and if it crashes yet again we'll post some
more info.

Swap partition was tested with bonie++ and badblocks. No errors were
found.  The partition is also on a raid-5 device.

----

kernel BUG at dcache.c:345!
invalid operand: 0000
CPU:    2
EIP:    0010:[<c02703bd>]   Not tainted
EFLAGS: 00010286
eax: ffffffff   ebx: f2c94898   ecx: cde32e00   edx: d4bcb798
esi: f2c94880   edi: e2db7580   edp: 00000bc3   esp: c222df1c
ds: 0018	es: 0018        ss: 0018
Process kswapd (pid: 7, stackpage=c222d000)
Stack: cde32e00 e5ba0d00 00000004 c1231d70 c01047d8 0000c808 c0270814 0000359d
       c024ffb0 00000006 000001d0 ffffffff 000001d0 00000004 0000001c 000001d0
       c01047d8 c01047d8 c025041a c222df88 000001d0 0000003c 00000020 c0250492
Call Trace:    [<c0270814>] [<c024ffb0>] [<c025041a>] [<c0250492>] [<c022f9d1>]
  [<c0250656>] [<c02506c8>] [<c0250808>] [<c021c65e>] [<c0250770>]

Code: 0f 0b 59 01 2f 36 4b c0 8d 43 f8 8b 53 f8 8b 48 04 89 11 89

----

Hardware information:
Intel Server Board SE7500CW2
Dual Xeon 2.4GHz

11:12:09 ~# cat /proc/cpuinfo
stepping        : 4
cpu MHz         : 2392.298
cache size      : 512 KB
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
bogomips        : 4771.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.40GHz
stepping        : 4
cpu MHz         : 2392.298
cache size      : 512 KB
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
bogomips        : 4784.12

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.40GHz
stepping        : 4
cpu MHz         : 2392.298
cache size      : 512 KB
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
bogomips        : 4784.12

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.40GHz
stepping        : 4
cpu MHz         : 2392.298
cache size      : 512 KB
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
bogomips        : 4784.12

11:21:09 ~# lspci
0000:00:00.0 Host bridge: Intel Corp. E7500 Memory Controller Hub (rev 03)
0000:00:00.1 ff00: Intel Corp. E7500/E7501 Host RASUM Controller (rev 03)
0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-PCI Bridge (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
0000:01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
0000:01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
0000:01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
0000:01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
0000:03:01.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
0000:04:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:04:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
0000:04:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
0000:04:06.0 RAID bus controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
----


-- 
Miika Pekkarinen <miika at ihme.org>



