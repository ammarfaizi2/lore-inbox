Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933074AbWGAAM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074AbWGAAM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933113AbWGAAM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:12:56 -0400
Received: from xenotime.net ([66.160.160.81]:15546 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S933074AbWGAAMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:12:55 -0400
Date: Fri, 30 Jun 2006 17:15:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, len.brown@intel.com, torvalds <torvalds@osdl.org>
Subject: Re: ACPI: Device [kobj-name] is not power manageable
Message-Id: <20060630171542.ebd05bb4.rdunlap@xenotime.net>
In-Reply-To: <200606302359.k5UNxPJ1002907@hera.kernel.org>
References: <200606302359.k5UNxPJ1002907@hera.kernel.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 23:59:25 GMT Linux Kernel Mailing List wrote:

> commit 64dedfb8fdbbc4fabb8c131e4b597cd4bc7f3881
> tree 7ef0c5e0574bc94fe4d25bb5994b31938205e7cf
> parent 9e7e2c047503db5a094ab30c7b4b8a5a0a324915
> author Jae-hyeon Park <hpark@tuhep.phys.tohoku.ac.jp> Tue, 27 Jun 2006 06:34:03 -0400
> committer Len Brown <len.brown@intel.com> Tue, 27 Jun 2006 08:00:40 -0400
> 
> ACPI: Device [kobj-name] is not power manageable
> 
> print kobj name in this message.
> lenb changed to use printk.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Len Brown <len.brown@intel.com>
> 
>  drivers/acpi/bus.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 917bf23..f4a36d3 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -196,7 +196,8 @@ int acpi_bus_set_power(acpi_handle handl
>  	/* Make sure this is a valid target state */
>  
>  	if (!device->flags.power_manageable) {
> -		ACPI_INFO((AE_INFO, "Device is not power manageable"));
> +		printk(KERN_DEBUG "Device `[%s]is not power manageable",
> +				device->kobj.name);
>  		return_VALUE(-ENODEV);
>  	}
>  	/*
> -

Andrew, can you send Linus the typo correction patch for this??
or should I?


s/`//
s/]/] /

Hm, needs a \n too.

~Randy
