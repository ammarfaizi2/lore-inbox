Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJYRlh>; Fri, 25 Oct 2002 13:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJYRlh>; Fri, 25 Oct 2002 13:41:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28664 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261507AbSJYRlg>;
	Fri, 25 Oct 2002 13:41:36 -0400
Message-ID: <3DB983AF.D264C49D@mvista.com>
Date: Fri, 25 Oct 2002 10:47:27 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Corey Minyard <minyard@acm.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog not ticking at the right intervals
References: <3DB95086.7060505@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard wrote:
> 
> As I have been working on my NMI patch, I have noticed that the NMI
> watchdog does not seem to be ticking correctly.  I've tried 2.4 and 2.5
> kernels, and I get the same results.  From my reading of the code, it
> should tick once a second.  However, I have had the time between ticks
> vary from around 33 to over 100 seconds.  Tbe time between ticks is
> different on every boot, but is consistent once booted.  Is there some
> divider register that's not getting initialized?

That seems unlikely.  It is driven by the performance
counter stuff which is clocked at TSC rates.  It could be
that it is not being set up properly to count every event.

-g
> 
> Here's my cpuinfo:
> 
> processor    : 0
> cpu_package    : 0
> vendor_id    : GenuineIntel
> cpu family    : 6
> model        : 11
> model name    : Intel(R) Pentium(R) III Mobile CPU      1066MHz
> stepping    : 1
> cpu MHz        : 730.601
> cache size    : 512 KB
> fdiv_bug    : no
> hlt_bug        : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 2
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse
> bogomips    : 1458.17
> 
> -Corey
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
