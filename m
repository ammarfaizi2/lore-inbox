Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUAPLvk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 06:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUAPLvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 06:51:40 -0500
Received: from zeus.gup.uni-linz.ac.at ([140.78.104.2]:28362 "HELO
	zeus.gup.uni-linz.ac.at") by vger.kernel.org with SMTP
	id S265309AbUAPLvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 06:51:37 -0500
Message-ID: <4007D047.40306@gup.jku.at>
Date: Fri, 16 Jan 2004 12:51:35 +0100
From: Martin Polak <mpolak@gup.jku.at>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.5) Gecko/20031117
X-Accept-Language: de-at, de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Wrong Setup of SMP irq affinity on X86_64 2.6.1
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.

It seems that the smp-affinity value gets initialized the wrong way on 
boot. On my 2 cpu opteron 240 Machine all interrupts get delivered to 
cpu0. When I cat the current setting of the /proc/irq/#/smp_affinity
it shows a value of '3' . When setting it manually to ffffffffffffffff
interrupts get delivered to both cpus as it should be.

Could this be an endianess issue, as 3 would be ok, if the first two
cpus should be enabled, but not if bytes get swapped?

3.
kernel, smp, irq_affinity, x86_64

4.
Linux version 2.6.1-gentoo (root@orthrus) (gcc-Version 3.3.2 20031022 
(Gentoo Linux 3.3.2-r2, propolice)) #6 SMP Tue Jan 13 13:13:30 CET 2004

5.,6.
-not applicable-

7.1
Linux orthrus 2.6.1-gentoo #6 SMP Tue Jan 13 13:13:30 CET 2004 x86_64 5 
  GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      3.0-pre5
e2fsprogs              1.33
reiserfsprogs          3.6.8
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.13
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0.91
Modules Loaded         sd_mod sg floppy nvidia bcm5700

7.2
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1403.211
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 
3dnowext 3dnow
bogomips        : 2744.32
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
.. same as above..

rest...
not applicable or unnescesarry


Greets

Martin Polak






