Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUBPT07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUBPTY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:24:26 -0500
Received: from mail.ondacorp.com.br ([200.195.196.14]:430 "EHLO
	mail.ondacorp.com.br") by vger.kernel.org with ESMTP
	id S265878AbUBPTXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:23:18 -0500
Message-ID: <403118A3.6010300@arenanetwork.com.br>
Date: Mon, 16 Feb 2004 16:23:15 -0300
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Organization: ArenaNetwork Lan House & Cyber
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2: P4 ClockMod speed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

I have a P4 2.4 running @ 3.12GHz. In 2.6.0, i could change it frequency 
via speedfreqd(8) up to its actual speed. Since 2.6.1, its max speed is 
locked on cpu *real* speed.

Is there anything to do so i can reuse old fashioned way?

Please c/c me as i'm not on list.

TIA.

hquest@phoenix:/proc$ more cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 3124.376
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6176.76

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 3124.376
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6242.30

hquest@phoenix:/proc$ speedfreq
Current policy is performance
hquest@phoenix:/proc$ speedfreq -c
CPU speed: min 300MHz, max 2400MHZ, current 2400MHz; 0.00% idle
hquest@phoenix:/proc$ cd /sys/devices/system/cpu/cpu0/cpufreq
hquest@phoenix:/sys/devices/system/cpu/cpu0/cpufreq$ more *
::::::::::::::
cpuinfo_max_freq
::::::::::::::
2400000
::::::::::::::
cpuinfo_min_freq
::::::::::::::
300000
::::::::::::::
scaling_available_frequencies
::::::::::::::
300000 600000 900000 1200000 1500000 1800000 2100000 2400000
::::::::::::::
scaling_available_governors
::::::::::::::
userspace performance
::::::::::::::
scaling_driver
::::::::::::::
p4-clockmod
::::::::::::::
scaling_governor
::::::::::::::
performance
::::::::::::::
scaling_max_freq
::::::::::::::
2400000
::::::::::::::
scaling_min_freq
::::::::::::::
300000
hquest@phoenix:/sys/devices/system/cpu/cpu0/cpufreq$ _

-- 
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br
