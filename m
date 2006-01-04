Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbWADSts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbWADSts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbWADSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:49:48 -0500
Received: from [195.177.114.17] ([195.177.114.17]:57325 "EHLO
	powerman.sky.net.ua") by vger.kernel.org with ESMTP id S965265AbWADSts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:49:48 -0500
Date: Wed, 4 Jan 2006 20:49:27 +0200
From: Alex Efros <powerman@sky.net.ua>
To: linux-kernel@vger.kernel.org
Subject: Hyper Threading slowdown
Message-ID: <20060104184927.GF13953@home.power>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: asdfGroup Inc., http://www.asdfGroup.com/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I notice Hyper Threading slowdown and kernel hangs while boot on:
    2.6.14.2
    2.6.15_rc6 with & without this patch:
	http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=1e483969930a82e16767884449f3a121a817ef00;hp=4c0335526c95d90a1d958e0059f40a5745fc7c5d
    2.6.15
(tested on two (similar) servers).

All details available here: http://bugs.gentoo.org/show_bug.cgi?id=115781

Below is my /proc/cpuinfo (without SMP) from these two servers.
If you need more details - email me (I'm not subscribed to this maillist).

---server1---
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 3
cpu MHz         : 3000.477
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm pni monitor ds_cpl est cid cx16 xtpr
bogomips        : 6008.95

---server2---
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 4
cpu MHz         : 2993.283
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid xtpr
bogomips        : 5993.49

-- 
			WBR, Alex.
