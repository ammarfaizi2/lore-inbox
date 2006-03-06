Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWCFUWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWCFUWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCFUWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:22:45 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:19550 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751267AbWCFUWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:22:44 -0500
Message-ID: <440C9A55.30201@tmr.com>
Date: Mon, 06 Mar 2006 15:23:49 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: jensmh@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc5 'lost' cpu
References: <200603020505.13108.jensmh@gmx.de>
In-Reply-To: <200603020505.13108.jensmh@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jensmh@gmx.de wrote:
> This is a dual xeon system with hyper threading enabled, so there should
> be 4 cpus

It decided that the first CPU had only one sibling, sounds like an ACPI 
issue, if I had to place a bet I would lean to the hardware/BIOS not 
admitting to that 2nd sibling.
> 
> jm@voyager ~ $ ll /proc/acpi/processor/
> total 0
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU0
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU1
> dr-xr-xr-x  2 root root 0 Mar  2 05:01 CPU3
> 
> jm@voyager ~ $ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.80GHz
> stepping        : 9
> cpu MHz         : 2792.148
> cache size      : 512 KB
> physical id     : 0
> siblings        : 1
> core id         : 0
> cpu cores       : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
> bogomips        : 5588.74
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.80GHz
> stepping        : 9
> cpu MHz         : 2799.930
> cache size      : 512 KB
> physical id     : 3
> siblings        : 2
> core id         : 0
> cpu cores       : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
> bogomips        : 5581.39
> 
> processor       : 2
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.80GHz
> stepping        : 9
> cpu MHz         : 2799.930
> cache size      : 512 KB
> physical id     : 3
> siblings        : 2
> core id         : 0
> cpu cores       : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
> bogomips        : 5581.34

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
