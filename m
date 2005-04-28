Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVD1IkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVD1IkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVD1Igf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:36:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17863 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262063AbVD1IU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:20:56 -0400
Date: Thu, 28 Apr 2005 10:20:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [ACPI] Re: [PATCH 6/6]suspend/resume SMP support
Message-ID: <20050428082037.GG1906@elf.ucw.cz>
References: <20050428074201.GA1906@elf.ucw.cz> <200504281611.00254.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504281611.00254.luming.yu@intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > > On ia64, with tiger_defconfig:
> >  > >
> >  > > kernel/built-in.o(.text+0x59e12): In function `suspend_prepare':
> >  > > : undefined reference to `disable_nonboot_cpus'
> >  > >
> >  > > kernel/built-in.o(.text+0x59e62): In function `suspend_prepare':
> >  > > : undefined reference to `enable_nonboot_cpus'
> >  > >
> >  > > kernel/built-in.o(.text+0x5a222): In function `suspend_finish':
> >  > > : undefined reference to `enable_nonboot_cpus'
> >  >
> >  > Pavel,
> >  > Could IA64 do software suspend? There possibly are other troubles here.
> >
> >  Someone would have to write low-level support. Bring me ia64 notebook
> >  and I'll do it ;-)))))))))))))))))))).
> 
> I just checked DSDT on one ia64 box, it has S0, S4, S5 object.
> So, the platform should have sufficient support for sleep-to-disk.

No arguments about that one... Something like
arch/i386/power/{swsusp.S,cpu.c} needs to be written for ia64,
then. I'm not goot at ia64 assembly (never done that), and do not have
ia64 machine nearby, so I'm probably not doing that work.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
