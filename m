Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTKJUdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 15:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTKJUdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 15:33:08 -0500
Received: from 30.226-200-80.adsl.skynet.be ([80.200.226.30]:58116 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S264113AbTKJUdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 15:33:01 -0500
Message-ID: <3FAFF601.1070101@trollprod.org>
Date: Mon, 10 Nov 2003 21:33:05 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tony@atomide.com
Cc: linux-kernel@vger.kernel.org
Subject: Re:[PATCH] amd76x_pm on 2.6.0-test9 more cleanup and clock skew test
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

skewtest.sh results for MSI K7D Master MB (2 Athlon MP 1500)

Olivier

----------------
Running test for kernel version 2.6.0-test9
This test will take about 140 seconds to run

ACPI interrupts before the first test:
   9:          0          0   IO-APIC-level  acpi

Running test without amd76x_pm module
                                            --- current ---    -- 
suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick 
  freq
1068494427      462.635489     462.635489   10000         0
1068494437      462.640807       0.005319   10000         0
1068494447      462.643195       0.002388   10000         0     9998 
-2540954
1068494457      462.648540       0.005346   10000         0     9995 
-2264529
1068494467      462.650932       0.002392   10000         0     9998 
-2566735
1068494477      462.652406       0.001474    9998  -2566735     9996 
882936
1068494487      462.655349       0.002944    9998  -2566735     9995 
-2197058
1068494497      462.656817       0.001468    9998  -2566735     9996 
922780

ACPI interrupts after the first test:
   9:          0          0   IO-APIC-level  acpi

Running test with amd76x_pm module
                                            --- current ---    -- 
suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick 
  freq
1068494507      462.655675     462.655675   10000         0
1068494517      462.662003       0.006329   10000         0
1068494527      462.665392       0.003389   10000         0     9997 
-2546729
1068494537      462.670736       0.005345   10000         0     9995 
-2259060
1068494547      462.673123       0.002387   10000         0     9998 
-2533142
1068494557      462.678602       0.005479    9998  -2533141     9992 
883274
1068494567      462.681072       0.002471    9998  -2533141     9995 
936536
1068494577      462.682542       0.001470    9998  -2533141     9996 
943092

ACPI interrupts after the second test:
   9:          0          0   IO-APIC-level  acpi

------------------------
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1800+
stepping        : 2
cpu MHz         : 1533.698
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
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3014.65



processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP
stepping        : 2
cpu MHz         : 1533.698
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
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3063.80


---------------------------
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] 
AMD-768 [Opus] Audio (rev 03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05)
01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a2)
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB 
(rev 07)
02:06.0 USB Controller: NEC Corporation USB (rev 41)
02:06.1 USB Controller: NEC Corporation USB (rev 41)
02:06.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
02:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 10)



