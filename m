Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVDDI7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVDDI7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVDDI7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:59:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24454 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261185AbVDDI7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:59:45 -0400
Date: Mon, 4 Apr 2005 10:59:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>
Subject: Re: [RFC 4/6]Add kconfig for S3 SMP
Message-ID: <20050404085932.GE14642@elf.ucw.cz>
References: <1112580364.4194.342.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112580364.4194.342.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add kconfig for IA32 S3 SMP.
> 
> Thanks,
> Shaohua
> 
> ---
> 
>  linux-2.6.11-root/kernel/power/Kconfig |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> diff -puN kernel/power/Kconfig~smp_s3_kconfig kernel/power/Kconfig
> --- linux-2.6.11/kernel/power/Kconfig~smp_s3_kconfig	2005-03-31 10:49:57.156487160 +0800
> +++ linux-2.6.11-root/kernel/power/Kconfig	2005-03-31 10:49:57.158486856 +0800
> @@ -72,3 +72,10 @@ config PM_STD_PARTITION
>  	  suspended image to. It will simply pick the first available swap 
>  	  device.
>  
> +config STR_SMP
> +	bool "Suspend to RAM SMP support (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL && ACPI_SLEEP && !X86_64
> +	depends on HOTPLUG_CPU
> +	default y
> +	---help---
> +	 enable Suspend to RAM SMP support. Some HT systems require this.

Should this be config option? If we have ACPI_SLEEP and SMP set, we
should probably require this one (so that user does not have to
care).... Also name is "interesting", perhaps CONFIG_SMP_SLEEP or
something?

							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
