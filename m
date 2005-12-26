Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVLZIVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVLZIVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 03:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVLZIVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 03:21:06 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:58198 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751049AbVLZIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 03:21:05 -0500
Date: Mon, 26 Dec 2005 10:23:39 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: reboot of x86_64 on Intel Xeon (2.6.15-rc7)
Message-ID: <20051226082339.GA13208@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems that reboots (using KDB's 'reboot' or 'reboot -n -f') simply 
hang in machine_emergency_restart() with the x86_64 port on Intel.

On AMD the same kernel reboots perfectly.

I've tried reboot=t - didn't work.

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2800.176
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm pni monitor ds_cpl cid
bogomips        : 5583.66

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2800.176
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm pni monitor ds_cpl cid
bogomips        : 5596.77

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
