Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUJURJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUJURJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbUJURHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:07:18 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:59285 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S270718AbUJUQ4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:56:45 -0400
From: Jan Killius <jkillius@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: cpufreq problems
Date: Thu, 21 Oct 2004 18:56:42 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410211856.42670.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm using the cpufreq ondemand scaling governor for my athlon64 system. My 
problem is every time the governor is scaling up the cpu frequency, my sound 
is stuttering for a second. I'm using jack for my sound output. First 
everything is ok the daemon is starting up without a delay. But if the cpu 
speed goes high I'm getting a continuous delay of ~30694.000 usecs...
At the moment im using 2.6.9-ck1. The problem exists also in 2.6.9 and every     
other 2.6 kernel, that I've used before with this feature. Before 2.6.9 I had 
used the cpudyn daemon for it, there occur the same problem.

/proc/cpuinfo(low freq):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 8
cpu MHz         : 879.954
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 syscallnx mmxext lm 3dnowext 3dnow
bogomips        : 1730.15
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

/proc/cpuinfo(high freq):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 8
cpu MHz         : 2199.887
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 syscallnx mmxext lm 3dnowext 3dnow
bogomips        : 4325.37
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


--
        Jan
