Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVDDJR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDDJR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVDDJR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:17:29 -0400
Received: from fmr18.intel.com ([134.134.136.17]:9861 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261186AbVDDJRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:17:23 -0400
Subject: Re: [RFC 4/6]Add kconfig for S3 SMP
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>
In-Reply-To: <20050404085932.GE14642@elf.ucw.cz>
References: <1112580364.4194.342.camel@sli10-desk.sh.intel.com>
	 <20050404085932.GE14642@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1112606095.4194.380.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 17:14:55 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 16:59, Pavel Machek wrote:
> Hi!
> 
> > Add kconfig for IA32 S3 SMP.
> > 
> > Thanks,
> > Shaohua
> > 
> > ---
> > 
> >  linux-2.6.11-root/kernel/power/Kconfig |    7 +++++++
> >  1 files changed, 7 insertions(+)
> > 
> > diff -puN kernel/power/Kconfig~smp_s3_kconfig kernel/power/Kconfig
> > --- linux-2.6.11/kernel/power/Kconfig~smp_s3_kconfig	2005-03-31 10:49:57.156487160 +0800
> > +++ linux-2.6.11-root/kernel/power/Kconfig	2005-03-31 10:49:57.158486856 +0800
> > @@ -72,3 +72,10 @@ config PM_STD_PARTITION
> >  	  suspended image to. It will simply pick the first available swap 
> >  	  device.
> >  
> > +config STR_SMP
> > +	bool "Suspend to RAM SMP support (EXPERIMENTAL)"
> > +	depends on EXPERIMENTAL && ACPI_SLEEP && !X86_64
> > +	depends on HOTPLUG_CPU
> > +	default y
> > +	---help---
> > +	 enable Suspend to RAM SMP support. Some HT systems require this.
> 
> Should this be config option? If we have ACPI_SLEEP and SMP set, we
> should probably require this one (so that user does not have to
> care)....
Sure, quite reasonable!

>  Also name is "interesting", perhaps CONFIG_SMP_SLEEP or
> something?
Just because my patches break S4 currently. After we figure out how  to
make both S3 and S4 work, I'll change it like you said.

Thanks,
Shaohua

