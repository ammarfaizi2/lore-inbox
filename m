Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263194AbVEGOPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbVEGOPY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 10:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbVEGOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 10:15:24 -0400
Received: from derlin.nsgroup.net ([195.84.17.145]:43656 "EHLO
	derlin.nsgroup.net") by vger.kernel.org with ESMTP id S263194AbVEGOPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 10:15:16 -0400
Subject: powernow-k8 in 2.6.8 - 2.6.11.8 causes system hang
From: Gustav Petersson <gustav.petersson@karlskrona.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 07 May 2005 16:15:14 +0200
Message-Id: <1115475314.4985.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, I haven't found any reports on this issue anywhere so I'm
starting to think it's a motherboard or BIOS issue but I figure I should
report it anyway.

I have an Asus K8N-E Deluxe (socket 754) with an Athlon64 3000+. I've
tried with different BIOS versions, from 1005 to 1007-beta without
success. 

I've tried using powernowd, cpufreqd, ondemand governor and userspace
governor and manually setting the speed. There is no error reported in
dmesg when the system starts to behave strangely, core dumps etc., and
eventually it hangs occasionally producing a kernel oops. Please tell me
if I've forgotten to include any infomation that could help you figure
out what the problem is.

Here is my /proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 12
model name      : AMD Athlon(tm) 64 Processor 3000+
stepping        : 0
cpu MHz         : 2009.811
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3981.31


...and the relevant parts of dmesg:
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version
1.00.09e)
powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
cpu_init done, current fid 0xc, vid 0x2

Br
Gustav Petersson

