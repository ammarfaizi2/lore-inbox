Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVDDJcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDDJcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVDDJcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:32:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51369 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261190AbVDDJc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:32:28 -0400
Date: Mon, 4 Apr 2005 11:32:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ncunningham@cyclades.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Message-ID: <20050404093213.GB14765@elf.ucw.cz>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com> <20050403193750.40cdabb2.akpm@osdl.org> <1112582553.4194.349.camel@sli10-desk.sh.intel.com> <20050403194807.32fd761a.akpm@osdl.org> <1112582947.4194.352.camel@sli10-desk.sh.intel.com> <1112601670.3757.6.camel@desktop.cunningham.myip.net.au> <1112604263.4194.367.camel@sli10-desk.sh.intel.com> <20050404091027.GA14765@elf.ucw.cz> <1112606651.4194.391.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112606651.4194.391.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'm switching suspend2 to use hotplug too. Li, I'll try adding your
> > > > patches as well as Zwane's if you like 
> > > Great!
> > > 
> > > > (suspend2 can enter S3, S4 or S5
> > > > after writing the image). I'd love to try it on my HT desktop, and
> > > > hotplug will get more testing too :>
> > > Unfortunately, my patches break Pavel's swsusp SMP, as my patches break
> > > current 'cpu_up' mechanism. S4 doesn't require to boot AP CPUs from real
> > > mode.
> > 
> > Uh, I don't like that one. Is it possible to put secondary CPUs back
> > to the real mode 
> Possibly doesn't need the trouble. Send a SIPI also can wakeup the a CPU
> in protected mode.
> 
> > so that cpu_up mechanism can handle them?
> If S4 also calls a smp_prepare_cpu, then the patches don't break S4. If
> people don't complain warm boot a CPU is slow, I'd like S4 also use
> smp_prepare_cpu.

Okay, that seems like a solution. Slowness should not really be a
problem (unless it takes > few seconds)...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
