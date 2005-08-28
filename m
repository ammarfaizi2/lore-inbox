Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVH1B1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVH1B1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 21:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVH1B1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 21:27:53 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:6434 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750743AbVH1B1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 21:27:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=C7+1ysKOAEKon8q/QIg9q5axNB9rWpG72rvrdLI9+F9KraIjXXO/95Oof4F1aw/rLIG/a5meUKDUGI5PxgyMLWLsHE++3xv1CBLl2m1tgJKOulC4eQLuoEWRNJmjTTXbDWkWPbaAnrKfqvKIbI6OMV43hzHGCJZLWETInMWOP6U=
Message-ID: <43112214.7070203@gmail.com>
Date: Sat, 27 Aug 2005 21:31:48 -0500
From: Patrick <mccpat@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Incorrect CPU Frequency in /proc/cpuinfo
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 There is a problem with the display of CPU Frequency in /proc/cpuinfo.
It displays the CPU Frequency correctly... until you change the speed
manually with the kernel's frequency scaling. Before I do this, my
frequency displayed in /proc/cpuinfo is: "3208.757", This is correct.
Then I: "||echo 600000 /sys/devices/cpu/cpu0/cpufreq/scaling_setspeed"
The file "scaling_setspeed" shows 600000, which is correct. My CPU does
change to that speed (I've run tests before and after, and temperature,
etc), yet /proc/cpuinfo shows no change, no matter what clock speed I
set it to.

I tried this on kernel 2.6.12-gentoo-r7, 2.6.13-rc6, 2.6.13-rc7, and it
still happened. I have a Pentium 4 2.4C (Northwood) with
Hyper-Threading. It is overclocked to 3.2GHz. I run Gentoo Base System
version 1.6.13.

/proc/cpuinfo:
---
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 3208.757
cache size      : 512 KB
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
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 6420.19

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 3208.757
cache size      : 512 KB
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
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 6413.76
---

The modules that were modprobed at the time:

p4_clockmod
speedstep-lib
freq_table

Patrick M.
/* EOF */

-- 
Patrick M.
/* EOF */

