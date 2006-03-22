Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWCVRoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWCVRoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWCVRoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:44:39 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:2757 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932212AbWCVRoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:44:37 -0500
Message-ID: <44218AF2.90003@t-online.de>
Date: Wed, 22 Mar 2006 18:35:46 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] wrong bogomips  values with kernel 2.6.16
References: <441FFB28.5050609@t-online.de> <Pine.LNX.4.64.0603211004250.3622@g5.osdl.org> <4420DE54.1020004@t-online.de> <Pine.LNX.4.64.0603220717270.26286@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603220717270.26286@g5.osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: Xdfi8GZCoeVNn99f8E0F+PPf394IUpMUv9PV0VaM+17EMf0NO3hvZU@t-dialin.net
X-TOI-MSGID: 485365b4-1b1c-4d2f-931e-0c5482a0e52f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 22 Mar 2006, Knut Petersen wrote:
>  
>
>>All Pentium M, Xeon up to model 2 and the P6 family increment with every
>>internal processor cycle.
>>    
>>
>
>Just to humor me. Try the bogomips loop in user space with something like 
>the appended (make sure the frequency is fixed to the lowest frequency).
>
>		Linus
>  
>
No problem ...

linux:~ # cat 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
1867000 1600000 1333000 1067000 800000

linux:~ # echo 800000 > 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed;cat 
/proc/cpuinfo;./test
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8
cpu MHz         : 800.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tmpbe nx est tm2
bogomips        : 3730.27

TSC: 798.307872 MHz




linux:~ # echo 1067000 > 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed;cat 
/proc/cpuinfo;./test
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8
cpu MHz         : 1067.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tmpbe nx est tm2
bogomips        : 4975.25

TSC: 1064.407897 MHz



linux:~ # echo 1333000 > 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed;cat 
/proc/cpuinfo;./test
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8
cpu MHz         : 1333.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tmpbe nx est tm2
bogomips        : 6215.57

TSC: 1330.511688 MHz


linux:~ # echo 1600000 > 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed;cat 
/proc/cpuinfo;./test
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8
cpu MHz         : 1600.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tmpbe nx est tm2
bogomips        : 7460.55

TSC: 1596.612533 MHz


linux:~ # echo 1867000 > 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed;cat 
/proc/cpuinfo;./test
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8
cpu MHz         : 1867.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tmpbe nx est tm2
bogomips        : 8705.53

TSC: 1862.715048 MHz


I tried kernel _2.6.15_ too - it´s even more broken:

linux:~ # cat /proc/cpuinfo;./test
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8
cpu MHz         : 4347.853
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tmpbe nx est tm2
bogomips        : 8702.35

TSC: 1863.086854 MHz

Isn´t that nice? I´m able to overclock my 1.86 MHz cpu to stable 4.35 MHz
with just a passive heatsink ;-)))

cu,
 Knut
