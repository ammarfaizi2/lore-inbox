Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVDEIS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVDEIS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDEIQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:16:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:24002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261582AbVDEIF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:05:29 -0400
Date: Tue, 5 Apr 2005 01:05:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-rc2-mm1
Message-Id: <20050405010517.461ea273.akpm@osdl.org>
In-Reply-To: <42524576.8040007@ens-lyon.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<425240C5.1050706@ens-lyon.org>
	<20050405004519.4be75785.akpm@osdl.org>
	<42524576.8040007@ens-lyon.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton a écrit :
> > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > 
> >>Andrew Morton a écrit :
> >> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
> >>
> >> Hi Andrew,
> >>
> >> printk timing seems broken.
> >> It always shows [ 0.000000] on my Compaq Evo N600c.
> > 
> > 
> > What sort of CPU does that thing have?  Please share the /proc/cpuinfo
> > output.
> 
> It's a Mobile Pentium 3:
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 11
> model name      : Intel(R) Pentium(R) III Mobile CPU      1000MHz
> stepping        : 1
> cpu MHz         : 996.763
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
> cmov pat pse36 mmx fxsr sse
> bogomips        : 1977.25

Mobile p3 has a TSC, doesn't it?  Confused.

Anyway,

> > Does reverting
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/broken-out/sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch
> > fix it?
> 
> Yes!
> 

Ingo broke my kernel!
